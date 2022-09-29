`timescale 1ns/1ns
module MIPS32(input clk, rst);
    wire [5:0] opcode, func;
    wire zero, mem_read, mem_write, alu_src, reg_write;
    wire [1:0] reg_dst, pc_src, mem_to_reg;
    wire [2:0] alu_op;
    DataPath dp(
        reg_dst, pc_src, mem_to_reg, clk, rst, reg_write,
        mem_read, mem_write, alu_operation, alu_src,
        alu_op, opcode, func, zero
    );
    Controller cn(
        opcode, func, zero, mem_read, mem_write, alu_src,
        reg_write, reg_dst, pc_src, mem_to_reg, alu_op
    );
endmodule
