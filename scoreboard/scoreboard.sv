class score_board #(parameter pck_sz=41, drvs=16);
  gen_agent_score_mbx  g_a_s_mbx; // mailbox para comunicarse con el agente
  score_check_mbx s_c_mbx; // mailbox para enviar transacciones al checker
  check_score_mbx c_s_mbx; //mailbox para recibir los resultados del checker
  test_score_mbx t_s_mbx; //mailbox para recibir instrucciones del test
  transaccion #(.pck_sz(pck_sz), .drvs(drvs)) transaccion_entrante; 
  transaccion #(.pck_sz(pck_sz), .drvs(drvs)) transaccion_resultante; 
  transaccion scoreboard[$]; // esta es la estructura dinámica que maneja el scoreboard 
  transaccion scoreboard_reportes[$]; // esta es la estructura dinámica utilizada para generar reportes
  transaccion to_checker;
  transaccion auxiliar_array[$]; // estructura auxiliar usada para explorar el scoreboard;  
  transaccion auxiliar_trans;
  shortreal retardo_promedio;
  solicitud_sb orden;
  int tamano_sb = 0;
  int transacciones_completadas =0;
  int retardo_total = 0;
  int f;
  
  task run();
    
    $display("[%g] El Score Board fue inicializado",$time);
    forever begin
      #5;
      if(g_a_s_mbx.num()>0)begin
        g_a_s_mbx.get(transaccion_entrante);
        transaccion_entrante.print("Score Board: transacción recibida desde el Agente");
	    scoreboard.push_back(transaccion_entrante);
        to_checker=scoreboard.pop_front();    
        s_c_mbx.put(to_checker);
      end else begin
        if(c_s_mbx.num()>0)begin
        c_s_mbx.get(transaccion_resultante);
        transaccion_resultante.print("Score Board: resultados recibidos desde el checker");
        if(transaccion_resultante.completado) begin
            retardo_total = retardo_total + transaccion_resultante.retardo;
            transacciones_completadas++;
	     end
	     scoreboard_reportes.push_back(transaccion_resultante);
        end else begin
        if(t_s_mbx.num()>0)begin
              t_s_mbx.get(orden);
              case(orden)
                retardo_promedio: begin
                  $display("Score Board: Recibida Orden Retardo_Promedio");
                  retardo_promedio = retardo_total/transacciones_completadas;
                  $display("[%g] Score board: el retardo promedio es: %0.3f", $time, retardo_promedio);
                end
                reporte: begin
                  $display("Score Board: Recibida Orden Reporte");
                  tamano_sb = this.scoreboard_reportes.size();
                  for(int i=0;i<tamano_sb;i++) begin
                    auxiliar_trans = scoreboard_reportes.pop_front;
                    auxiliar_trans.print("SB_Report:");
                    auxiliar_array.push_back(auxiliar_trans);
                  end
                  scoreboard_reportes = auxiliar_array;
                end
	        archivo: begin
                  $display("Score Board: Recibida Orden Archivo");
		  		  tamano_sb = this.scoreboard_reportes.size();
		 		  f = $fopen("output.txt","w");
                  for(int i=0;i<tamano_sb;i++) begin
                    auxiliar_trans = scoreboard_reportes.pop_front;
		    auxiliar_array.push_back(auxiliar_trans);
                    $fwrite(f,"%p\n",auxiliar_array[i]);
                  end
                  scoreboard_reportes = auxiliar_array;
            end
                endcase
            end
        end
      end         
      end
    endtask 
endclass
