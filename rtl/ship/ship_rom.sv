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
        input  logic  [7:0] addres,
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
            7'h018: data = 48'hffffffffffff;
            7'h019: data = 48'hffffffffffff;
            7'h01a: data = 48'hffffffffffff;
            7'h01b: data = 48'hffffffffffff;
            7'h01c: data = 48'hffffffffffff;
            7'h01d: data = 48'hffffffffffff;
            7'h01e: data = 48'hffffffffffff;
            7'h01f: data = 48'hffffffffffff;
            7'h020: data = 48'hffffffffffff;
            7'h021: data = 48'hffffffffffff;
            7'h022: data = 48'hffffffffffff;
            7'h023: data = 48'hffffffffffff;
            7'h024: data = 48'hffffffffffff;
            7'h025: data = 48'hffffffffffff; //0100000
            7'h026: data = 48'hffffffffffff;
            7'h027: data = 48'hffffffffffff;
            7'h028: data = 48'hffffffffffff;
            7'h029: data = 48'hffffffffffff;
            7'h02a: data = 48'hffffffffffff;
            7'h02b: data = 48'hffffffffffff;
            7'h02c: data = 48'hffffffffffff;
            7'h02d: data = 48'hffffffffffff;
            7'h02e: data = 48'hffffffffffff;
            7'h02f: data = 48'hffffffffffff;

            7'b01000000: data = 48'h000000000000; //0000001100000
            7'h031: data = 48'h000000000000;
            7'h032: data = 48'h000000000000;
            7'h033: data = 48'h000000000000;
            7'h034: data = 48'h000000000000;
            7'h035: data = 48'h000000000000;
            7'h036: data = 48'h000000000000;
            7'h037: data = 48'h000000000000;
            7'h038: data = 48'h000000000000;
            7'h039: data = 48'h000000000000;
            7'h03a: data = 48'h000000000000;
            7'h03b: data = 48'h000000000000;
            7'h03c: data = 48'h000000000000;
            7'h03d: data = 48'h000000000000;
            7'h03e: data = 48'h000000000000;
            7'h03f: data = 48'h000000000000;
            7'h040: data = 48'h000000000000;
            7'h041: data = 48'h000000000000;
            7'h042: data = 48'h000000000000;
            7'h043: data = 48'h000000000000;
            7'h044: data = 48'h000000000000;
            7'h045: data = 48'h000000000000;
            7'h046: data = 48'h000000000000;
            7'h047: data = 48'h000000000000;
            7'h048: data = 48'h000000000000;
            7'h049: data = 48'h000000000000;
            7'h04a: data = 48'h000000000000;
            7'h04b: data = 48'h000000000000;
            7'h04c: data = 48'h000000000000;
            7'h04d: data = 48'h000000000000;
            7'h04e: data = 48'h000000000000;
            7'h04f: data = 48'h000000000000;
            7'h050: data = 48'h000000000000;
            7'h051: data = 48'h000000000000;
            7'h052: data = 48'h000000000000;
            7'h053: data = 48'h000000000000;
            7'h054: data = 48'h000000000000;
            7'h055: data = 48'h000000000000;
            7'h056: data = 48'h000000000000;
            7'h057: data = 48'h000000000000;
            7'h058: data = 48'h000000000000;
            7'h059: data = 48'h000000000000;
            7'h05a: data = 48'h000000000000;
            7'h05b: data = 48'h000000000000;
            7'h05c: data = 48'h000000000000;
            7'h05d: data = 48'h000000000000;
            7'h05e: data = 48'h000000000000;
            7'h05f: data = 48'h000000000000;
        endcase
    end
endmodule