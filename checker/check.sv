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
  int transacciones_completadas=0;//cuentan las transacciones que llegan//
  int retardo;//Evalua el retardo de las transacciones que llegan del score y los drv_mon
  transaccion trans;//transacciones instancia
  transaccion trans1;//transaccion instacia
  transaccion auxiliar_score;//variable auxiliar de transaccion del scoreboard
  transaccion m[$];//       cola que almacenan transacciones que vienen de drv_mon //
  transaccion auxiliar_mon;//variable auxiliar de transaccion del drv_mon
  event completado;//  indica que las transacciones que vienen del drv_mon han llegado  //
  
  
 task verificacion();
    forever begin
      
      if(m_c_mbx1.num()>0)//la transaccion viene del driver 1 al monitor 1//
        m_c_mbx1.get(trans);
        $display("llega desde el monitor 1");
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
    end
      if(m_c_mbx2.num()>0)begin//la transaccion viene del driver 2 al monitor 2//
        $display("llega desde el monitor 2");
        m_c_mbx2.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx3.num()>0)begin//la transaccion viene del driver 3 al monitor 3//
        $display("llega desde el monitor 3");
        m_c_mbx3.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx4.num()>0)begin//la transaccion viene del driver 4 al monitor 4//
        $display("llega desde el monitor 4");
        m_c_mbx4.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx5.num()>0)begin//la transaccion viene del driver 5 al monitor 5//
        $display("llega desde el monitor 5");
        m_c_mbx5.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx6.num()>0)begin//la transaccion viene del driver 6 al monitor 6//
        $display("llega desde el monitor 6");
        m_c_mbx6.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx7.num()>0)begin//la transaccion viene del driver 7 al monitor 7//
        $display("llega desde el monitor 7");
        m_c_mbx7.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx8.num()>0)begin//la transaccion viene del driver 8 al monitor 8//
        $display("llega desde el monitor 8");
        m_c_mbx8.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx9.num()>0)begin//la transaccion viene del driver 9 al monitor 9//
        $display("llega desde el monitor 9");
        m_c_mbx9.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx10.num()>0)begin//la transaccion viene del driver 10 al monitor 10//
       $display("llega desde el monitor 10");
        m_c_mbx10.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx11.num()>0)begin//la transaccion viene del driver 11 al monitor 11//
        $display("llega desde el monitor 11");
        m_c_mbx11.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx12.num()>0)begin//la transaccion viene del driver 12 al monitor 12//
        $display("llega desde el monitor 12");
        m_c_mbx12.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx13.num()>0)begin//la transaccion viene del driver 13 al monitor 13//
        $display("llega desde el monitor 13");
        m_c_mbx13.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx14.num()>0)begin
        $display("llega desde el monitor 14");
        m_c_mbx14.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx15.num()>0)begin//la transaccion viene del driver 14 al monitor 14//
        $display("llega desde el monitor 15");
        m_c_mbx15.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
      end
      if(m_c_mbx16.num()>0)begin//la transaccion viene del driver 15 al monitor 15//
        $display("llega desde el monitor 16");
        m_c_mbx16.get(trans);
        trans.tiempo_recibido=$time;
        trans.completado=1;
        m.push_back(trans);
        transacciones_completadas++;
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
