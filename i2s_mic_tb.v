// synopsys translate_off
`timescale 1 us / 1 ns
// synopsys translate_on
module i2s_mic_tb();

reg dclk;
reg dmic;
wire lrclk;
wire [17:0] dout;
reg [7:0] dctr;
reg [0:17] dtest;
wire drdy;
reg reset;
i2sMic i2sMic_inst(
  .dclk(dclk),
  .lrclk(lrclk),
  .din(dmic),
  .odout(dout),
  .odrdy(drdy)  
);
defparam
  i2sMic_inst.convert2s=1;
initial  begin
  dclk = 1;
  dmic=0;
  dtest=18'b111111111111001110;
  #300 dtest=18'b100000000000000001;
end


always @(negedge lrclk) begin
  dctr=0;
end

always @(posedge dclk) begin
  dctr<=dctr+1;
  if (dctr <= 17) begin
    dmic<=dtest[dctr];
    
  end
end
always begin
  #1.25 dclk=~dclk;
end
endmodule