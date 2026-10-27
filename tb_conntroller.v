`timescale 1ns / 1ps

module tb_controller;

    reg clk;
    reg rst;
    reg [3:0] floor_req;
    reg emergency_stop;

    wire move_up;
    wire move_down;
    wire motor_stop;
    wire [1:0] current_floor;

    reg [1:0] floor_before;

    // DUT instantiation
    controller dut (
        .clk(clk),
        .rst(rst),
        .floor_req(floor_req),
        .emergency_stop(emergency_stop),
        .move_up(move_up),
        .move_down(move_down),
        .motor_stop(motor_stop),
        .current_floor(current_floor)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        floor_req = 4'b0000;
        emergency_stop = 1'b0;

        // Reset
        #20;
        rst = 1'b0;
        @(negedge clk);

        // Test 1: Go to floor 2
        floor_req = 4'b0100;
        wait (current_floor == 2'd2);
        @(negedge clk);
        floor_req = 4'b0000;
        $display("TEST 1: Reached floor %0d", current_floor);

        // Test 2: Go to floor 0
        repeat (2) @(negedge clk);
        floor_req = 4'b0001;
        wait (current_floor == 2'd0);
        @(negedge clk);
        floor_req = 4'b0000;
        $display("TEST 2: Reached floor %0d", current_floor);

        // Test 3: Go to floor 3
        repeat (2) @(negedge clk);
        floor_req = 4'b1000;
        wait (current_floor == 2'd3);
        @(negedge clk);
        floor_req = 4'b0000;
        $display("TEST 3: Reached floor %0d", current_floor);

        // Test 4: Emergency stop while moving down
        repeat (2) @(negedge clk);
        floor_req = 4'b0001;
        wait (move_down == 1'b1);

        @(negedge clk);
        emergency_stop = 1'b1;
        floor_before = current_floor;

        repeat (2) @(posedge clk);
        #1;

        if (current_floor == floor_before &&
            motor_stop == 1'b1 &&
            move_down == 1'b0)
            $display("TEST 4 PASSED: Emergency stop works");
        else
            $display("TEST 4 FAILED");

        @(negedge clk);
        emergency_stop = 1'b0;
        floor_req = 4'b0000;

        repeat (3) @(negedge clk);

        $display("All tests completed.");
        $finish;
    end

    // Timeout protection
    initial begin
        #2000;
        $display("ERROR: Simulation timeout!");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor(
            "Time=%0t rst=%b req=%b emergency=%b floor=%0d state=%b up=%b down=%b stop=%b",
            $time, rst, floor_req, emergency_stop,
            current_floor, dut.current_state,
            move_up, move_down, motor_stop
        );
    end

endmodule

