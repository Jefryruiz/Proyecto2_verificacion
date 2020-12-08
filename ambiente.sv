class ambiente#(parameter pck_sz=41,drvs=16);
  generator #(.pck_sz(pck_sz),.drvs(drvs)) ga0;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d0;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d1;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d2;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d3;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d4;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d5;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d6;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d7;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d8;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d9;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d10;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d11;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d12;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d13;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d14;
  driver #(.pck_sz(pck_sz),.drvs(drvs)) d15;
  score_board #(.pck_sz(pck_sz),.drvs(drvs)) s0;
  check #(.pck_sz(pck_sz),.drvs(drvs)) c0;
  
  virtual mesh_gnrt vdc;
  
  event drv_done0;
  event drv_done1;
  event drv_done2;
  event drv_done3;
  event drv_done4;
  event drv_done5;
  event drv_done6;
  event drv_done7;
  event drv_done8;
  event drv_done9;
  event drv_done10;
  event drv_done11;
  event drv_done12;
  event drv_done13;
  event drv_done14;
  event drv_done15;
  
  test_gen_mbx t_g_mbx;
  test_score_mbx t_s_mbx;
 
  gen_agent_drv_mbx g_a_d_mbx;
  gen_agent_score_mbx g_a_s_mbx;
  
  gen_agent_drv_mbx g_a_d_mbx1;
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
  
  check_score_mbx c_s_mbx;
  score_check_mbx s_c_mbx;
  
  drv_chkr_mbx m_c_mbx1;
  drv_chkr_mbx m_c_mbx2;
  drv_chkr_mbx m_c_mbx3;
  drv_chkr_mbx m_c_mbx4;
  drv_chkr_mbx m_c_mbx5;
  drv_chkr_mbx m_c_mbx6;
  drv_chkr_mbx m_c_mbx7;
  drv_chkr_mbx m_c_mbx8;
  drv_chkr_mbx m_c_mbx9;
  drv_chkr_mbx m_c_mbx10;
  drv_chkr_mbx m_c_mbx11;
  drv_chkr_mbx m_c_mbx12;
  drv_chkr_mbx m_c_mbx13;
  drv_chkr_mbx m_c_mbx14;
  drv_chkr_mbx m_c_mbx15;
  drv_chkr_mbx m_c_mbx16;
  
  
  function new();
  t_g_mbx=new();
  t_s_mbx=new();  
   
  g_a_s_mbx=new;
  g_a_d_mbx=new;
    
  g_a_d_mbx1=new;
  g_a_d_mbx2=new;
  g_a_d_mbx3=new;
  g_a_d_mbx4=new;
  g_a_d_mbx5=new;
  g_a_d_mbx6=new;
  g_a_d_mbx7=new;
  g_a_d_mbx8=new;
  g_a_d_mbx9=new;
  g_a_d_mbx10=new;
  g_a_d_mbx11=new;
  g_a_d_mbx12=new;
  g_a_d_mbx13=new;
  g_a_d_mbx14=new;
  g_a_d_mbx15=new;
  g_a_d_mbx16=new;
    
  c_s_mbx=new;
  s_c_mbx=new;
    
  m_c_mbx1=new;
  m_c_mbx2=new;
  m_c_mbx3=new;
  m_c_mbx4=new;
  m_c_mbx5=new;
  m_c_mbx6=new;
  m_c_mbx7=new;
  m_c_mbx8=new;
  m_c_mbx9=new;
  m_c_mbx10=new;
  m_c_mbx11=new;
  m_c_mbx12=new;
  m_c_mbx13=new;
  m_c_mbx14=new;
  m_c_mbx15=new;
  m_c_mbx16=new;   
    
    
    ga0=new();
    s0=new();
    c0=new();
    d0=new();
    d1=new();
    d2=new();
    d3=new();
    d4=new();
    d5=new();
    d6=new();
    d7=new();
    d8=new();
    d9=new();
    d10=new();
    d11=new();
    d12=new();
    d13=new();
    d14=new();
    d15=new();
    
    ga0.t_g_mbx=t_g_mbx;
    ga0.g_a_s_mbx=g_a_s_mbx;
    s0.g_a_s_mbx=g_a_s_mbx;
    s0.t_s_mbx=t_s_mbx;
    
    s0.s_c_mbx=s_c_mbx;
    c0.s_c_mbx=s_c_mbx;
    
    c0.c_s_mbx=c_s_mbx;
    s0.c_s_mbx=c_s_mbx;
    
    d0.vdc=vdc;
    d1.vdc=vdc;
    d2.vdc=vdc;
    d3.vdc=vdc;
    d4.vdc=vdc;
    d5.vdc=vdc;
    d6.vdc=vdc;
    d7.vdc=vdc;
    d8.vdc=vdc;
    d9.vdc=vdc;
    d10.vdc=vdc;
    d11.vdc=vdc;
    d12.vdc=vdc;
    d13.vdc=vdc;
    d14.vdc=vdc;
    d15.vdc=vdc;
    
    
    
    ga0.g_a_d_mbx1=g_a_d_mbx1;
    d0.g_a_d_mbx=g_a_d_mbx1;
    ga0.g_a_d_mbx2=g_a_d_mbx2;
    d1.g_a_d_mbx=g_a_d_mbx2;
    ga0.g_a_d_mbx3=g_a_d_mbx3;
    d2.g_a_d_mbx=g_a_d_mbx3;
    ga0.g_a_d_mbx4=g_a_d_mbx4;
    d3.g_a_d_mbx=g_a_d_mbx4; 
    ga0.g_a_d_mbx5=g_a_d_mbx5;
    d4.g_a_d_mbx=g_a_d_mbx5; 
    ga0.g_a_d_mbx6=g_a_d_mbx6;
    d5.g_a_d_mbx=g_a_d_mbx6; 
    ga0.g_a_d_mbx7=g_a_d_mbx7;
    d6.g_a_d_mbx=g_a_d_mbx7; 
    ga0.g_a_d_mbx8=g_a_d_mbx8;
    d7.g_a_d_mbx=g_a_d_mbx8; 
    ga0.g_a_d_mbx9=g_a_d_mbx9;
    d8.g_a_d_mbx=g_a_d_mbx9; 
    ga0.g_a_d_mbx10=g_a_d_mbx10;
    d9.g_a_d_mbx=g_a_d_mbx10; 
    ga0.g_a_d_mbx11=g_a_d_mbx11;
    d10.g_a_d_mbx=g_a_d_mbx11; 
    ga0.g_a_d_mbx12=g_a_d_mbx12;
    d11.g_a_d_mbx=g_a_d_mbx12; 
    ga0.g_a_d_mbx13=g_a_d_mbx13;
    d12.g_a_d_mbx=g_a_d_mbx13; 
    ga0.g_a_d_mbx14=g_a_d_mbx14;
    d13.g_a_d_mbx=g_a_d_mbx14; 
    ga0.g_a_d_mbx15=g_a_d_mbx15;
    d14.g_a_d_mbx=g_a_d_mbx15;
    ga0.g_a_d_mbx16=g_a_d_mbx16;
    d15.g_a_d_mbx=g_a_d_mbx16;
    
    c0.m_c_mbx1=m_c_mbx1;
    d0.d_c_mbx=m_c_mbx1;
    c0.m_c_mbx2=m_c_mbx2;
    d1.d_c_mbx=m_c_mbx2;
    c0.m_c_mbx3=m_c_mbx3;
    d2.d_c_mbx=m_c_mbx3;
    c0.m_c_mbx4=m_c_mbx4;
    d3.d_c_mbx=m_c_mbx4;
    c0.m_c_mbx5=m_c_mbx5;
    d4.d_c_mbx=m_c_mbx5;
    c0.m_c_mbx6=m_c_mbx6;
    d5.d_c_mbx=m_c_mbx6;
    c0.m_c_mbx7=m_c_mbx7;
    d6.d_c_mbx=m_c_mbx7;
    c0.m_c_mbx8=m_c_mbx8;
    d7.d_c_mbx=m_c_mbx8;
    c0.m_c_mbx9=m_c_mbx9;
    d8.d_c_mbx=m_c_mbx9;
    c0.m_c_mbx10=m_c_mbx10;
    d9.d_c_mbx=m_c_mbx10;
    c0.m_c_mbx11=m_c_mbx11;
    d10.d_c_mbx=m_c_mbx11;
    c0.m_c_mbx12=m_c_mbx12;
    d11.d_c_mbx=m_c_mbx12;
    c0.m_c_mbx13=m_c_mbx13;
    d12.d_c_mbx=m_c_mbx13;
    c0.m_c_mbx14=m_c_mbx14;
    d13.d_c_mbx=m_c_mbx14;
    c0.m_c_mbx15=m_c_mbx15;
    d14.d_c_mbx=m_c_mbx15;
    c0.m_c_mbx16=m_c_mbx16;
    d15.d_c_mbx=m_c_mbx16;
    
    ga0.drv_done0=drv_done0;
    ga0.drv_done1=drv_done1;
    ga0.drv_done2=drv_done2;
    ga0.drv_done3=drv_done3;
    ga0.drv_done4=drv_done4;
    ga0.drv_done5=drv_done5;
    ga0.drv_done6=drv_done6;
    ga0.drv_done7=drv_done7;
    ga0.drv_done8=drv_done8;
    ga0.drv_done9=drv_done9;
    ga0.drv_done10=drv_done10;
    ga0.drv_done11=drv_done11;
    ga0.drv_done12=drv_done12;
    ga0.drv_done13=drv_done13;
    ga0.drv_done14=drv_done14;
    ga0.drv_done15=drv_done15;
    
    d0.drv_done=drv_done0;
    d1.drv_done=drv_done1;
    d2.drv_done=drv_done2;
    d3.drv_done=drv_done3;
    d4.drv_done=drv_done4;
    d5.drv_done=drv_done5;
    d6.drv_done=drv_done6;
    d7.drv_done=drv_done7;
    d8.drv_done=drv_done8;
    d9.drv_done=drv_done9;
    d10.drv_done=drv_done10;
    d11.drv_done=drv_done11;
    d12.drv_done=drv_done12;
    d13.drv_done=drv_done13;
    d14.drv_done=drv_done14;
    d15.drv_done=drv_done15;
  endfunction
  
  virtual task run();
    $display("[%0t]El ambiente fue inicializado",$time);
    fork
      ga0.run();
      d0.run();
      d1.run();
      d2.run();
      d3.run();
      d4.run();
      d5.run();
      d6.run();
      d7.run();
      d8.run();
      d9.run();
      d10.run();
      d11.run();
      d12.run();
      d13.run();
      d14.run();
      d15.run();
      s0.run();
      c0.run();
    join_any
  endtask
  
endclass
