class driver #(parameter pck_sz=41, drvs=16, id_drv=0);
    virtual  mesh_gnrt #(.pckg_sz(pck_sz))vdc; 
    gen_agent_drv_mbx g_a_d_mbx; 
    drv_chkr_mbx d_c_mbx;
    event drv_done;
    int wait_;
    int dvc;
    bit [pck_sz-1:0] fifo[$];
    //int id_drv;
    
    task run();
        $display("Tiempo:[%g] - Modo envío: el driver %0d fué inicializado",$time, dvc);
        forever begin
        for(int i=0;i<16;i++)begin  
        transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;   
        @(posedge vdc.clk);
         vdc.reset=1;
        @(posedge vdc.clk);
            $display("Tiempo:[%g] - Modo envío: el driver %0d espera por una transacción",$time, dvc);
        wait_=0; 
        @(posedge vdc.clk); 
        g_a_d_mbx.get(trans);  
        dvc=trans.sender;
            $display("Tiempo:[%g] - Modo envío: se recibió una transaccion en el driver, dispositivo=%0d ",$time, dvc);
        while(wait_ < trans.retardo)begin
            @(posedge vdc.clk);
            wait_=wait_+1;
            fifo.push_back(trans.dato);
        end  
          if(vdc.pndng_i_in[i])begin//envio
              vdc.pop_in[i]<=1;
              vdc.data_out_i_in[i]=fifo.pop_front(trans.dato);
          end
          if(vdc.pndng[i])begin//recibido
            vdc.pop[i]<=1;
            transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans=new;
            trans.dato<=vdc.data_out[i];
            d_c_mbx.put(trans);
          end
          end  
        @(posedge vdc.clk);  
        ->drv_done;
        end
    endtask
endclass
