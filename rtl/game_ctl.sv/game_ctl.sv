/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow
// Create Date : 28.07.2024
// Designers Name : Tomasz Ochmanek
// Module Name : game_ctl
// Project Name : UEC2_PRJ_STATKI
// Target Devices : BASYS3
// 
// Description : 
////////////////////////////////////////////////////////////////////

module game_ctl
(
    input clk,
    input rst,
    input mouse_start,
    input logic [11:0] mouse_xpos,
    input logic [11:0] mouse_ypos,
    input logic [5:0] mouse_pos,
    input logic place,
    output logic [0:1] ship_pos

);

    always_comb begin
        if (mouse_start == 1) begin
            for (i = 0; i < 4; i++) begin
                if (place == 1) begin
