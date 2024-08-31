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
     input  logic clk_75,
     input  logic clk_100,
     inout  logic ps2_clk,
     inout  logic ps2_data,
     input  logic rst,
     input  logic start_button,
     input  logic board_addres,
     input  logic [10:0] check_in,
     output logic [10:0] check_out,
     output logic vs,
     output logic hs,
     output logic [3:0] led,
     output logic [3:0] r,
     output logic [3:0] g,
     output logic [3:0] b
 );
 
 
// LOCAL VARIABLES AND SIGNALS /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 vga_if vga_tim();
 vga_if vga_bg();
 vga_if vga_rect();
 vga_if mouse_out();
 vga_if draw_out();
 //logic  [11:0] xpos;
 //logic  [11:0] ypos;
 logic  mouse_left;
 logic  place;
 logic  [7:0] mouse_pos;
 logic  [11:0] xpos_buf_in;
 logic  [11:0] ypos_buf_in;
 logic  [11:0] xpos_buf_out;
 logic  [11:0] ypos_buf_out;
 logic [31:0] ship_line_pixels;
 logic [31:0] ship_line_pixels_guest;
 logic  [10:0] char_addr;
 logic  [7:0]  char_pixels;
 logic [6:0] addres;
 logic [6:0] addres_guest;
logic pick_ship;
logic [4:0] ship_line;
logic [1:0] ship_code_host;
logic [1:0] ship_code_guest;
 logic [6:0] ship_xy_host;
 logic [6:0] ship_xy_guest;
logic [1:0] hit; 
logic pick_place;
logic [3:0] ship_count;
logic [7:0] addres4check;
 // SIGNALS ASSIGNMENTS ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 assign vs = mouse_out.vsync;
 assign hs = mouse_out.hsync;
 assign {r,g,b} = mouse_out.rgb;
 
 // SUBMODULES ISTANCES /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 vga_timing u_vga_timing (
     .clk(clk_75),
     .rst,
     .vga_out(vga_tim)
 );

/*bg_letters u_bg_letters(
    .clk(clk_75),
    .rst,
    .vga_in(vga_tim),
    .char_addr(char_addr)
);

font_rom u_font_rom(
    .clk(clk_75),
    .addr(char_addr),
    .char_line_pixels(char_pixels)
);
*/

draw_bg u_draw_bg (
    .clk(clk_75),
    .rst,
    .vga_in(vga_tim),
    .vga_out(vga_bg)
);

draw_ship u_draw_ship (
    .clk(clk_75),
    .rst,
    .ship_xy_guest(ship_xy_guest),
    .ship_xy_host(ship_xy_host),
    .ship_line(ship_line),
    .vga_in(vga_bg),
    .vga_out(draw_out),
    .ship_pixels(ship_line_pixels),
    .ship_pixels_guest(ship_line_pixels_guest)
);
logic_ctl u_logic_ctl(
    .clk(clk_75),
    .rst,
    .mouse_left(mouse_left),
    .mouse_position(mouse_pos),
    .mouse_xpos(xpos_buf_out),
    .mouse_ypos(ypos_buf_out),
    .pick_ship(pick_ship),
    .pick_place(pick_place),
    .state_led(led),
    .ship_count(ship_count),
    .board_addres(board_addres),
    //.hit(hit),
    .msg_in(check_in[1:0]),
    .msg_send(check_out[1:0]),
    .check_in(check_in[9:2]),
    .check_out(check_out[9:2]),
    .addres4check(addres4check),
    .addres_sent(check_out[10]),
   // .your_turn(your_turn),
    .vga_in(draw_out)
);
game_board u_game_board(
    .clk(clk_75),
    .rst,
    .ship_xy_guest(ship_xy_guest),
    .ship_xy_host(ship_xy_host),
    .ship_code_host(ship_code_host),
    .ship_code_guest(ship_code_guest),
    .mouse_pos(mouse_pos),
    .pick_ship(pick_ship),
    .pick_place(pick_place),
    .ship_count(ship_count),
    //.hit(hit),
    .check_in(addres4check),
    //.check_out(check_out[9:2]),
    .msg_in(check_in[1:0]),
    .msg_out(check_out[1:0]),
    .addres_recieved(check_in[10]),
    .vga_in(draw_out)
   // .your_turn(your_turn)
);

always_comb begin
    
    addres = {ship_code_host, ship_line};
    addres_guest = {ship_code_guest, ship_line};
end



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

always_ff @(posedge clk_75) begin
    xpos_buf_out <= xpos_buf_in;
    ypos_buf_out <= ypos_buf_in;
end

draw_mouse u_draw_mouse(
    .clk(clk_75),
    .rst,
    .vga_in(draw_out),
    .vga_out(mouse_out),
    .xpos(xpos_buf_out),
    .ypos(ypos_buf_out)
);

ship_rom u_ship_rom (
    .clk(clk_75),
    .addres(addres),
    .addres_guest(addres_guest),
    .ship_line_pixels_out(ship_line_pixels),
    .ship_line_pixels_out_guest(ship_line_pixels_guest)
);




 endmodule
