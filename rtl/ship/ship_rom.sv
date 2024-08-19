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
        output logic  [47:0] ship_line_pixels   // pixels of the figure line //
    );

    // SIGNAL DECLARATION //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    logic [47:0] data;

    // BODY ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk) begin
        ship_line_pixels <= data;
    end
    
    always_comb begin
        case (ship_line)
            9'h001: data = 48'h000000000000;
            9'h002: data = 48'h000000000000;
            9'h003: data = 48'h000000014000;
            9'h004: data = 48'h000000069000;
            9'h005: data = 48'h000000069000;
            9'h006: data = 48'h000000014000;
            9'h007: data = 48'h000000069000;
            9'h008: data = 48'h0000001AA400;
            9'h009: data = 48'h0000006AA900;
            9'h00a: data = 48'h000001AAAA40;
            9'h00b: data = 48'h000001AAAA40;
            9'h00c: data = 48'h000006AAA900;
            9'h00d: data = 48'h00001AAAA414;
            9'h00e: data = 48'h00001AAA9048;
            9'h00f: data = 48'h000011111000;
            9'h010: data = 48'h000011111119;
            9'h011: data = 48'h000001111111;
            9'h012: data = 48'h000001111119;
            9'h013: data = 48'h00001AAAAAA4;
            9'h014: data = 48'h00001AAAAAA4;
            9'h015: data = 48'h00001AAAAAA4;
            9'h016: data = 48'h000006AAAA90;
            9'h017: data = 48'h000006AAAA90;
            9'h018: data = 48'h000001AAAA40;
            9'h019: data = 48'h000001AAAA40;
            9'h01a: data = 48'h000005555550;
            9'h01b: data = 48'h00001AAAAAA4;
            9'h01c: data = 48'h000000501155;
            9'h01d: data = 48'h0000111AAAA9;
            9'h01e: data = 48'h000011111155;
            9'h01f: data = 48'h000000000000;
            9'h020: data = 48'h000000000000;
        endcase     
    end
endmodule