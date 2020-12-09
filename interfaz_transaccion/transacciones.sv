interface mesh_gnrt#(parameter ROW=4,COLUMS=4,pckg_sz=41,fifo_depth=4)(input bit clk);
  logic reset;
  logic pndng[2*ROWS+2*COLUMS];
  logic [pckg_sz-1:0] data_out[ROWS*2+COLUMS*2];
  logic pop_in[ROWS*2+COLUMS*2];
  logic pop[ROWS*2+COLUMS*2];
  logic [pckg_sz-1:0] data_out_i_in[ROWS*2+COLUMS*2];
  logic pndgn_i_in[ROWS*2+COLUMS*2];
endinterface

class transaccion#(parameter pck_sz=41,drvs=16);//transaccion que se le pasa al driver
  rand bit [pck_sz-9:pck_sz-12] target_row_out;//direccion de fila destino
  rand bit [pck_sz-13:pck_sz-16] target_column_out;//direccion de columna destino
  rand bit [pck_sz-17:pck_sz-18] mode;//modo de ruteo
  rand bit [pck_sz-19:0] payload;//contenido del mensaje 
  bit [pck_sz-1:pck_sz-8] next_jump;//salto
  bit [pck_sz-1:0] dato;//dato en el que se concatenan las partes del paquete
  int tiempo;
  randc int retardo;
  int retardo_max;//retardo maximo de envio
  rand int tiempo_envio;
  int tiempo_recibido;
  bit completado;//si se completo la transaccion
  int num_transacciones_completadas;
  randc bit [3:0] sender;//fuente
  bit [3:0] receptor;
  
  function new(bit NJ=0);//inicializa el next jump, todos los bits en cero
    next_jump=NJ;
  endfunction
  
  constraint trgt1 {target_row_out inside{0,1,2,3,4,5};}//randomiza direccion de fila
  
  constraint trgt2 {target_column_out inside{0,1,2,3,4,5};}//randomiza direccion de columna
  
  constraint trgt3 {(target_column_out==0 || target_column_out==5) -> target_row_out inside{1,2,3,4};}//agarra los id externos
  
  constraint trgt4 {(target_row_out==0 || target_row_out==5) -> target_column_out inside{1,2,3,4};}//agarra los id externos
  
  constraint source {sender>=0;
                     sender<=15;} //configura la fuente
 
  constraint mod  {mode inside {0,1};}//configura el modo de ruteo
  
  constraint pld  {payload>=0;
                   payload<=256;}//randomiza el contenido
  
  constraint ret {retardo>0;
                  retardo<=retardo_max;}//randomiza el retardo y lo limita
  
  constraint tmp_snd {tiempo_envio>=1;
                      tiempo_envio<=15;}//randomiza el tienpo de envio del mensaje

  
  function void print(string tag="");
    $display("[%g] %s target_row_out=%d target_colunm_out=%d  payload=%d modo=%0b sender=%0d receptor=%0d tiempo de envio=%g retardo=%d ",$time,tag,this.target_row_out, this.target_column_out, this.payload,this.mode,this.sender,this.receptor,this.tiempo_envio,this.retardo);
  endfunction
  
endclass

//Enumerados que se usaran
typedef enum {transacciones_aleatorizadas, transacciones_especificas,transacciones_alternadas,un_solo_dispositivo} instrucciones_generador;
typedef enum {retardo_promedio,reporte, archivo} solicitud_sb;
//mailbox que se usaran
typedef mailbox #(instrucciones_generador) test_gen_mbx;
typedef mailbox #(transaccion) gen_agent_drv_mbx;
typedef mailbox #(transaccion) gen_agent_score_mbx;
typedef mailbox #(transaccion) score_check_mbx;
typedef mailbox #(transaccion) check_score_mbx;
typedef mailbox #(solicitud_sb) test_score_mbx;
typedef mailbox #(transaccion) drv_chkr_mbx;
