//////////////////////////////////////////////////////////////////////
////                                                              ////
////  eth_avalon_rxdma.v                                          ////
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
//      12/01/08 - Added proper support for aborted packets. This
//                 addresses an issue with the MAC not aborting
//                 promiscuous packets in non-promiscuous mode.
//
//      12/01/09 - Modified to allow for configurable memory 
//                 interface width. Added memory interface burst
//                 capability. Modified descriptor interface
//                 such that two memory accesses are performed
//                 to a single-wide memory rather than a single
//                 access to a double-wide memory.
//      01/29/10 - Added support for bursting
//
module  eth_avalon_rxdma   #(   parameter   MEM_WIDTH   = 32,
                                parameter   BURST_TARGET= 8,
                                parameter   BURST_ENABLE= 1,
                                parameter   FIFO_DEPTH  = 1024,
                                // NOT TO BE OVERRIDDEN
                                parameter   BURST_CBITS = ((BURST_ENABLE == 0) ? 1 : clogb2(BURST_TARGET)), // Number of bits to represent burst target
                                parameter   MBYTE_CNT   = MEM_WIDTH / 8         // Number of bytes per memory access
                            ) (
    //Commaon signals
    input                       clk,
    input                       reset,

    //Descriptor ram interface
    input       [6:0]           max_rx_bd,          // Highest index RX Descriptor
    input       [31:0]          bd_rdata,           // Descriptor Control data input
    input                       bd_wait,            // Descriptor RAM is busy

    output                      bd_write,           // write control data to BD RAM
    output                      bd_read,            // read control and pointer data from BD RAM
    output      [7:0]           bd_address,         // Which descriptor to read
    output      [31:0]          bd_wdata,           // Control data to be written to descriptor

    //Memory port interface
    input                       av_waitrequest,     // Memory port is busy

    output  reg                 av_write,           // Memory port write
    output  reg [31:0]          av_address,         // Memory port address
    output  reg [MEM_WIDTH-1:0] av_writedata,       // Memory port writedata
    output  reg [MBYTE_CNT-1:0] av_byteenable,      // Memory port byteenable
    output  reg [BURST_CBITS-1:0]av_burstcount,     // Memory port burstcount

    //Streaming interface
    input                       RxEn,               // Receive Enable
    input                       rxclk,              // Receive clock
    input       [7:0]           rx_data,            // input data
    input                       rx_dv,              // qualifies datain, startofpacket, and endofpacket
    input       [8:0]           rx_err,             // error bits
    input                       rx_sop,             // start of data packet
    input                       rx_eop,             // end of data packet
    input                       rx_abort,           // abort packet

    //Interrupt outputs
    output  reg                 RxB_IRQ,
    output  reg                 RxE_IRQ,
    output                      Busy_IRQ  
);

`include "eth_avalon_functions.v"

localparam  MBYTE_BITS  = clogb2(MBYTE_CNT-1);  // Number of insignificant address bits
localparam  MADDR_BITS  = 32 - MBYTE_BITS;      // Number of significant address bits

//Let's determine the FIFO Depths. We use two FIFOs. One to pass data.
//and one to pass error information. The error FIFO does not need to be as
//large because it is only written to on an end of packet. We'll make the
//assumption that normally packets will be a minimum of 64 bytes long. So
//We divide the FIFO depth by 64 to get the Error FIFO depth. To be on the
//safe side, we double that number (really divide by 32). If either one of
//these FIFOs overflow, on overrun will occur.
localparam  MINFD   = max(FIFO_DEPTH,128);  // Minimum 128 byte FIFO depth
localparam  RFD     = nextPow2(MINFD);      // FIFO depth next power of 2 (and divide by 4)
localparam  EFD     = max( ( (RFD * MBYTE_CNT)>>3) , 4);     // Minimum error FIFO depth of 4

localparam  FF_WIDTH    = MEM_WIDTH + MBYTE_BITS + 2;
localparam  FF_USEDW    = clogb2(RFD);
// The error fifo width is 9 without bursting, otherwise we add enough bits to
// pass length through
localparam  EFF_WIDTH   = (BURST_ENABLE == 1) ? 9 + 16 : 9;

localparam  RXCNT_BITS  = (BURST_ENABLE == 1) ? 16 : MBYTE_BITS;

//FF bit definitions
localparam  FF_DATAL    =   0,              // Lower bit of data field
            FF_DATAH    =   MEM_WIDTH - 1,  // Upper bit of data field
            FF_CNTL     =   MEM_WIDTH,      // Lower bit of valid count field
            FF_CNTH     =   MEM_WIDTH + MBYTE_BITS - 1,
            FF_EOP      =   MEM_WIDTH + MBYTE_BITS,
            FF_ABORT    =   MEM_WIDTH + MBYTE_BITS + 1;

// Generic useful constants
localparam  ONE     = 32'd1;
localparam  ZERO    = 32'd0;
localparam  ALL     = 32'b1111_1111_1111_1111_1111_1111_1111_1111;

//Descriptor status bit defines
localparam  BIT_LEN_H   = 31,   // Upper bit of length field
            BIT_LEN_L   = 16,   // Lower bit of length field
            //Control bits
            BIT_EMPTY   = 15,   // Empty control bit (1=EMPTY Controller can write to it)
            BIT_IRQ     = 14,   // Generate an interrupt at end of RX
            BIT_WRAP    = 13,   // Wrap to first RX descriptor after this one
            BIT_RSVD_H  = 12,   // Upper bit of reserved field
            BIT_RSVD_L  = 11,   // Lower bit of reserved field
            //Status bits
            BIT_CF      = 8,    // Control Frame was received
            BIT_M       = 7,    // Miss
            BIT_OR      = 6,    // FIFO overrun
            BIT_IS      = 5,    // Invalid Symbol
            BIT_DN      = 4,    // Dribble Nibble
            BIT_TL      = 3,    // Frame too long
            BIT_SF      = 2,    // Frame short
            BIT_CRC     = 1,    // CRC error
            BIT_LC      = 0;    // Late Collision

//DMA State Machine Bits
localparam  ST_IDLE     =   0,
            ST_BD_RD1   =   1,
            ST_BD_RD2   =   2,
            ST_DMA1     =   3,
            ST_DMA2     =   4,
            ST_BD_WR    =   5;

//RX State Machine Bits
localparam  RX_IDLE = 0,
            RX_REC  = 1,
            RX_DISC = 2,
            RX_EOP  = 3;

//Avalon interface signals
wire                        pre_av_write;
wire    [MEM_WIDTH-1:0]     pre_av_writedata;
wire    [MBYTE_CNT-1:0]     pre_av_byteenable;
wire    [BURST_CBITS-1:0]   pre_av_burstcount;

// Logic needed for bursting
wire                        burst_start;

//Descriptor signals
reg     [6:0]               bd_index;   // Which descriptor to read
reg     [31:0]              desc;       // Descriptor control word
reg     [31:0]              ptr;        // Write pointer (from descriptor)
wire    [MBYTE_BITS:0]      cur_len;    // Length of current word
reg     [15:0]              len;        // Length counter

//DMA controller signals
reg     [6:0]               state;      // One-hot state machine bits
wire    [MBYTE_BITS-1:0]    cnt;        // Valid byte count (out of FIFO);
wire                        eop;        // End of packet flag (out of FIFO)
wire                        abort;      // Abort flag (out of FIFO)
reg                         err_r;

reg                         first_write_n;// First write to memory
wire    [MBYTE_CNT-1:0]     lsb_be;     // LSB byteenable
wire    [(MBYTE_CNT*2)-1:0] msb_be;
reg     [MBYTE_CNT-1:0]     next_msb_be;
reg                         last_wr_en;
wire    [(MEM_WIDTH*2)-1:0] sdata;      // shifted data
wire    [(MBYTE_CNT*3)-1:0] sbe;        // shifted byte enable

//FIFO Signals
//(DMA side)
wire                        dff_empty;  // data FIFO empty
wire    [FF_WIDTH-1:0]      dff_dout;   // data FIFO output  
reg     [FF_WIDTH-1:0]      dff_dout_r; // registered dff_out
wire                        dff_read;   // data FIFO read
wire    [FF_USEDW-1:0]      dff_used;   // data FIFO used

wire                        eff_empty;  // error FIFO empty
wire    [EFF_WIDTH-1:0]     eff_din;    // error FIFO input
wire    [EFF_WIDTH-1:0]     eff_dout;   // error FIFO output
reg     [8:0]               eff_dout_r; // registered eff_dout
wire                        eff_read;   // error FIFO read
//(Streaming Side)
wire    [FF_WIDTH-1:0]      dff_din;    // data fifo input data
reg     [7:0]               dff_din_reg[MBYTE_CNT-1:0];// registered incoming data word (to make a x4)
reg     [MBYTE_BITS+1:0]    dff_stat;   // {errors,eop,#valid bytes}
wire                        dff_wr;     // write data to FIFO
wire                        dff_full;   // data FIFO full
wire                        eff_wr;
wire                        eff_full;

//Streaming interface signals
reg     [3:0]               rx_state;   // RX state bits
reg     [15:0]              rx_cnt;     // # of valid bytes in entire word
wire    [MBYTE_BITS-1:0]    rx_bcnt;    // # of valid bytes in data word
reg                         rx_wr;      // indicates normal write to FIFO
wire                        rx_rdy;     // indicates FIFO is ready to receive (not full)
reg                         rx_bsy;     // Translates to Busy_IRQ but in the rx domain
reg                         rx_overrun; // an overrun as occurred
reg                         rx_abort_r; // latch rx_abort flag at end of packet

integer i;
genvar ig;

//*****************************************************************************
//************************* Avalon Interface Logic ****************************
assign  pre_av_writedata    = sdata[MEM_WIDTH+:MEM_WIDTH];
assign  pre_av_byteenable   = state[ST_DMA2] ? next_msb_be : sbe[MBYTE_CNT+:MBYTE_CNT];

always @(posedge clk or posedge reset)
    if(reset)           av_write    <= 1'b0;
    else if(~av_waitrequest)
                        av_write    <= pre_av_write;

always @(posedge clk)
    if(~av_waitrequest) begin
                        av_writedata    <= pre_av_writedata;
                        av_byteenable   <= pre_av_byteenable;

        if(burst_start) begin
                        av_address      <= {ptr[31:MBYTE_BITS],ZERO[0+:MBYTE_BITS]};
                        av_burstcount   <= pre_av_burstcount;
        end
    end
//*********************** End Avalon Interface Logic **************************
//*****************************************************************************

//*****************************************************************************
//***************************** Burst Logic ***********************************
generate if(BURST_ENABLE) begin
    // Signals for counting words
    reg                         eff_empty_r;
    reg     [15-MBYTE_BITS:0]   wcnt;       // current word count
    reg     [15:0]              wcnt_tgt;   // target word count
    wire    [15-MBYTE_BITS:0]   wcnt_rem;   // difference between target word count and current word count
    // Signals for controlling bursts
    reg     [BURST_CBITS-1:0]   burst_count;// counts burst transactions
    wire                        burst_ready;// Enough data ready for burst
    reg                         burst_begin;
    reg                         burst_busy; 

    assign  pre_av_write        = burst_busy;
    assign  pre_av_burstcount   = (eff_empty_r | (wcnt_rem > BURST_TARGET)) ? BURST_TARGET[0+:BURST_CBITS] : wcnt_rem[0+:BURST_CBITS];
    assign  burst_start = burst_begin;
    // FIFO read signals
    assign  dff_read    = state[ST_DMA1] & ~dff_empty & ~av_waitrequest & burst_busy;
    assign  eff_read    = state[ST_DMA2] & ~eff_empty & ((~av_waitrequest & burst_busy) | ~last_wr_en);


    // Word counter logic
    assign  wcnt_rem    = wcnt_tgt[15:MBYTE_BITS] - wcnt;
    // Burst control logic
    assign  burst_ready = ~eff_empty_r ? |(wcnt_tgt[15:MBYTE_BITS]^wcnt) : (dff_used > BURST_TARGET);


    always @(posedge clk) begin
                                        eff_empty_r <= eff_empty;
                                        wcnt_tgt    <= eff_dout[9+:16] + ptr[0+:MBYTE_BITS];
        if(state[ST_IDLE]) begin
                                        burst_busy  <= 1'b0;
                                        burst_begin <= 1'b0;
                                        burst_count <= ZERO[0+:BURST_CBITS];
                                        wcnt        <= ZERO[15-MBYTE_BITS:0];
        end else begin
            if(~burst_busy & ~av_waitrequest & burst_ready & (state[ST_DMA1] | state[ST_DMA2])) begin
                                        burst_busy  <= 1'b1;
                                        burst_begin <= 1'b1;
                                        burst_count <= pre_av_burstcount - ONE[0+:BURST_CBITS];
            end
            if(burst_busy & ~av_waitrequest) begin
                if(!burst_count)        burst_busy  <= 1'b0;
                                        burst_begin <= 1'b0;
                                        burst_count <= burst_count - ONE[0+:BURST_CBITS];
                                        wcnt        <= wcnt + ONE[15-MBYTE_BITS:0];
            end
        end
    end // always @(posedge clk)


end 
//*************************** End Burst Logic *********************************
//*****************************************************************************
else begin // Not using burst mode
    assign  pre_av_write        = (state[ST_DMA1] & ~dff_empty) | (state[ST_DMA2] & ~eff_empty & last_wr_en);
    assign  pre_av_burstcount   = ONE[0+:BURST_CBITS];
    assign  burst_start         = 1'b1;
    // FIFO read signals
    assign  dff_read    = state[ST_DMA1] & ~dff_empty & ~av_waitrequest;
    assign  eff_read    = state[ST_DMA2] & ~eff_empty & ~av_waitrequest;
end
endgenerate
    
    

//*****************************************************************************
//************************** DMA Interface Logic ******************************

assign  abort       = dff_dout_r [FF_ABORT];
assign  eop         = dff_dout   [FF_EOP];
assign  cnt         = dff_dout   [FF_CNTH:FF_CNTL];


//Shift data for unaligned transfers
assign  sdata   = {dff_dout[FF_DATAH:FF_DATAL], dff_dout_r[FF_DATAH:FF_DATAL]}  << {ptr[0+:MBYTE_BITS],3'd0};
assign  sbe     = {msb_be, lsb_be} << ptr[0+:MBYTE_BITS];
assign  msb_be  = {ZERO[0+:MBYTE_CNT],ALL[0+:MBYTE_CNT]} >> ~cnt;
assign  lsb_be  = {MBYTE_CNT{first_write_n}}; // either all 1's or all 0's

//State machine (one-hot) encoding
always @(posedge clk or posedge reset)
    if(reset)   begin                               
                                                    state           <= 5'd0;
                                                    state[ST_IDLE]  <= 1'b1;
    end else begin
        /*default case-->*/                         state           <= 5'd0;
        case(1'b1) // synopsys parallel_case 
            state[ST_IDLE ]:  // do nothing (not enabled)
                if(RxEn & ~av_write)                state[ST_BD_RD1]<= 1'b1;
                else                                state[ST_IDLE ] <= 1'b1;
            state[ST_BD_RD1]: // read descriptor   
                if(~bd_wait & bd_rdata[BIT_EMPTY])  state[ST_BD_RD2]<= 1'b1;
                else                                state[ST_BD_RD1]<= 1'b1;
            state[ST_BD_RD2]: // read pointer   
                if(~bd_wait)                        state[ST_DMA1]  <= 1'b1;
                else                                state[ST_BD_RD2]<= 1'b1;
            state[ST_DMA1 ]:  // transfer data 
                if(dff_read & eop)                  state[ST_DMA2 ] <= 1'b1;
                else                                state[ST_DMA1 ] <= 1'b1;
            state[ST_DMA2 ]:  // transfer last
                if(eff_read)                        state[ST_BD_WR] <= 1'b1;
                else                                state[ST_DMA2 ] <= 1'b1;
            state[ST_BD_WR]:  // write descriptor
                if(~bd_wait & ~av_write)            state[ST_IDLE ] <= 1'b1;
                else                                state[ST_BD_WR] <= 1'b1;
        endcase
    end

always @(posedge clk) begin
    if(state[ST_IDLE ])         first_write_n   <= 1'b0;
    if(dff_read)                first_write_n   <= 1'b1; 
end


// Length counter. We don't actually count the bytes written but instead the
// bytes read from the FIFO. What we're interested in is the final length 
// count. 
assign  cur_len = {1'b0,cnt} + ONE[0+:MBYTE_BITS]; 
always @(posedge clk)
    if(state[ST_BD_RD1])        len <= 16'd0;
    else if(dff_read)           len <= len + cur_len;

// Latch next MSB byte enable
always @(posedge clk)
    if(state[ST_DMA1]) begin     
                                next_msb_be <= sbe[MBYTE_CNT*2+:MBYTE_CNT];
                                last_wr_en  <= sbe[MBYTE_CNT*2];
    end

// Latch Data FIFO output whenever a write to memory takes place
always @(posedge clk)
    if(dff_read)                dff_dout_r  <= dff_dout;


//************************ End DMA Interface Logic ****************************
//*****************************************************************************

//****************************************************************************
//********************** Descriptor Interface Logic **************************
assign  bd_read     = state[ST_BD_RD1] | state[ST_BD_RD2];
assign  bd_write    = state[ST_BD_WR] & ~abort & ~av_write;
assign  bd_address  = {bd_index,state[ST_BD_RD2]};
assign  bd_wdata    = {len[15:0],1'b0,desc[BIT_IRQ:BIT_WRAP],4'b000,eff_dout_r};

//Load pointer and descriptor data in BD Read state
always @(posedge clk) begin
    if(state[ST_BD_RD1])        desc        <= bd_rdata;
    if(state[ST_BD_RD2])        ptr         <= bd_rdata;
    if(dff_read)                ptr[31:MBYTE_BITS] <= ptr[31:MBYTE_BITS] + ONE[0+:MADDR_BITS];
end

always @(posedge clk)
    if(eff_read) begin  
                                eff_dout_r  <= eff_dout[8:0];
                                err_r       <= |{eff_dout[8:3],eff_dout[1:0]};
    end

//bd_index decoder
always @(posedge clk or posedge reset)
    if(reset)                   bd_index    <= 7'd0;
    else if(~RxEn)              bd_index    <= 7'd0;
    else if(bd_write & ~bd_wait) begin
        if((bd_index == max_rx_bd) | desc[BIT_WRAP])
                                bd_index    <= 7'd0;
        else
                                bd_index    <= bd_index + 7'd1;
    end

//IRQ generation to feed back to registers module
always @(posedge clk or posedge reset)
    if(reset)   begin           RxE_IRQ <= 1'b0;
                                RxB_IRQ <= 1'b0;
    end else begin              
                                RxE_IRQ <= 1'b0;
                                RxB_IRQ <= 1'b0;              
        if(bd_write & ~bd_wait)  begin
                                RxE_IRQ <= desc[BIT_IRQ] & err_r;
                                RxB_IRQ <= desc[BIT_IRQ] & ~err_r;
        end 
    end
//********************** Descriptor Interface Logic **************************
//****************************************************************************

//****************************************************************************
//****************** Dual-Clock Data and Error FIFOs *************************

//Data FIFO
eth_avalon_dma_fifo #(  .DEPTH(RFD),
                        .WIDTH(FF_WIDTH)) eth_rxdma_datafifo(
    .aclr   (reset              ),
    .wrclk  (rxclk              ),
    .wrreq  (dff_wr & rx_rdy    ),
    .wrfull (dff_full           ),
    .wrusedw(                   ),
    .data   (dff_din            ),

    .rdclk  (clk                ),
    .rdreq  (dff_read           ),
    .rdempty(dff_empty          ),
    .rdusedw(dff_used           ),
    .q      (dff_dout           )
    );

// Error FIFO. In reality, we pass the errors and also a length count through
// this FIFO. The length is used on the other end to help determine the burst
// length.
eth_avalon_dma_fifo #(  .DEPTH(EFD),
                        .WIDTH(EFF_WIDTH) ) eth_rxdma_errfifo(
    .aclr   (reset              ),
    .wrclk  (rxclk              ),
    .wrreq  (eff_wr & rx_rdy    ),
    .wrfull (eff_full           ),
    .wrusedw(                   ),
    .data   (eff_din            ),

    .rdclk  (clk                ),
    .rdreq  (eff_read           ),
    .rdempty(eff_empty          ),
    .rdusedw(                   ),
    .q      (eff_dout           )
    );

//Set Busy IRQ if a new frame comes in and
//we're too busy to receive it.
always @(posedge rxclk)     rx_bsy  <= rx_sop & rx_dv & ~rx_rdy;

eth_dc_reg rx_busy_dc_reg(
    .d      (rx_bsy             ),
    .inclk  (rxclk              ),
    .outclk (clk                ),
    .reset  (reset              ),
    .q      (Busy_IRQ           )
);

//**************** End Dual-Clock Data and Error FIFOs ***********************
//****************************************************************************

//*****************************************************************************
//********************* Streaming Interface Logic *****************************
assign  rx_rdy      = ~dff_full & ~eff_full;    // ready when space in FIFO
assign  dff_wr      = (rx_state[RX_REC ] & rx_wr) | rx_state[RX_EOP];
assign  eff_wr      = rx_state[RX_EOP ];
assign  eff_din[8:0]= {rx_err[8:7],rx_overrun,rx_err[5:0]};
// split byte count out of rx_cnt
assign  rx_bcnt     = rx_cnt[0+:MBYTE_BITS];

generate if(BURST_ENABLE) begin
    wire    [15:0]  rx_wcnt;
    // Round up to the nearest word
    assign  rx_wcnt = rx_cnt + ALL[0+:MBYTE_BITS];
    // # of memory writes required to send all data. We send this through the
    // error FIFO so that the DMA controller knows how many transactions are
    // required. On the other end, this needs to be modified to include the
    // address offset
    assign  eff_din[EFF_WIDTH-1:9]  = rx_wcnt;
end
endgenerate


// Assign data fifo inputs
assign  dff_din[FF_ABORT:FF_CNTL]   = dff_stat;
generate
    for(ig=0;ig<MBYTE_CNT;ig=ig+1) begin : dff_din_assigns
        assign  dff_din[ig*8+:8]    = dff_din_reg[ig];
    end
endgenerate

always @(posedge rxclk or posedge reset)
    if(reset) begin                     rx_state            <= 4'd0;
                                        rx_state[RX_IDLE]   <= 1'b1;
    end else begin           
        /*default case-->*/             rx_state            <= 4'd0;
        case(1'b1) // synopsys parallel_case
            //Wait for start of FRAME
            //We'll never leave this
            //state if the FIFO isn't
            //ready
            rx_state[RX_IDLE]:
                if(rx_dv & rx_sop)
                    if(rx_rdy)          rx_state[RX_REC ]   <= 1'b1;
                    else                rx_state[RX_IDLE]   <= 1'b1;
                else                    rx_state[RX_IDLE]   <= 1'b1;
            //Receiving Frame
            rx_state[RX_REC ]:
                if(rx_dv) begin
                    if(rx_eop)          rx_state[RX_EOP ]   <= 1'b1;
                    else if(~rx_rdy)    rx_state[RX_DISC]   <= 1'b1;
                    else                rx_state[RX_REC ]   <= 1'b1;
                end else                rx_state[RX_REC ]   <= 1'b1;
            //Throw away the frame. We
            //Overran the FIFO in the
            //middle of the frame. We
            //discard the rest of the
            //frame.
            rx_state[RX_DISC]: 
                if(rx_eop & rx_dv)      rx_state[RX_EOP ]   <= 1'b1;
                else                    rx_state[RX_DISC]   <= 1'b1;
            //Write last word to FIFO.
            //We will sit here indefintely
            //until the FIFO is ready
            rx_state[RX_EOP]:
                if(rx_rdy)              rx_state[RX_IDLE]   <= 1'b1;
                else                    rx_state[RX_EOP ]   <= 1'b1;
        endcase
    end

// rx_overrun decoder
always @(posedge rxclk or posedge reset)
    if(reset)                           rx_overrun      <= 1'b0;
    else if(rx_state[RX_REC])           rx_overrun      <= rx_dv & ~rx_rdy;
    else if(rx_state[RX_EOP] & rx_rdy)  rx_overrun      <= 1'b0;      

// rx_abort decoder
always @(posedge rxclk)
    if(rx_state[RX_IDLE])               rx_abort_r      <= 1'b0;
    else if(rx_state[RX_REC] | rx_state[RX_DISC])
                                        rx_abort_r      <= rx_dv & rx_eop & rx_abort;

//We'll allow this to overrun
always @(posedge rxclk or posedge reset)
    if(reset)                               rx_cnt      <= ZERO[0+:RXCNT_BITS];
    else 
        case(1'b1) // synopsys parallel_case
            rx_state[RX_IDLE]:
                if(rx_dv & rx_sop & rx_rdy) rx_cnt      <= rx_cnt + ONE[0+:RXCNT_BITS];
                else                        rx_cnt      <= ZERO[0+:RXCNT_BITS];

            rx_state[RX_REC ]:
                if(rx_dv)                   rx_cnt      <= rx_cnt + ONE[0+:RXCNT_BITS];

            rx_state[RX_EOP ]:              rx_cnt      <= ZERO[0+:RXCNT_BITS];
        endcase

//set the write flag when all 4 bytes are received
always @(posedge rxclk or posedge reset)
    if(reset)                               rx_wr       <= 1'b0;
    else 
        if(rx_state[RX_REC])                rx_wr       <= rx_dv & (&rx_bcnt);
        else                                rx_wr       <= 1'b0;


//We'll alow these to overrun
always @* begin             dff_stat[MBYTE_BITS]    = rx_state[RX_EOP ];
    if(rx_state[RX_EOP])    dff_stat[MBYTE_BITS+1]  = rx_abort_r;
    else                    dff_stat[MBYTE_BITS+1]  = 1'b0;
end

always @(posedge rxclk)
    if(rx_dv)   begin       dff_din_reg[rx_bcnt]    <= rx_data;
                            dff_stat[0+:MBYTE_BITS] <= rx_bcnt;
    end

//******************* End Streaming Interface Logic ***************************
//*****************************************************************************
endmodule

