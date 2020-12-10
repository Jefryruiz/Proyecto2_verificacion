`timescale 1ns/1ps
//incluye todos los elementos de ambiente
`include "interfaz.sv"
`include "transacciones.sv"
`include "generator.sv"
`include "scoreboard.sv"
`include "driver.sv"
`include "monitor.sv"
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
  
  test #(.pck_sz(pck_sz),.drvs(drvs)) t0;//instancia el test
  
  
  mesh_gnrt #(.ROW(row),.COLUMS(columns),.pckg_sz(pck_sz),.fifo_depth(fifo_depth),.broadcast(broadcast)) vdc(.clk(clk));//inicializa la interfaz
  
  always #1 clk=~clk;//configura el reloj
  
  mesh_gnrtr  #(.ROW(row),.COLUMS(columns),.pckg_sz(pck_sz),.fifo_depth(fifo_depth),.broadcast(broadcast)) uut (.pndng(vdc.pndng),.data_out(vdc.data_out),.popin(vdc.pop_in),.pop(vdc.pop),.data_out_i_in(vdc.data_out_i_in),.pndng_i_in(vdc.pndgn_i_in),.clk(vdc.clk),.reset(vdc.reset));//instancia el DUT
  
  initial begin
    clk=0;//inicia el reloj en cero
    t0=new;//construye el test
    t0.vdc=vdc;//conecta el test a la interfaz virtual
    t0.ambiente_inst.d0.vdc=vdc;//conecta para los 16 drivers_monitor la interfaz virtual 
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
    t0.ambiente_inst.m0._if=vdc;//conecta para los 16 drivers y monitores la interfaz virtual 
    t0.ambiente_inst.m1._if=vdc;
    t0.ambiente_inst.m2._if=vdc;
    t0.ambiente_inst.m3._if=vdc;
    t0.ambiente_inst.m4._if=vdc;
    t0.ambiente_inst.m5._if=vdc;
    t0.ambiente_inst.m6._if=vdc;
    t0.ambiente_inst.m7._if=vdc;
    t0.ambiente_inst.m8._if=vdc;
    t0.ambiente_inst.m9._if=vdc;
    t0.ambiente_inst.m10._if=vdc;
    t0.ambiente_inst.m11._if=vdc;
    t0.ambiente_inst.m12._if=vdc;
    t0.ambiente_inst.m13._if=vdc;
    t0.ambiente_inst.m14._if=vdc;
    t0.ambiente_inst.m15._if=vdc;
    fork
      t0.run();//corre el test como proceso hijo
    join
  end
  
  always@(posedge clk)begin//si se sobrepasa el tiempo de prueba termine el test
    if($time>3000000)begin
      $display("tiempo_limite de test");
      $finish;
    end
  end
  
endmodule
