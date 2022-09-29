`timescale 1ns/1ns
module DataPath(
        input [1:0] reg_dst, pc_src, mem_to_reg,
        input clk, rst, reg_write, mem_read, mem_write, alu_operation, alu_src,
        input [2:0] alu_op,
        output reg [5:0] opcode, func, output reg zero
    );
    
    reg [31:0] pc_address, next_pc, pc_adder_out, write_data, read_data1,read_data2,
		sign_out, alu_b, alu_out, shift_out, data_out, pc_offset_add_out, instruction;              
    reg [4:0] write_address;
        
 	PC pc(next_pc, clk, rst, pc_address);
    Adder32 adder32_1(4, pc_address, pc_adder_out);
    InstMem instmem(pc_address, instruction);
    MUX3_5 mux3_5(instruction[20:16], instruction[15:11], 5'd31, reg_dst, write_address);
    RegFile regfile(instruction[25:21], instruction[20:16], write_address, write_data, clk, reg_write, read_data1, read_data2);
    SE se(instruction[15:0], sign_out);
    MUX2 mux2(read_data2, sign_out, alu_src, alu_b);
    ALU alu (read_data1, alu_b, alu_op, alu_out, zero); 
    Shift2 shift(sign_out, shift_out);
    Adder32 adder32_2(shift_out, pc_adder_out, pc_offset_add_out);
    MUX4 mux_pc(pc_adder_out, read_data1, {pc_address[31:28],instruction[25:0],pc_address[1:0]}, pc_offset_add_out, pc_src, next_pc);
    DataMem datamem(alu_out, read_data2, mem_read, mem_write, clk, data_out);
    MUX3_32 mux3_32(alu_out, data_out, pc_adder_out, mem_to_reg, write_data);

    assign opcode = instruction[31:26];
    assign func = instruction[5:0];
endmodule