class agent#(parameter pck_sz=41,drvs=16);
  gen_agent_mbx g_a_mbx;
  agent_score_mbx a_s_mbx;
  agent_drv_mbx a_d_mbx1;
  agent_drv_mbx a_d_mbx2;
  agent_drv_mbx a_d_mbx3;
  agent_drv_mbx a_d_mbx4;
  agent_drv_mbx a_d_mbx5;
  agent_drv_mbx a_d_mbx6;
  agent_drv_mbx a_d_mbx7;
  agent_drv_mbx a_d_mbx8;
  agent_drv_mbx a_d_mbx9;
  agent_drv_mbx a_d_mbx10;
  agent_drv_mbx a_d_mbx11;
  agent_drv_mbx a_d_mbx12;
  agent_drv_mbx a_d_mbx13;
  agent_drv_mbx a_d_mbx14;
  agent_drv_mbx a_d_mbx15;
  agent_drv_mbx a_d_mbx16;
  event drv_done;
  bit [pck_sz-1:0] dato;
  rand int ret;
  
  constraint retard {ret>0;
                    ret<=10;}
  function new();
  ret=$urandom;  
  endfunction
  
  task run();
    $display("[%g]AGENTE:El agente fue inicializado",$time);
    #ret;
    forever begin
      transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;
      g_a_mbx.get(trans);
      case(inst)
        transacciones_aleatorizadas:begin
        dato={trans.next_jump,trans.target_row,trans.target_column,trans.mode,trans.payload};
        trans.dato=dato;
          if(trans.sender==0)
            $display("La transaccion se envia desde el dispositivo %0d",0);
            a_d_mbx1.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==1)
            $display("La transaccion se envia desde el dispositivo %0d",1);
            a_d_mbx2.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==2)
            $display("La transaccion se envia desde el dispositivo %0d",2);
            a_d_mbx3.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==3)
            $display("La transaccion se envia desde el dispositivo %0d",3);
            a_d_mbx4.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==4)
            $display("La transaccion se envia desde el dispositivo %0d",4);
            a_d_mbx5.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==5)
            $display("La transaccion se envia desde el dispositivo %0d",5);
            a_d_mbx6.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==6)
            $display("La transaccion se envia desde el dispositivo %0d",6);
            a_d_mbx7.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==7)
            $display("La transaccion se envia desde el dispositivo %0d",7);
            a_d_mbx8.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==8)
            $display("La transaccion se envia desde el dispositivo %0d",8);
            a_d_mbx9.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==9)
            $display("La transaccion se envia desde el dispositivo %0d",10);
            a_d_mbx10.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==10)
            $display("La transaccion se envia desde el dispositivo %0d",11);
            a_d_mbx11.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==11)
            $display("La transaccion se envia desde el dispositivo %0d",12);
            a_d_mbx12.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==12)
            $display("La transaccion se envia desde el dispositivo %0d",13);
            a_d_mbx13.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==13)
            $display("La transaccion se envia desde el dispositivo %0d",14);
            a_d_mbx14.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==14)
            $display("La transaccion se envia desde el dispositivo %0d",15);
            a_d_mbx15.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==15)
            $display("La transaccion se envia desde el dispositivo %0d",16);
            a_d_mbx16.put(trans);
            a_s_mbx.put(trans);
        @(drv_done); 
        end
        
        transacciones_alternadas:begin
        dato={trans.next_jump,trans.target_row,trans.target_column,trans.mode,trans.payload};
        trans.dato=dato;
          if(trans.sender==0)
            $display("La transaccion se envia desde el dispositivo %0d",0);
            a_d_mbx1.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==1)
            $display("La transaccion se envia desde el dispositivo %0d",1);
            a_d_mbx2.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==2)
            $display("La transaccion se envia desde el dispositivo %0d",2);
            a_d_mbx3.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==3)
            $display("La transaccion se envia desde el dispositivo %0d",3);
            a_d_mbx4.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==4)
            $display("La transaccion se envia desde el dispositivo %0d",4);
            a_d_mbx5.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==5)
            $display("La transaccion se envia desde el dispositivo %0d",5);
            a_d_mbx6.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==6)
            $display("La transaccion se envia desde el dispositivo %0d",6);
            a_d_mbx7.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==7)
            $display("La transaccion se envia desde el dispositivo %0d",7);
            a_d_mbx8.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==8)
            $display("La transaccion se envia desde el dispositivo %0d",8);
            a_d_mbx9.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==9)
            $display("La transaccion se envia desde el dispositivo %0d",10);
            a_d_mbx10.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==10)
            $display("La transaccion se envia desde el dispositivo %0d",11);
            a_d_mbx11.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==11)
            $display("La transaccion se envia desde el dispositivo %0d",12);
            a_d_mbx12.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==12)
            $display("La transaccion se envia desde el dispositivo %0d",13);
            a_d_mbx13.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==13)
            $display("La transaccion se envia desde el dispositivo %0d",14);
            a_d_mbx14.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==14)
            $display("La transaccion se envia desde el dispositivo %0d",15);
            a_d_mbx15.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==15)
            $display("La transaccion se envia desde el dispositivo %0d",16);
            a_d_mbx16.put(trans);
            a_s_mbx.put(trans);
        @(drv_done); 
        end
        
        un_solo_dispositivo:begin
        dato={trans.next_jump,trans.target_row,trans.target_column,trans.mode,trans.payload};
        trans.dato=dato;
          if(trans.sender==0)
            $display("La transaccion se envia desde el dispositivo %0d",0);
            a_d_mbx1.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==1)
            $display("La transaccion se envia desde el dispositivo %0d",1);
            a_d_mbx2.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==2)
            $display("La transaccion se envia desde el dispositivo %0d",2);
            a_d_mbx3.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==3)
            $display("La transaccion se envia desde el dispositivo %0d",3);
            a_d_mbx4.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==4)
            $display("La transaccion se envia desde el dispositivo %0d",4);
            a_d_mbx5.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==5)
            $display("La transaccion se envia desde el dispositivo %0d",5);
            a_d_mbx6.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==6)
            $display("La transaccion se envia desde el dispositivo %0d",6);
            a_d_mbx7.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==7)
            $display("La transaccion se envia desde el dispositivo %0d",7);
            a_d_mbx8.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==8)
            $display("La transaccion se envia desde el dispositivo %0d",8);
            a_d_mbx9.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==9)
            $display("La transaccion se envia desde el dispositivo %0d",10);
            a_d_mbx10.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==10)
            $display("La transaccion se envia desde el dispositivo %0d",11);
            a_d_mbx11.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==11)
            $display("La transaccion se envia desde el dispositivo %0d",12);
            a_d_mbx12.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==12)
            $display("La transaccion se envia desde el dispositivo %0d",13);
            a_d_mbx13.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==13)
            $display("La transaccion se envia desde el dispositivo %0d",14);
            a_d_mbx14.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==14)
            $display("La transaccion se envia desde el dispositivo %0d",15);
            a_d_mbx15.put(trans);
            a_s_mbx.put(trans);
          if(trans.sender==15)
            $display("La transaccion se envia desde el dispositivo %0d",16);
            a_d_mbx16.put(trans);
            a_s_mbx.put(trans);
        @(drv_done);  
        end
      endcase
    end
  endtask
endclass
