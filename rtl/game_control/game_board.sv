/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company : AGH University of Krakow
// Create Date : 28.07.2024
// Designers Name : Jan Panek & TOmasz Ochmanek
// Module Name : game_board
// Project Name : UEC2_PRJ_STATKI
// Target Devices : BASYS3
// 
// Description :matryca pozycji statków
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module game_board 
    (
        input logic clk,                           // Zegar
        input logic rst,
        input logic [1:0] start,                           // Reset
        input logic place,
        input logic [5:0] mouse_pos,
        input logic [6:0] ship_xy_host,
        input logic [6:0] ship_xy_guest,
        output logic [1:0] ship_code_host,
        output logic [1:0] ship_code_guest,
        output logic [1:0] board_H [0:9][0:9],
        output logic [1:0] board_G [0:9][0:9]
        
    );
    logic [1:0] start_loc;
    logic [1:0] board_host [0:9][0:9];
    logic [1:0] board_guest [0:9][0:9];

        always_ff @(posedge clk, posedge rst) begin
            if (rst) begin
                start_loc <= 2'b00;
                ship_code_host <= 2'b00;
                ship_code_guest <= 2'b00;

                board_host[0] <= {2'b01, 2'b00, 2'b00, 2'b10, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[1] <= {2'b00, 2'b00, 2'b00, 2'b11, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[2] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[3] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[4] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[5] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[6] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[7] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_host[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};

                board_guest[0] <= {2'b10, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[1] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[2] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[3] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[4] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[5] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[6] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[7] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[8] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00};
                board_guest[9] <= {2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b00, 2'b10};

            end 
            else begin
                start_loc <= start;
                if (start == 2'b01) begin
                    for (logic i = 0; i < 4; i++) begin
                        if (place == 1) begin
                            board_host[mouse_pos[5:3]][mouse_pos[2:0]] <= 2'b01;
                        end
                        start_loc <= 2'b10;
                    end
                end
            
            
                else if (start == 2'b00) begin
                    if(board_guest[mouse_pos[5:3]][mouse_pos[2:0]]  == 2'b01 && place == 1)  begin
                        board_guest[mouse_pos[5:3]][mouse_pos[2:0]] <= 2'b10;
                    end
                    else if (board_guest[mouse_pos[5:3]][mouse_pos[2:0]]  == 2'b00 && place == 1) begin
                        board_guest[mouse_pos[5:3]][mouse_pos[2:0]] <= 2'b11;
                    end
                end
            
            else begin
                ship_code_host <= board_host[ship_xy_host/10][ship_xy_host%10];
                ship_code_guest <= board_guest[ship_xy_guest/10][ship_xy_guest%10];
            end

            end
        end
            
endmodule
    
    