class monitor#(parameter pck_sz=41, drvs=16);
  virtual mesh_gnrt _if;//instancia interfaz virtual
  transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;//instancia transaccion
  mon_chkr_mbx m_c_mbx;//mailbox que le pasa transacciones la checker
  int id_mon;
  task run();
    $display("[%g] MODO Monitor", $time);
    forever begin
      for(int i=0;i<16;i++)begin
      @(posedge _if.clk);
        
        _if.pop[i]<=1;//Agreguele valor de 1 a pop  
        trans=new;//construye nuevo objeto transaccion
        trans.target_row_out<=_if.data_out[i][pck_sz-9:pck_sz-12];//pasa la direccion de fila
        trans.target_column_out<=_if.data_out[i][pck_sz-13:pck_sz-16];//pasa la direccion de columna
        trans.mode<=_if.data_out[i][pck_sz-17];//pasa el modo de ruteo
        trans.payload<=_if.data_out[i][pck_sz-19:0];//pasa el contenido de mensaje
        m_c_mbx.put(trans); //se lo envia al checker para que lo revise
          $display("[%g]Se envia la transaccion con exito",$time);
        
       @(posedge _if.clk);
        _if.pop[i]<=0;//el proximo flanco de reloj pone el pop en 0
      end
    end
  endtask
endclass
