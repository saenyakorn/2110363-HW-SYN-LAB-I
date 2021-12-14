module TestDebounce();
reg clk, d;
wire q;

always #2 clk = ~clk;
always #2 d = 1;

Debounce #(.POWER(4)) debounce(.q(q), .d(d), .clk(clk));

initial begin
    $monitor();
    #0
    clk = 0;
    d = 0;
    #500
    $finish;
end

endmodule
