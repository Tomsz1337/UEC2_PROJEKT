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
    input logic  [2:0] board[0:9][0:9],
    input logic        mouse_left,
    input logic [63:0] possible_moves,
    input logic [11:0] mouse_xpos,
    input logic [11:0] mouse_ypos,
    input logic        begin_turn,
    input logic        oponent_pick,
    input logic  [5:0] oponent_position,
    input logic        set_player,
    output logic [5:0] mouse_position,
    output logic       pick_place,
    output logic       next_turn,
    vga_if.in vga_in
);
typedef enum bit [1:0]{
    IDLE        = 2'b00,
    PICK_SHIP   = 2'b01,
    TURN_HOST   = 2'b10,
    TURN_GUEST  = 2'b11
} STATE_T;

STATE_T state, state_nxt;

logic pick_place_nxt;
logic [5:0] pick_position;
logic your_turn;
logic player_already_set = 0;

always_ff @(posedge begin_turn)begin
    your_turn <= '1;
end
always_ff @(negedge begin_turn)begin
    your_turn <= '1;
end

always_ff @(posedge clk) begin : xypos_blk
        if(rst) begin
            state    <= IDLE;
            mouse_position <= 0;
            pick_place <= '0;
            your_turn <= '0;
        end else begin
            if(vga_in.hcount == 0 & vga_in.vcount == 0)begin
                state    <= state_nxt;
                if(player_already_set == 0 & set_player == 1)begin
                    your_turn <= '1;
                end 
                else begin
                    pick_place <= pick_place_nxt;
                    mouse_position[7:4] <= (mouse_ypos-193)/32;
                    mouse_position[3:0] <= (mouse_xpos-608)/32;
                end
            end
        end
end


always_comb begin : state_nxt_blk
    case(state)
        IDLE:           state_nxt = ship_count = '0 && button = '1 ? PICK_SHIP : IDLE;                               // dodac counter statkow
        PICK_SHIP:      state_nxt = ship_count == '10 ? TURN_HOST : PICK_SHIP;                                // sygnal pick_rdy dodany
        TURN_HOST:      state_nxt = ((hit == '1 && ship_count != '0) ? TURN_GUEST : TURN_HOST) || (ship_count == '0 ? IDLE : TURN__HOST);                                    // sygnal hit
        TURN_GUEST:     state_nxt = ((hit == '1 && ship_count != '0) ? TURN_HOST : TURN_GUEST) || (ship_count == '0 ? IDLE : TURN__GUEST);
        
        default:    state_nxt = IDLE;
    endcase  
end


always_comb begin : output_blk
    case(state)
        IDLE: begin
            pick_position = 0;

        end

        PICK_SHIP: begin

            pick_position = mouse_position;

        end

        TURN_HOST: begin
            pick_position = mouse_position;

        end
        TURN_GUEST: begin
            pick_place_nxt = 0;
            if(pick_position == mouse_position)begin
                your_turn = 1;
            end else begin
                your_turn = 0;
                next_turn = !begin_turn;
            end

        end

        default: begin
            pick_place_nxt = 0;

        end
    endcase
end

endmodule