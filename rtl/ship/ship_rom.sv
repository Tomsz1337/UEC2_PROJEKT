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
        output logic  [31:0] ship_line_pixels_out   // pixels of the figure line //
    );

    // SIGNAL DECLARATION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [31:0] data;

    // BODY ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk) begin
        ship_line_pixels_out <= data;
    end
    
    always_comb begin
        case (addres)
            //////////Statek
            7'h00: data = 32'hffffffff;  //0100000
            7'h01: data = 32'hffffffff;
            7'h02: data = 32'hffffffff;
            7'h03: data = 32'hffffffff;
            7'h04: data = 32'hffffffff;
            7'h05: data = 32'hffffffff;
            7'h06: data = 32'hffffffff;
            7'h07: data = 32'hffffffff;
            7'h08: data = 32'hffffffff;
            7'h09: data = 32'hffffffff;
            7'h0a: data = 32'hffffffff;
            7'h0b: data = 32'hffffffff;
            7'h0c: data = 32'hffffffff;
            7'h0d: data = 32'hffffffff;
            7'h0e: data = 32'hffffffff;
            7'h0f: data = 32'hffffffff;
            

            /////////////////PUSTE POLE
            7'h20: data = 32'h00000000; 
            7'h21: data = 32'h00000000;
            7'h22: data = 32'h00000000;
            7'h23: data = 32'h00000000;
            7'h24: data = 32'h00000000;
            7'h25: data = 32'h00000000;
            7'h26: data = 32'h00000000;
            7'h27: data = 32'h00000000;
            7'h28: data = 32'h00000000;
            7'h29: data = 32'h00000000;
            7'h2a: data = 32'h00000000;
            7'h2b: data = 32'h00000000;
            7'h2c: data = 32'h00000000;
            7'h2d: data = 32'h11110000;
            7'h2e: data = 32'hF1110000;
            7'h2f: data = 32'h00000000;
            7'h30: data = 32'h00000000;
            7'h31: data = 32'h00000000;
            7'h32: data = 32'h00000000;
            7'h33: data = 32'h11100000;
            7'h34: data = 32'h00000000;
            7'h35: data = 32'h00000000;
            7'h36: data = 32'h00000000;
            7'h37: data = 32'h00000000;
            7'h38: data = 32'h00000000;
            7'h39: data = 32'h00000000;
            7'h3a: data = 32'h00000000;
            7'h3b: data = 32'h00000000;
            7'h3c: data = 32'h00000000;
            7'h3d: data = 32'h00000000;
            7'h3e: data = 32'h00000000;
            7'h3f: data = 32'h00000000;


            //////////////TRFIONY
            7'h40: data = 32'h00000000; //100.0000
            7'h41: data = 32'h00000000;
            7'h42: data = 32'h01C00380;
            7'h43: data = 32'h00E00700;
            7'h44: data = 32'h00700E00;
            7'h45: data = 32'h00381C00;
            7'h46: data = 32'h001C3800;
            7'h47: data = 32'h000E7000;
            7'h48: data = 32'h0003C000;
            7'h49: data = 32'h000E7000;
            7'h4a: data = 32'h001C3800;
            7'h4b: data = 32'h00381C00;
            7'h4c: data = 32'h00700E00;
            7'h4d: data = 32'h00E00700;
            7'h4e: data = 32'h01C00380;
            7'h4f: data = 32'h00000000;
            

            ////////////////////////CHYBIONY
            7'h60: data = 32'h00000000; 
            7'h61: data = 32'h7FFFFFFE;
            7'h62: data = 32'h7000000E;
            7'h63: data = 32'h7000000E;
            7'h64: data = 32'h7000000E;
            7'h65: data = 32'h7000000E;
            7'h66: data = 32'h7000000E;
            7'h67: data = 32'h7000000E;
            7'h68: data = 32'h7000000E;
            7'h69: data = 32'h7000000E;
            7'h6a: data = 32'h7000000E;
            7'h6b: data = 32'h7000000E;
            7'h6c: data = 32'h7000000E;
            7'h6d: data = 32'h7000000E;
            7'h6e: data = 32'h7FFFFFFE;
            7'h6f: data = 32'h00000000;
            

            
        endcase
    end
endmodule
