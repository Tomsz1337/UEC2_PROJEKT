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
        output logic board_host [0:8][0:8],
        output logic board_guest [0:8][0:8]
    
    );
    
        always_ff @(posedge clk, posedge rst) begin
            if (rst) begin
                board_host[0] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[1] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[2] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[3] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[4] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[5] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[6] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[7] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_host[8] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

                board_guest[0] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[1] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[2] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[3] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[4] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[5] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[6] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[7] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                board_guest[8] <= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            end
            else begin
                if (start == 2'b01) begin
                    for (logic i = 0; i < 4; i++) begin
                        if (place == 1) begin
                            board_host[mouse_pos[5:3]][mouse_pos[2:0]] <= 1;
                        end
                    end
                end
                else if (start == 2'b10) begin
                    for (logic i = 0; i < 4; i++) begin
                        if (place == 1) begin
                            board_guest[mouse_pos[5:3]][mouse_pos[2:0]] <= 1;
                        end
                    end
                end           
            end
        end
            
endmodule
    
    