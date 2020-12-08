class test#(parameter pck_sz=41,drvs=16);
  test_gen_mbx t_g_mbx;
  test_score_mbx t_s_mbx;
  instrucciones_generador instruccion;
  solicitud_sb inst_sr;
  
  ambiente #(.pck_sz(pck_sz),.drvs(drvs)) ambiente_inst;
  
  virtual mesh_gnrt vdc;
  
  function new();
    t_g_mbx=new();
    t_s_mbx=new();
    
    ambiente_inst=new();
    ambiente_inst.vdc=vdc;
    ambiente_inst.t_g_mbx=t_g_mbx;
    ambiente_inst.ga0.t_g_mbx=t_g_mbx;
    ambiente_inst.t_s_mbx=t_s_mbx;
    ambiente_inst.s0.t_s_mbx=t_s_mbx;
  endfunction
  
  task run();
    $display("[%g]Test ha sido inicializado",$time);
    fork
      ambiente_inst.run();
    join_none
    
    instruccion=transacciones_aleatorizadas;
    t_g_mbx.put(instruccion);
    $display("[%0t]Test: Enviada la primera instruccion al generador transacciones aleatorias",$time);
    
    
    instruccion=un_solo_dispositivo;
    ambiente_inst.ga0.trgt_r_spec=0;
    ambiente_inst.ga0.trgt_c_spec=4;
    t_g_mbx.put(instruccion);
    $display("[%0t]Test: Enviada la segunda instruccion al generador un solo dispositivo",$time);
    
    
    #10000;
    $display("[T=%t] Test: Se alcanza el tiempo limite de la prueba",$time);
    inst_sr=retardo_promedio;
    t_s_mbx.put(inst_sr);
    inst_sr=reporte;
    t_s_mbx.put(inst_sr);
    inst_sr=archivo;
    t_s_mbx.put(inst_sr);
    
    $finish;
  endtask 
endclass
