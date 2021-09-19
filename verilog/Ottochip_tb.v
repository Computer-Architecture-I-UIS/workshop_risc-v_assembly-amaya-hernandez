`timescale 1 ns/1 ps
module Ottochip_tb;
	reg clock = 0;
	reg reset;
	wire  io_pad_0;
	wire  io_pad_1;
	
    reg io_rx;
    assign io_pad_1 = io_rx;
    wire  io_pad_2;
		wire  io_pad_3;
		wire  io_pad_4;
    wire  io_pad_5;
    wire  io_pad_6;
Ottochip myCHIP (
    .clock (clock),
    .reset (reset),    
    .io_pad_0(io_pad_0),
    .io_pad_1(io_pad_1),
    .io_pad_2(io_pad_2),
    .io_pad_3(io_pad_3),
    .io_pad_4(io_pad_4),
    .io_pad_5(io_pad_5),
    .io_pad_6(io_pad_6)
);

    parameter CLOCK_PERIOD =10;
    parameter BAUD_RATE =9600;
    always
    begin
        #(CLOCK_PERIOD/2);
        clock = ~clock;
    
    end    
    integer programhex;
    integer c=0;//1;
    
    reg a;

    parameter TB_ns =(1000000000/BAUD_RATE);    
    initial    begin
    reset = 1;
    io_rx = 1; 
    #(CLOCK_PERIOD*20);
    reset = 0;
    #(TB_ns*3);
	uart_send(8'hFF);//AUTO BAUD
        
	send_word("CAFE");

	
	send_word(32'h8);

	send_word(32'h00000013);
	send_word(32'h20000137);
	send_word(32'h02010113);
	send_word(32'h00800193);
	send_word(32'h00012223);
	send_word(32'h00012023);
	send_word(32'h00312023);
	send_word(32'hff9ff06f);
	

    end
    
    task uart_send;
        input [7:0] word;
        integer c;
        begin
            io_rx = 0;
            #TB_ns;
            for(c=0;c<=7;c=c+1) begin
                io_rx = word[c];
                #TB_ns;
            end		
            io_rx = 1;
            #TB_ns;
        end
    endtask  
    
     
    task send_word;
        input [31:0] word;
        begin
           #(1*TB_ns);
           uart_send(word[31:24]);
           #(1*TB_ns);
           uart_send(word[23:16]);
           #(1*TB_ns);
           uart_send(word[15:8]);
           #(1*TB_ns);
           uart_send(word[7:0]);
           #(1*TB_ns);
        end
    endtask 
    
  initial begin
 //   $monitor("At time %t, value = %h (%0d)", $time, value, value);
    $dumpfile("test.vcd"); // Archivo en el que se guardarán los resultados de la simulación
    $dumpvars;
    #(100000); // Configurar el tiempo de simulación
    $finish;
    end
endmodule

