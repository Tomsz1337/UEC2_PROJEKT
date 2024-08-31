//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow
// Create Date : 24.07.2024
// Designers Name : Tomasz Ochmanek & Jan Panek
// Module Name : draw_mouse
// Project Name : UEC2_PROJEKT_STATKI
// Target Devices : BASYS3
// 
// Description : Moduł odpowiedzialny za rysowanie myszy
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 1 ps


module draw_mouse (
    input  logic clk,
    vga_if.in vga_in,
    vga_if.out vga_out,
    input logic [11:0] xpos,
    input logic [11:0] ypos
);

import vga_pkg::*;

always_ff @(posedge clk) begin
    vga_out.vcount <= vga_in.vcount;
    vga_out.vsync  <= vga_in.vsync;
    vga_out.vblnk  <= vga_in.vblnk;
    vga_out.hcount <= vga_in.hcount;
    vga_out.hsync  <= vga_in.hsync;
end

MouseDisplay u_MouseDisplay(
    .pixel_clk(clk),
    .hcount(vga_in.hcount),
    .vcount(vga_in.vcount),
    .blank(vga_in.vblnk | vga_in.hblnk),
    .rgb_in(vga_in.rgb),
    .rgb_out(vga_out.rgb),
    .xpos,
    .ypos,
    .enable_mouse_display_out()

 );
 endmodule
 