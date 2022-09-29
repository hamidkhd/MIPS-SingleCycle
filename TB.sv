`timescale 1ns/1ns
module TB();
	logic clk, rst;
	MIPS32 mips(clk, rst);
	initial begin
		#10 clk = 0;
		rst = 1;
		#10 rst = 0;
		repeat(1000) begin
			#10 clk = ~clk;
		end
	end
endmodule
