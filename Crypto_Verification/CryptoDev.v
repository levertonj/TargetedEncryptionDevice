module CryptoDev (
	input         CLOCK_50,
	input   [3:0] KEY	
);

wire zero;

assign zero = 1'b0;

crypto_test u0 (
   .clk_clk       (CLOCK_50),       //   clk.clk
   .reset_reset_n (KEY[0])  // reset.reset_n
);

endmodule