`default_nettype none

module tt_um_koggestone_adder4 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [3:0] A, B;
  wire [3:0] Sum;
  wire Cout;
  
  assign A = ui_in[3:0];
  assign B = ui_in[7:4];
   

  wire [3:0] P, G;
  wire [4:0] C;


  assign P = A ^ B;
  assign G = A & B;

assign C[0] = 0;
assign C[1] = G[0] | (P[0] & C[0]); 
assign C[2] = G[1] | (P[1] & C[1]); 
assign C[3] = G[2] | (P[2] & C[2]); 
assign C[4] = G[3] | (P[3] & C[3]); 

assign Sum[0] = P[0] ^ C[0]; 
assign Sum[1] = P[1] ^ C[1]; 
assign Sum[2] = P[2] ^ C[2]; 
assign Sum[3] = P[3] ^ C[3]; 

assign Cout = C[4];

assign uo_out[3:0] = Sum;
assign uo_out[4] = Cout; 
assign uo_out[7:5] = 3'b000;
assign uio_out = 8'b00000000;
assign uio_oe = 8'b00000000;

endmodule
