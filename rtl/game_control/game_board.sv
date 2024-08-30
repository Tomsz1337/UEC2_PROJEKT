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
        input logic pick_ship,
        input logic [7:0] mouse_pos,
        input logic [6:0] ship_xy_host,
        input logic [6:0] ship_xy_guest,
        output logic [1:0] ship_code_host,
        output logic [1:0] ship_code_guest 
        
    );
    
    logic [1:0] board_host [0:9][0:9];
    logic [1:0] board_guest [0:9][0:9];
    logic [3:0] ship_count;
        always_ff @(posedge clk, posedge rst) begin
            if (rst) begin
                ship_count <= 4'b0000;
                ship_code_host <= 2'b00;
                ship_code_guest <= 2'b00;

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
            
            else if(pick_ship == 1 && board_host[mouse_pos[7:4]][mouse_pos[3:0]] == 2'b00 && ship_count <= 10) begin
                
                board_host[mouse_pos[7:4]][mouse_pos[3:0]] <= 2'b01;
                ship_count ++;
            end
            
               
            
            else begin
                ship_code_host <= board_host[ship_xy_host/10][ship_xy_host%10];
                ship_code_guest <= board_guest[ship_xy_guest/10][ship_xy_guest%10];
            end

            end
        
            
endmodule
    
    