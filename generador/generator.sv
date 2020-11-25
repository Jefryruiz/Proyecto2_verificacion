class generator#(parameter pck_sz=41,drvs=16);
  test_gen_mbx t_g_mbx;
  gen_agent_mbx g_a_mbx;
  event agent_done;
  intrucciones_generador instrucciones;
  rand int num_transacciones;
  int ret_spec;
  int max_retardo;
  bit [pck_sz-9:pck_sz-16] trgt_spec;
  bit [pck_sz-17:pck_sz-18] mode_spec;
  bit [pck_sz-19:0] payload_spec;
  rand int ret;
  transaccion trans;
  
  constraint Ret {ret>0;
                 ret<=10;}
  
   constraint num_trans {num_transacciones>=1;
                       num_transacciones<=60;}
  function new();
    num_transacciones=$urandom;
    retardo_max=15;
  endfunction
  
  
  task run();
    $display("[%g]GENERATOR:El generador fue inicializado",$time);
    
    forever begin
    #ret
      if(t_g_mbx.num()>0)begin 
      $display("[%g] GENERATOR:Se recibe transaccion",$time);  
      t_g_mbx.get(instrucciones);
      case(instrucciones)
      transacciones_aleatorias:begin
        for(int i=0;i<num_transacciones;i=i+1)begin
          trans=new;
          trans.randomize();
          trans.retardo_max=retardo_max;
          trans.print("GENERATOR:transaccion creada");
          g_a_mbx.put(trans);
        end
        @(agent_done);
      end
      transacciones_alternadas:begin
        for(int i=0;i< 10;i++)begin
          trans=new;
          trans.target=trgt_spec;
          trans.mode=mode_spec;
          trans.payload={22{1'b1}};
          trans.retardo=ret_spec;
          trans.retardo_max=retardo_max;
          trans.sender=$urandom;
          trans.tiempo_envio=$urandom;
          trans.print("GENERATOR:transaccion creada");
          g_a_mbx.put(trans);
        end
        for(int i=0;i< 10;i++)begin
          trans=new;
          trans.target=trgt_spec;
          trans.mode=mode_spec;
          trans.retardo_max=retardo_max;
          trans.payload={22{1'b0}};
          trans.retardo=ret_spec;
          trans.retardo_max=retardo_max;
          trans.sender=$urandom;
          trans.tiempo_envio=$urandom;
          trans.print("GENERATOR:transaccion creada");
          g_a_mbx.put(trans);
        end
        @(agent_done);
      end
       un_solo_dispositivo:
         for(int i=0;i<num_transacciones;i++)begin
           trans=new;
           trans.target=trgt_spec;
           trans.mode=$urandom;
           trans.payload=$urandom;
           trans.sender=$urandom;
           trans.retardo=$urandom;
           trans.tiempo_envio=$urandom;
           trans.retardo_max=retardo_max;
           trans.print("GENERATOR:transaccion creada");
           g_a_mbx.put(trans);
         end
        @(agent_done);
      endcase
        
      end
  
    end
  endtask
endclass
