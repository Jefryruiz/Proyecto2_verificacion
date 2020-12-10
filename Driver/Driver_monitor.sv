class driver #(parameter pck_sz=41, drvs=16, id_drv=0);
    virtual  mesh_gnrt #(.pckg_sz(pck_sz))vdc; 
    gen_agent_drv_mbx g_a_d_mbx; 
    event drv_done;
    int wait_;
    int dvc; //id del driver
    bit [pck_sz-1:0] fifo[$];
    int id_drv;
    bit rst;
    
    task run();
        $display("Tiempo:[%g] - Modo envío: el driver %0d fué inicializado",$time, id_drv);
        @(posedge vdc.clk);
        vdc.reset=1;
        @(posedge vdc.clk);
            forever begin 
                transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;
                vdc.reset=0;
                vdc.data_out_i_in=[pck_sz-1]'b0;
                vdc.pop=0;
                vdc.pndgn_i_in=0;
                $display("Tiempo:[%g] - Modo envío: el driver %0d espera por una transacción",$time, id_drv);
                wait_=0; 
                @(posedge vdc.clk);
                g_a_d_mbx.get(trans);
                trans.print("Driver: transacción recibida");
                $display("Transacciones pendientes en el mbx=%g",g_a_d_mbx.num());
                dvc=trans.sender;
                if(vdc.pndng_i_in==1)begin//envio
                    $display("Tiempo:[%g] - Modo envío: se recibió una transaccion en el driver, envía dispositivo=%0d ",$time, dvc);
                    while(wait_ < trans.retardo)begin
                        @(posedge vdc.clk);
                        wait_=wait_+1;
                        fifo.push_back(trans.dato);
                    end
                    vdc.pop_in[i]<=1;
                    vdc.data_out_i_in[i]=fifo.pop_front(trans.dato);
                end 
            @(posedge vdc.clk);  
            ->drv_done;
            end
    endtask
endclass
