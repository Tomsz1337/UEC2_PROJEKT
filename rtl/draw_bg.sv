/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 * Modified : Tomasz Ochmanek 2024
 * Description:
 * Draw background.
 */


 `timescale 1 ns / 1 ps
 
 module draw_bg 
 (
     input  logic clk,
     input  logic rst,
     vga_if.in vga_in,    
     vga_if.out vga_out   
 );
 
 import vga_pkg::*;
 
 // LOCAL VARIABLES AND SIGNALES ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 logic [11:0] rgb_nxt;
 localparam LIGHT_COLOR = 12'h0_C_F;
 localparam DARK_COLOR = 12'hC_C_C;
 vga_if int2();
 
  // INTERNAL LOGIC ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 delay #(
     .WIDTH(38),
     .CLK_DEL(1)
 ) u_delay(
     .clk(clk),
     .rst(rst),
     .din({vga_in.vcount, vga_in.vsync, vga_in.vblnk, vga_in.hcount, vga_in.hsync, vga_in.hblnk, vga_in.rgb}),
     .dout({int2.vcount, int2.vsync, int2.vblnk, int2.hcount, int2.hsync, int2.hblnk, int2.rgb})
 );
 
 
 always_ff @(posedge clk) begin : bg_ff_blk
     if (rst) begin
         vga_out.vcount <= '0;
         vga_out.vsync  <= '0;
         vga_out.vblnk  <= '0;
         vga_out.hcount <= '0;
         vga_out.hsync  <= '0;
         vga_out.hblnk  <= '0;
         vga_out.rgb    <= '0;
     end else begin
         vga_out.vcount <= int2.vcount;
         vga_out.vsync  <= int2.vsync;
         vga_out.vblnk  <= int2.vblnk;
         vga_out.hcount <= int2.hcount;
         vga_out.hsync  <= int2.hsync;
         vga_out.hblnk  <= int2.hblnk;
         vga_out.rgb    <= rgb_nxt;
     end
 end
 
 always_comb begin : bg_comb_blk
     
     // BLANKING REGION ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     
     if (int2.vblnk || int2.hblnk) begin             // Blanking region:
         rgb_nxt = 12'h0_0_0;                    // - make it it black.
     end 
     
     // ACTIVE REGION ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
     else begin             
 
         // OBRAMOWANIE EKRANU ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
         if (int2.vcount == 0)                       // TOP EDGE - YELLOW //
             rgb_nxt = 12'hf_f_0;                    
         else if (int2.vcount == VER_PIXELS - 1)     // BOTTOM EDGE - RED //
             rgb_nxt = 12'hf_0_0;                    
         else if (int2.hcount == 0)                  // LEFT EDGE - GREEN //
             rgb_nxt = 12'h0_f_0;                    
         else if (int2.hcount == HOR_PIXELS - 1)     // RIGHT EDGE - BLUE //
             rgb_nxt = 12'h0_0_f;                    
        
         // RAMKA PLANSZY I POL 1PIX /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          
           else if(int2.hcount%32 == 0 & ((int2.hcount >= 96 & int2.hcount <= 416) | (int2.hcount >= 608 & int2.hcount <= 928)) & int2.vcount >= 192 & int2.vcount <= 512)
                 rgb_nxt = 12'h0_0_0;
 
           else if(int2.vcount%32 == 0 & ((int2.hcount >= 96 & int2.hcount <= 416) | (int2.hcount >= 608 & int2.hcount <= 928)) & int2.vcount >= 192 & int2.vcount <= 512)
                 rgb_nxt = 12'h0_0_0;
 
 
         // POLA PLANSZY 48PIX /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
             else if ((int2.hcount >= 96 & int2.hcount < 416 & int2.vcount >= 192 & int2.vcount < 512))
                 rgb_nxt = LIGHT_COLOR;
        
             else if ((int2.hcount >= 608 & int2.hcount < 928 & int2.vcount >= 192 & int2.vcount < 512))
                 rgb_nxt = DARK_COLOR;

         // KOLOR TŁA ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////        
         else                                     
             rgb_nxt = 12'hF_A_C;                
        
    end
end 
endmodule
