class driver #(parameter pck_sz=40, drvs=16);
    virtual device #(.pck_sz(pck_sz))vdc; 
    agent_drv_mbx a_d_mbx; 
    drv_chkr_mbx d_c_mbx;
    event drv_done;
    int wait_;
    transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;
    
    task run();
        $display("[%g] El driver fué inicializado",$time);
        @(posedge vdc.clk);
        transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans; 
        vdc.dato=pck_sz´b0;
        $display("[%g] el driver espera por una transacción",$time);
        wait_=0; 
        @(posedge vdc.clk); 
        a_d_mbx.get(trans);
        trans.print("Se recibió una transaccion en el driver, dispositivo=%0d ", trans.sender);
        while(wait_ < trans.ret)begin
            @(posedge vdc.clk);
            wait_=wait_+1;
            vdc.dato = trans.dato;
        end
        case(trans.mode)
            0: begin //envío
                vdc.push=1;  
                trans.time=$time;
                trans.mode=1;
                drv_chkr_mbx.put(trans);
                trans.print("Driver: Transacción ejecutada",$time);
        case(trans.mode)
            1: begin //recibido
                trans.dato=vdc.dato_out;
                trans.tiempo=$time;
                @(posedge vdc.clk);
                vdc.pop=1;
                drv_chkr_mbx.put(trans);
                trans.print("Driver: Transaccion ejecutada";$time);
        default: begin
            $display("Error, no existe modo válido de envío/lectura de la transaccion",$time);
            $finish;
        @(drv_done);
        @(posedge vdc.clk);
    endtask
endclass
