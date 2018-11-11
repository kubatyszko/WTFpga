`timescale 1ns / 1ps
//define our module and it's inputs/outputs
module top(
	input CLK,
	input BTN1,
	input BTN2,
	input BTN3,
	input BTN_N,
	input [7:0] sw,
	output [4:0] led,
	output [6:0] seg,
	output ca
    );

//define wires and registers here
	wire [7:0] disp0,disp1;
	wire displayClock;
	wire[7:0] dispValue;
	wire[7:0] sum;
	//wire wire1, wire2;
	reg[7:0] storedValue;
	
//parallel assignments can go here
	assign led[4:0]=sw[4:0];
	assign dispValue = BTN1?sum:(BTN2?storedValue:sw);
	assign sum=sw+storedValue;
	

//always @ blocks can go here
	always @(negedge BTN_N)
		
	begin
		storedValue<=sw;
	end
		
//		commmands-to-run-when-triggered;

//instantiate modules here
	nibble_to_seven_seg nibble0(
		.nibblein(dispValue[3:0]),
		.segout(disp0)
	);	 
	nibble_to_seven_seg nibble1(
		.nibblein(sw[7:4]),
		.segout(disp1)
	);	 
	 
	 
	clkdiv displayClockGen(
		.clk(CLK),
		.clkout(displayClock)
	);

	seven_seg_mux display(
		.clk(displayClock),
		.disp0(disp0),
		.disp1(disp1),
		.segout(seg),
		.disp_sel(ca)
	);

endmodule
