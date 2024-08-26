//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow
// Create Date : 24.07.2024
// Designers Name : Tomasz Ochmanek & Jan Panek
// Module Name : draw_hit
// Project Name : UEC2_PROJEKT_STATKI
// Target Devices : BASYS3
// 
// Description : Moduł odpowiedzialny za oznaczanie trafien
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module draw_hit 
(
    input  logic clk,
    input  logic rst,
    input  logic [31:0]  hit_pixels,
    output logic [6:0]   hit_xy_host,
    output logic [6:0]   hit_xy_guest,
    output logic [4:0]   hit_line,
    vga_if.in  vga_in,
    vga_if.out vga_out
);

import vga_pkg::*;

// LOCAL VARIABLES AND SIGNALES ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

vga_if int1();
vga_if int2();

logic [11:0]   rgb_nxt;
logic [10:0]   hit_xy_host_buf;
logic [10:0]   hit_xy_guest_buf;
logic [10:0]   hit_line_buf;

 // INITIAL LOGIC ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clk) begin
    if (rst) begin
        int1.vcount <= '0;
        int1.vsync  <= '0;
        int1.vblnk  <= '0;
        int1.hcount <= '0;
        int1.hsync  <= '0;
        int1.hblnk  <= '0;
        int1.rgb    <= '0;
    end else begin
        int1.vcount <= vga_in.vcount;
        int1.vsync  <= vga_in.vsync;
        int1.vblnk  <= vga_in.vblnk;
        int1.hcount <= vga_in.hcount;
        int1.hsync  <= vga_in.hsync;
        int1.hblnk  <= vga_in.hblnk;
        int1.rgb    <= vga_in.rgb;
    end
end

delay #(
    .WIDTH(38),
    .CLK_DEL(2)
) u_delay
(
    .clk(clk),
    .rst(rst),
    .din({vga_in.vcount, vga_in.vsync, vga_in.vblnk, vga_in.hcount, vga_in.hsync, vga_in.hblnk, vga_in.rgb}),
    .dout({int2.vcount, int2.vsync, int2.vblnk, int2.hcount, int2.hsync, int2.hblnk, int2.rgb})
);

always_ff @(posedge clk) begin
    vga_out.vcount <= int2.vcount;
    vga_out.vsync  <= int2.vsync;
    vga_out.vblnk  <= int2.vblnk;
    vga_out.hcount <= int2.hcount;
    vga_out.hsync  <= int2.hsync;
    vga_out.hblnk  <= int2.hblnk;
    vga_out.rgb    <= rgb_nxt;
end

always_comb begin
    hit_line_buf = vga_in.vcount - CHAR_Y_HOST;
    hit_xy_host_buf = vga_in.hcount - CHAR_X_HOST;
    hit_xy_guest_buf = vga_in.hcount - CHAR_X_GUEST;
    hit_xy_host = hit_xy_host_buf[10:5]+ 10*hit_line_buf[8:5];
    hit_xy_guest = hit_xy_guest_buf[10:5] + 10*hit_line_buf[8:5];
    hit_line = int1.vcount[4:1] - CHAR_Y_HOST[4:1];
end

always_comb begin
    if(((int2.hcount >= CHAR_X_GUEST) & (int2.hcount < CHAR_LENGTH + CHAR_X_GUEST) & (int2.vcount >= CHAR_Y_GUEST) & (int2.vcount <= CHAR_Y_GUEST + CHAR_HEIGHT)))  begin  
        
        if((hit_pixels[32 - (int2.hcount[10:0] - CHAR_X_GUEST)%32] == 1'b1) & (hit_pixels[31 - (int2.hcount[10:0] - CHAR_X_GUEST)%32] == 1'b1)) begin    
            rgb_nxt = 12'hf_0_0;
        end else begin
            rgb_nxt = int2.rgb;
        end
        /*else if(((int2.hcount >= CHAR_X_GUEST) & (int2.hcount < CHAR_LENGTH + CHAR_X_GUEST) & (int2.vcount >= CHAR_Y_HOST) & (int2.vcount <= CHAR_Y_HOST + CHAR_HEIGHT)))    
        if((ship_pixels[47 - (int2.hcount[10:1]*2 - CHAR_X_GUEST)%48] == 1'b0) & (ship_pixels[46 - (int2.hcount[10:1] - CHAR_X_GUEST)%48] == 1'b1)) begin    
            rgb_nxt = int2.rgb;
        end else if((ship_pixels[47 - (int2.hcount[10:1]*2 - CHAR_X_GUEST)%48] == 1'b1) & (ship_pixels[46 - (int2.hcount[10:1] - CHAR_X_GUEST)%48] == 1'b0)) begin    
            rgb_nxt = int2.rgb;
        end else if((ship_pixels[47 - (int2.hcount[10:1]*2 - CHAR_X_GUEST)%48] == 1'b1) & (ship_pixels[46 - (int2.hcount[10:1]*2 - CHAR_X_GUEST)%48] == 1'b1)) begin    
            rgb_nxt = int2.rgb;
        end else begin
            rgb_nxt = int2.rgb; 
        
            



         else if(((int2.hcount >= CHAR_X_GUEST) & (int2.hcount < CHAR_LENGTH + CHAR_X_GUEST) & (int2.vcount >= CHAR_Y_GUEST) & (int2.vcount <= CHAR_Y_GUEST + CHAR_HEIGHT))) begin 
        
            if((ship_pixels[32 - (int2.hcount[10:0] - CHAR_X_GUEST)%32] == 1'b1) & (ship_pixels[31 - (int2.hcount[10:0] - CHAR_X_GUEST)%32] == 1'b1)) begin    
            rgb_nxt = 12'hf_0_0;
        end else begin
            rgb_nxt = int2.rgb;
        end   
      */
   
        
    end
    else begin
        rgb_nxt = int2.rgb;
    end
end
endmodule
