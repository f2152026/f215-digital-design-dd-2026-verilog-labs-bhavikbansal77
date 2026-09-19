`timescale 1ns/1ps

module tb;

    reg [3:0] a, b;
    reg       op;
    wire [3:0] result;

    reg [3:0] expected;
    integer errors;
    integer total;

    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    initial begin
        errors = 0;
        total = 0;

        a = 4'd7;
        b = 4'd3;

        op = 1'b0;
        #1;

        expected = a + b;
        total = total + 1;

        if (result !== expected) begin
            $display("FAIL: A=%d B=%d OP=ADD got=%d expected=%d",
                     a, b, result, expected);
            errors = errors + 1;
        end

        op = 1'b1;
        #1;

        expected = a - b;
        total = total + 1;

        if (result !== expected) begin
            $display("FAIL: A=%d B=%d OP=SUB got=%d expected=%d",
                     a, b, result, expected);
            errors = errors + 1;
        end

        for (integer i = 0; i < 16; i = i + 1) begin
            for (integer j = 0; j < 16; j = j + 1) begin

                a = i;
                b = j;

                op = 1'b0;
                #1;

                expected = i + j;
                total = total + 1;

                if (result !== expected) begin
                    $display("FAIL: A=%d B=%d OP=ADD got=%d expected=%d",
                             a, b, result, expected);
                    errors = errors + 1;
                end

                op = 1'b1;
                #1;

                expected = i - j;
                total = total + 1;

                if (result !== expected) begin
                    $display("FAIL: A=%d B=%d OP=SUB got=%d expected=%d",
                             a, b, result, expected);
                    errors = errors + 1;
                end

            end
        end

        $write("RESULT: %0d/%0d tests passed",
               total - errors, total);

        if (errors == 0)
            $write(" — ALL PASS\n");
        else
            $write(" — %0d FAILED\n", errors);

        $finish;
    end

endmodule