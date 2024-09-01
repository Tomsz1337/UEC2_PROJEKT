///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
//Company : AGH University of Krakow
// Create Date : 25.08.2024
// Designers Name : Tomasz Ochmanek & JAn PAnek
// Module Name : logic_ctl
// Project Name :  UEC2_PROJEKT_STATKI
// Target Devices : BASYS3
// 
// Description : maszyna stanow sterujaca gra
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module logic_ctl
import vga_pkg::*; (
    input logic         clk,
    input logic         rst,
    input logic         mouse_left,
    input logic  [11:0] mouse_xpos,
    input logic  [11:0] mouse_ypos,
    input logic         board_addres,
    input logic  [1:0]  msg_send,
    input logic  [1:0]  msg_in,
    input logic  [3:0]  ship_count,
    input logic  [7:0]  check_in,
    input logic  [10:0] hcount,
    input logic  [10:0] vcount,
    output logic [7:0]  check_out,
    output logic        addres_sent,
    output logic [7:0]  mouse_position,
    output logic [7:0]  addres4check,
    output logic        pick_place,
    output logic        pick_ship,
    output logic [2:0]  state_led
    
);
typedef enum bit [1:0]
{
    PICK_SHIP   = 2'b01,
    WAIT        = 2'b10,
    TURN        = 2'b11
} STATE_T;

STATE_T state, state_nxt;

logic player;
logic your_turn;
logic your_turn_nxt;
logic addres_sent_nxt;
logic pick_ship_nxt;
logic pick_place_nxt;
logic [7:0] check_out_nxt;


always_ff @(posedge clk) begin : xypos_blk
        if(rst) begin
            player <= '0;
            state    <= PICK_SHIP;
            mouse_position <= '0;
            pick_ship <= '0;
            pick_place <= '0;
            addres_sent <= '0;
            your_turn <= '0;
            check_out <= '0;
        end else begin
            
            if(hcount == 0 & vcount == 0)begin
                player <= board_addres;
                state    <= state_nxt;
                your_turn <= your_turn_nxt;
                pick_ship <= pick_ship_nxt;
                pick_place <= pick_place_nxt;
                addres_sent <= addres_sent_nxt;
                check_out <= check_out_nxt;

                mouse_position[7:4] <= (mouse_ypos-193)/32;
                mouse_position[3:0] <= (mouse_xpos-608)/32;      
            end
        end
end


always_comb begin : state_nxt_blk
    case(state)
        PICK_SHIP:      state_nxt = ship_count == 11 & !mouse_left ? (player ? WAIT : TURN) : PICK_SHIP;                               
        WAIT:           state_nxt = your_turn & !msg_send & !msg_in ? TURN : WAIT;                                 
        TURN:           state_nxt = your_turn & !msg_in & !msg_send ? TURN : WAIT;
        
        default:    state_nxt = PICK_SHIP;
    endcase  
end


always_ff @(posedge clk) begin : output_blk
    case(state)
    
        PICK_SHIP: begin
            if(mouse_left == 1) begin
                pick_ship_nxt <= 1;
            end
            else begin
                pick_ship_nxt <= 0;
            end
            state_led <= 3'b100;
            if(player == 1)begin
                your_turn_nxt <= '0;
            end else begin
                your_turn_nxt <= '1;
            end
        end

        WAIT: begin
            pick_place_nxt <= 0;
            addres4check <= check_in;
            if(msg_send != 0 ) begin
                your_turn_nxt <= 1;
            end
            addres_sent_nxt <= '0;
            state_led <= 3'b010;
        end
        TURN: begin
            pick_place_nxt <= 1;
            if(mouse_left == 1)begin
                check_out_nxt <= mouse_position;
                addres_sent_nxt <= '1;
            end
            state_led <= 3'b001;
            if(msg_in != 0) begin
                your_turn_nxt <= 0;
            end
            else begin
                your_turn_nxt <= 1;
            end
        end

        default: begin
            your_turn_nxt <= '0;
           

        end
    endcase
end

endmodule