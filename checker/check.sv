class check#(parameter pck_sz=41);
  check_score_mbx c_s_mbx;//mailbox que pasa mensajes desde el checker al scoreboard(retardo, reporte)//
  score_check_mbx s_c_mbx;//mailbox que recibe transacciones desde el scoreboard
  drv_chkr_mbx m_c_mbx1;//                                                      //
  drv_chkr_mbx m_c_mbx2;//                                                      //
  drv_chkr_mbx m_c_mbx3;//                                                      //
  drv_chkr_mbx m_c_mbx4;//                                                      //
  drv_chkr_mbx m_c_mbx5;//                                                      //
  drv_chkr_mbx m_c_mbx6;//                                                      //
  drv_chkr_mbx m_c_mbx7;//                                                      //
  drv_chkr_mbx m_c_mbx8;//                                                      //
  drv_chkr_mbx m_c_mbx9;// mailboxes que recibe transacciones desde los drivers_monitor//
  drv_chkr_mbx m_c_mbx10;//                                                      //
  drv_chkr_mbx m_c_mbx11;//                                                      //
  drv_chkr_mbx m_c_mbx12;//                                                      //
  drv_chkr_mbx m_c_mbx13;//                                                      //
  drv_chkr_mbx m_c_mbx14;//                                                      //
  drv_chkr_mbx m_c_mbx15;//                                                      //
  drv_chkr_mbx m_c_mbx16;//                                                      //
  drv_chkr_mbx c_c_mbx;  //mailbox interno del mismo checker ***
  int transacciones_completadas=0;//cuentan las transacciones que llegan//
  int retardo;//Evalua el retardo de las transacciones que llegan del score y los drv_mon
  transaccion trans;//transacciones instancia
  transaccion trans1;//transaccion instacia
  transaccion auxiliar_score;//variable auxiliar de transaccion del scoreboard
  transaccion m[$];//       cola que almacenan transacciones que vienen de drv_mon //
  transaccion auxiliar_mon;//variable auxiliar de transaccion del drv_mon
  event completado;//  indica que las transacciones que vienen del drv_mon han llegado  //
  int drvs=16; // numero total de drivers
  
 task verificacion();
    forever begin       //cambio sobre lectura de los mbxs
      for(int i=0;i<drvs;i++) begin
       case(i)
         0: c_c_mbx = m_c_mbx1;
         1: c_c_mbx = m_c_mbx2;
         2: c_c_mbx = m_c_mbx3;
         3: c_c_mbx = m_c_mbx4;
         4: c_c_mbx = m_c_mbx5;
         5: c_c_mbx = m_c_mbx6;
         6: c_c_mbx = m_c_mbx7;
         7: c_c_mbx = m_c_mbx8;
         8: c_c_mbx = m_c_mbx9;
         9: c_c_mbx = m_c_mbx10;
         10: c_c_mbx = m_c_mbx11;
         11: c_c_mbx = m_c_mbx12;
         12: c_c_mbx = m_c_mbx13;
         13: c_c_mbx = m_c_mbx14;
         14: c_c_mbx = m_c_mbx15;
         15: c_c_mbx = m_c_mbx16;
       endcase
       c_c_mbx.get(trans);
       if(c_c_mbx.num()>0 and trans.sender == i)begin
         $display("llega desde el monitor=%0d", trans.receptor);
         trans.tiempo_recibido=$time;
         trans.completado=1;
         m.push_back(trans);
         transacciones_completadas++;
       end
     end      
   
      #1->completado;
      
      if(s_c_mbx.num()>0)begin//evalua el retardo y la integridad del paquete recibido
          s_c_mbx.get(trans1);
          auxiliar_score=trans1;
          auxiliar_mon=m.pop_front();
          retardo=auxiliar_score.tiempo_envio-auxiliar_mon.tiempo_recibido;
          trans1.retardo=retardo;
          if(auxiliar_score.target_column_out==auxiliar_mon.target_column_out && auxiliar_score.target_row_out==auxiliar_mon.target_row_out)begin
            $display("[pass] Destino esperado trgt_r_out=%d trgt_c_out=%d", auxiliar_mon.target_row_out,auxiliar_mon.target_column_out);
          end else begin
            $display("[fail] Destino corrupto trgt_r_out=%d trgt_c_out=%d", auxiliar_mon.target_row_out,auxiliar_mon.target_column_out);
          end
          if(auxiliar_score.mode==auxiliar_mon.mode)begin
            $display("[pass] El modo es coincidente %b",auxiliar_score.mode);
            if(auxiliar_score.mode)begin
              $display("[pass]El modo de ruteo es por fila");
            end else begin
              $display("[pass]El modo de ruteo es por columna");
            end
          end else begin
            $display("[fail] El modo no es coincidente %b",auxiliar_mon.mode);
          end
          if(auxiliar_score.payload==auxiliar_mon.payload)begin
            $display("[pass] El mensaje de envio coincide con el recibido, pld=%d", auxiliar_score.payload);
          end else begin
            $display("[fail] El mensaje de envio no es igual al recibido, pld=%d", auxiliar_mon.payload);
            end 
     c_s_mbx.put(trans);
     wait(completado.triggered); 
     trans.completado=0;
        $display("%d",trans.completado);  
      end
    end
  endtask
  
  task run();
    fork
    verificacion();
    join
  endtask
  
endclass
