/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2014 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

#ifndef __ALTERA_MSGDMA_H__
#define __ALTERA_MSGDMA_H__

#include <stddef.h>
#include <errno.h>

#include "sys/alt_dev.h"
#include "alt_types.h"
#include "altera_msgdma_csr_regs.h"
#include "altera_msgdma_descriptor_regs.h"
#include "altera_msgdma_response_regs.h"
#include "os/alt_sem.h"
#include "os/alt_flag.h"

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

/*
 * To ensure that a descriptor is created without spaces
 * between the structure members, we call upon GCC's ability
 * to pack to a byte-aligned boundary.
 */
#define alt_msgdma_standard_descriptor_packed __attribute__ ((packed, aligned(16)))
#define alt_msgdma_extended_descriptor_packed __attribute__ ((packed, aligned(32)))
#define alt_msgdma_response_packed __attribute__ ((packed, aligned(8)))

/*
 * The function alt_find_dev() is used to search the device list "list" to
 * locate a device named "name". If a match is found, then a pointer to the
 * device is returned, otherwise NULL is returned.
 */
extern alt_dev* alt_find_dev (const char* name, alt_llist* list);

/* Callback routine type definition */
typedef void (*alt_msgdma_callback)(void *context);

/* use this structure if you haven't enabled the enhanced features */
typedef struct {
  alt_u32 *read_address;
  alt_u32 *write_address;
  alt_u32 transfer_length;
  alt_u32 control;
} alt_msgdma_standard_descriptor_packed alt_msgdma_standard_descriptor;

/* use this structure if you have enabled the enhanced features (only the elements 
enabled in hardware will be used) */
typedef struct {
  alt_u32 *read_address_low;
  alt_u32 *write_address_low;
  alt_u32 transfer_length;
  alt_u16 sequence_number;
  alt_u8  read_burst_count;
  alt_u8  write_burst_count;
  alt_u16 read_stride;
  alt_u16 write_stride;
  alt_u32 *read_address_high;
  alt_u32 *write_address_high;
  alt_u32 control;
} alt_msgdma_extended_descriptor_packed alt_msgdma_extended_descriptor;

/* msgdma device structure */
typedef struct alt_msgdma_dev
{
	/* Device linked-list entry */
    alt_llist                            llist;
	/* Name of msgdma in Qsys system */
    const char                           *name;
	/* Base address of control and status register */
    alt_u32                              *csr_base;
	/* Base address of the descriptor slave port */
    alt_u32                              *descriptor_base;
	/* Base address of the response register */
    alt_u32                              *response_base;
	/* FIFO size to store descriptor count,
	{ 8, 16, 32, 64,default:128, 256, 512, 1024 } */
    alt_u32                              descriptor_fifo_depth;
	/* FIFO size to store response count */
    alt_u32                              response_fifo_depth;
	/* Callback routine pointer */
    alt_msgdma_callback                  callback;
	/* Callback context pointer */
    void                                 *callback_context;
	/* user define control setting during interrupt registering*/
    alt_u32                              control;
	/* Enable burst transfer */
    alt_u8				burst_enable;
	/* Enable burst wrapping */
    alt_u8				burst_wrapping_support;
        /* Depth of the internal data path FIFO*/
    alt_u32				data_fifo_depth;
	/* Data path Width. This parameter affect both read
           master and write master data width */
    alt_u32			        data_width;
	/* Maximum burst count*/
    alt_u32                             max_burst_count;
	/* Maximum transfer length*/
    alt_u32                             max_byte;
	/* Maximum stride count */
    alt_u64				max_stride;
	/* Enable dynamic burst programming*/
    alt_u8			     programmable_burst_enable;
	/* Enable stride addressing */
    alt_u8				stride_enable;
	/* Supported transaction type */
    const char                          *transfer_type;	
       /* Extended feature support enable "1"-enable  "0"-disable */ 
    alt_u8				enhanced_features;
      /* Enable response port "0"-memory-mapped, "1"-streaming, "2"-disable */	
    alt_u8				response_port;
	/* Semaphore used to control access registers
	in multi-threaded mode */
    ALT_SEM                              (regs_lock)
} alt_msgdma_dev;



/*******************************************************************************
 *  Public API
 ******************************************************************************/
alt_msgdma_dev* alt_msgdma_open (const char* name);
 
void alt_msgdma_register_callback(
	alt_msgdma_dev *dev,
	alt_msgdma_callback callback,
	alt_u32 control,
	void *context); 
  
int alt_msgdma_standard_descriptor_async_transfer(
	alt_msgdma_dev *dev,
	alt_msgdma_standard_descriptor *desc);

int alt_msgdma_extended_descriptor_async_transfer(
	alt_msgdma_dev *dev,
	alt_msgdma_extended_descriptor *desc);

int alt_msgdma_construct_standard_mm_to_mm_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_standard_descriptor *descriptor,
	alt_u32 *read_address,
	alt_u32 *write_address,
	alt_u32 length,
	alt_u32 control);

int alt_msgdma_construct_standard_st_to_mm_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_standard_descriptor *descriptor, 
	alt_u32 *write_address, 
	alt_u32 length, alt_u32 control);

int alt_msgdma_construct_standard_mm_to_st_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_standard_descriptor *descriptor, 
	alt_u32 *read_address, 
	alt_u32 length, alt_u32 control);

int alt_msgdma_construct_standard_mm_to_st_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_standard_descriptor *descriptor, 
	alt_u32 *read_address, 
	alt_u32 length, 
	alt_u32 control);

int alt_msgdma_construct_extended_st_to_mm_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_extended_descriptor *descriptor, 
	alt_u32 *write_address, 
	alt_u32 length, 
	alt_u32 control, 
	alt_u16 sequence_number,
	alt_u8 write_burst_count,
	alt_u16 write_stride);

int alt_msgdma_construct_extended_mm_to_st_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_extended_descriptor *descriptor, 
	alt_u32 *read_address, 
	alt_u32 length, 
	alt_u32 control, 
	alt_u16 sequence_number, 
	alt_u8 read_burst_count, 
	alt_u16 read_stride);

int alt_msgdma_construct_extended_mm_to_mm_descriptor (
	alt_msgdma_dev *dev,
	alt_msgdma_extended_descriptor *descriptor, 
	alt_u32 *read_address, 
	alt_u32 *write_address, 
	alt_u32 length, 
	alt_u32 control,
	alt_u16 sequence_number,
	alt_u8 read_burst_count,
	alt_u8 write_burst_count, 
	alt_u16 read_stride, 
	alt_u16 write_stride);

int alt_msgdma_standard_descriptor_sync_transfer(
	alt_msgdma_dev *dev,
	alt_msgdma_standard_descriptor *desc);

int alt_msgdma_extended_descriptor_sync_transfer(
	alt_msgdma_dev *dev,
	alt_msgdma_extended_descriptor *desc);

void alt_msgdma_init (alt_msgdma_dev *dev, alt_u32 ic_id, alt_u32 irq);

/* HAL initialization macros */

/*Depth of internal data path FIFO.STRIDE_ENABLE
 * ALTERA_MSGDMA_INSTANCE is the macro used by alt_sys_init() to
 * allocate any per device memory that may be required.
 */
#define ALTERA_MSGDMA_CSR_DESCRIPTOR_SLAVE_RESPONSE_INSTANCE(name, csr_if, desc_if, resp_if, dev) \
static alt_msgdma_dev dev =                                                                       \
{                                                                                                 \
  ALT_LLIST_ENTRY,                                                                                \
  name##_CSR_NAME,                                                                                \
  ((alt_u32 *)(csr_if##_BASE)),                                                                   \
  ((alt_u32 *)(desc_if##_BASE)),                                                                  \
  ((alt_u32 *)(resp_if##_BASE)),                                                                   \
  ((alt_u32  )desc_if##_DESCRIPTOR_FIFO_DEPTH),                                                   \
  ((alt_u32  )resp_if##_DESCRIPTOR_FIFO_DEPTH * 2),                                               \
  ((void *) 0x0),                                                                                 \
  ((void *) 0x0),                                                                                 \
  ((alt_u32) 0x0),                                                                                \
  ((alt_u8) csr_if##_BURST_ENABLE),                                                               \
  ((alt_u8) csr_if##_BURST_WRAPPING_SUPPORT),                                                     \
  ((alt_u32) csr_if##_DATA_FIFO_DEPTH),                                                           \
  ((alt_u32) csr_if##_DATA_WIDTH),                                                                \
  ((alt_u32) csr_if##_MAX_BURST_COUNT),                                                           \
  ((alt_u32) csr_if##_MAX_BYTE),                                                                  \
  ((alt_u64) csr_if##_MAX_STRIDE),                                                                \
  ((alt_u8) csr_if##_PROGRAMMABLE_BURST_ENABLE),                                                  \
  ((alt_u8) csr_if##_STRIDE_ENABLE),                                                              \
  csr_if##_TRANSFER_TYPE,                                                                         \
  ((alt_u8) csr_if##_ENHANCED_FEATURES),                                                          \
  ((alt_u8) csr_if##_RESPONSE_PORT)                                                               \
}; 

#define ALTERA_MSGDMA_CSR_DESCRIPTOR_SLAVE_INSTANCE(name, csr_if, desc_if, dev) \
static alt_msgdma_dev dev =                                                     \
{                                                                               \
  ALT_LLIST_ENTRY,                                                              \
  name##_CSR_NAME,                                                              \
  ((alt_u32 *)(csr_if##_BASE)),                                                 \
  ((alt_u32 *)(desc_if##_BASE)),                                                \
  ((alt_u32 *)(0)),                                                             \
  ((alt_u32  )desc_if##_DESCRIPTOR_FIFO_DEPTH),                                 \
  ((alt_u32) 0x0),                                                              \
  ((void *) 0x0),                                                               \
  ((void *) 0x0),                                                               \
  ((alt_u32) 0x0),                                                              \
  ((alt_u8) csr_if##_BURST_ENABLE),                                             \
  ((alt_u8) csr_if##_BURST_WRAPPING_SUPPORT),                                   \
  ((alt_u32) csr_if##_DATA_FIFO_DEPTH),                                         \
  ((alt_u32) csr_if##_DATA_WIDTH),                                              \
  ((alt_u32) csr_if##_MAX_BURST_COUNT),                                         \
  ((alt_u32) csr_if##_MAX_BYTE),                                                \
  ((alt_u64) csr_if##_MAX_STRIDE),                                              \
  ((alt_u8) csr_if##_PROGRAMMABLE_BURST_ENABLE),                                \
  ((alt_u8) csr_if##_STRIDE_ENABLE),                                            \
  csr_if##_TRANSFER_TYPE,                                                       \
  ((alt_u8) csr_if##_ENHANCED_FEATURES),                                        \
  ((alt_u8) csr_if##_RESPONSE_PORT)                                             \
}; 

/*
 * The macro ALTERA_MSGDMA_INIT is called by the auto-generated function
 * alt_sys_init() to initialize a given device instance.
 */
#define ALTERA_MSGDMA_INIT(name, dev)                                              \
  if (name##_CSR_IRQ == ALT_IRQ_NOT_CONNECTED)                                     \
  {                                                                                \
    ALT_LINK_ERROR ("Error: Interrupt not connected for " #dev ". "                \
                    "The Altera Modular Scatter-Gather DMA driver requires "       \
                    "that an interrupt is connected. Please select an IRQ "        \
                    "for this device in Qsys.");                                   \
  }                                                                                \
  else                                                                             \
  {                                                                                \
    alt_msgdma_init(&dev, name##_CSR_IRQ_INTERRUPT_CONTROLLER_ID, name##_CSR_IRQ); \
  }


#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __ALTERA_MSGDMA_H__ */
