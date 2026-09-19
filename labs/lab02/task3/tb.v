`timescale 1ns/1ps

module tb;

    reg [1:0] t_a, t_b;
    wire t_gt, t_lt, t_eq;

    reg exp_gt, exp_lt, exp_eq;
    integer errors;
    integer total;

    comp2 uut (
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
    );

    initial begin
        errors = 0;
        total = 0;

        for (integer i = 0; i < 4; i = i + 1) begin
            for (integer j = 0; j < 4; j = j + 1) begin

                t_a = i;
                t_b = j;

                if (i > j) begin
                    exp_gt = 1;
                    exp_lt = 0;
                    exp_eq = 0;
                end
                else if (i < j) begin
                    exp_gt = 0;
                    exp_lt = 1;
                    exp_eq = 0;
                end
                else begin
                    exp_gt = 0;
                    exp_lt = 0;
                    exp_eq = 1;
                end

                #1;

                total = total + 1;

                if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
                    $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                             $time, t_a, t_b, t_gt, t_lt, t_eq,
                             exp_gt, exp_lt, exp_eq);
                    errors = errors + 1;
                end

            end
        end

        $write("RESULT: %0d/%0d tests passed", total - errors, total);

        if (errors == 0)
            $write(" — ALL PASS\n");
        else
            $write(" — %0d FAILED\n", errors);

        $finish;
    end

endmodule