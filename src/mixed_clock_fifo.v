module mixed_clock_fifo( data_out, population, full, empty, data_in, enqueue, dequeue, flush, read_clock, write_clock );
parameter capacity = 1, bit_width = 1; //redefined before called

integer i;
input enqueue, dequeue, flush, read_clock, write_clock;   //input signals 
input [bit_width-1:0]	data_in;    										  // data input                 
output	empty, full;   //output signals if buffer is empty or full
output[bit_width-1:0] data_out;  //data output
output[bit_width-1:0] population;  // number of elements present in the buffer  
           
reg[bit_width-1:0] data_out;
wire empty, full;
reg[$ceil($clog2(capacity+1))-1 :0] population;	// population should be log2(max capactiy +1), rounded up;
reg[$ceil($clog2(capacity+1))-1 :0] population_next;	//next value of population
reg[bit_width-1:0] read_ptr, write_ptr;         // pointer to read and write addresses  
reg[bit_width-1:0] read_ptr_next, write_ptr_next;         // pointer to read and write addresses (next value of those states) 
reg[bit_width-1:0]	buffer[capacity-1 : 0]; 	// actual buffer

//initialize some variables
initial begin
    population = 0;    write_ptr = 0;    read_ptr = 0;    data_out = 'bx;
	for( i = 0; i < capacity; i = i + 1) begin
		buffer[i] <= 'bx;
	end
end

assign empty = (population==0);
assign full = (population == capacity);

always@(flush)
begin
if( flush )	//if flushed both pointers return to 0
	begin
		write_ptr <= 0;		read_ptr <= 0;		population <= 0;	data_out = 'bx;
		for( i = 0; i < capacity; i = i + 1) begin
			buffer[i] <= 'bx;
		end
    end
end

always@(posedge write_clock)
begin
	if( !flush )
    begin
		if( !full && (enqueue) )  //if its not full and data is written to buffer
		begin
			buffer[ write_ptr ] <= data_in;
			write_ptr <= (write_ptr + 1)%capacity; //move pointer size of data;
			population <= population + 1;
		end
    end
end

always@(posedge read_clock)
begin
	if( !flush )
	begin
		if( !empty && (dequeue) )//if its not empty and data is being read
		begin
			data_out <= buffer[read_ptr];
			buffer[read_ptr] <= 'bx;
			read_ptr <= (read_ptr + 1)%capacity; //move the write pointer with the shift.
			population <= population - 1;
		end
    end
end
endmodule