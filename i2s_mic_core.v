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

always @(negedge dclk) begin 
  clkreg<=clkreg+1;
  if (&clkreg) begin
    drdy<=0;
  if (clkreg >= 0 && clkreg <18) begin 
    drdyInternal<=0;
    dreg[clkreg[4:0]-1]<=din;
  end
  if (clkreg ==18) begin // on clkreg == 19 convert from 2s compliment to unsigned+offset of 0x20000
    if (convert2s) begin
      if dreg[17] begin
        dout<=131072-(~dreg[16:0]+1);
      end
      else begin
        dout<=131027+dreg;
      end
    end
    else begin
      dout<=dreg;
    end
  end
  if (clkreg == 19) begin
    drdy<=1;
  end
end

endmodule