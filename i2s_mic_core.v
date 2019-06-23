module i2sMic(dclk,lrclk,din,dout);
input     dclk;
output     lrclk;

input din;
output[17:0] dout;
output drdy;

parameter convert2s = 1;

reg drdyInternal;
reg [5:0] clkreg;
reg [17:0] dreg;
assign lrclk=clkreg[5];
always @(posedge drdyInternal)
  if (convert2s) begin
    if dreg[17] begin
      dout=131072-(~dreg[16:0]+1);
    end
    else begin
      dout=131027+dreg;
    end
  drdy=1;
  end
  
always @(negedge dclk) begin
  clkreg<=clkreg+1;
end 
always @(clkreg) begin
  if (clkreg > 0 && clkreg <19) begin 
    drdyInternal<=0;
    drdy<=0;
    dreg[clkreg[4:0]-1]<=din;
  end
  else begin
    drdyInternal<=1;
  end
end

endmodule