interface mesh_gnrt#(parameter ROW=4,COLUMS=4,pckg_sz=41,fifo_depth=4)(input bit clk);
  logic reset;
  logic pndng[2*ROWS+2*COLUMS];
  logic [pckg_sz-1:0] data_out[ROWS*2+COLUMS*2];
  logic pop_in[ROWS*2+COLUMS*2];
  logic pop[ROWS*2+COLUMS*2];
  logic [pckg_sz-1:0] data_out_i_in[ROWS*2+COLUMS*2];
  logic pndgn_i_in[ROWS*2+COLUMS*2];
endinterface

class transaccion#(parameter pck_sz=41,drvs=16);
  rand bit [pck_sz-9:pck_sz-16] target;
  rand bit [pck_sz-17:0] mode;
  rand bit [pck_sz-18:0] payload;
  bit [pck_sz-1:pck_sz-8] next_jump;
  bit [pck_sz-1:0] dato;
  rand bit retardo;
  int retardo_max;
  rand int tiempo_envio;
  int tiempo_recibido;
  bit completado;
  int num_transacciones_completadas;
  rand bit [3:0] sender;
  rand bit [3:0] receptor;
  rand int num_transacciones;
  

  constraint trgt {target inside {01, 02, 03,04,51,52,53,54,10, 20,30,40,15,25,53,45};}            
  
  constraint mensajero_recep {sender>=0;
                             sender<drvs;
                             receptor>=0;
                             receptor<drvs;
                             receptor!=sender;}

  
  constraint modo  {mode inside {[0:1]};}
  
  
  constraint pld  {payload>=0;
                  payload<=256;}
  
  constraint ret {retardo<retardo_max;}
  
  constraint tmp_snd {tiempo_envio>0;}
  
  constraint num_trans {num_transacciones>=1;
                       num_transacciones<=60;}
  
  function void print(tag="");
    $display("[%g] %s target=0x%h payload=0x%h modo=%b sender=%0d receptor=%0d tiempo de envio=%g retardo=%g",$time,tag,this.target,this.payload,this.modo,this.sender,this.receptor,this.tiempo_envio,this.retardo);
  endfunction
  
endclass

//Enumerados que se usaran
typedef enum {transacciones_aleatorizadas, transacciones_especificas} instrucciones_generador;
//mailbox que se usaran
typedef mailbox #(instrucciones_generador) test_gen_mbx;
typedef mailbox #(transaccion) gen_agent_mbx;
typedef mailbox #(transaccion) agent_drv_mbx;
typedef mailbox #(transaccion) agent_score_mbx;
typedef mailbox #(transaccion) score_check_mbx;
typedef mailbox #(transaccion) mon_check_mbx;
