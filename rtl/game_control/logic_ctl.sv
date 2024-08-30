///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//Company : AGH University of Krakow
// Create Date : 25.08.2024
// Designers Name : Tomasz Ochmanek & JAn PAnek
// Module Name : logic_ctl
// Project Name : SZACHY - Projekt zaliczeniowy
// Target Devices : BASYS3
// 
// Description : maszyna stanow sterujaca gra
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module logic_ctl
import vga_pkg::*; (
    input logic        clk,
    input logic        rst,
    input logic        mouse_left,
    input logic        start_button,
    input logic [11:0] mouse_xpos,
    input logic [11:0] mouse_ypos,
    input logic        answer,
    input logic        set_player,
    output logic [7:0] mouse_position,
    output logic       pick_place,
    output logic       pick_ship,
    vga_if.in vga_in
);
typedef enum bit [1:0]
{
    IDLE        = 2'b00,
    PICK_SHIP   = 2'b01,
    WAIT        = 2'b10,
    TURN        = 2'b11
} STATE_T;

STATE_T state, state_nxt;

logic ship_count_buf;
logic hit_buf;
logic answer_buf;
logic pick_place_nxt;
logic [7:0] pick_position;
logic your_turn;

/*always_ff @(posedge begin_turn)begin
    your_turn <= '1;
end
always_ff @(negedge begin_turn)begin
    your_turn <= '1;
end*/

always_ff @(posedge clk) begin : xypos_blk
        if(rst) begin
            state    <= IDLE;
            mouse_position <= 0;
            pick_place <= '0;
            your_turn <= '0;
        end else begin
            if(vga_in.hcount == 0 & vga_in.vcount == 0)begin
                state    <= state_nxt;
                //if(player_already_set == 0 & set_player == 1)begin
                 //   your_turn <= '1;
                //end 
               // else begin
                    pick_place <= pick_place_nxt;
                    
                    if(mouse_left == '1 ) begin
                        mouse_position[7:4] <= (mouse_ypos-193)/32;
                        mouse_position[3:0] <= (mouse_xpos-608)/32;
                    end
                    /*else if (mouse_left == '1 && mouse_xpos <= 416)
                        mouse_position[7:4] <= (mouse_ypos-193)/32;
                        mouse_position[3:0] <= (mouse_xpos-96)/32;
                    */
            end
        end
end


always_comb begin : state_nxt_blk
    case(state)
        IDLE:           state_nxt = start_button == '1 ? PICK_SHIP : IDLE;                               // dodac counter statkow
        PICK_SHIP:      state_nxt = ship_count_buf == 10 ? WAIT : PICK_SHIP;                                // sygnal pick_rdy dodany
        WAIT:           state_nxt = your_turn == '1 ? TURN : WAIT;                                  // sygnal hit
        TURN:           state_nxt = hit_buf == '1 && answer_buf == '1 ? WAIT : TURN;
        
        default:    state_nxt = IDLE;
    endcase  
end


always_comb begin : output_blk
    case(state)
        IDLE: begin
            pick_position = 0;
            pick_ship = 0;
        end

        PICK_SHIP: begin

            pick_position = mouse_position;
            pick_ship = 1;
        end

        WAIT: begin
            pick_place = 0;

        end
        TURN: begin
            pick_place = 1;

        end

        default: begin
            pick_place_nxt = 0;

        end
    endcase
end

endmodule