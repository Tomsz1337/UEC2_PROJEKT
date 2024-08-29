//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow
// Create Date : 23.08.2024
// Designers Name : Tomasz Ochamenk & Jan PAnek
// Module Name : ship_rom
// Project Name : 
// Target Devices : BASYS3
// 
// Description : rysowanie statkow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module ship_rom
    (
        input  logic   clk,
        input  logic  [6:0] addres,
        input  logic  [6:0] addres_guest,
        output logic  [31:0] ship_line_pixels_out,
        output logic  [31:0] ship_line_pixels_out_guest   // pixels of the figure line //
    );

    // SIGNAL DECLARATION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [31:0] data;
    logic [31:0] data_guest;

    // BODY ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk) begin
        ship_line_pixels_out <= data;
        ship_line_pixels_out_guest <= data_guest;

    end
    
    always_comb begin
        case (addres)
            //////////puste pole
            7'h00: data = 32'h00000000;  //0100000
            7'h01: data = 32'h00000000;
            7'h02: data = 32'h00000000;
            7'h03: data = 32'h00000000;
            7'h04: data = 32'h00000000;
            7'h05: data = 32'h00000000;
            7'h06: data = 32'h00000000;
            7'h07: data = 32'h00000000;
            7'h08: data = 32'h00000000;
            7'h09: data = 32'h00000000;
            7'h0a: data = 32'h00000000;
            7'h0b: data = 32'h00000000;
            7'h0c: data = 32'h00000000;
            7'h0d: data = 32'h00000000;
            7'h0e: data = 32'h00000000;
            7'h0f: data = 32'h00000000;
            

            /////////////////statek
            7'h20: data = 32'hffffffff; 
            7'h21: data = 32'hffffffff;
            7'h22: data = 32'hffffffff;
            7'h23: data = 32'hffffffff;
            7'h24: data = 32'hffffffff;
            7'h25: data = 32'hffffffff;
            7'h26: data = 32'hffffffff;
            7'h27: data = 32'hffffffff;
            7'h28: data = 32'hffffffff;
            7'h29: data = 32'hffffffff;
            7'h2a: data = 32'hffffffff;
            7'h2b: data = 32'hffffffff;
            7'h2c: data = 32'hffffffff;
            7'h2d: data = 32'hffffffff;
            7'h2e: data = 32'hffffffff;
            7'h2f: data = 32'hffffffff;
            


            //////////////TRFIONY
            7'h40: data = 32'hFFFFFFFF; //100.0000
            7'h41: data = 32'hF38001CF;
            7'h42: data = 32'hF1C0038F;
            7'h43: data = 32'hF0E0070F;
            7'h44: data = 32'hF0700E0F;
            7'h45: data = 32'hF0381C0F;
            7'h46: data = 32'hF01C380F;
            7'h47: data = 32'hF00E700F;
            7'h48: data = 32'hF003C00F;
            7'h49: data = 32'hF00E700F;
            7'h4a: data = 32'hF01C380F;
            7'h4b: data = 32'hF0381C0F;
            7'h4c: data = 32'hF0700E0F;
            7'h4d: data = 32'hF0E0070F;
            7'h4e: data = 32'hF1C0038F;
            7'h4f: data = 32'hFFFFFFFF;
            

            ////////////////////////CHYBIONY
            7'h60: data = 32'h00000000; 
            7'h61: data = 32'h00000000;
            7'h62: data = 32'h07FFFFE0;
            7'h63: data = 32'h070000E0;
            7'h64: data = 32'h070000E0;
            7'h65: data = 32'h070000E0;
            7'h66: data = 32'h070000E0;
            7'h67: data = 32'h070000E0;
            7'h68: data = 32'h070000E0;
            7'h69: data = 32'h070000E0;
            7'h6a: data = 32'h070000E0;
            7'h6b: data = 32'h070000E0;
            7'h6c: data = 32'h070000E0;
            7'h6d: data = 32'h07FFFFE0;
            7'h6e: data = 32'h00000000;
            7'h6f: data = 32'h00000000;
            

            
        endcase
        case (addres_guest)
            //////////puste pole
            7'h00: data_guest = 32'h00000000;  //0100000
            7'h01: data_guest = 32'h00000000;
            7'h02: data_guest = 32'h00000000;
            7'h03: data_guest = 32'h00000000;
            7'h04: data_guest = 32'h00000000;
            7'h05: data_guest = 32'h00000000;
            7'h06: data_guest = 32'h00000000;
            7'h07: data_guest = 32'h00000000;
            7'h08: data_guest = 32'h00000000;
            7'h09: data_guest = 32'h00000000;
            7'h0a: data_guest = 32'h00000000;
            7'h0b: data_guest = 32'h00000000;
            7'h0c: data_guest = 32'h00000000;
            7'h0d: data_guest = 32'h00000000;
            7'h0e: data_guest = 32'h00000000;
            7'h0f: data_guest = 32'h00000000;
            

            /////////////////statek
            7'h20: data_guest = 32'hffffffff; 
            7'h21: data_guest = 32'hffffffff;
            7'h22: data_guest = 32'hffffffff;
            7'h23: data_guest = 32'hffffffff;
            7'h24: data_guest = 32'hffffffff;
            7'h25: data_guest = 32'hffffffff;
            7'h26: data_guest = 32'hffffffff;
            7'h27: data_guest = 32'hffffffff;
            7'h28: data_guest = 32'hffffffff;
            7'h29: data_guest = 32'hffffffff;
            7'h2a: data_guest = 32'hffffffff;
            7'h2b: data_guest = 32'hffffffff;
            7'h2c: data_guest = 32'hffffffff;
            7'h2d: data_guest = 32'hffffffff;
            7'h2e: data_guest = 32'hffffffff;
            7'h2f: data_guest = 32'hffffffff;
            


            //////////////TRFIONY
            7'h40: data_guest = 32'hFFFFFFFF; //100.0000
            7'h41: data_guest = 32'hF38001CF;
            7'h42: data_guest = 32'hF1C0038F;
            7'h43: data_guest = 32'hF0E0070F;
            7'h44: data_guest = 32'hF0700E0F;
            7'h45: data_guest = 32'hF0381C0F;
            7'h46: data_guest = 32'hF01C380F;
            7'h47: data_guest = 32'hF00E700F;
            7'h48: data_guest = 32'hF003C00F;
            7'h49: data_guest = 32'hF00E700F;
            7'h4a: data_guest = 32'hF01C380F;
            7'h4b: data_guest = 32'hF0381C0F;
            7'h4c: data_guest = 32'hF0700E0F;
            7'h4d: data_guest = 32'hF0E0070F;
            7'h4e: data_guest = 32'hF1C0038F;
            7'h4f: data_guest = 32'hFFFFFFFF;
            

            ////////////////////////CHYBIONY
            7'h60: data_guest = 32'h00000000; 
            7'h61: data_guest = 32'h00000000;
            7'h62: data_guest = 32'h07FFFFE0;
            7'h63: data_guest = 32'h070000E0;
            7'h64: data_guest = 32'h070000E0;
            7'h65: data_guest = 32'h070000E0;
            7'h66: data_guest = 32'h070000E0;
            7'h67: data_guest = 32'h070000E0;
            7'h68: data_guest = 32'h070000E0;
            7'h69: data_guest = 32'h070000E0;
            7'h6a: data_guest = 32'h070000E0;
            7'h6b: data_guest = 32'h070000E0;
            7'h6c: data_guest = 32'h070000E0;
            7'h6d: data_guest = 32'h07FFFFE0;
            7'h6e: data_guest = 32'h00000000;
            7'h6f: data_guest = 32'h00000000;
            

            
        endcase
    end
endmodule
