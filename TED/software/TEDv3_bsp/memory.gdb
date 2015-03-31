# memory.gdb - GDB memory region definitions
#
# Machine generated for CPU 'nios2_qsys_0' in SOPC Builder design 'TEDv3_architecture'
# SOPC Builder design path: ../../TEDv3_architecture.sopcinfo
#
# Generated: Mon Mar 30 18:51:58 EDT 2015

# DO NOT MODIFY THIS FILE
#
# Changing this file will have subtle consequences
# which will almost certainly lead to a nonfunctioning
# system. If you do modify this file, be aware that your
# changes will be overwritten and lost when this file
# is generated again.
#
# DO NOT MODIFY THIS FILE

# License Agreement
#
# Copyright (c) 2008
# Altera Corporation, San Jose, California, USA.
# All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# This agreement shall be governed in all respects by the laws of the State
# of California and by the laws of the United States of America.

# Define memory regions for each memory connected to the CPU.
# The cache attribute is specified which improves GDB performance
# by allowing GDB to cache memory contents on the host.

# descriptor_mem
memory 0x0 0x4010 cache

# heap_stack
memory 0x28000 0x2ce20 cache

# instruction_memory
memory 0x100000 0x12bf20 cache

# red_to_black_memory
memory 0x1000000 0x100c350 cache

# black_to_red_memory
memory 0x2000000 0x200c350 cache
