//////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow                                       //
// Create Date : 16.08.2024                                                 //
// Designers Name : Jan Panek & Tomek                                       //
// Module Name : bg_Letters                                                 //
// Project Name : Statki                                                    //
// Target Devices : BASYS3                                                  //
//                                                                          //
// Description : Moduł odpowiedzialny za połoenie figur na szachownicy.     //
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module bg_letters 
(
    input  logic clk,
    input  logic rst,
    output logic [10:0] char_addr,
    vga_if.in vga_in   // Wejście interfejsu vga_if
);

import vga_pkg::*;

logic [10:0] char_line_buf;
logic [10:0] char_code_buf; 

always_comb begin
    char_line_buf = vga_in.vcount;
    //if(vga_in.hcount%44 >= 14 & vga_in.hcount%44 <= 22) begin
       // char_code_buf = "A" + vga_in.hcount [10:6];
    //end

    if(vga_in.hcount%45 >= 14 & vga_in.hcount%45 <= 22) begin
        char_code_buf = "A" + vga_in.hcount [10:6];
    end
    else if ((vga_in.vcount)%45 >= 7 & (vga_in.vcount)%45 <= 23) begin
        char_code_buf = "1" + vga_in.vcount [10:6] - 3;
    end    
    else begin
        char_code_buf = 0;
    end    
end

always_comb begin
    if((vga_in.hcount >= 45 & vga_in.hcount <= 450) & ((vga_in.vcount >= 164 & vga_in.vcount <= 180) | (vga_in.vcount >= 586 & vga_in.vcount <= 601))) begin
        char_addr = {char_code_buf[6:0] , char_line_buf[3:0]};
    end
    else if ((vga_in.vcount >= 180 & vga_in.vcount <= 585) & ((vga_in.hcount >= 37 & vga_in.hcount <= 45) | (vga_in.hcount >= 450 & vga_in.hcount <=458)))  begin
        char_addr = {char_code_buf[6:0] , char_line_buf[3:0]};
    end
    else begin
        char_addr = 0;
    end
end

endmodule
