//////////////////////////////////////////////////////////////////////
////                                                              ////
////  eth_avalon_txdma.v                                          ////
////                                                              ////
////  This file is a patch used in conjunction with the           ////
////  Ethernet IP core project.                                   ////
////  http://www.opencores.org/projects/ethmac/                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Jakob Jones (jrjonsie@gmail.com)                      ////
////                                                              ////
////  All additional information is available in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//    History:
//      07/03/08 - Repaired bug with determining number of valid
//                 bytes corresponding to last data read from
//                 memory. Code was examining length field from
//                 descriptor input rather than registered
//                 descriptor data.
//
//      08/12/08 - Added logic to prevent FIFO overflows when 
//                 Avalon BUS has large latency.
//
//      12/02/08 - Modified condition for passing start flag to
//                 transmit state machine. This resolves an issue
//                 with memory interfaces with very long read
//                 latencies when transmitting short packets.
//
//      11/24/09 - Modified to allow for configurable memory
//                 interface width. Added memory interface burst
//                 capability. Modified descriptor interface
//                 such that two memory accesses are performed
//                 to a single-wide memory rather than a single
//                 access to a double-wide memory.
//      02/02/10 - Modified fifo depth calculation. Depth is now
//                 specified in words rather than bytes. Fixed fifo
//                 threshold to prevent overflow (introduced with 
//                 burst capability).
//
module eth_avalon_txdma    #(   parameter   MEM_WIDTH       = 32,
                                parameter   BURST_ENABLE    = 1,
                                parameter   BURST_TARGET    = 8,
                                parameter   FIFO_DEPTH      = 128,
                                // NOT TO BE OVERRIDDEN
                                parameter   BURST_CBITS     = ((BURST_ENABLE == 0) ? 1 :clogb2(BURST_TARGET))
                            ) (
    //Commaon signals
    input                       clk,                // System clock
    input                       reset,

    //Descriptor ram interface
    input       [6:0]           max_tx_bd,          // Highest index RX Descriptor
    input       [31:0]          bd_rdata,           // Descriptor Control data input
    input                       bd_wait,            // Descriptor RAM is busy

    output                      bd_write,           // write control data to BD RAM
    output                      bd_read,            // read control and pointer data from BD RAM
    output      [7:0]           bd_address,         // Which descriptor to read
    output      [31:0]          bd_wdata,           // Control data to be written to descriptor

    //Memory port interface
    input                       av_waitrequest,     // Memory port is busy
    input       [MEM_WIDTH-1:0] av_readdata,        // Memory port readdata
    input                       av_readdatavalid,   // Memory port readdata valid signal

    output  reg                 av_read,            // Memory port read
    output  reg [31:0]          av_address,         // Memory port address
    output  reg [BURST_CBITS-1:0] av_burstcount,    // Memory burst count

    //Streaming interface
    input                       TxEn,               // Enable transmit
    input                       txclk,              // Transmit clock
    output      [7:0]           tx_data,            // output data
    output                      tx_dv,              // qualifies dataout, startofpacket, and endofpacket
    output                      tx_sop,             // start of data packet
    output                      tx_eop,             // end of data packet
    input                       tx_ack,             // Acknowledge TX data
    input       [8:0]           tx_stat,            // Status bits
    input                       tx_stat_valid,      // Status is valid
    output                      tx_stat_ack,
    input                       tx_retry,

    output                      PerPacketPad,       // Per packet pad
    output                      PerPacketCrc,       // Per packet crc
    output                      TxUnderRun,         // An underrun occured

    //Interrupt outputs
    output  reg                 TxB_IRQ,
    output  reg                 TxE_IRQ 
);

//Some useful constant functions
`include "eth_avalon_functions.v"

localparam  MBYTE_CNT   = MEM_WIDTH / 8;        // Number of bytes per memory access
localparam  MBYTE_BITS  = clogb2(MBYTE_CNT-1);  // Number of insignificant address bits
localparam  MADDR_BITS  = 32 - MBYTE_BITS;      // Number of significant address bits
localparam  MLEN_BITS   = 16 - MBYTE_BITS;      // Number of significant packet length bits

localparam  MINFD       = max(FIFO_DEPTH,128);  // Minimum 128 byte FIFO depth
localparam  RFD         = nextPow2(MINFD);      // FIFO depth next power of 2

localparam  BURST_TGT   = (BURST_ENABLE == 1) ? BURST_TARGET : 1;

// Our FIFO threshold is (the depth - the burst target - 1
// to account for the FIFO's latency - 1 to account for our pipelining)
// to account for the latency of the FIFO's "used" signal. 
localparam  FF_THRESH   = (RFD - BURST_TGT) - 2;
localparam  FF_WIDTH    = MEM_WIDTH + MBYTE_BITS + 2;
localparam  FF_CNT_BITS = clogb2(RFD);

localparam  ONE     = 32'd1;
localparam  ZERO    = 32'd0;
localparam  ALL     = 32'b1111_1111_1111_1111_1111_1111_1111_1111;

//Bit descriptions for TX descriptor
localparam  BIT_LEN_H   = 31,   // Upper bit of length field
            BIT_LEN_L   = 16,   // Lower bit of length field
            //Control bits
            BIT_READY   = 15,   // Ready control bit (1=READY Controller can write to it)
            BIT_IRQ     = 14,   // Generate an interrupt at end of TX
            BIT_WRAP    = 13,   // Wrap to first RX descriptor after this one
            BIT_PAD     = 12,   // Add Padding to small frames
            BIT_CRC     = 11,   // Add CRC
            BIT_RSVD_H  = 10,   // Upper bit of reserved field
            BIT_RSVD_L  = 9,    // Lower bit of reserved field
            //Status bits
            BIT_UR      = 8,    // Buffer Underrun
            BIT_RTRY_H  = 7,    // Upper bit of retry count
            BIT_RTRY_L  = 4,    // Lower bit of retry count
            BIT_RL      = 3,    // Retransmission Limit
            BIT_LC      = 2,    // Late Collision
            BIT_DF      = 1,    // Defer Indication
            BIT_CS      = 0;    // Carrier Sense Lost

//State bits
localparam  ST_IDLE     =   0,
            ST_BD_RD1   =   1,  // Read Descriptor
            ST_BD_RD2   =   2,  // Read memory address
            ST_DMA1     =   3,  // Transfer first word
            ST_HOLD     =   4,  // Pause read requests
            ST_DMA2     =   5,  // Wait for all data to be written to FIFO 
            ST_STAT     =   6,  // Wait for status from MAC
            ST_BD_WR    =   7;  // Write status back to MAC

//TX State machine bits
localparam  TX_IDLE     =   0,  // Waiting for data to transmit
            TX_SEND     =   1,  // Sending transmit data
            TX_WAIT     =   2;  // Waiting for status from MAC

//FF bit definitions
localparam  FF_DATAL    =   0,              // Lower bit of data field
            FF_DATAH    =   MEM_WIDTH - 1,  // Upper bit of data field
            FF_CNTL     =   MEM_WIDTH,      // Lower bit of valid count field
            FF_CNTH     =   MEM_WIDTH + MBYTE_BITS - 1,
            FF_EOP      =   MEM_WIDTH + MBYTE_BITS,
            FF_SOP      =   MEM_WIDTH + MBYTE_BITS + 1;

wire    [31:0]              pre_av_address; // pre_registered avalon address
wire    [BURST_CBITS-1:0]   pre_av_burstcount; // pre-registered avalon burstcount
wire                        valid_tx_rd;    // Avalon bus acknowledged read

reg     [7:0]               state;          // State machine bits

reg     [6:0]               bd_index;       // Which descriptor to read
reg     [31:0]              ptr;            // Memory read pointer
reg     [31:0]              desc;           // Registered descriptor from bd_ram
wire    [15:0]              desc_len;       // Frame length from stored descriptor

wire    [MBYTE_BITS-1:0]    valid_cnt;      // Number of valid bytes in current data word
reg     [MBYTE_BITS-1:0]    first_valid_cnt;// Number of valid bytes in first data word
reg     [MBYTE_BITS-1:0]    last_valid_cnt; // Number of valid bytes in last data word

reg     [MLEN_BITS-1:0]     tg_cnt;         // target count (number of words to read from memory)
reg     [MLEN_BITS-1:0]     rd_cnt;         // read count (number of words read from memory)
reg     [MLEN_BITS-1:0]     wr_cnt;         // write count (number of words written to FIFO)
wire    [MLEN_BITS-1:0]     rem_cnt;        // Number of remaining reads
wire    [15:0]              next_tg_cnt;    // intentionally 2 bits larger
wire    [MLEN_BITS-1:0]     next_rd_cnt;    // next value of rd_cnt
wire    [MLEN_BITS-1:0]     next_wr_cnt;    // next value of wr_cnt
reg     [FF_CNT_BITS-1:0]   rd_pending;     // Number of reads pending (used to gate reads for FIFO protection)
wire    [FF_CNT_BITS-1:0]   rd_pending_add; // Amount to be added to rd_pending;
wire    [FF_CNT_BITS-1:0]   rd_pending_nxt; // Next value of rd_pending;
wire                        rd_hold;        // Hold the pipeline until there is space to receive more reads

wire                        last_read;      // Last read from memory
reg                         last_read_r;    // Registered last_read
reg                         first_write;    // First write to FIFO
wire                        last_write;     // Last write to FIFO

reg     [MEM_WIDTH-1:0]     rdata;          // registered av_readdata
reg                         valid_rdata;    // registered av_readdatavalid

wire                        stat_ready;     // Status ready from TX
reg     [BIT_UR:BIT_CS]     stat;
wire                        stat_error;     // Status indicates error


wire                        dff_clear;      // Data FIFO clear
wire    [FF_CNT_BITS-1:0]   dff_wrused;     // Amount of space used in data FIFO
wire                        dff_full;       // Data FIFO full
wire                        dff_write;      // Data FIFO write
wire    [FF_WIDTH-1:0]      dff_din;        // Data FIFO data input

wire                        dff_read;       // Data FIFO read
wire                        dff_empty;      // Data FIFO empty
wire    [FF_WIDTH-1:0]      dff_dout;       // Data FIFO data output

reg     [2:0]               tx_state;       // Transmit state machine bits
reg                         tx_stat_valid_r;// Registered tx_stat_valid
wire                        tx_start;       // Start signal to transmit state machine
wire                        last_byte;      // Indicates last valid byte of current data word
wire    [7:0]               tx_ff_data [0:MBYTE_CNT-1];// Transmit bytes from data FIFO
wire    [MBYTE_BITS-1:0]    byte_cnt;       // Indicates how many bytes are valid from data FIFO
reg     [MBYTE_BITS-1:0]    byte_index;     // Indexes tx_ff_data for byte transmission

//Avalon bus
assign  pre_av_address[31:MBYTE_BITS]   = ptr[31:MBYTE_BITS];
assign  pre_av_address[0+:MBYTE_BITS]   = ZERO[0+:MBYTE_BITS];
assign  pre_av_burstcount = rem_cnt[MLEN_BITS-1:(BURST_CBITS-1)] ? BURST_TGT[0+:BURST_CBITS] : rem_cnt[0+:BURST_CBITS];
assign  valid_tx_rd = state[ST_DMA1] & ~av_waitrequest;

//Descriptor bus
assign  bd_read     = state[ST_BD_RD2] | state[ST_BD_RD1];
assign  bd_write    = state[ST_BD_WR];
assign  bd_address  = {bd_index,state[ST_BD_RD2]};  // first memory location contains descriptor
                                                    // second contains
                                                    // pointer.
//Descriptor writeback data
assign  bd_wdata[BIT_LEN_H:BIT_LEN_L]   = desc[BIT_LEN_H:BIT_LEN_L];    //No modification to length
assign  bd_wdata[BIT_READY]             = 1'b0;             // Clear ready flag
assign  bd_wdata[BIT_IRQ]               = desc[BIT_IRQ];    // leave IRQ
assign  bd_wdata[BIT_WRAP]              = desc[BIT_WRAP];   // leave WRAP
assign  bd_wdata[BIT_PAD]               = desc[BIT_PAD];    // leave PAD
assign  bd_wdata[BIT_CRC]               = desc[BIT_CRC];    // leave CRC
assign  bd_wdata[BIT_RSVD_H:BIT_RSVD_L] = desc[BIT_RSVD_H:BIT_RSVD_L]; // leave reserved field
assign  bd_wdata[BIT_UR:BIT_CS]         = stat[BIT_UR:BIT_CS];  // set status flags

assign  desc_len    = desc[BIT_LEN_H:BIT_LEN_L];


//Add a pipeline stage for Avalon reads
always @(posedge clk or posedge reset)
    if(reset)                   av_read     <= 1'b0;
    else if(~av_waitrequest)    av_read     <= state[ST_DMA1];

always @(posedge clk)
    if(~av_waitrequest) begin   
                                av_address      <= pre_av_address;
                                av_burstcount   <= pre_av_burstcount;
    end


always @(posedge clk or posedge reset)
    if(reset)                                       state   <= 6'd1;
    else begin                                      state   <= 6'd0;
        //This really is a parallel case 
        case(1'b1) // synopsys parallel_case 
            state[ST_IDLE  ]: // do nothing (not enabled)
                if(TxEn & ~stat_ready)              state[ST_BD_RD1]<= 1'b1;
                else                                state[ST_IDLE ] <= 1'b1;
            state[ST_BD_RD1]: // read descriptor
                if(~bd_wait & bd_rdata[BIT_READY])  state[ST_BD_RD2]<= 1'b1;
                else                                state[ST_BD_RD1]<= 1'b1;
            state[ST_BD_RD2]: // read pointer
                if(~bd_wait)                        state[ST_DMA1 ] <= 1'b1;
                else                                state[ST_BD_RD2]<= 1'b1;
            state[ST_DMA1  ]: // issue all reads
                if(~av_waitrequest & last_read)     state[ST_DMA2 ] <= 1'b1;
                else if(rd_hold)                    state[ST_HOLD ] <= 1'b1;
                else                                state[ST_DMA1 ] <= 1'b1;
            state[ST_HOLD ]: // pause reads
                if(~rd_hold)                        state[ST_DMA1 ] <= 1'b1;
                else                                state[ST_HOLD ] <= 1'b1;
            state[ST_DMA2 ]: // wait here for stat                    
                if(last_write & valid_rdata)        state[ST_STAT ] <= 1'b1;
                else                                state[ST_DMA2 ] <= 1'b1;
            state[ST_STAT ]: begin // wait for status
                if(stat_ready) begin                      
                    if(tx_retry)                    state[ST_IDLE ] <= 1'b1;
                    else                            state[ST_BD_WR] <= 1'b1;
                end else                            state[ST_STAT ] <= 1'b1;
            end
            state[ST_BD_WR]: // write descriptor   
                if(~bd_wait)                        state[ST_IDLE ] <= 1'b1;
                else                                state[ST_BD_WR] <= 1'b1;
        endcase
    end


// We add the length to the least significant bits of the pointer address to
// determine if we're going to have to wrap an extra address.
assign  next_tg_cnt = desc_len + ({1'b0,bd_rdata[0+:MBYTE_BITS]} + {1'b0,ALL[0+:MBYTE_BITS]});
assign  next_rd_cnt = rd_cnt + pre_av_burstcount;
assign  next_wr_cnt = wr_cnt + ONE[0+:MLEN_BITS];
assign  rem_cnt     = tg_cnt - rd_cnt;

assign  rd_pending_add  = (pre_av_burstcount & {BURST_CBITS{valid_tx_rd}}) + {16{valid_rdata}};
assign  rd_pending_nxt  = rd_pending + rd_pending_add;
assign  rd_hold     = {1'b1,rd_pending_nxt} > ({1'b1,FF_THRESH[0+:FF_CNT_BITS]} - {1'b0,dff_wrused});

assign  last_read   = (next_rd_cnt >= tg_cnt) | stat_ready;
assign  last_write  = last_read_r & (next_wr_cnt >= rd_cnt);
assign  valid_cnt   = first_write ? first_valid_cnt:
                      last_write  ? last_valid_cnt:
                      ALL[MBYTE_BITS-1:0];

//Register last read signal
always @(posedge clk) begin
                                            valid_rdata <= av_readdatavalid;
                                            rdata       <= av_readdata;
                                            rd_pending  <= rd_pending_nxt;
    if(valid_rdata) begin               
                                            wr_cnt      <= next_wr_cnt;
                                            first_write <= 1'b0;
    end
    //This really is a parallel case 
    case(1'b1) // synopsys parallel_case 
        state[ST_IDLE]: begin
                                            last_read_r <= 1'b0;                //clear last read flag
                                            rd_cnt      <= ZERO[0+:MLEN_BITS];  //clear read count
                                            wr_cnt      <= ZERO[0+:MLEN_BITS];  //clear write count
                                            first_write <= 1'b1;                //set first write flag
                                            TxB_IRQ     <= 1'b0;                //clear irq
                                            TxE_IRQ     <= 1'b0;                //clear error irq
            if(~TxEn)                       bd_index    <= 7'd0;                //clear the BD indexer
        end //state[ST_IDLE ]

        state[ST_BD_RD1]: begin
            if(~bd_wait & bd_rdata[BIT_READY])
                                            desc        <= bd_rdata;            //load descriptor
        end //state[ST_BD_RD1]

        state[ST_BD_RD2]: begin
                                            tg_cnt      <= next_tg_cnt[15-:MLEN_BITS];
                                            ptr         <= bd_rdata;            //load pointer
        end //state[ST_BD_RD1]


        state[ST_DMA1 ]: begin
                                            first_valid_cnt <= (ALL[0+:MBYTE_BITS] - ptr[0+:MBYTE_BITS]);
                                            last_valid_cnt  <= (desc_len[MBYTE_BITS:0] + {1'b0,ptr[0+:MBYTE_BITS]}) + ALL[MBYTE_BITS:0];
            if(valid_tx_rd) begin 
                                            ptr[31:MBYTE_BITS]  <= ptr[31:MBYTE_BITS] + pre_av_burstcount;  //increment read address
                                            last_read_r <= last_read;           //set last read flag
                                            rd_cnt      <= next_rd_cnt;         //increment read count
            end
        end //state[ST_DMA1 ]

        state[ST_BD_WR]:
            if(~bd_wait) begin
                                            TxB_IRQ     <= desc[BIT_IRQ] & ~stat_error;
                                            TxE_IRQ     <= desc[BIT_IRQ] & stat_error;
                if(desc[BIT_WRAP] | (bd_index == max_tx_bd))
                                            bd_index    <= 7'd0;
                else                        bd_index    <= bd_index + 7'd1;
            end

    endcase
end


//***************************************************************************
//*************************** Data FIFO *************************************
assign  dff_clear                   = reset | state[ST_IDLE];
assign  dff_write                   = valid_rdata & ~stat_ready;
assign  dff_din[FF_DATAH:FF_DATAL]  = first_write? (rdata >> {ptr[0+:MBYTE_BITS],3'd0}): rdata;
assign  dff_din[FF_CNTH:FF_CNTL]    = valid_cnt;
assign  dff_din[FF_EOP]             = last_write;
assign  dff_din[FF_SOP]             = first_write;

//We'll read from the FIFO everytime there is a word ready or if something
//happened to put us into the WAIT state. We do this to flush the FIFO so
//any pending incoming reads from the avalon bus will make it into the FIFO 
assign  dff_read        = tx_state[TX_WAIT] | (tx_state[TX_SEND] & last_byte & tx_ack); 
eth_avalon_dma_fifo #(  .DEPTH(RFD),
                        .WIDTH(FF_WIDTH)) data_fifo(
    .aclr       (dff_clear              ),

    .wrclk      (clk                    ),
    .data       (dff_din                ),
    .wrreq      (dff_write              ),
    .wrfull     (dff_full               ),
    .wrusedw    (dff_wrused             ),

    .rdclk      (txclk                  ),
    .rdreq      (dff_read&~dff_empty    ),
    .rdempty    (dff_empty              ),
    .rdusedw    (                       ),
    .q          (dff_dout               )
); 

//Send stat_ready signal from TX to Avalon
eth_dc_reg stat_ready_dc_reg(
	.d      (tx_state[TX_WAIT] & tx_stat_valid_r),
	.inclk  (txclk              ),
	.outclk (clk                ),
	.reset  (reset              ),
	.q      (stat_ready         )
    );

//Send stat_ack signal from Avalon to TX
eth_dc_reg stat_ack_dc_reg(
	.d      (state[ST_IDLE] ),
	.inclk  (clk            ),
	.outclk (txclk          ),
	.reset  (reset          ),
	.q      (tx_stat_ack    )
    );

//Send tx_start signal from Avalon to TX
//We start sending the data when there is either
//words in the FIFO or when the DMA transfer
//has finished.
eth_dc_reg tx_start_dc_reg(
	.d      ((dff_wrused >= BURST_TGT) | (state[ST_DMA2] & ~first_write) ),
	.inclk  (clk            ),
	.outclk (txclk          ),
	.reset  (reset          ),
	.q      (tx_start       )
);

//************************* End Data FIFO ***********************************
//***************************************************************************
            
//***************************************************************************
//************************* Streaming Interface *****************************
assign  stat_error  = |{stat[BIT_UR],stat[BIT_RL:BIT_CS]};

assign  byte_cnt        = dff_dout[FF_CNTH:FF_CNTL];
assign  last_byte       = (byte_index == byte_cnt);
genvar ig;
generate
    for(ig = 0; ig < MBYTE_CNT; ig = ig + 1) begin : tx_ff_data_gen
        assign  tx_ff_data[ig]  = dff_dout[(ig*8)+:8];
    end
endgenerate

assign  tx_data = tx_ff_data[byte_index];
assign  tx_dv   = tx_state[TX_SEND];
assign  tx_sop  = tx_state[TX_SEND] & !byte_index & dff_dout[FF_SOP];
assign  tx_eop  = tx_state[TX_SEND] & last_byte & dff_dout[FF_EOP];

assign  PerPacketPad    = desc[BIT_PAD];
assign  PerPacketCrc    = desc[BIT_CRC];
assign  TxUnderRun      = tx_state[TX_SEND] & tx_ack & dff_empty;

always @(posedge txclk or posedge reset)
    if(reset)                       tx_state            <= 3'd1;
    else begin
        /*default case-->*/         tx_state            <= 3'd0;
        case(1'b1) // synopsys parallel_case 
            tx_state[TX_IDLE]:// Wait for start
                if(tx_start)        tx_state[TX_SEND]   <= 1'b1;
                else                tx_state[TX_IDLE]   <= 1'b1;

            tx_state[TX_SEND]:// Send all data 
                if((last_byte & dff_dout[FF_EOP] & tx_ack) | tx_stat_valid)
                                    tx_state[TX_WAIT]   <= 1'b1;
                else                tx_state[TX_SEND]   <= 1'b1;
                                

            tx_state[TX_WAIT]:// Wait for status
                if(tx_stat_ack)     tx_state[TX_IDLE]   <= 1'b1;
                else                tx_state[TX_WAIT]   <= 1'b1;

        endcase
    end

always @(posedge txclk) 
        if(tx_stat_valid)       stat    <= tx_stat;

always @(posedge txclk)
        if(tx_state[TX_IDLE])   tx_stat_valid_r <= 1'b0;
        else if(tx_stat_valid)  tx_stat_valid_r <= 1'b1;

always @(posedge txclk)
    case(1'b1)
        tx_state[TX_IDLE]: begin
                                            byte_index  <= ZERO[0+:MBYTE_BITS];
        end

        tx_state[TX_SEND]: begin
            if(tx_ack) begin
                if(last_byte)               byte_index  <= ZERO[0+:MBYTE_BITS];
                else                        byte_index  <= byte_index + ONE[0+:MBYTE_BITS];
            end
        end
    endcase
//*********************** End Streaming Interface ***************************
//***************************************************************************

endmodule

