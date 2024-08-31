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
    input logic [11:0] mouse_xpos,
    input logic [11:0] mouse_ypos,
   
    input logic        start_button,
    input logic        board_addres,
    input logic [1:0] msg_send,
    input logic [1:0] msg_in,
    input logic [7:0] check_in,
    output logic [7:0] check_out,
    input logic [3:0]  ship_count,
    output logic [7:0] mouse_position,
    output logic [7:0] addres4check,
    output logic       pick_place,
    output logic       pick_ship,
    output logic [3:0] state_led,
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

logic player;

logic your_turn;
logic your_turn_nxt;


always_ff @(posedge clk) begin : xypos_blk
        if(rst) begin
            player <= '0;
            state    <= PICK_SHIP;
            mouse_position <= 0;
            
            your_turn <= '0;
        end else begin
            if(vga_in.hcount == 0 & vga_in.vcount == 0)begin
                
                player <= board_addres;
                state    <= state_nxt;
                your_turn <= your_turn_nxt;
                
                mouse_position[7:4] <= (mouse_ypos-193)/32;
                mouse_position[3:0] <= (mouse_xpos-608)/32;
                    
                   
            end
        end
end


always_comb begin : state_nxt_blk
    case(state)
        //IDLE:           state_nxt = start_button == '1 ? PICK_SHIP : IDLE;                               // dodac counter statkow
        PICK_SHIP:      state_nxt = ship_count == 11 ? (player ? WAIT : TURN) : PICK_SHIP;                                // sygnal pick_rdy dodany
        WAIT:           state_nxt = your_turn == '1 ? TURN : WAIT;                                  // sygnal hit
        TURN:           state_nxt = your_turn ? TURN : WAIT;
        
        default:    state_nxt = PICK_SHIP;
    endcase  
end


always_comb begin : output_blk
    case(state)
        IDLE: begin
            
            pick_ship = 0;
            state_led = 4'b1000;
        end

        PICK_SHIP: begin
            if(mouse_left == 1) begin
                pick_ship = 1;
            end
            else begin
                pick_ship = 0;
            end
            state_led = 4'b0100;
        end

        WAIT: begin
            pick_place = 0;
            addres4check = check_in;
            if(msg_send != 0 ) begin
                your_turn_nxt = 1;
            end
            state_led = 4'b0010;
        end
        TURN: begin
            pick_place = 1;
            if(mouse_left == 1)begin
                check_out = mouse_position;
            end
            state_led = 4'b0001;
            if(msg_in != 0) begin
                your_turn_nxt = 0;
            end
            else begin
                your_turn_nxt = 1;
            end
        end

        default: begin
           

        end
    endcase
end

endmodule