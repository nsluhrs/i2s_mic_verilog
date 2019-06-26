module i2sMic(dclk,lrclk,din,odout,odrdy);
input     dclk;
output     lrclk;

input din;
output[17:0] odout;
output odrdy;

parameter convert2s = 1;


reg [5:0] clkreg=0;
reg [17:0] dreg=0 ;
reg [17:0] dout;
reg drdy;
assign odout=dout;
assign odrdy=drdy;
assign lrclk=clkreg[5];


always @(negedge dclk) begin 

  clkreg<=clkreg+1;
  if (&clkreg) begin
    drdy<=0;
  end
  if (clkreg >= 0 && clkreg <18) begin 
    dreg[17-clkreg[4:0]]<=din;
  end
  if (clkreg ==18) begin // on clkreg == 19 convert from 2s compliment to unsigned+offset of 0x20000
    if (convert2s) begin
      dout<=dreg^18'h20000;
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