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
        output logic  [47:0] ship_line_pixels_out   // pixels of the figure line //
    );

    // SIGNAL DECLARATION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [47:0] data;

    // BODY ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk) begin
        ship_line_pixels_out <= data;
    end
    
    always_comb begin
        case (addres)
            7'h000: data = 48'hffffffffffff;
            7'h001: data = 48'hffffffffffff;
            7'h002: data = 48'hffffffffffff;
            7'h003: data = 48'hffffffffffff;
            7'h004: data = 48'hffffffffffff;
            7'h005: data = 48'hffffffffffff;
            7'h006: data = 48'hffffffffffff;
            7'h007: data = 48'hffffffffffff;
            7'h008: data = 48'hffffffffffff;
            7'h009: data = 48'hffffffffffff;
            7'h00a: data = 48'hffffffffffff;
            7'h00b: data = 48'hffffffffffff;
            7'h00c: data = 48'hffffffffffff;
            7'h00d: data = 48'hffffffffffff;
            7'h00e: data = 48'hffffffffffff;
            7'h00f: data = 48'hffffffffffff;
            7'h010: data = 48'hffffffffffff;
            7'h011: data = 48'hffffffffffff;
            7'h012: data = 48'hffffffffffff;
            7'h013: data = 48'hffffffffffff;
            7'h014: data = 48'hffffffffffff;
            7'h015: data = 48'hffffffffffff;
            7'h016: data = 48'hffffffffffff;
            7'h017: data = 48'hffffffffffff;
            7'h018: data = 48'h000000000000;
            7'h019: data = 48'h000000000000;
            7'h01a: data = 48'h000000000000;
            7'h01b: data = 48'h000000000000;
            7'h01c: data = 48'h000000000000;
            7'h01d: data = 48'h000000000000;
            7'h01e: data = 48'h000000000000;
            7'h01f: data = 48'h000000000000;
            7'h020: data = 48'h000000000000;
            7'h021: data = 48'h000000000000;
            7'h022: data = 48'h000000000000;
            7'h023: data = 48'h000000000000;
            7'h024: data = 48'h000000000000;
            7'h025: data = 48'h000000000000;
            7'h026: data = 48'h000000000000;
            7'h027: data = 48'h000000000000;
            7'h028: data = 48'h000000000000;
            7'h029: data = 48'h000000000000;
            7'h02a: data = 48'h000000000000;
            7'h02b: data = 48'h000000000000;
            7'h02c: data = 48'h000000000000;
            7'h02d: data = 48'h000000000000;
            7'h02e: data = 48'h000000000000;
            7'h02f: data = 48'hffffffffffff;

        endcase
    end
endmodule