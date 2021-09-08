
/* CTRL --> 1 FOR OUT = IN
	    0 FOR OUT = Z */
module Tristate  (ctrl, in, out);
	input in;
	input ctrl;
	output out;

assign out = (ctrl) ? in : 1'bz;

endmodule
		  