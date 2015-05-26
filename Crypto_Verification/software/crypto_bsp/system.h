/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_qsys_0' in SOPC Builder design 'crypto_test'
 * SOPC Builder design path: ../../crypto_test.sopcinfo
 *
 * Generated: Mon Mar 23 23:46:13 EDT 2015
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
#define ALT_CPU_BREAK_ADDR 0x0000c820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x14
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00080020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x14
#define ALT_CPU_NAME "nios2_qsys_0"
#define ALT_CPU_RESET_ADDR 0x00080000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x0000c820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x14
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00080020
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
#define NIOS2_INST_ADDR_WIDTH 0x14
#define NIOS2_RESET_ADDR 0x00080000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_QSYS
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
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0xd0a8
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0xd0a8
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0xd0a8
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "crypto_test"


/*
 * crypto_module configuration
 *
 */

#define ALT_MODULE_CLASS_crypto_module ted_crypto
#define CRYPTO_MODULE_BASE 0xd080
#define CRYPTO_MODULE_IRQ -1
#define CRYPTO_MODULE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CRYPTO_MODULE_NAME "/dev/crypto_module"
#define CRYPTO_MODULE_SPAN 32
#define CRYPTO_MODULE_TYPE "ted_crypto"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER_0
#define ALT_TIMESTAMP_CLK TIMESTAMP_TIMER


/*
 * incoming_memory configuration
 *
 */

#define ALT_MODULE_CLASS_incoming_memory altera_avalon_onchip_memory2
#define INCOMING_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define INCOMING_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define INCOMING_MEMORY_BASE 0x8000
#define INCOMING_MEMORY_CONTENTS_INFO ""
#define INCOMING_MEMORY_DUAL_PORT 0
#define INCOMING_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define INCOMING_MEMORY_INIT_CONTENTS_FILE "crypto_test_incoming_memory"
#define INCOMING_MEMORY_INIT_MEM_CONTENT 1
#define INCOMING_MEMORY_INSTANCE_ID "NONE"
#define INCOMING_MEMORY_IRQ -1
#define INCOMING_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define INCOMING_MEMORY_NAME "/dev/incoming_memory"
#define INCOMING_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define INCOMING_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define INCOMING_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define INCOMING_MEMORY_SINGLE_CLOCK_OP 0
#define INCOMING_MEMORY_SIZE_MULTIPLE 1
#define INCOMING_MEMORY_SIZE_VALUE 16384
#define INCOMING_MEMORY_SPAN 16384
#define INCOMING_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define INCOMING_MEMORY_WRITABLE 1


/*
 * instruction_memory configuration
 *
 */

#define ALT_MODULE_CLASS_instruction_memory altera_avalon_onchip_memory2
#define INSTRUCTION_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define INSTRUCTION_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define INSTRUCTION_MEMORY_BASE 0x80000
#define INSTRUCTION_MEMORY_CONTENTS_INFO ""
#define INSTRUCTION_MEMORY_DUAL_PORT 0
#define INSTRUCTION_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define INSTRUCTION_MEMORY_INIT_CONTENTS_FILE "crypto_test_instruction_memory"
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
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0xd0a8
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * outgoing_memory configuration
 *
 */

#define ALT_MODULE_CLASS_outgoing_memory altera_avalon_onchip_memory2
#define OUTGOING_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define OUTGOING_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define OUTGOING_MEMORY_BASE 0x4000
#define OUTGOING_MEMORY_CONTENTS_INFO ""
#define OUTGOING_MEMORY_DUAL_PORT 0
#define OUTGOING_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define OUTGOING_MEMORY_INIT_CONTENTS_FILE "crypto_test_outgoing_memory"
#define OUTGOING_MEMORY_INIT_MEM_CONTENT 1
#define OUTGOING_MEMORY_INSTANCE_ID "NONE"
#define OUTGOING_MEMORY_IRQ -1
#define OUTGOING_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OUTGOING_MEMORY_NAME "/dev/outgoing_memory"
#define OUTGOING_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define OUTGOING_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define OUTGOING_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define OUTGOING_MEMORY_SINGLE_CLOCK_OP 0
#define OUTGOING_MEMORY_SIZE_MULTIPLE 1
#define OUTGOING_MEMORY_SIZE_VALUE 16356
#define OUTGOING_MEMORY_SPAN 16356
#define OUTGOING_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define OUTGOING_MEMORY_WRITABLE 1


/*
 * stack_heap configuration
 *
 */

#define ALT_MODULE_CLASS_stack_heap altera_avalon_onchip_memory2
#define STACK_HEAP_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define STACK_HEAP_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define STACK_HEAP_BASE 0x0
#define STACK_HEAP_CONTENTS_INFO ""
#define STACK_HEAP_DUAL_PORT 0
#define STACK_HEAP_GUI_RAM_BLOCK_TYPE "AUTO"
#define STACK_HEAP_INIT_CONTENTS_FILE "crypto_test_stack_heap"
#define STACK_HEAP_INIT_MEM_CONTENT 1
#define STACK_HEAP_INSTANCE_ID "NONE"
#define STACK_HEAP_IRQ -1
#define STACK_HEAP_IRQ_INTERRUPT_CONTROLLER_ID -1
#define STACK_HEAP_NAME "/dev/stack_heap"
#define STACK_HEAP_NON_DEFAULT_INIT_FILE_ENABLED 0
#define STACK_HEAP_RAM_BLOCK_TYPE "AUTO"
#define STACK_HEAP_READ_DURING_WRITE_MODE "DONT_CARE"
#define STACK_HEAP_SINGLE_CLOCK_OP 0
#define STACK_HEAP_SIZE_MULTIPLE 1
#define STACK_HEAP_SIZE_VALUE 16384
#define STACK_HEAP_SPAN 16384
#define STACK_HEAP_TYPE "altera_avalon_onchip_memory2"
#define STACK_HEAP_WRITABLE 1


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0xd0a0
#define SYSID_QSYS_0_ID 305419896
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1427168442
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"


/*
 * timer_0 configuration
 *
 */

#define ALT_MODULE_CLASS_timer_0 altera_avalon_timer
#define TIMER_0_ALWAYS_RUN 0
#define TIMER_0_BASE 0xd040
#define TIMER_0_COUNTER_SIZE 64
#define TIMER_0_FIXED_PERIOD 0
#define TIMER_0_FREQ 50000000
#define TIMER_0_IRQ 1
#define TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_0_LOAD_VALUE 49999
#define TIMER_0_MULT 0.001
#define TIMER_0_NAME "/dev/timer_0"
#define TIMER_0_PERIOD 1
#define TIMER_0_PERIOD_UNITS "ms"
#define TIMER_0_RESET_OUTPUT 0
#define TIMER_0_SNAPSHOT 1
#define TIMER_0_SPAN 64
#define TIMER_0_TICKS_PER_SEC 1000
#define TIMER_0_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_0_TYPE "altera_avalon_timer"


/*
 * timestamp_timer configuration
 *
 */

#define ALT_MODULE_CLASS_timestamp_timer altera_avalon_timer
#define TIMESTAMP_TIMER_ALWAYS_RUN 0
#define TIMESTAMP_TIMER_BASE 0xd000
#define TIMESTAMP_TIMER_COUNTER_SIZE 64
#define TIMESTAMP_TIMER_FIXED_PERIOD 0
#define TIMESTAMP_TIMER_FREQ 50000000
#define TIMESTAMP_TIMER_IRQ 2
#define TIMESTAMP_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMESTAMP_TIMER_LOAD_VALUE 49
#define TIMESTAMP_TIMER_MULT 1.0E-6
#define TIMESTAMP_TIMER_NAME "/dev/timestamp_timer"
#define TIMESTAMP_TIMER_PERIOD 1
#define TIMESTAMP_TIMER_PERIOD_UNITS "us"
#define TIMESTAMP_TIMER_RESET_OUTPUT 0
#define TIMESTAMP_TIMER_SNAPSHOT 1
#define TIMESTAMP_TIMER_SPAN 64
#define TIMESTAMP_TIMER_TICKS_PER_SEC 1000000
#define TIMESTAMP_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMESTAMP_TIMER_TYPE "altera_avalon_timer"

#endif /* __SYSTEM_H_ */
