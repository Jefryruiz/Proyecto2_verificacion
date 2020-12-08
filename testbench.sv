`timescale 1ns/1ps
`include "transacciones.sv"
`include "generator.sv"
`include "scoreboard.sv"
`include "driver.sv"
`include "checker.sv"
`include "ambiente.sv"
`include "test.sv"
`define FIFOS
`include "fifo.sv"
`include "Library.sv"
`define LIB
`include "Router_library.sv"

module test_bench;
  reg clk;
  parameter row=4;
  parameter columns=4;
  parameter pck_sz=41;
  parameter fifo_depth=4;
  parameter drvs=16;
  parameter broadcast={8{1'b1}};
  
  test #(.pck_sz(pck_sz),.drvs(drvs)) t0;
  
  
  mesh_gnrt #(.ROW(row),.COLUMS(columns),.pckg_sz(pck_sz),.fifo_depth(fifo_depth),.broadcast(broadcast)) vdc(.clk(clk));
  
  always #5 clk=~clk;
  
  mesh_gnrtr  #(.ROW(row),.COLUMS(columns),.pckg_sz(pck_sz),.fifo_depth(fifo_depth),.broadcast(broadcast)) uut (.pndng(vdc.pndng),.data_out(vdc.data_out),.popin(vdc.pop_in),.pop(vdc.pop),.data_out_i_in(vdc.data_out_i_in),.pndng_i_in(vdc.pndgn_i_in),.clk(vdc.clk),.reset(vdc.reset));
  
  initial begin
    clk=0;
    t0=new;
    t0.vdc=vdc;
    t0.ambiente_inst.d0.vdc=vdc;
    t0.ambiente_inst.d1.vdc=vdc;
    t0.ambiente_inst.d2.vdc=vdc;
    t0.ambiente_inst.d3.vdc=vdc;
    t0.ambiente_inst.d4.vdc=vdc;
    t0.ambiente_inst.d5.vdc=vdc;
    t0.ambiente_inst.d6.vdc=vdc;
    t0.ambiente_inst.d7.vdc=vdc;
    t0.ambiente_inst.d8.vdc=vdc;
    t0.ambiente_inst.d9.vdc=vdc;
    t0.ambiente_inst.d10.vdc=vdc;
    t0.ambiente_inst.d11.vdc=vdc;
    t0.ambiente_inst.d12.vdc=vdc;
    t0.ambiente_inst.d13.vdc=vdc;
    t0.ambiente_inst.d14.vdc=vdc;
    t0.ambiente_inst.d15.vdc=vdc;
    fork
    t0.run();
    join
  end
  
  always@(posedge clk)begin
    if($time>300000)begin
      $display("tiempo_limite de test");
      $finish;
    end
  end
  
endmodule
