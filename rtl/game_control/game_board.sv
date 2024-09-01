/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow
// Create Date : 28.07.2024
// Designers Name : Jan Panek & TOmasz Ochmanek
// Module Name : game_board
// Project Name : UEC2_PRJ_STATKI
// Target Devices : BASYS3
// 
// Description :matryca pozycji statków, kontrola wpisywania i odczytywania danych
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module game_board 
    (
        input logic        clk,                           
        input logic        rst,                         
        input logic        pick_ship,
        input logic  [7:0] mouse_pos,
        input logic  [6:0] ship_xy_host,
        input logic  [6:0] ship_xy_guest,
        input logic        pick_place,
        input logic  [1:0] msg_in,
        input logic  [7:0] check_in,
        input logic        addres_recieved,
        output logic [1:0] msg_out,
        output logic [1:0] ship_code_host,
        output logic [1:0] ship_code_guest, 
        output logic [3:0] ship_count,
        vga_if.in vga_in
    );
    
    logic [1:0] board_host [0:9][0:9];
    logic [1:0] board_guest [0:9][0:9];
    logic [3:0] hit_counter;

        always_ff @(posedge clk, posedge rst) begin
            if (rst) begin
                hit_counter <= 4'b1011;
                ship_count <= 4'b0000;
                ship_code_host <= 2'b00;
                ship_code_guest <= 2'b00;
                msg_out <= 2'b00;

                board_host[0] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[1] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[2] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[3] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[4] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[5] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[6] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[7] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};

                board_guest[0] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[1] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[2] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[3] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[4] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[5] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[6] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[7] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};

            end 
            else if(vga_in.hcount == 0 & vga_in.vcount == 300)begin
                if(pick_ship == 1 && board_host[mouse_pos[7:4]][mouse_pos[3:0]] == 2'b00 && ship_count <= 10) begin
                    
                    board_host[mouse_pos[7:4]][mouse_pos[3:0]] <= 2'b01;
                    ship_count ++;
                end
                
                else if (pick_place == 0 && pick_ship == 0 && ship_count >= 10 && addres_recieved == 1) begin

                    if(board_host[check_in[7:4]][check_in[3:0]] == 2'b00) begin
                        msg_out <= 2'b11;
                        board_host[check_in[7:4]][check_in[3:0]] <= 2'b11;
                    end
                    else if(board_host[check_in[7:4]][check_in[3:0]] == 2'b01) begin
                        msg_out <= 2'b10;
                        board_host[check_in[7:4]][check_in[3:0]] <= 2'b10;
                        hit_counter --;
                    end else begin
                        msg_out <= 2'b00;
                    end
                    
                end

                else if(pick_place == 1 && pick_ship == 0 && ship_count >= 10 && addres_recieved == 0) begin
                    if(msg_in != 0) begin
                        board_guest[mouse_pos[7:4]][mouse_pos[3:0]] <= msg_in;
                    end

                end
                //if ten ctr jest 11 to msg out 01 to rysujemy w na host a L na guest a jak msg_in 01 to na odwrot (rysujemy to tak jak boarda w resecie) 
                else if (hit_counter == 4'b0000) begin 
                    if (msg_out == 2'b01) begin
                         board_host[0] <= {2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01};
                         board_host[1] <= {2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00};
                         board_host[2] <= {2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00};
                         board_host[3] <= {2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00};
                         board_host[4] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00};
                         board_host[5] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00};
                         board_host[6] <= {2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00};
                         board_host[7] <= {2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00};
                         board_host[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                         board_host[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};

                        board_guest[0] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[1] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[2] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[3] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[4] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[5] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[6] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[7] <= {2'b00, 2'b00, 2'b01, 2'b01, 2'b01, 2'b01, 2'b01, 2'b01, 2'b00, 2'b00};
                        board_guest[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_guest[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                    end else if (msg_in == 2'b01) begin
                        board_host[0] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[1] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[2] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[3] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[4] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[5] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[6] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[7] <= {2'b00, 2'b00, 2'b01, 2'b01, 2'b01, 2'b01, 2'b01, 2'b01, 2'b00, 2'b00};
                        board_host[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                        board_host[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};

                       board_guest[0] <= {2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01};
                       board_guest[1] <= {2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00};
                       board_guest[2] <= {2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00};
                       board_guest[3] <= {2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00};
                       board_guest[4] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00};
                       board_guest[5] <= {2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00};
                       board_guest[6] <= {2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00};
                       board_guest[7] <= {2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00};
                       board_guest[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                       board_guest[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b01, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};

                    end    
                end
            end
            else begin
                ship_code_host <= board_host[ship_xy_host/10][ship_xy_host%10];
                ship_code_guest <= board_guest[ship_xy_guest/10][ship_xy_guest%10];
            end

        end
        
            
endmodule
    
    