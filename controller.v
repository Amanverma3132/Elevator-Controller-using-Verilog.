`timescale 1ns / 1ps

module controller (
    input clk,
    input rst,
    input [3:0] floor_req,
    input emergency_stop,

    output reg move_up,
    output reg move_down,
    output reg motor_stop,
    output reg [1:0] current_floor
);

    parameter idle       = 2'b00;
    parameter move_up_s  = 2'b01;
    parameter move_down_s = 2'b10;
    parameter emergency  = 2'b11;

    reg [1:0] current_state, next_state;
    reg [1:0] target_floor;

    // Target floor selection: floor 0 has highest priority
    always @(*) begin
        target_floor = current_floor;

        if (floor_req[0])
            target_floor = 2'd0;
        else if (floor_req[1])
            target_floor = 2'd1;
        else if (floor_req[2])
            target_floor = 2'd2;
        else if (floor_req[3])
            target_floor = 2'd3;
    end

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= idle;
        else
            current_state <= next_state;
    end

    // Floor tracking: never move beyond target floor
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_floor <= 2'd0;
        else if (emergency_stop)
            current_floor <= current_floor;
        else if (current_state == move_up_s &&
                 current_floor < target_floor)
            current_floor <= current_floor + 1'b1;
        else if (current_state == move_down_s &&
                 current_floor > target_floor)
            current_floor <= current_floor - 1'b1;
    end

    // Next-state logic
    always @(*) begin
        next_state = current_state;

        if (emergency_stop) begin
            next_state = emergency;
        end
        else begin
            case (current_state)
                idle: begin
                    if (target_floor > current_floor)
                        next_state = move_up_s;
                    else if (target_floor < current_floor)
                        next_state = move_down_s;
                    else
                        next_state = idle;
                end

                move_up_s: begin
                    if (current_floor >= target_floor)
                        next_state = idle;
                    else
                        next_state = move_up_s;
                end

                move_down_s: begin
                    if (current_floor <= target_floor)
                        next_state = idle;
                    else
                        next_state = move_down_s;
                end

                emergency: begin
                    next_state = idle;
                end

                default: next_state = idle;
            endcase
        end
    end

    // Output logic
    always @(*) begin
        move_up = 1'b0;
        move_down = 1'b0;
        motor_stop = 1'b1;

        case (current_state)
            move_up_s: begin
                move_up = 1'b1;
                motor_stop = 1'b0;
            end

            move_down_s: begin
                move_down = 1'b1;
                motor_stop = 1'b0;
            end

            default: begin
                move_up = 1'b0;
                move_down = 1'b0;
                motor_stop = 1'b1;
            end
        endcase
    end

endmodule
