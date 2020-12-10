class driver #(parameter pck_sz=41, drvs=16, id_drv=0);
    virtual  mesh_gnrt #(.pckg_sz(pck_sz))vdc; //interfaz virtual
    gen_agent_drv_mbx g_a_d_mbx;//mailbox que conecta al generador agente 
    event drv_done;//evento que comunica con el generador_agente
    int wait_;//variable de espera
    int dvc; //id del driver
    bit [pck_sz-1:0] fifo[$];//fifo que almacena el paquete
    //int id_drv;
    bit rst;
    
    task run();
        $display("Tiempo:[%g] - Modo envío: el driver %0d fué inicializado",$time, id_drv);
        @(posedge vdc.clk);
        vdc.reset=1;
        @(posedge vdc.clk);
            forever begin 
            
              for(int i=0;i<16;i++)begin
                transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;//instancia el driver
                vdc.reset=0;
                vdc.data_out_i_in[i]={pck_sz-1{1'b0}};//inicializa las señales en cero
                vdc.pop[i]=0;
                vdc.pndgn_i_in[i]=0;
                $display("Tiempo:[%g] - Modo envío: el driver %0d espera por una transacción",$time, id_drv);
                wait_=0; //variable de espera
                @(posedge vdc.clk);
                g_a_d_mbx.get(trans);//obtiene el dato desde el generador_agente
                trans.print("Driver: transacción recibida");
                $display("Transacciones pendientes en el mbx=%g",g_a_d_mbx.num());
                dvc=trans.sender;
                //envio
                $display("Tiempo:[%g] - Modo envío: se recibió una transaccion en el driver, envía dispositivo=%0d ",$time, dvc);
                while(wait_ < trans.retardo)begin
                    @(posedge vdc.clk);
                    wait_=wait_+1;
                  fifo.push_back(trans.dato);//Coloca el paquete dentro de la fifo
                 end
                vdc.pop[i]<=1;//levanta bandera de pop_in para darle el paquete al dato entrada-salida
                vdc.data_out_i_in[i]=fifo.pop_front();
              @(posedge vdc.clk);  
             ->drv_done;//envia el evento al generador_agente  
              
              end
            end
    endtask
endclass
