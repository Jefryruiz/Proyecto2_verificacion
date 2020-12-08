class driver #(parameter pck_sz=41, drvs=16, id_drv=0);
    virtual  mesh_gnrt #(.pckg_sz(pck_sz))vdc; 
    gen_agent_drv_mbx g_a_d_mbx; 
    drv_chkr_mbx d_c_mbx;
    event drv_done;
    int wait_;
    int dvc;
    //int id_drv;
    
    task run();
        $display("[%g] El driver fué inicializado",$time);
        forever begin
        for(int i=0;i<16;i++)begin  
        transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;   
        @(posedge vdc.clk);
         vdc.reset=1;
        @(posedge vdc.clk);
        
        vdc.data_out_i_in[i]={pck_sz{1'bz}};
        $display("[%g] el driver espera por una transacción",$time);
        wait_=0; 
        @(posedge vdc.clk); 
        g_a_d_mbx.get(trans);
        dvc=trans.sender;
        $display("Se recibió una transaccion en el driver, dispositivo=%0d ", dvc);
      while(wait_ < trans.retardo)begin
            @(posedge vdc.clk);
            wait_=wait_+1;
        vdc.data_out_i_in[i] = trans.dato;
        end
      case(trans.modo)
            0: begin //envío
                //vdc.push=1;  
                trans.tiempo=$time;
                trans.modo=1;
                d_c_mbx.put(trans);
                trans.print("Driver: Transacción ejecutada");
            end
              endcase
     case(trans.modo)
            1: begin //recibido
              trans.dato=vdc.data_out[i];
                trans.tiempo=$time;
                @(posedge vdc.clk);
              vdc.pop[i]=1;
                d_c_mbx.put(trans);
                trans.print("Driver: Transaccion ejecutada");
            end
        default: begin
            $display("Un error de ambiente, id de dispositivo de envio/llegada no coincide",$time);
            $finish;
        end
          endcase
          end  
        @(posedge vdc.clk);  
        ->drv_done;
        end
    endtask
endclass
