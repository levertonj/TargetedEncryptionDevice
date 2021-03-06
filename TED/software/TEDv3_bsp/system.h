/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_qsys_0' in SOPC Builder design 'TEDv3_architecture'
 * SOPC Builder design path: ../../TEDv3_architecture.sopcinfo
 *
 * Generated: Wed Apr 01 19:25:00 EDT 2015
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00030820
#define ALT_CPU_CPU_FREQ 75000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1a
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00100020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 75000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x15
#define ALT_CPU_NAME "nios2_qsys_0"
#define ALT_CPU_RESET_ADDR 0x00100000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00030820
#define NIOS2_CPU_FREQ 75000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1a
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00100020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x15
#define NIOS2_RESET_ADDR 0x00100000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SGDMA
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_ETH_TSE
#define __ALTERA_NIOS2_QSYS
#define __ALTERA_UP_AVALON_CHARACTER_LCD
#define __ALTPLL
#define __HEX_CONDUIT
#define __TED_CRYPTO


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x319f8
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x319f8
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x319f8
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "TEDv3_architecture"


/*
 * black_interface configuration
 *
 */

#define ALT_MODULE_CLASS_black_interface altera_eth_tse
#define BLACK_INTERFACE_BASE 0x31400
#define BLACK_INTERFACE_ENABLE_MACLITE 0
#define BLACK_INTERFACE_FIFO_WIDTH 32
#define BLACK_INTERFACE_IRQ -1
#define BLACK_INTERFACE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BLACK_INTERFACE_IS_MULTICHANNEL_MAC 0
#define BLACK_INTERFACE_MACLITE_GIGE 0
#define BLACK_INTERFACE_MDIO_SHARED 0
#define BLACK_INTERFACE_NAME "/dev/black_interface"
#define BLACK_INTERFACE_NUMBER_OF_CHANNEL 1
#define BLACK_INTERFACE_NUMBER_OF_MAC_MDIO_SHARED 1
#define BLACK_INTERFACE_PCS 0
#define BLACK_INTERFACE_PCS_ID 0
#define BLACK_INTERFACE_PCS_SGMII 0
#define BLACK_INTERFACE_RECEIVE_FIFO_DEPTH 4096
#define BLACK_INTERFACE_REGISTER_SHARED 0
#define BLACK_INTERFACE_RGMII 1
#define BLACK_INTERFACE_SPAN 1024
#define BLACK_INTERFACE_TRANSMIT_FIFO_DEPTH 2048
#define BLACK_INTERFACE_TYPE "altera_eth_tse"
#define BLACK_INTERFACE_USE_MDIO 1


/*
 * black_rx configuration
 *
 */

#define ALT_MODULE_CLASS_black_rx altera_avalon_sgdma
#define BLACK_RX_ADDRESS_WIDTH 32
#define BLACK_RX_ALWAYS_DO_MAX_BURST 1
#define BLACK_RX_ATLANTIC_CHANNEL_DATA_WIDTH 4
#define BLACK_RX_AVALON_MM_BYTE_REORDER_MODE 0
#define BLACK_RX_BASE 0x318c0
#define BLACK_RX_BURST_DATA_WIDTH 8
#define BLACK_RX_BURST_TRANSFER 0
#define BLACK_RX_BYTES_TO_TRANSFER_DATA_WIDTH 16
#define BLACK_RX_CHAIN_WRITEBACK_DATA_WIDTH 32
#define BLACK_RX_COMMAND_FIFO_DATA_WIDTH 104
#define BLACK_RX_CONTROL_DATA_WIDTH 8
#define BLACK_RX_CONTROL_SLAVE_ADDRESS_WIDTH 0x4
#define BLACK_RX_CONTROL_SLAVE_DATA_WIDTH 32
#define BLACK_RX_DESCRIPTOR_READ_BURST 0
#define BLACK_RX_DESC_DATA_WIDTH 32
#define BLACK_RX_HAS_READ_BLOCK 0
#define BLACK_RX_HAS_WRITE_BLOCK 1
#define BLACK_RX_IN_ERROR_WIDTH 0
#define BLACK_RX_IRQ 2
#define BLACK_RX_IRQ_INTERRUPT_CONTROLLER_ID 0
#define BLACK_RX_NAME "/dev/black_rx"
#define BLACK_RX_OUT_ERROR_WIDTH 0
#define BLACK_RX_READ_BLOCK_DATA_WIDTH 32
#define BLACK_RX_READ_BURSTCOUNT_WIDTH 4
#define BLACK_RX_SPAN 64
#define BLACK_RX_STATUS_TOKEN_DATA_WIDTH 24
#define BLACK_RX_STREAM_DATA_WIDTH 32
#define BLACK_RX_SYMBOLS_PER_BEAT 4
#define BLACK_RX_TYPE "altera_avalon_sgdma"
#define BLACK_RX_UNALIGNED_TRANSFER 0
#define BLACK_RX_WRITE_BLOCK_DATA_WIDTH 32
#define BLACK_RX_WRITE_BURSTCOUNT_WIDTH 4


/*
 * black_to_red_memory configuration
 *
 */

#define ALT_MODULE_CLASS_black_to_red_memory altera_avalon_onchip_memory2
#define BLACK_TO_RED_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define BLACK_TO_RED_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define BLACK_TO_RED_MEMORY_BASE 0x2000000
#define BLACK_TO_RED_MEMORY_CONTENTS_INFO ""
#define BLACK_TO_RED_MEMORY_DUAL_PORT 0
#define BLACK_TO_RED_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define BLACK_TO_RED_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_black_to_red_memory"
#define BLACK_TO_RED_MEMORY_INIT_MEM_CONTENT 1
#define BLACK_TO_RED_MEMORY_INSTANCE_ID "NONE"
#define BLACK_TO_RED_MEMORY_IRQ -1
#define BLACK_TO_RED_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BLACK_TO_RED_MEMORY_NAME "/dev/black_to_red_memory"
#define BLACK_TO_RED_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define BLACK_TO_RED_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define BLACK_TO_RED_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define BLACK_TO_RED_MEMORY_SINGLE_CLOCK_OP 0
#define BLACK_TO_RED_MEMORY_SIZE_MULTIPLE 1
#define BLACK_TO_RED_MEMORY_SIZE_VALUE 48000
#define BLACK_TO_RED_MEMORY_SPAN 48000
#define BLACK_TO_RED_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define BLACK_TO_RED_MEMORY_WRITABLE 1


/*
 * black_to_red_memory configuration as viewed by black_rx_m_write
 *
 */

#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_BASE 0x2000000
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_CONTENTS_INFO ""
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_DUAL_PORT 0
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_black_to_red_memory"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_INIT_MEM_CONTENT 1
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_INSTANCE_ID "NONE"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_IRQ -1
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_NAME "/dev/black_to_red_memory"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_SINGLE_CLOCK_OP 0
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_SIZE_MULTIPLE 1
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_SIZE_VALUE 48000
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_SPAN 48000
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define BLACK_RX_M_WRITE_BLACK_TO_RED_MEMORY_WRITABLE 1


/*
 * black_to_red_memory configuration as viewed by red_tx_m_read
 *
 */

#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_BASE 0x2000000
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_CONTENTS_INFO ""
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_DUAL_PORT 0
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_black_to_red_memory"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_INIT_MEM_CONTENT 1
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_INSTANCE_ID "NONE"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_IRQ -1
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_NAME "/dev/black_to_red_memory"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_SINGLE_CLOCK_OP 0
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_SIZE_MULTIPLE 1
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_SIZE_VALUE 48000
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_SPAN 48000
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define RED_TX_M_READ_BLACK_TO_RED_MEMORY_WRITABLE 1


/*
 * black_tx configuration
 *
 */

#define ALT_MODULE_CLASS_black_tx altera_avalon_sgdma
#define BLACK_TX_ADDRESS_WIDTH 32
#define BLACK_TX_ALWAYS_DO_MAX_BURST 1
#define BLACK_TX_ATLANTIC_CHANNEL_DATA_WIDTH 4
#define BLACK_TX_AVALON_MM_BYTE_REORDER_MODE 0
#define BLACK_TX_BASE 0x31880
#define BLACK_TX_BURST_DATA_WIDTH 8
#define BLACK_TX_BURST_TRANSFER 0
#define BLACK_TX_BYTES_TO_TRANSFER_DATA_WIDTH 16
#define BLACK_TX_CHAIN_WRITEBACK_DATA_WIDTH 32
#define BLACK_TX_COMMAND_FIFO_DATA_WIDTH 104
#define BLACK_TX_CONTROL_DATA_WIDTH 8
#define BLACK_TX_CONTROL_SLAVE_ADDRESS_WIDTH 0x4
#define BLACK_TX_CONTROL_SLAVE_DATA_WIDTH 32
#define BLACK_TX_DESCRIPTOR_READ_BURST 0
#define BLACK_TX_DESC_DATA_WIDTH 32
#define BLACK_TX_HAS_READ_BLOCK 1
#define BLACK_TX_HAS_WRITE_BLOCK 0
#define BLACK_TX_IN_ERROR_WIDTH 0
#define BLACK_TX_IRQ 4
#define BLACK_TX_IRQ_INTERRUPT_CONTROLLER_ID 0
#define BLACK_TX_NAME "/dev/black_tx"
#define BLACK_TX_OUT_ERROR_WIDTH 0
#define BLACK_TX_READ_BLOCK_DATA_WIDTH 32
#define BLACK_TX_READ_BURSTCOUNT_WIDTH 4
#define BLACK_TX_SPAN 64
#define BLACK_TX_STATUS_TOKEN_DATA_WIDTH 24
#define BLACK_TX_STREAM_DATA_WIDTH 32
#define BLACK_TX_SYMBOLS_PER_BEAT 4
#define BLACK_TX_TYPE "altera_avalon_sgdma"
#define BLACK_TX_UNALIGNED_TRANSFER 0
#define BLACK_TX_WRITE_BLOCK_DATA_WIDTH 32
#define BLACK_TX_WRITE_BURSTCOUNT_WIDTH 4


/*
 * descriptor_mem configuration
 *
 */

#define ALT_MODULE_CLASS_descriptor_mem altera_avalon_onchip_memory2
#define DESCRIPTOR_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define DESCRIPTOR_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define DESCRIPTOR_MEM_BASE 0x0
#define DESCRIPTOR_MEM_CONTENTS_INFO ""
#define DESCRIPTOR_MEM_DUAL_PORT 0
#define DESCRIPTOR_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define DESCRIPTOR_MEM_INIT_CONTENTS_FILE "TEDv3_architecture_descriptor_mem"
#define DESCRIPTOR_MEM_INIT_MEM_CONTENT 1
#define DESCRIPTOR_MEM_INSTANCE_ID "NONE"
#define DESCRIPTOR_MEM_IRQ -1
#define DESCRIPTOR_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DESCRIPTOR_MEM_NAME "/dev/descriptor_mem"
#define DESCRIPTOR_MEM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define DESCRIPTOR_MEM_RAM_BLOCK_TYPE "AUTO"
#define DESCRIPTOR_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define DESCRIPTOR_MEM_SINGLE_CLOCK_OP 0
#define DESCRIPTOR_MEM_SIZE_MULTIPLE 1
#define DESCRIPTOR_MEM_SIZE_VALUE 16400
#define DESCRIPTOR_MEM_SPAN 16400
#define DESCRIPTOR_MEM_TYPE "altera_avalon_onchip_memory2"
#define DESCRIPTOR_MEM_WRITABLE 1


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK SYSTEM_TIMER
#define ALT_TIMESTAMP_CLK none


/*
 * heap_stack configuration
 *
 */

#define ALT_MODULE_CLASS_heap_stack altera_avalon_onchip_memory2
#define HEAP_STACK_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define HEAP_STACK_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define HEAP_STACK_BASE 0x28000
#define HEAP_STACK_CONTENTS_INFO ""
#define HEAP_STACK_DUAL_PORT 0
#define HEAP_STACK_GUI_RAM_BLOCK_TYPE "AUTO"
#define HEAP_STACK_INIT_CONTENTS_FILE "TEDv3_architecture_heap_stack"
#define HEAP_STACK_INIT_MEM_CONTENT 1
#define HEAP_STACK_INSTANCE_ID "NONE"
#define HEAP_STACK_IRQ -1
#define HEAP_STACK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEAP_STACK_NAME "/dev/heap_stack"
#define HEAP_STACK_NON_DEFAULT_INIT_FILE_ENABLED 0
#define HEAP_STACK_RAM_BLOCK_TYPE "AUTO"
#define HEAP_STACK_READ_DURING_WRITE_MODE "DONT_CARE"
#define HEAP_STACK_SINGLE_CLOCK_OP 0
#define HEAP_STACK_SIZE_MULTIPLE 1
#define HEAP_STACK_SIZE_VALUE 25000
#define HEAP_STACK_SPAN 25000
#define HEAP_STACK_TYPE "altera_avalon_onchip_memory2"
#define HEAP_STACK_WRITABLE 1


/*
 * hex configuration
 *
 */

#define ALT_MODULE_CLASS_hex hex_conduit
#define HEX_BASE 0x31a00
#define HEX_IRQ -1
#define HEX_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEX_NAME "/dev/hex"
#define HEX_SPAN 4
#define HEX_TYPE "hex_conduit"


/*
 * input_port configuration
 *
 */

#define ALT_MODULE_CLASS_input_port altera_avalon_pio
#define INPUT_PORT_BASE 0x319c0
#define INPUT_PORT_BIT_CLEARING_EDGE_REGISTER 0
#define INPUT_PORT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define INPUT_PORT_CAPTURE 0
#define INPUT_PORT_DATA_WIDTH 32
#define INPUT_PORT_DO_TEST_BENCH_WIRING 0
#define INPUT_PORT_DRIVEN_SIM_VALUE 0
#define INPUT_PORT_EDGE_TYPE "NONE"
#define INPUT_PORT_FREQ 75000000
#define INPUT_PORT_HAS_IN 1
#define INPUT_PORT_HAS_OUT 0
#define INPUT_PORT_HAS_TRI 0
#define INPUT_PORT_IRQ -1
#define INPUT_PORT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define INPUT_PORT_IRQ_TYPE "NONE"
#define INPUT_PORT_NAME "/dev/input_port"
#define INPUT_PORT_RESET_VALUE 0
#define INPUT_PORT_SPAN 16
#define INPUT_PORT_TYPE "altera_avalon_pio"


/*
 * instruction_memory configuration
 *
 */

#define ALT_MODULE_CLASS_instruction_memory altera_avalon_onchip_memory2
#define INSTRUCTION_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define INSTRUCTION_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define INSTRUCTION_MEMORY_BASE 0x100000
#define INSTRUCTION_MEMORY_CONTENTS_INFO ""
#define INSTRUCTION_MEMORY_DUAL_PORT 0
#define INSTRUCTION_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define INSTRUCTION_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_instruction_memory"
#define INSTRUCTION_MEMORY_INIT_MEM_CONTENT 1
#define INSTRUCTION_MEMORY_INSTANCE_ID "NONE"
#define INSTRUCTION_MEMORY_IRQ -1
#define INSTRUCTION_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define INSTRUCTION_MEMORY_NAME "/dev/instruction_memory"
#define INSTRUCTION_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define INSTRUCTION_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define INSTRUCTION_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define INSTRUCTION_MEMORY_SINGLE_CLOCK_OP 0
#define INSTRUCTION_MEMORY_SIZE_MULTIPLE 1
#define INSTRUCTION_MEMORY_SIZE_VALUE 200000
#define INSTRUCTION_MEMORY_SPAN 200000
#define INSTRUCTION_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define INSTRUCTION_MEMORY_WRITABLE 1


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x319f8
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 1024
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 1024
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * lcd configuration
 *
 */

#define ALT_MODULE_CLASS_lcd altera_up_avalon_character_lcd
#define LCD_BASE 0x31a04
#define LCD_IRQ -1
#define LCD_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LCD_NAME "/dev/lcd"
#define LCD_SPAN 2
#define LCD_TYPE "altera_up_avalon_character_lcd"


/*
 * lcd_clk configuration
 *
 */

#define ALT_MODULE_CLASS_lcd_clk altpll
#define LCD_CLK_BASE 0x319e0
#define LCD_CLK_IRQ -1
#define LCD_CLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LCD_CLK_NAME "/dev/lcd_clk"
#define LCD_CLK_SPAN 16
#define LCD_CLK_TYPE "altpll"


/*
 * output_port configuration
 *
 */

#define ALT_MODULE_CLASS_output_port altera_avalon_pio
#define OUTPUT_PORT_BASE 0x319d0
#define OUTPUT_PORT_BIT_CLEARING_EDGE_REGISTER 0
#define OUTPUT_PORT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OUTPUT_PORT_CAPTURE 0
#define OUTPUT_PORT_DATA_WIDTH 32
#define OUTPUT_PORT_DO_TEST_BENCH_WIRING 0
#define OUTPUT_PORT_DRIVEN_SIM_VALUE 0
#define OUTPUT_PORT_EDGE_TYPE "NONE"
#define OUTPUT_PORT_FREQ 75000000
#define OUTPUT_PORT_HAS_IN 0
#define OUTPUT_PORT_HAS_OUT 1
#define OUTPUT_PORT_HAS_TRI 0
#define OUTPUT_PORT_IRQ -1
#define OUTPUT_PORT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OUTPUT_PORT_IRQ_TYPE "NONE"
#define OUTPUT_PORT_NAME "/dev/output_port"
#define OUTPUT_PORT_RESET_VALUE 0
#define OUTPUT_PORT_SPAN 16
#define OUTPUT_PORT_TYPE "altera_avalon_pio"


/*
 * red_interface configuration
 *
 */

#define ALT_MODULE_CLASS_red_interface altera_eth_tse
#define RED_INTERFACE_BASE 0x31000
#define RED_INTERFACE_ENABLE_MACLITE 0
#define RED_INTERFACE_FIFO_WIDTH 32
#define RED_INTERFACE_IRQ -1
#define RED_INTERFACE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_INTERFACE_IS_MULTICHANNEL_MAC 0
#define RED_INTERFACE_MACLITE_GIGE 0
#define RED_INTERFACE_MDIO_SHARED 0
#define RED_INTERFACE_NAME "/dev/red_interface"
#define RED_INTERFACE_NUMBER_OF_CHANNEL 1
#define RED_INTERFACE_NUMBER_OF_MAC_MDIO_SHARED 1
#define RED_INTERFACE_PCS 0
#define RED_INTERFACE_PCS_ID 0
#define RED_INTERFACE_PCS_SGMII 0
#define RED_INTERFACE_RECEIVE_FIFO_DEPTH 4096
#define RED_INTERFACE_REGISTER_SHARED 0
#define RED_INTERFACE_RGMII 1
#define RED_INTERFACE_SPAN 1024
#define RED_INTERFACE_TRANSMIT_FIFO_DEPTH 2048
#define RED_INTERFACE_TYPE "altera_eth_tse"
#define RED_INTERFACE_USE_MDIO 1


/*
 * red_rx configuration
 *
 */

#define ALT_MODULE_CLASS_red_rx altera_avalon_sgdma
#define RED_RX_ADDRESS_WIDTH 32
#define RED_RX_ALWAYS_DO_MAX_BURST 1
#define RED_RX_ATLANTIC_CHANNEL_DATA_WIDTH 4
#define RED_RX_AVALON_MM_BYTE_REORDER_MODE 0
#define RED_RX_BASE 0x31940
#define RED_RX_BURST_DATA_WIDTH 8
#define RED_RX_BURST_TRANSFER 0
#define RED_RX_BYTES_TO_TRANSFER_DATA_WIDTH 16
#define RED_RX_CHAIN_WRITEBACK_DATA_WIDTH 32
#define RED_RX_COMMAND_FIFO_DATA_WIDTH 104
#define RED_RX_CONTROL_DATA_WIDTH 8
#define RED_RX_CONTROL_SLAVE_ADDRESS_WIDTH 0x4
#define RED_RX_CONTROL_SLAVE_DATA_WIDTH 32
#define RED_RX_DESCRIPTOR_READ_BURST 0
#define RED_RX_DESC_DATA_WIDTH 32
#define RED_RX_HAS_READ_BLOCK 0
#define RED_RX_HAS_WRITE_BLOCK 1
#define RED_RX_IN_ERROR_WIDTH 0
#define RED_RX_IRQ 1
#define RED_RX_IRQ_INTERRUPT_CONTROLLER_ID 0
#define RED_RX_NAME "/dev/red_rx"
#define RED_RX_OUT_ERROR_WIDTH 0
#define RED_RX_READ_BLOCK_DATA_WIDTH 32
#define RED_RX_READ_BURSTCOUNT_WIDTH 4
#define RED_RX_SPAN 64
#define RED_RX_STATUS_TOKEN_DATA_WIDTH 24
#define RED_RX_STREAM_DATA_WIDTH 32
#define RED_RX_SYMBOLS_PER_BEAT 4
#define RED_RX_TYPE "altera_avalon_sgdma"
#define RED_RX_UNALIGNED_TRANSFER 0
#define RED_RX_WRITE_BLOCK_DATA_WIDTH 32
#define RED_RX_WRITE_BURSTCOUNT_WIDTH 4


/*
 * red_to_black_memory configuration
 *
 */

#define ALT_MODULE_CLASS_red_to_black_memory altera_avalon_onchip_memory2
#define RED_TO_BLACK_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RED_TO_BLACK_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RED_TO_BLACK_MEMORY_BASE 0x1000000
#define RED_TO_BLACK_MEMORY_CONTENTS_INFO ""
#define RED_TO_BLACK_MEMORY_DUAL_PORT 0
#define RED_TO_BLACK_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define RED_TO_BLACK_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_red_to_black_memory"
#define RED_TO_BLACK_MEMORY_INIT_MEM_CONTENT 1
#define RED_TO_BLACK_MEMORY_INSTANCE_ID "NONE"
#define RED_TO_BLACK_MEMORY_IRQ -1
#define RED_TO_BLACK_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_TO_BLACK_MEMORY_NAME "/dev/red_to_black_memory"
#define RED_TO_BLACK_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RED_TO_BLACK_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define RED_TO_BLACK_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define RED_TO_BLACK_MEMORY_SINGLE_CLOCK_OP 0
#define RED_TO_BLACK_MEMORY_SIZE_MULTIPLE 1
#define RED_TO_BLACK_MEMORY_SIZE_VALUE 48000
#define RED_TO_BLACK_MEMORY_SPAN 48000
#define RED_TO_BLACK_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define RED_TO_BLACK_MEMORY_WRITABLE 1


/*
 * red_to_black_memory configuration as viewed by black_tx_m_read
 *
 */

#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_BASE 0x1000000
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_CONTENTS_INFO ""
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_DUAL_PORT 0
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_red_to_black_memory"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_INIT_MEM_CONTENT 1
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_INSTANCE_ID "NONE"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_IRQ -1
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_NAME "/dev/red_to_black_memory"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_SINGLE_CLOCK_OP 0
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_SIZE_MULTIPLE 1
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_SIZE_VALUE 48000
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_SPAN 48000
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define BLACK_TX_M_READ_RED_TO_BLACK_MEMORY_WRITABLE 1


/*
 * red_to_black_memory configuration as viewed by red_rx_m_write
 *
 */

#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_BASE 0x1000000
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_CONTENTS_INFO ""
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_DUAL_PORT 0
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_INIT_CONTENTS_FILE "TEDv3_architecture_red_to_black_memory"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_INIT_MEM_CONTENT 1
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_INSTANCE_ID "NONE"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_IRQ -1
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_NAME "/dev/red_to_black_memory"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_SINGLE_CLOCK_OP 0
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_SIZE_MULTIPLE 1
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_SIZE_VALUE 48000
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_SPAN 48000
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define RED_RX_M_WRITE_RED_TO_BLACK_MEMORY_WRITABLE 1


/*
 * red_tx configuration
 *
 */

#define ALT_MODULE_CLASS_red_tx altera_avalon_sgdma
#define RED_TX_ADDRESS_WIDTH 32
#define RED_TX_ALWAYS_DO_MAX_BURST 1
#define RED_TX_ATLANTIC_CHANNEL_DATA_WIDTH 4
#define RED_TX_AVALON_MM_BYTE_REORDER_MODE 0
#define RED_TX_BASE 0x31900
#define RED_TX_BURST_DATA_WIDTH 8
#define RED_TX_BURST_TRANSFER 0
#define RED_TX_BYTES_TO_TRANSFER_DATA_WIDTH 16
#define RED_TX_CHAIN_WRITEBACK_DATA_WIDTH 32
#define RED_TX_COMMAND_FIFO_DATA_WIDTH 104
#define RED_TX_CONTROL_DATA_WIDTH 8
#define RED_TX_CONTROL_SLAVE_ADDRESS_WIDTH 0x4
#define RED_TX_CONTROL_SLAVE_DATA_WIDTH 32
#define RED_TX_DESCRIPTOR_READ_BURST 0
#define RED_TX_DESC_DATA_WIDTH 32
#define RED_TX_HAS_READ_BLOCK 1
#define RED_TX_HAS_WRITE_BLOCK 0
#define RED_TX_IN_ERROR_WIDTH 0
#define RED_TX_IRQ 3
#define RED_TX_IRQ_INTERRUPT_CONTROLLER_ID 0
#define RED_TX_NAME "/dev/red_tx"
#define RED_TX_OUT_ERROR_WIDTH 0
#define RED_TX_READ_BLOCK_DATA_WIDTH 32
#define RED_TX_READ_BURSTCOUNT_WIDTH 4
#define RED_TX_SPAN 64
#define RED_TX_STATUS_TOKEN_DATA_WIDTH 24
#define RED_TX_STREAM_DATA_WIDTH 32
#define RED_TX_SYMBOLS_PER_BEAT 4
#define RED_TX_TYPE "altera_avalon_sgdma"
#define RED_TX_UNALIGNED_TRANSFER 0
#define RED_TX_WRITE_BLOCK_DATA_WIDTH 32
#define RED_TX_WRITE_BURSTCOUNT_WIDTH 4


/*
 * system_id configuration
 *
 */

#define ALT_MODULE_CLASS_system_id altera_avalon_sysid_qsys
#define SYSTEM_ID_BASE 0x319f0
#define SYSTEM_ID_ID 305419896
#define SYSTEM_ID_IRQ -1
#define SYSTEM_ID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSTEM_ID_NAME "/dev/system_id"
#define SYSTEM_ID_SPAN 8
#define SYSTEM_ID_TIMESTAMP 1427928872
#define SYSTEM_ID_TYPE "altera_avalon_sysid_qsys"


/*
 * system_timer configuration
 *
 */

#define ALT_MODULE_CLASS_system_timer altera_avalon_timer
#define SYSTEM_TIMER_ALWAYS_RUN 0
#define SYSTEM_TIMER_BASE 0x31840
#define SYSTEM_TIMER_COUNTER_SIZE 64
#define SYSTEM_TIMER_FIXED_PERIOD 0
#define SYSTEM_TIMER_FREQ 75000000
#define SYSTEM_TIMER_IRQ 5
#define SYSTEM_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SYSTEM_TIMER_LOAD_VALUE 74999
#define SYSTEM_TIMER_MULT 0.001
#define SYSTEM_TIMER_NAME "/dev/system_timer"
#define SYSTEM_TIMER_PERIOD 1
#define SYSTEM_TIMER_PERIOD_UNITS "ms"
#define SYSTEM_TIMER_RESET_OUTPUT 0
#define SYSTEM_TIMER_SNAPSHOT 1
#define SYSTEM_TIMER_SPAN 64
#define SYSTEM_TIMER_TICKS_PER_SEC 1000
#define SYSTEM_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define SYSTEM_TIMER_TYPE "altera_avalon_timer"


/*
 * ted_decryptor configuration
 *
 */

#define ALT_MODULE_CLASS_ted_decryptor ted_crypto
#define TED_DECRYPTOR_BASE 0x31980
#define TED_DECRYPTOR_IRQ -1
#define TED_DECRYPTOR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TED_DECRYPTOR_NAME "/dev/ted_decryptor"
#define TED_DECRYPTOR_SPAN 32
#define TED_DECRYPTOR_TYPE "ted_crypto"


/*
 * ted_encryptor configuration
 *
 */

#define ALT_MODULE_CLASS_ted_encryptor ted_crypto
#define TED_ENCRYPTOR_BASE 0x319a0
#define TED_ENCRYPTOR_IRQ -1
#define TED_ENCRYPTOR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TED_ENCRYPTOR_NAME "/dev/ted_encryptor"
#define TED_ENCRYPTOR_SPAN 32
#define TED_ENCRYPTOR_TYPE "ted_crypto"

#endif /* __SYSTEM_H_ */
