-------------------------------------------------------------------------------
@ddblock_begin copyright

Copyright (c) 1999-2010
Maryland DSPCAD Research Group, The University of Maryland at College Park 

Permission is hereby granted, without written agreement and without
license or royalty fees, to use, copy, modify, and distribute this
software and its documentation for any purpose, provided that the above
copyright notice and the following two paragraphs appear in all copies
of this software.

IN NO EVENT SHALL THE UNIVERSITY OF MARYLAND BE LIABLE TO ANY PARTY
FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
THE UNIVERSITY OF MARYLAND HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

THE UNIVERSITY OF MARYLAND SPECIFICALLY DISCLAIMS ANY WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE
PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF
MARYLAND HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
ENHANCEMENTS, OR MODIFICATIONS.

@ddblock_end copyright
-------------------------------------------------------------------------------
>>For this test the read clock has a higher frequency than write clock
>This test shows the configurability of the mixed_clock_fifo design. Simply
changing the definition of CAPACITY and BIT_WIDTH in the testbench to 5 and
16, respectively, allows a larger buffer and values up to 65535.

>Notice that even with capacity of 5, the buffer will not read in a new value 
when it has a population of 5 and full is true.

>Flushing a non empty FIFO, resets population, pointers and the buffer.

>Ensure FIFO operation with read clock at higher frequency than write clock


>postprocess.py parses the data to display only the mimimum required
sum and carry output.
