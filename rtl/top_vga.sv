/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

 `timescale 1 ns / 1 ps

 module top_vga 
 (
     input  logic clk_65,
     input  logic clk_100,
     inout  logic ps2_clk,
     inout  logic ps2_data,
     input  logic rst,
     output logic vs,
     output logic hs,
     output logic [3:0] r,
     output logic [3:0] g,
     output logic [3:0] b
 );
 
 
// LOCAL VARIABLES AND SIGNALS /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 vga_if vga_tim();
 vga_if vga_bg();
 vga_if vga_rect();
 vga_if mouse_out();

 //logic  [11:0] xpos;
 //logic  [11:0] ypos;
 logic  mouse_left;
 logic  place;
 logic  [5:0] mouse_pos;
 logic  [11:0] xpos_buf_in;
 logic  [11:0] ypos_buf_in;
 logic  [11:0] xpos_buf_out;
 logic  [11:0] ypos_buf_out;
 logic [47:0] ship_line_pixels;
 logic  [10:0] char_addr;
 logic  [7:0]  char_pixels;
logic [8:0] addres;

logic [4:0] ship_line;
logic [3:0] ship_code_host;
logic [3:0] ship_code_guest;
 logic [5:0] ship_xy_host;
 logic [5:0] ship_xy_guest;
 
 // SIGNALS ASSIGNMENTS ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 assign vs = mouse_out.vsync;
 assign hs = mouse_out.hsync;
 assign {r,g,b} = mouse_out.rgb;
 
 // SUBMODULES ISTANCES /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 vga_timing u_vga_timing (
     .clk(clk_65),
     .rst,
     .vga_out(vga_tim)
 );

/*bg_letters u_bg_letters(
    .clk(clk_65),
    .rst,
    .vga_in(vga_tim),
    .char_addr(char_addr)
);

font_rom u_font_rom(
    .clk(clk_65),
    .addr(char_addr),
    .char_line_pixels(char_pixels)
);
*/
draw_ship u_draw_ship (
    .clk(clk_65),
    .rst,
    .ship_xy_guest(ship_xy_guest),
    .ship_xy_host(ship_xy_host),
    .ship_line(ship_line),
    .vga_in(vga_tim),
    .vga_out(vga_bg),
    .ship_pixels(ship_line_pixels)
);
always_comb begin
    
    addres = {ship_code_host, ship_line};
end

ship_rom u_ship_rom (
    .clk(clk_65),
    .addres(addres),
    .ship_line_pixels_out(ship_line_pixels)
);

draw_bg u_draw_bg (
    .clk(clk_65),
    .rst,
    .vga_in(vga_tim),
    .vga_out(vga_bg)
);



MouseCtl u_MouseCtl(
    .clk(clk_100),
    .rst,
    .ps2_data,
    .ps2_clk,
    .xpos(xpos_buf_in),
    .ypos(ypos_buf_in),

    .zpos(),
    .left(mouse_left),
    .middle(),
    .right(),
    .new_event(),
    .value('0),
    .setx('0),
    .sety('0),
    .setmax_x('0),
    .setmax_y('0)
    );

always_ff @(posedge clk_65) begin
    xpos_buf_out <= xpos_buf_in;
    ypos_buf_out <= ypos_buf_in;
end

mouse_pos u_mouse_pos(
    .clk(clk_65),
    .rst,
    .LMB(mouse_left),
    .mouse_xpos(xpos_buf_out),
    .mouse_ypos(ypos_buf_out),
    .mouse_pos(mouse_pos),
    .place(place)
);

game_board u_game_board(
    .clk(clk_65),
    .rst,
    .ship_xy_guest(ship_xy_guest),
    .ship_xy_host(ship_xy_host),
    .ship_code_host(ship_code_host),
    .mouse_pos(mouse_pos),
    .place(place)
);

draw_mouse u_draw_mouse(
    .clk(clk_65),
    .rst,
    .vga_in(vga_bg),
    .vga_out(mouse_out),
    .xpos(xpos_buf_out),
    .ypos(ypos_buf_out)
);


 endmodule
