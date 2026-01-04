module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire [15:0] sum_low, sum_high_0, sum_high_1;
    wire carry_low, carry_high_0, carry_high_1;
    reg [15:0] sum_high;
    
    add16 add_low (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum_low),
        .cout(carry_low)
    );
    
    add16 add_high_0 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .sum(sum_high_0),
        .cout(carry_high_0)
    );
    
    add16 add_high_1 (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .sum(sum_high_1),
        .cout(carry_high_1)
    );
    
    // MUX by case
    always @(*) begin

        case (carry_low)
            1'b0: sum_high = sum_high_0;
            1'b1: sum_high = sum_high_1;
        endcase
    end
    
    assign sum = {sum_high, sum_low};
           
endmodule
