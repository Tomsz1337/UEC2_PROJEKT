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
        input  logic  [8:0] ship_line,
        output logic  [47:0] figure_line_pixels   // pixels of the figure line //
    );

    // SIGNAL DECLARATION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [47:0] data;

    // BODY ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk) begin
        figure_line_pixels <= data;
    end
    
    always_comb begin
        case (ship_line)
            9'h040: data = 48'h0000000000000000;
            9'h041: data = 48'h0000000000000000;
            9'h042: data = 48'h0000000140000000;
            9'h043: data = 48'h0000000690000000;
            9'h044: data = 48'h0000000690000000;
            9'h045: data = 48'h0000000140000000;
            9'h046: data = 48'h0000000690000000;
            9'h047: data = 48'h0000001AA4000000;
            9'h048: data = 48'h0000006AA9000000;
            9'h049: data = 48'h000001AAAA400000;
            9'h04a: data = 48'h000001AAAA400000;
            9'h04b: data = 48'h000006AAA9000000;
            9'h04c: data = 48'h00001AAAA4140000;
            9'h04d: data = 48'h00001AAA90480000;
            9'h04e: data = 48'h0000111110000000;
            9'h04f: data = 48'h0000111111190000;
            9'h050: data = 48'h0000011111110000;
            9'h051: data = 48'h0000011111190000;
            9'h052: data = 48'h00001AAAAAA40000;
            9'h053: data = 48'h00001AAAAAA40000;
            9'h054: data = 48'h00001AAAAAA40000;
            9'h055: data = 48'h000006AAAA900000;
            9'h056: data = 48'h000006AAAA900000;
            9'h057: data = 48'h000001AAAA400000;
            9'h058: data = 48'h000001AAAA400000;
            9'h059: data = 48'h0000055555500000;
            9'h05a: data = 48'h00001AAAAAA40000;
            9'h05b: data = 48'h0000005011550000;
            9'h05c: data = 48'h0000111AAAA90000;
            9'h05d: data = 48'h0000111111550000;
            9'h05e: data = 48'h0000000000000000;
            9'h05f: data = 48'h0000000000000000;
        endcase     
    end
endmodule