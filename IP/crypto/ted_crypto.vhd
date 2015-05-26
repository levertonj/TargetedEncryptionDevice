-------------------------------------------------------------------------------
-- Filename: ted_crypto.vhd
-- Date:     10 Jan 2015
-- Author:   Blake Mackey
--
--
-- The design consists of 4 main elements, these are:
--   Control and Status Avalon MM slave
--     Used to load read and write address into the DMA and for control
--     and status monitoring.
--   Read Master
--     A 32 bit Avalon MM read master that reads from the Avalon MM system.
--   Write Master.
--     A 32 bit Avalon MM write master that writes to the Avalon MM system.
--   FIFO
--     a buffer between the read master and write master.
--
--
-- The FIFO
--
-- This is a 32 bit by 4 word FIFO that was created with the Quartus II MegaWizard
-- PlugIn manager and instantiated within this design.
--
--
-- Read master operation
--
-- The read master performs blocks of 32 word reads and writes the data to the FIFO
-- In order to support non-aligned-byte en/decryption, an internal byteenable signal
-- is used in order to determine which byte will be read and written to the FIFO untouched
-- A read transaction will only be started if there is sufficient room in the FIFO
-- This is implemented as a state machine with the following 3 states:
-- IDLE
--   State machine is idle awaiting the go bit
-- RUNNING
--   This is where the reading/encryption occurs.
--   Upon completion of the reads the state machine goes to stopping
-- STOPPING
--   This state allows for one extra cycle before going back to idle
--   this is required because the fifo empty flag is not updated until one
--   cycle after data is written in.
--   Since the write state machine detects completion based upon a read
--   state of idle and an empty fifo this cycle delay becomes necessary.
--
--
-- Write master operation
--
-- The write master takes data from the fifo and writes to the Avalon MM system
-- until the fifo is empty and the read state machine is idle
--
--
-- Control Slave
--
-- This is a simple memory mapped collection of registers and and readdata mux to control
-- read start, write start, number of bytes to encrypt, and all the cryptographic information
-- such as the injection vector, as well as all three sets of keys.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ted_crypto is
  port (
    -- clock interface
    csi_clock_clk   : in std_logic;
    csi_clock_reset : in std_logic;

    -- read master
    avm_read_master_read        : out std_logic;
    avm_read_master_address     : out std_logic_vector (31 downto 0);
    avm_read_master_readdata    : in  std_logic_vector (31 downto 0);
    avm_read_master_waitrequest : in  std_logic;

    -- write master
    avm_write_master_write       : out std_logic;
    avm_write_master_address     : out std_logic_vector (31 downto 0);
    avm_write_master_writedata   : out std_logic_vector (31 downto 0);
    avm_write_master_waitrequest : in  std_logic;
    --avm_write_master_byteenable  : out std_logic_vector (3 downto 0);

    -- control & status registers (CSR) slave
    avs_csr_address   : in  std_logic_vector (2 downto 0);
    avs_csr_readdata  : out std_logic_vector (31 downto 0);
    avs_csr_write     : in  std_logic;
    avs_csr_writedata : in  std_logic_vector (31 downto 0)
    );
end ted_crypto;

architecture arch of ted_crypto is

-- declare FIFO component
-- the FIFO component was generated using the Quartus II MegaWizard Plug-In Manager
  component ted_crypto_fifo
    port
      (
        aclr  : in  std_logic;
        clock : in  std_logic;
        data  : in  std_logic_vector (31 downto 0);
        rdreq : in  std_logic;
        wrreq : in  std_logic;
        empty : out std_logic;
        full  : out std_logic;
        q     : out std_logic_vector (31 downto 0)
      );
  end component;

-- fifo instantiation signals
  signal fifo_read, fifo_write : std_logic;
  signal fifo_empty, fifo_full : std_logic;

-- state machine states
  type   read_states_T is (idle, running, stopping);
  signal read_state  : read_states_T;
  signal reads_done : std_logic;

-- extra read master signals
  signal read_address : std_logic_vector (31 downto 0);   -- the current read address
  signal bytes_read   : std_logic_vector (31 downto 0);   -- tracks the bytes read
  signal read_signal  : std_logic;                        -- tracks the sends a read signal
  signal read_master_byteenable  : std_logic_vector(3 downto 0);
  signal read_master_readdata   : std_logic_vector(31 downto 0); 

-- extra write master signals
  signal write_address            : std_logic_vector (31 downto 0);  -- the current write address
  signal writing                  : std_logic; 
  --signal write_master_byteenable  : std_logic_vector(3 downto 0);
  signal write_master_writedata   : std_logic_vector(31 downto 0);  

-- CSR registers
  signal csr_control : std_logic;
  signal csr_status  : std_logic_vector (31 downto 0);    -- the status word that will be read from the status register
  signal csr_go_flag : std_logic;                         -- used to start the DMA (when logic 1)
  signal active_flag : std_logic;                         -- logic 1 if either state machines are active
  signal csr_rd_addr : std_logic_vector (31 downto 0);    -- the read start address register
  signal csr_wr_addr : std_logic_vector (31 downto 0);    -- the write start address register
  signal transfer_length : std_logic_vector(31 downto 0);
  signal injection_vector : std_logic_vector(31 downto 0);
  signal key_8  : std_logic_vector(31 downto 0);
  signal key_16 : std_logic_vector(31 downto 0);
  signal key_32 : std_logic_vector(31 downto 0);

  --These are the tumbler bits that controls how the encryption keys rotate.
  type crypto_bits_t is
    record
      tumbler_bits      : std_logic_vector(11 downto 0);
      injection_vector  : std_logic_vector(31 downto 0);
      key_8             : std_logic_vector(31 downto 0);
      key_16            : std_logic_vector(31 downto 0);
      key_32            : std_logic_vector(31 downto 0);
    end record;
  
  constant CRYPTO_RESET : crypto_bits_t := ((others=>'0'),(others=>'0'),(others=>'0'),(others=>'0'), (others=>'0'));
    
  signal r : crypto_bits_t := CRYPTO_RESET;
  
begin

-------------------------------------------------------------------------------
-- FIFO INSTATIATION
-------------------------------------------------------------------------------

  fifo_inst : ted_crypto_fifo
    port map (
      aclr                => csi_clock_reset,
      clock               => csi_clock_clk,
      data (31 downto 0)  => read_master_readdata,
      rdreq               => fifo_read,
      wrreq               => fifo_write,
      empty               => fifo_empty,
      full                => fifo_full,
      q(31 downto 0)      => write_master_writedata
      );

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- THE READ MASTER STATE MACHINE
-------------------------------------------------------------------------------

  read_FSM : process (csi_clock_clk, csi_clock_reset)
  variable v : crypto_bits_t := CRYPTO_RESET;
  begin
    if csi_clock_reset = '1' then
      read_state   <= idle;
      read_address <= (others => '0');
      bytes_read   <= (others => '0');
      read_master_byteenable   <= (others => '1');
      read_signal <= '0';
      reads_done <= '0';
      r <= CRYPTO_RESET;
    elsif rising_edge (csi_clock_clk) then
      v := r;
      case read_state is

        -- IDLE
        -- When idle just sit and wait for the go flag.
        -- Only start if the write state machine is idle as it may be
        -- finishing a previous data transfer.
        -- Start the machine by moving to the running state and initialising address and counters.
        when idle =>
          if csr_go_flag = '1' then
            reads_done <= '0';
            v.tumbler_bits      := (others=>'0');
            v.injection_vector  := injection_vector;
            v.key_8             := key_8;
            v.key_16            := key_16;
            v.key_32            := key_32;
            case csr_rd_addr(1 downto 0) is
              when "00" =>
                    if (transfer_length = 4) then
                      read_signal               <= '1';
                      read_address              <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable    <= "1111";
                      bytes_read                <= bytes_read + 4;
                      read_state                <= stopping;  
                    elsif (transfer_length = 3) then
                      read_signal   <= '1';
                      read_address  <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable    <= "0111";
                      bytes_read    <= bytes_read + 3;
                      read_state    <= stopping;
                    elsif (transfer_length = 2) then
                      read_signal   <= '1';
                      read_address  <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable    <= "0011";
                      bytes_read    <= bytes_read + 2;
                      read_state    <= stopping;
                    elsif (transfer_length = 1) then
                      read_signal   <= '1';
                      read_address  <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable    <= "0001";
                      bytes_read    <= bytes_read + 1;
                      read_state    <= stopping;
                    else
                      read_signal   <= '1';
                      read_address  <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable    <= "1111";
                      bytes_read    <= bytes_read + 4;
                      read_state    <= running;                      
                    end if;
                when "01" =>
                    if (transfer_length = 3) then
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "1110";
                      bytes_read <= bytes_read + 3;
                      read_state   <= stopping;
                    elsif (transfer_length = 2) then
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "0110";
                      bytes_read <= bytes_read + 2;
                      read_state   <= stopping;
                    elsif (transfer_length = 1) then
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "0010";
                      bytes_read <= bytes_read + 1;
                      read_state   <= stopping;
                    else
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "1110";
                      bytes_read <= bytes_read + 3;
                      read_state   <= running;
                    end if;                
                when "10" =>
                    if (transfer_length = 2) then
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "1100";
                      bytes_read <= bytes_read + 2;
                      read_state   <= stopping;
                    elsif (transfer_length = 1) then
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "0100";
                      bytes_read <= bytes_read + 1;
                      read_state   <= stopping;
                    else
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "1100";
                      bytes_read <= bytes_read + 2;                    
                      read_state   <= running;
                    end if;                
                when "11" =>
                    if (transfer_length = 1) then
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "1000";
                      bytes_read <= bytes_read + 1;
                      read_state   <= stopping;
                    else
                      read_signal <= '1';
                      read_address <= csr_rd_addr(31 downto 2) & "00";
                      read_master_byteenable <= "1000";
                      bytes_read <= bytes_read + 1;                    
                      read_state   <= running;
                    end if;
                when others =>
              end case;   
          end if;

          -- RUNNING
          -- Count reads, inc address and check for completion
          -- The read signal is held inactive by comb logic if fifo full so do nothing if fifo full
          -- also do nothing if waitrequest is active as this means signals need to be held
        when running =>
          -- if waitrequest is active or fifo full do nothing, otherwise...
          if avm_read_master_waitrequest /= '1' and fifo_full /= '1' then
            if csr_control = '0' then
              case read_master_byteenable is
                when "0001" =>
                  v.injection_vector := ((avm_read_master_readdata(31 downto 8)) & 
                                        (avm_read_master_readdata(7 downto 0) XOR r.injection_vector(7 downto 0) XOR r.key_8(7 downto 0)  XOR r.key_16(7 downto 0) XOR r.key_32(7 downto 0)));
                when "0011" =>
                  v.injection_vector := ((avm_read_master_readdata(31 downto 16)) & 
                                        (avm_read_master_readdata(15 downto 0) XOR r.injection_vector(15 downto 0) XOR r.key_8(15 downto 0) XOR r.key_16(15 downto 0) XOR r.key_32(15 downto 0)));
                when "0111" =>
                  v.injection_vector := ((avm_read_master_readdata(31 downto 24)) & 
                                        (avm_read_master_readdata(23 downto 0) XOR r.injection_vector(23 downto 0) XOR r.key_8(23 downto 0) XOR r.key_16(23 downto 0) XOR r.key_32(23 downto 0)));
                when "1111" =>
                  v.injection_vector := (avm_read_master_readdata(31 downto 0) XOR r.injection_vector(31 downto 0) XOR r.key_8(31 downto 0) XOR r.key_16(31 downto 0) XOR r.key_32(31 downto 0));
                when "1110" =>
                  v.injection_vector := ((avm_read_master_readdata(31 downto 8) XOR r.injection_vector(31 downto 8) XOR r.key_8(31 downto 8) XOR r.key_16(31 downto 8) XOR r.key_32(31 downto 8)) & 
                                        (avm_read_master_readdata(7 downto 0)));
                when "1100" =>
                  v.injection_vector := ((avm_read_master_readdata(31 downto 16) XOR r.injection_vector(31 downto 16) XOR r.key_8(31 downto 16) XOR r.key_16(31 downto 16) XOR r.key_32(31 downto 16)) & 
                                        (avm_read_master_readdata(15 downto 0)));
                when "1000" =>
                  v.injection_vector := ((avm_read_master_readdata(31 downto 24) XOR r.injection_vector(31 downto 24) XOR r.key_8(31 downto 24) XOR r.key_16(31 downto 24) XOR r.key_32(31 downto 24)) & 
                                        (avm_read_master_readdata(23 downto 0)));
                when others =>
              end case;
            elsif csr_control = '1' then
                v.injection_vector := avm_read_master_readdata(31 downto 0);
            end if;
            
            --Rotate the 32 bit key to the right, every.time.
            v.key_32(30 downto 0) := r.key_32(31 downto 1);
            v.key_32(31)          := r.key_32(0);
            
            --Rotate the 16 bit key to the right, every 32nd time.
            if ((v.tumbler_bits(4 downto 0) and "11111") = "11111") then
              v.key_16(30 downto 0) := r.key_16(31 downto 1);
              v.key_16(31)          := r.key_16(0);
            end if;
            
            if ((v.tumbler_bits(8 downto 0) and "111111111") = "111111111") then
              v.key_8(30 downto 0) := r.key_8(31 downto 1);
              v.key_8(31)          := r.key_8(0);
            end if;
            
            v.tumbler_bits := v.tumbler_bits + 1;
            
            if (bytes_read = transfer_length - 4) then
              read_signal <= '1';
              read_address <= read_address + 4;
              read_master_byteenable <= "1111";
              bytes_read <= bytes_read + 4;
              read_state <= stopping;
            elsif (bytes_read = transfer_length - 3) then
              read_signal <= '1';
              read_address <= read_address + 4;
              read_master_byteenable <= "0111";
              bytes_read <= bytes_read + 3;
              read_state <= stopping;
            elsif (bytes_read = transfer_length - 2) then
              read_signal <= '1';
              read_address <= read_address + 4;
              read_master_byteenable <= "0011";
              bytes_read <= bytes_read + 2;
              read_state <= stopping;
            elsif (bytes_read = transfer_length - 1) then
              read_signal <= '1';
              read_address <= read_address + 4;
              read_master_byteenable <= "0001";
              bytes_read <= bytes_read + 1;
              read_state <= stopping;
            else
              read_signal <= '1';
              read_address <= read_address + 4;
              read_master_byteenable <= "1111";
              bytes_read <= bytes_read + 4;
              read_state <= running;
            end if;
          end if;

          -- STOPPING
          -- Required to implement a cycle delay before going idle
          -- This ensures that the fifo empty flag is updated before going idle
          -- so that the write state machine does not register a false completion
        when stopping =>
          if avm_read_master_waitrequest /= '1' and fifo_full /= '1' then
            read_signal <= '0';
            read_address <= read_address;
            read_master_byteenable <= "0000";
            bytes_read  <= (others => '0');
            read_state <= idle;
            reads_done <= '1';
          end if;
      end case;
    end if;
    if active_flag = '0' then
      reads_done <= '0';
    end if;
    r <= v;
  end process;

  with read_master_byteenable select read_master_readdata <=
    (avm_read_master_readdata(31 downto 8)   & (avm_read_master_readdata(7 downto 0)  XOR r.injection_vector(7 downto 0)  XOR r.key_8(7 downto 0)  XOR r.key_16(7 downto 0)  XOR r.key_32(7 downto 0)))       when "0001",
    (avm_read_master_readdata(31 downto 16)  & (avm_read_master_readdata(15 downto 0) XOR r.injection_vector(15 downto 0) XOR r.key_8(15 downto 0) XOR r.key_16(15 downto 0) XOR r.key_32(15 downto 0)))      when "0011",
    (avm_read_master_readdata(31 downto 24)  & (avm_read_master_readdata(23 downto 0) XOR r.injection_vector(23 downto 0) XOR r.key_8(23 downto 0) XOR r.key_16(23 downto 0) XOR r.key_32(23 downto 0)))      when "0111",
    (avm_read_master_readdata(31 downto 0)    XOR r.injection_vector(31 downto 0)  XOR r.key_8(31 downto 0)  XOR r.key_16(31 downto 0)  XOR r.key_32(31 downto 0))                                            when "1111",
    ((avm_read_master_readdata(31 downto 8)   XOR r.injection_vector(31 downto 8)  XOR r.key_8(31 downto 8)  XOR r.key_16(31 downto 8)  XOR r.key_32(31 downto 8))   & avm_read_master_readdata(7 downto 0))  when "1110",
    ((avm_read_master_readdata(31 downto 16)  XOR r.injection_vector(31 downto 16) XOR r.key_8(31 downto 16) XOR r.key_16(31 downto 16) XOR r.key_32(31 downto 16))  & avm_read_master_readdata(15 downto 0)) when "1100",
    ((avm_read_master_readdata(31 downto 24)  XOR r.injection_vector(31 downto 24) XOR r.key_8(31 downto 24) XOR r.key_16(31 downto 24) XOR r.key_32(31 downto 24))  & avm_read_master_readdata(23 downto 0)) when "1000",
    (others=>'0') when others;
  
  -- read combinatorial signals
  -- read when in in running state and fifo not full
  avm_read_master_read <= '1' when read_signal = '1' and fifo_full = '0' else '0';

  -- simply write data into the fifo as it comes in (read asserted and waitrequest not active)
  fifo_write <= '1' when read_signal = '1' and avm_read_master_waitrequest = '0'  and fifo_full = '0' else '0';

  -- this maps the internal address directly to the external port
  avm_read_master_address <= read_address;

-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- THE WRITE MASTER STATE MACHINE
-------------------------------------------------------------------------------

  write_FSM : process (csi_clock_clk, csi_clock_reset)
  begin
    if csi_clock_reset = '1' then
        write_address <= (others=>'0');
        writing <= '0';
        fifo_read <= '0';
        avm_write_master_write <= '0';
    elsif rising_edge (csi_clock_clk) then
      if csr_go_flag = '1' then
        write_address <= csr_wr_addr;
        writing <= '0';
        fifo_read <= '0';
      end if;
      if fifo_empty /= '1' then
        if writing = '1' then
          fifo_read <= '0';
          avm_write_master_write <= '1';
        else
          fifo_read <= '1';
          writing <= '1';
        end if;
      end if;
      if writing = '1' then
        if avm_write_master_waitrequest /= '1' then
          write_address <= write_address + 4;  -- Masters use byte addressing so inc by 4 for next word
          writing <= '0';
          avm_write_master_write <= '0';
        end if;
      end if;
    end if;
  end process;
  -- this maps the internal address directly to the external port       
  avm_write_master_address     <= write_address;
  avm_write_master_writedata   <= write_master_writedata;
  --avm_write_master_byteenable  <= write_master_byteenable;

-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- CONTROL AND STATUS REGISTERS
-------------------------------------------------------------------------------

-- control and status registers
--
-- address map
--  000 control
--  001 status (read only)
--  010 read start address
--  011 write start address
--  100 transfer_length (bytes)
--  101 injection vector
--  110 "00000000" & key_8 & key_16
--  111 key_32
--
-- control register 
--  bit 0 : start control (pulse 1 to start)
--
-- status register
--  bit 0 : active flag (1 when DMA active)

-- write control of read and write address registers
  csr : process (csi_clock_clk, csi_clock_reset)
  begin
    if csi_clock_reset = '1' then
      csr_rd_addr      <= (others => '0');
      csr_wr_addr      <= (others => '0');
      key_8            <= (others => '0');
      key_16           <= (others => '0');
      key_32           <= (others => '0');
      injection_vector <= (others => '0');
      transfer_length  <= (others => '0');
      active_flag <= '0';
      csr_control <= '0';
    elsif rising_edge (csi_clock_clk) then
      if avs_csr_write = '1' then
        case avs_csr_address is
          when "000" => 
            csr_control <= avs_csr_writedata (1);
          when "010" =>
            csr_rd_addr <= avs_csr_writedata (31 downto 0);
          when "011" =>
            csr_wr_addr <= avs_csr_writedata (31 downto 0);
          when "100" =>
            transfer_length <= avs_csr_writedata;
          when "101" =>
            injection_vector <= avs_csr_writedata;
          when "110" =>
            key_8(31 downto 24)  <= avs_csr_writedata(23 downto 16);
            key_8(23 downto 16)  <= avs_csr_writedata(23 downto 16);
            key_8(15 downto 8)   <= avs_csr_writedata(23 downto 16);
            key_8(7 downto 0)    <= avs_csr_writedata(23 downto 16);
            key_16(31 downto 16) <= avs_csr_writedata(15 downto 0);
            key_16(15 downto 0)  <= avs_csr_writedata(15 downto 0);
          when "111" =>
            key_32 <= avs_csr_writedata;
          when others =>
        end case;
      end if;
      if csr_go_flag = '1' then
        active_flag <= '1';
      end if;
      if reads_done = '1' and fifo_empty = '1' and writing = '0' then
        active_flag <= '0';
      end if;
    end if;
  end process;

-- write control of go flag
-- note that this is a pulsed signal rather than a registered control bit
-- this is because this device is pulsed to start and then runs to completion
-- there is no stop control
  csr_go_flag <= avs_csr_writedata(0) when avs_csr_write = '1' and avs_csr_address = "000" else '0';
  csr_status <= "0000000000000000000000000000000" & active_flag;
  
-- readdata mux
  read_mux : process (avs_csr_address, csr_status, csr_rd_addr, csr_wr_addr)
  begin
    case avs_csr_address is
      when "000" => 
        avs_csr_readdata <= "000000000000000000000000000000" & csr_control & csr_go_flag;
      when "001" => 
        avs_csr_readdata <= csr_status;
      when "010" =>
        avs_csr_readdata <= csr_rd_addr;
      when "011" =>
        avs_csr_readdata <= csr_wr_addr(31 downto 2) & "00";
      when "100" =>
        avs_csr_readdata <= transfer_length;
      when "101" =>
        avs_csr_readdata <= injection_vector;
      when "110" =>
        avs_csr_readdata <= "00000000" & key_8(7 downto 0) & key_16(15 downto 0);
      when "111" =>
        avs_csr_readdata <= key_32;
      when others =>
        avs_csr_readdata <= csr_status;
    end case;
  end process;

-------------------------------------------------------------------------------
end arch;

