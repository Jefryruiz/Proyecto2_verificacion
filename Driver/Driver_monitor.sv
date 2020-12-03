class driver #(parameter pck_sz=40, drvs=16, id_drv);
    virtual device #(.pck_sz(pck_sz))vdc; 
    agent_drv_mbx a_d_mbx; 
    drv_chkr_mbx d_c_mbx;
    event drv_done;
    int wait_;
    int id_drv;
    transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans;
    
    task run();
        $display("[%g] El driver fué inicializado",$time);
        @(posedge vdc.clk);
        vdc.rst=1;
        @(posedge vdc.clk);
        transaccion #(.pck_sz(pck_sz),.drvs(drvs)) trans; 
        vdc.dato=pck_sz´bx;
        $display("[%g] el driver espera por una transacción",$time);
        wait_=0; 
        @(posedge vdc.clk); 
        a_d_mbx.get(trans);
        dvc=trans.sender;
        trans.print("Se recibió una transaccion en el driver, dispositivo=%0d ", dvc);
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
            $display("Un error de ambiente, id de dispositivo de envio/llegada no coincide",$time);
            $finish;
        @(drv_done);
        @(posedge vdc.clk);
    endtask
endclass
