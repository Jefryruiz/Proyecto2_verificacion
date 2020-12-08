class generator#(parameter pck_sz=41);
  test_gen_mbx t_g_mbx;//mailbox que se comunica con el test al generador_agente
  gen_agent_drv_mbx g_a_d_mbx1;/*16 mailboxes que se comunican con las 16 instancias de driver*/
  gen_agent_drv_mbx g_a_d_mbx2;
  gen_agent_drv_mbx g_a_d_mbx3;
  gen_agent_drv_mbx g_a_d_mbx4;
  gen_agent_drv_mbx g_a_d_mbx5;
  gen_agent_drv_mbx g_a_d_mbx6;
  gen_agent_drv_mbx g_a_d_mbx7;
  gen_agent_drv_mbx g_a_d_mbx8;
  gen_agent_drv_mbx g_a_d_mbx9;
  gen_agent_drv_mbx g_a_d_mbx10;
  gen_agent_drv_mbx g_a_d_mbx11;
  gen_agent_drv_mbx g_a_d_mbx12;
  gen_agent_drv_mbx g_a_d_mbx13;
  gen_agent_drv_mbx g_a_d_mbx14;
  gen_agent_drv_mbx g_a_d_mbx15;
  gen_agent_drv_mbx g_a_d_mbx16;
  gen_agent_score_mbx g_a_s_mbx;//mailbox que envia mensajes del generador_agente al scoreboard
  event drv_done0;///                                                     ///
  event drv_done1;//                                                        //
  event drv_done2;//                                                         //
  event drv_done3;//                                                         //
  event drv_done4;//                                                         //
  event drv_done5;//                                                          //
  event drv_done6;//                                                           //
  event drv_done7;//                                                           //  
  event drv_done8;//      Eventos que se comunican con los diferentes drivers  //
  event drv_done9;//                                                           //
  event drv_done10;//                                                            //
  event drv_done11;//                                                            //
  event drv_done12;//                                                            //
  event drv_done13;//                                                            //
  event drv_done14;//                                                            //
  event drv_done15;//                                                            //
  instrucciones_generador instrucciones;//comandos que vienen del test al generador_agente//
  randc int num_transacciones;//numero de transacciones//
  int ret_spec;//retardo especifico//
  int retardo_max;//retardo maximo//
  bit [pck_sz-9:pck_sz-12] trgt_r_spec;//Target de fila especifico//
  bit [pck_sz-9:pck_sz-12] trgt_c_spec;//Target de columna especifico//
  bit [pck_sz-17:pck_sz-18] mode_spec;//Modo especifico//
  bit [pck_sz-19:0] payload_spec;//Contenido de mensaje especifico//
  rand int ret;
  transaccion trans;//Transaccion//
  bit [pck_sz-1:0] dato;//El paquete que se envía//
  
  
  constraint Ret {ret>0;
                 ret<=10;}
  
   constraint num_trans {num_transacciones>=1;
                       num_transacciones<=60;}
  function new();
    num_transacciones=$random;
    retardo_max=15;
  endfunction
  
  
  task run();
    $display("[%g]GENERATOR:El generador fue inicializado",$time);
    
    if(t_g_mbx.num()>0)begin//si el mailbox del test no esta vacio
      $display("[%g] GENERATOR:Se recibe transaccion",$time);  
      t_g_mbx.get(instrucciones);//agarra la instruccion
      case(instrucciones)//ejecuta los posibles escenarios
      transacciones_aleatorizadas:begin//transacciones aleatoreas
        for(int i=0;i<15;i=i+1)begin
          trans=new;
          trans.retardo_max=retardo_max;
          trans.randomize() with {target_column_out==5 || target_column_out==0 || target_row_out==0 || target_row_out==5;};//se randomiza transaccion//
          trans.print("GENERATOR:transaccion creada");
          dato={trans.next_jump,trans.target_row_out,trans.target_column_out,trans.mode,trans.payload};
        trans.dato=dato;//concatena partes del paquete en uno solo y se lo devuelve a transaccion
          
          if(trans.sender==0)//si el envio viene del dispotivo 0
           $display("La transaccion se envia desde el dispositivo %0d",0);
            g_a_d_mbx1.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done0.triggered);
          if(trans.sender==1)//si el envio viene del dispotivo 1
            $display("La transaccion se envia desde el dispositivo %0d",1);
            g_a_d_mbx2.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done1.triggered);
          if(trans.sender==2)//si el envio viene del dispotivo 2
            $display("La transaccion se envia desde el dispositivo %0d",2);
            g_a_d_mbx3.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done2.triggered);
          if(trans.sender==3)//si el envio viene del dispotivo 3
            $display("La transaccion se envia desde el dispositivo %0d",3);
            g_a_d_mbx4.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done3.triggered);
          if(trans.sender==4)//si el envio viene del dispotivo 4
            $display("La transaccion se envia desde el dispositivo %0d",4);
            g_a_d_mbx5.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done4.triggered);
          if(trans.sender==5)//si el envio viene del dispotivo 5
            $display("La transaccion se envia desde el dispositivo %0d",5);
            g_a_d_mbx6.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done5.triggered);
          if(trans.sender==6)//si el envio viene del dispotivo 6
            $display("La transaccion se envia desde el dispositivo %0d",6);
            g_a_d_mbx7.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done6.triggered);
          if(trans.sender==7)//si el envio viene del dispotivo 7
            $display("La transaccion se envia desde el dispositivo %0d",7);
            g_a_d_mbx8.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done7.triggered);
          if(trans.sender==8)//si el envio viene del dispotivo 8
            $display("La transaccion se envia desde el dispositivo %0d",8);
            g_a_d_mbx9.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done8.triggered);
          if(trans.sender==9)//si el envio viene del dispotivo 9
            $display("La transaccion se envia desde el dispositivo %0d",9);
            g_a_d_mbx10.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done9.triggered);
          if(trans.sender==10)//si el envio viene del dispotivo 10
            $display("La transaccion se envia desde el dispositivo %0d",10);
            g_a_d_mbx11.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done10.triggered);
          if(trans.sender==11)//si el envio viene del dispotivo 11
            $display("La transaccion se envia desde el dispositivo %0d",11);
            g_a_d_mbx12.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done11.triggered);
          if(trans.sender==12)//si el envio viene del dispotivo 12
            $display("La transaccion se envia desde el dispositivo %0d",12);
            g_a_d_mbx13.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done12.triggered);
          if(trans.sender==13)//si el envio viene del dispotivo 13
            $display("La transaccion se envia desde el dispositivo %0d",13);
            g_a_d_mbx14.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done13.triggered);
          if(trans.sender==14)//si el envio viene del dispotivo 14
            $display("La transaccion se envia desde el dispositivo %0d",14);
            g_a_d_mbx15.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done14.triggered);
          if(trans.sender==15)//si el envio viene del dispotivo 15
            $display("La transaccion se envia desde el dispositivo %0d",15);
            g_a_d_mbx16.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done15.triggered);
        end
      end
      transacciones_alternadas:begin//transacciones con contenido especifico(unos y ceros)
        for(int i=0;i< 10;i++)begin
          trans=new;
          trans.retardo_max=retardo_max;
          trans.randomize() with {target_column_out==5 || target_column_out==0 || target_row_out==0 || target_row_out==5;};//se randomiza transaccion//
          trans.target_row_out=trgt_r_spec;
          trans.target_column_out=trgt_c_spec;
          trans.mode=mode_spec;
          trans.payload={22{1'b1}};
          trans.retardo=ret_spec;
          trans.print("GENERATOR:transaccion creada");
          dato={trans.next_jump,trans.target_row_out,trans.target_column_out,trans.mode,trans.payload};
        trans.dato=dato;//concatena partes del paquete en uno solo y se lo devuelve a transaccion
          
          if(trans.sender==0)//si el envio viene del dispotivo 0
           $display("La transaccion se envia desde el dispositivo %0d",0);
            g_a_d_mbx1.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done0.triggered);
          if(trans.sender==1)//si el envio viene del dispotivo 1
            $display("La transaccion se envia desde el dispositivo %0d",1);
            g_a_d_mbx2.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done1.triggered);
          if(trans.sender==2)//si el envio viene del dispotivo 2
            $display("La transaccion se envia desde el dispositivo %0d",2);
            g_a_d_mbx3.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done2.triggered);
          if(trans.sender==3)//si el envio viene del dispotivo 3
            $display("La transaccion se envia desde el dispositivo %0d",3);
            g_a_d_mbx4.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done3.triggered);
          if(trans.sender==4)//si el envio viene del dispotivo 4
            $display("La transaccion se envia desde el dispositivo %0d",4);
            g_a_d_mbx5.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done4.triggered);
          if(trans.sender==5)//si el envio viene del dispotivo 5
            $display("La transaccion se envia desde el dispositivo %0d",5);
            g_a_d_mbx6.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done5.triggered);
          if(trans.sender==6)//si el envio viene del dispotivo 6
            $display("La transaccion se envia desde el dispositivo %0d",6);
            g_a_d_mbx7.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done6.triggered);
          if(trans.sender==7)//si el envio viene del dispotivo 7
            $display("La transaccion se envia desde el dispositivo %0d",7);
            g_a_d_mbx8.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done7.triggered);
          if(trans.sender==8)//si el envio viene del dispotivo 8
            $display("La transaccion se envia desde el dispositivo %0d",8);
            g_a_d_mbx9.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done8.triggered);
          if(trans.sender==9)//si el envio viene del dispotivo 9
            $display("La transaccion se envia desde el dispositivo %0d",9);
            g_a_d_mbx10.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done9.triggered);
          if(trans.sender==10)//si el envio viene del dispotivo 10
            $display("La transaccion se envia desde el dispositivo %0d",10);
            g_a_d_mbx11.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done10.triggered);
          if(trans.sender==11)//si el envio viene del dispotivo 11
            $display("La transaccion se envia desde el dispositivo %0d",11);
            g_a_d_mbx12.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done11.triggered);
          if(trans.sender==12)//si el envio viene del dispotivo 12
            $display("La transaccion se envia desde el dispositivo %0d",12);
            g_a_d_mbx13.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done12.triggered);
          if(trans.sender==13)//si el envio viene del dispotivo 13
            $display("La transaccion se envia desde el dispositivo %0d",13);
            g_a_d_mbx14.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done13.triggered);
          if(trans.sender==14)//si el envio viene del dispotivo 14
            $display("La transaccion se envia desde el dispositivo %0d",14);
            g_a_d_mbx15.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done14.triggered);
          if(trans.sender==15)//si el envio viene del dispotivo 15
            $display("La transaccion se envia desde el dispositivo %0d",15);
            g_a_d_mbx16.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done15.triggered);
        end
        for(int i=0;i< 10;i++)begin
          trans=new;
          trans.retardo_max=retardo_max;
          trans.randomize() with {target_column_out==5 || target_column_out==0 || target_row_out==0 || target_row_out==5;};//se randomiza transaccion//
          trans.target_row_out=trgt_r_spec;
          trans.target_column_out=trgt_c_spec;
          trans.mode=mode_spec;
          trans.payload={22{1'b0}};
          trans.retardo=ret_spec;
          trans.print("GENERATOR:transaccion creada");
          dato={trans.next_jump,trans.target_row_out,trans.target_column_out,trans.mode,trans.payload};
        trans.dato=dato;//concatena partes del paquete en uno solo y se lo devuelve a transaccion
          
          
          if(trans.sender==0)//si el envio viene del dispotivo 0
           $display("La transaccion se envia desde el dispositivo %0d",0);
            g_a_d_mbx1.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done0.triggered);
          if(trans.sender==1)//si el envio viene del dispotivo 1
            $display("La transaccion se envia desde el dispositivo %0d",1);
            g_a_d_mbx2.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done1.triggered);
          if(trans.sender==2)//si el envio viene del dispotivo 2
            $display("La transaccion se envia desde el dispositivo %0d",2);
            g_a_d_mbx3.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done2.triggered);
          if(trans.sender==3)//si el envio viene del dispotivo 3
            $display("La transaccion se envia desde el dispositivo %0d",3);
            g_a_d_mbx4.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done3.triggered);
          if(trans.sender==4)//si el envio viene del dispotivo 4
            $display("La transaccion se envia desde el dispositivo %0d",4);
            g_a_d_mbx5.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done4.triggered);
          if(trans.sender==5)//si el envio viene del dispotivo 5
            $display("La transaccion se envia desde el dispositivo %0d",5);
            g_a_d_mbx6.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done5.triggered);
          if(trans.sender==6)//si el envio viene del dispotivo 6
            $display("La transaccion se envia desde el dispositivo %0d",6);
            g_a_d_mbx7.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done6.triggered);
          if(trans.sender==7)//si el envio viene del dispotivo 7
            $display("La transaccion se envia desde el dispositivo %0d",7);
            g_a_d_mbx8.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done7.triggered);
          if(trans.sender==8)//si el envio viene del dispotivo 8
            $display("La transaccion se envia desde el dispositivo %0d",8);
            g_a_d_mbx9.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done8.triggered);
          if(trans.sender==9)//si el envio viene del dispotivo 9
            $display("La transaccion se envia desde el dispositivo %0d",9);
            g_a_d_mbx10.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done9.triggered);
          if(trans.sender==10)//si el envio viene del dispotivo 10
            $display("La transaccion se envia desde el dispositivo %0d",10);
            g_a_d_mbx11.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done10.triggered);
          if(trans.sender==11)//si el envio viene del dispotivo 11
            $display("La transaccion se envia desde el dispositivo %0d",11);
            g_a_d_mbx12.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done11.triggered);
          if(trans.sender==12)//si el envio viene del dispotivo 12
            $display("La transaccion se envia desde el dispositivo %0d",12);
            g_a_d_mbx13.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done12.triggered);
          if(trans.sender==13)//si el envio viene del dispotivo 13
            $display("La transaccion se envia desde el dispositivo %0d",13);
            g_a_d_mbx14.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done13.triggered);
          if(trans.sender==14)//si el envio viene del dispotivo 14
            $display("La transaccion se envia desde el dispositivo %0d",14);
            g_a_d_mbx15.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done14.triggered);
          if(trans.sender==15)//si el envio viene del dispotivo 15
            $display("La transaccion se envia desde el dispositivo %0d",15);
            g_a_d_mbx16.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done15.triggered);
        end
       end
        un_solo_dispositivo:begin//Transacciones se envia a un dispositivo destino
          for(int i=0;i<10;i=i+1)begin
          trans=new;
          trans.retardo_max=retardo_max;  
          trans.randomize() with {target_column_out==5 || target_column_out==0 || target_row_out==0 || target_row_out==5;};//se randomiza transaccion//  
          trans.target_row_out=trgt_r_spec;
          trans.target_column_out=trgt_c_spec;
          trans.payload=payload_spec;
          trans.mode=mode_spec;  
          trans.print("GENERATOR:transaccion creada");
            dato={trans.next_jump,trans.target_row_out,trans.target_column_out,trans.mode,trans.payload};
        trans.dato=dato;//concatena partes del paquete en uno solo y se lo devuelve a transaccion
          
          if(trans.sender==0)//si el envio viene del dispotivo 0
           $display("La transaccion se envia desde el dispositivo %0d",0);
            g_a_d_mbx1.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done0.triggered);
          if(trans.sender==1)//si el envio viene del dispotivo 1
            $display("La transaccion se envia desde el dispositivo %0d",1);
            g_a_d_mbx2.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done1.triggered);
          if(trans.sender==2)//si el envio viene del dispotivo 2
            $display("La transaccion se envia desde el dispositivo %0d",2);
            g_a_d_mbx3.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done2.triggered);
          if(trans.sender==3)//si el envio viene del dispotivo 3
            $display("La transaccion se envia desde el dispositivo %0d",3);
            g_a_d_mbx4.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done3.triggered);
          if(trans.sender==4)//si el envio viene del dispotivo 4
            $display("La transaccion se envia desde el dispositivo %0d",4);
            g_a_d_mbx5.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done4.triggered);
          if(trans.sender==5)//si el envio viene del dispotivo 5
            $display("La transaccion se envia desde el dispositivo %0d",5);
            g_a_d_mbx6.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done5.triggered);
          if(trans.sender==6)//si el envio viene del dispotivo 6
            $display("La transaccion se envia desde el dispositivo %0d",6);
            g_a_d_mbx7.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done6.triggered);
          if(trans.sender==7)//si el envio viene del dispotivo 7
            $display("La transaccion se envia desde el dispositivo %0d",7);
            g_a_d_mbx8.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done7.triggered);
          if(trans.sender==8)//si el envio viene del dispotivo 8
            $display("La transaccion se envia desde el dispositivo %0d",8);
            g_a_d_mbx9.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done8.triggered);
          if(trans.sender==9)//si el envio viene del dispotivo 9
            $display("La transaccion se envia desde el dispositivo %0d",9);
            g_a_d_mbx10.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done9.triggered);
          if(trans.sender==10)//si el envio viene del dispotivo 10
            $display("La transaccion se envia desde el dispositivo %0d",10);
            g_a_d_mbx11.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done10.triggered);
          if(trans.sender==11)//si el envio viene del dispotivo 11
            $display("La transaccion se envia desde el dispositivo %0d",11);
            g_a_d_mbx12.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done11.triggered);
          if(trans.sender==12)//si el envio viene del dispotivo 12
            $display("La transaccion se envia desde el dispositivo %0d",12);
            g_a_d_mbx13.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done12.triggered);
          if(trans.sender==13)//si el envio viene del dispotivo 0¿13
            $display("La transaccion se envia desde el dispositivo %0d",13);
            g_a_d_mbx14.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done13.triggered);
          if(trans.sender==14)//si el envio viene del dispotivo 14
            $display("La transaccion se envia desde el dispositivo %0d",14);
            g_a_d_mbx15.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done14.triggered);
          if(trans.sender==15)//si el envio viene del dispotivo 15
            $display("La transaccion se envia desde el dispositivo %0d",15);
            g_a_d_mbx16.put(trans);
            g_a_s_mbx.put(trans);
            wait(drv_done15.triggered);
        end
        end
      endcase
      end
  endtask
endclass
