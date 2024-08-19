///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//Company : AGH University of Krakow
// Create Date : 07.08.2024
// Designers Name : Tomasz Ochmanek & Jan PAnek
// Module Name : mouse_pos
// Project Name : UEC2_PRJ_STATKI
// Target Devices : BASYS3
// 
// Description : wspolzendne kursora
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module mouse_pos
(
    input logic        clk,
    input logic        rst,
    input logic        LMB,
    input logic [11:0] mouse_xpos,
    input logic [11:0] mouse_ypos,
    output logic [5:0] mouse_pos, // miejsce na planszy na którym znajduje sie myszka
    output logic place
);

logic LMB_pressed;

import vga_pkg::*; 

    always_ff @(posedge clk, posedge rst, posedge LMB) begin : xypos_blk
    if(rst) begin
        mouse_pos <= '0;
        place <= '0;
    end else begin
        if(LMB == 1 & LMB_pressed == 0) begin
            LMB_pressed <= 1;
            place <= 1;
        end 
        else if(LMB == 0 & LMB_pressed == 1) begin
            LMB_pressed <= 0;
            place <= 0;
        end 
        
        mouse_pos[5:3] <= (mouse_ypos-128)/48;
        mouse_pos[2:0] <= (mouse_xpos-256)/48;

    end
end

endmodule
