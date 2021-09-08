
module gpio_pad
(
input gpio_port_PE,
input gpio_port_IE,
input gpio_port_DS,
input gpio_port_I,
input gpio_port_OEN,
output gpio_port_C,
inout PAD
);
assign gpio_port_C = gpio_port_IE & PAD;
assign PAD = gpio_port_OEN ? 1'bZ : gpio_port_I;
//DS current mode
//PE actives a Pull up register
endmodule
				