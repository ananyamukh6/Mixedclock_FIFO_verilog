/******************************************************************************
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
N AN "AS IS" BASIS, AND THE UNIVERSITY OF
MARYLAND HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
ENHANCEMENTS, OR MODIFICATIONS.

@ddblock_end copyright
******************************************************************************/
`define CAPACITY 3
`define BIT_WIDTH 8
`timescale 1ns/10ps
`include "../../src/mixed_clock_fifo.v"

module fifo_testbench;

    reg [`BIT_WIDTH-1:0] data_in;
    reg enqueue, dequeue, flush, read_clock, write_clock;
    
    wire [$ceil($clog2(`CAPACITY+1))-1:0] population;
    wire [`BIT_WIDTH-1:0] data_out;
    wire empty, full;

    integer descr; //output file
    mixed_clock_fifo #(`CAPACITY,`BIT_WIDTH) fifo( data_out, population, full, empty, data_in, enqueue, dequeue, flush, read_clock, write_clock );

    initial begin
        descr = $fopen("out_temp.txt");
	$fmonitor(descr, "%2d - pop: %d, full: %d, empty: %d, data_in: %d, data_out: %d, buffer: %2p;",
	    $time, fifo.population, fifo.full, fifo.empty, data_in, data_out, fifo.buffer); 

       // $fmonitor(descr, "%2d - data_in: %d, buffer: %2p,\tdata_out: %d, E: %d, D: %d,  wc: %d, rc: %d", 
       //     $time, data_in, fifo.buffer, data_out, enqueue, dequeue, write_clock, read_clock);
	#1000 $finish;
    end

    initial begin
        data_in = `BIT_WIDTH'd0; enqueue = 0; dequeue = 0; flush = 0;
        #10
	data_in = `BIT_WIDTH'd100; enqueue = 1; dequeue = 0; flush = 0;
        #10
	data_in = `BIT_WIDTH'd110; enqueue = 1; dequeue = 1; flush = 0;
        #10
	data_in = `BIT_WIDTH'd120; enqueue = 1; dequeue = 0; flush = 0;
        #10
	data_in = `BIT_WIDTH'd130; enqueue = 1; dequeue = 1; flush = 0;
        #10
	data_in = `BIT_WIDTH'd140; enqueue = 1; dequeue = 0; flush = 0;
        #10
	data_in = `BIT_WIDTH'd150; enqueue = 1; dequeue = 1; flush = 0;
        #10
	data_in = `BIT_WIDTH'd150; enqueue = 0; dequeue = 1; flush = 0;
    end

    initial begin
	write_clock = 0;
	forever begin
	    #2 write_clock = !write_clock;
	end
    end

initial begin
	read_clock = 1;
	#2
	forever begin
	    #5 read_clock = !read_clock;
	end
    end

endmodule
