module Condor_MI(
  input         clock,
  input         reset,
  input  [31:0] io_in_data,
  input  [31:0] io_in_addr,
  input         io_in_wr,
  input  [1:0]  io_in_wsize,
  input         io_in_valid,
  output [31:0] io_out_data,
  output        io_out_valid,
  output [31:0] io_condor_caddr,
  output        io_condor_cwrite,
  output        io_condor_creq,
  output        io_condor_cvalid,
  output [2:0]  io_condor_csize,
  output [31:0] io_condor_cwdata,
  input  [31:0] io_condor_crdata,
  input         io_condor_cready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] data_w; // @[condorMaster.scala 40:25]
  wire  _T = io_in_valid & io_condor_cready; // @[condorMaster.scala 41:26]
  reg [1:0] state; // @[condorMaster.scala 48:28]
  wire  _T_1 = state == 2'h0; // @[condorMaster.scala 56:20]
  wire  _T_2 = _T_1 & io_condor_cready; // @[condorMaster.scala 56:29]
  wire  _GEN_4 = _T_2 & io_in_valid; // @[condorMaster.scala 56:49]
  wire  _T_4 = state == 2'h2; // @[condorMaster.scala 65:20]
  wire  _T_5 = _T_4 & io_condor_cready; // @[condorMaster.scala 65:30]
  wire  _GEN_6 = io_in_valid | _GEN_4; // @[condorMaster.scala 67:42]
  wire  _GEN_9 = _T_5 ? _GEN_6 : _GEN_4; // @[condorMaster.scala 65:50]
  wire  _T_7 = state == 2'h1; // @[condorMaster.scala 74:20]
  wire  _T_8 = _T_7 & io_condor_cready; // @[condorMaster.scala 74:29]
  wire  _GEN_11 = io_in_valid | _GEN_9; // @[condorMaster.scala 76:42]
  wire  req = _T_8 ? _GEN_11 : _GEN_9; // @[condorMaster.scala 74:49]
  assign io_out_data = io_condor_crdata; // @[condorMaster.scala 96:20]
  assign io_out_valid = _T_8 | _T_5; // @[condorMaster.scala 84:25]
  assign io_condor_caddr = req ? io_in_addr : 32'h0; // @[condorMaster.scala 91:25]
  assign io_condor_cwrite = req & io_in_wr; // @[condorMaster.scala 90:25]
  assign io_condor_creq = _T_8 ? _GEN_11 : _GEN_9; // @[condorMaster.scala 89:23]
  assign io_condor_cvalid = _T_8 ? _GEN_11 : _GEN_9; // @[condorMaster.scala 88:25]
  assign io_condor_csize = {{1'd0}, io_in_wsize}; // @[condorMaster.scala 93:25]
  assign io_condor_cwdata = data_w; // @[condorMaster.scala 92:25]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  data_w = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  state = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T) begin
      data_w <= io_in_data;
    end
    if (reset) begin
      state <= 2'h0;
    end else if (_T_8) begin
      if (io_in_valid) begin
        if (io_in_wr) begin
          state <= 2'h2;
        end else begin
          state <= 2'h1;
        end
      end else begin
        state <= 2'h0;
      end
    end else if (_T_5) begin
      if (io_in_valid) begin
        if (io_in_wr) begin
          state <= 2'h2;
        end else begin
          state <= 2'h1;
        end
      end else begin
        state <= 2'h0;
      end
    end else if (_T_2) begin
      if (io_in_valid) begin
        if (io_in_wr) begin
          state <= 2'h2;
        end else begin
          state <= 2'h1;
        end
      end else begin
        state <= 2'h0;
      end
    end
  end
endmodule
module MemoryManagementUnit(
  input         clock,
  input         reset,
  input         io_IM_abort,
  input  [31:0] io_IM_addr,
  output [31:0] io_IM_data_r,
  output        io_IM_ready,
  input         io_DM_valid,
  input         io_DM_we,
  input  [31:0] io_DM_addr,
  input  [1:0]  io_DM_size,
  input  [31:0] io_DM_data_w,
  output [31:0] io_DM_data_r,
  output        io_DM_ready,
  input         io_dma_pmode,
  input  [31:0] io_dma_addr,
  input  [31:0] io_dma_data,
  input         io_dma_we,
  output        io_progBuffAc_we,
  output [31:0] io_progBuffAc_data_w,
  output [31:0] io_progBuffAc_addr_wr,
  input  [31:0] io_progBuffAc_data_r,
  output [31:0] io_progBuffAc_IF_addr,
  input  [31:0] io_progBuffAc_IF_data_r,
  output [31:0] io_D_condor_caddr,
  output        io_D_condor_cwrite,
  output        io_D_condor_creq,
  output        io_D_condor_cvalid,
  output [2:0]  io_D_condor_csize,
  output [31:0] io_D_condor_cwdata,
  input  [31:0] io_D_condor_crdata,
  input         io_D_condor_cready,
  output [31:0] io_I_condor_caddr,
  output        io_I_condor_cwrite,
  output        io_I_condor_creq,
  output        io_I_condor_cvalid,
  output [2:0]  io_I_condor_csize,
  output [31:0] io_I_condor_cwdata,
  input  [31:0] io_I_condor_crdata,
  input         io_I_condor_cready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire [10:0] DPSRAM_fpga_addr_A; // @[mmu.scala 60:42]
  wire [31:0] DPSRAM_fpga_out_data_A; // @[mmu.scala 60:42]
  wire [31:0] DPSRAM_fpga_data_A; // @[mmu.scala 60:42]
  wire [3:0] DPSRAM_fpga_WE_A; // @[mmu.scala 60:42]
  wire [10:0] DPSRAM_fpga_addr_B; // @[mmu.scala 60:42]
  wire [31:0] DPSRAM_fpga_out_data_B; // @[mmu.scala 60:42]
  wire [31:0] DPSRAM_fpga_data_B; // @[mmu.scala 60:42]
  wire [3:0] DPSRAM_fpga_WE_B; // @[mmu.scala 60:42]
  wire  DPSRAM_fpga_clock; // @[mmu.scala 60:42]
  wire  IF_MI_clock; // @[mmu.scala 72:27]
  wire  IF_MI_reset; // @[mmu.scala 72:27]
  wire [31:0] IF_MI_io_in_data; // @[mmu.scala 72:27]
  wire [31:0] IF_MI_io_in_addr; // @[mmu.scala 72:27]
  wire  IF_MI_io_in_wr; // @[mmu.scala 72:27]
  wire [1:0] IF_MI_io_in_wsize; // @[mmu.scala 72:27]
  wire  IF_MI_io_in_valid; // @[mmu.scala 72:27]
  wire [31:0] IF_MI_io_out_data; // @[mmu.scala 72:27]
  wire  IF_MI_io_out_valid; // @[mmu.scala 72:27]
  wire [31:0] IF_MI_io_condor_caddr; // @[mmu.scala 72:27]
  wire  IF_MI_io_condor_cwrite; // @[mmu.scala 72:27]
  wire  IF_MI_io_condor_creq; // @[mmu.scala 72:27]
  wire  IF_MI_io_condor_cvalid; // @[mmu.scala 72:27]
  wire [2:0] IF_MI_io_condor_csize; // @[mmu.scala 72:27]
  wire [31:0] IF_MI_io_condor_cwdata; // @[mmu.scala 72:27]
  wire [31:0] IF_MI_io_condor_crdata; // @[mmu.scala 72:27]
  wire  IF_MI_io_condor_cready; // @[mmu.scala 72:27]
  wire  MI_clock; // @[mmu.scala 74:24]
  wire  MI_reset; // @[mmu.scala 74:24]
  wire [31:0] MI_io_in_data; // @[mmu.scala 74:24]
  wire [31:0] MI_io_in_addr; // @[mmu.scala 74:24]
  wire  MI_io_in_wr; // @[mmu.scala 74:24]
  wire [1:0] MI_io_in_wsize; // @[mmu.scala 74:24]
  wire  MI_io_in_valid; // @[mmu.scala 74:24]
  wire [31:0] MI_io_out_data; // @[mmu.scala 74:24]
  wire  MI_io_out_valid; // @[mmu.scala 74:24]
  wire [31:0] MI_io_condor_caddr; // @[mmu.scala 74:24]
  wire  MI_io_condor_cwrite; // @[mmu.scala 74:24]
  wire  MI_io_condor_creq; // @[mmu.scala 74:24]
  wire  MI_io_condor_cvalid; // @[mmu.scala 74:24]
  wire [2:0] MI_io_condor_csize; // @[mmu.scala 74:24]
  wire [31:0] MI_io_condor_cwdata; // @[mmu.scala 74:24]
  wire [31:0] MI_io_condor_crdata; // @[mmu.scala 74:24]
  wire  MI_io_condor_cready; // @[mmu.scala 74:24]
  wire [31:0] _T_1 = io_IM_addr & 32'hffffffe0; // @[mmu.scala 81:27]
  wire  IFInPB = _T_1 == 32'h2000; // @[mmu.scala 81:56]
  wire [31:0] _T_3 = io_IM_addr & 32'hffffe000; // @[mmu.scala 82:27]
  wire  IFinSP = _T_3 == 32'h0; // @[mmu.scala 82:56]
  wire  _T_4 = ~IFinSP; // @[mmu.scala 83:15]
  wire  _T_5 = ~IFInPB; // @[mmu.scala 83:25]
  wire  IfInBus = _T_4 & _T_5; // @[mmu.scala 83:23]
  wire [31:0] _T_9 = io_dma_pmode ? io_dma_addr : {{23'd0}, io_IM_addr[10:2]}; // @[mmu.scala 87:60]
  wire  _T_12 = ~reset; // @[mmu.scala 95:51]
  reg [1:0] state; // @[mmu.scala 102:26]
  wire  _T_14 = state == 2'h0; // @[mmu.scala 104:19]
  wire  _T_15 = state == 2'h1; // @[mmu.scala 108:25]
  wire  _T_16 = IfInBus & IF_MI_io_out_valid; // @[mmu.scala 110:30]
  wire  _T_17 = IfInBus & io_IM_abort; // @[mmu.scala 112:37]
  wire  _T_18 = ~IfInBus; // @[mmu.scala 114:28]
  wire  _T_19 = _T_18 & IF_MI_io_out_valid; // @[mmu.scala 114:37]
  wire  _T_20 = state == 2'h2; // @[mmu.scala 120:25]
  wire [31:0] Memory_io_out_data_A = DPSRAM_fpga_out_data_A; // @[mmu.scala 54:31 mmu.scala 61:34]
  wire [31:0] _T_22 = IfInBus ? IF_MI_io_out_data : Memory_io_out_data_A; // @[mmu.scala 128:69]
  wire [31:0] instruction = IFInPB ? io_progBuffAc_IF_data_r : _T_22; // @[mmu.scala 128:30]
  wire  _T_24 = _T_15 & IF_MI_io_out_valid; // @[mmu.scala 130:53]
  wire  _T_25 = IFInPB | IFinSP; // @[mmu.scala 130:93]
  reg  _T_26; // @[mmu.scala 130:84]
  wire  _T_29 = io_dma_pmode & io_dma_we; // @[mmu.scala 134:27]
  wire [31:0] _T_34 = io_DM_addr & 32'hffffffe0; // @[mmu.scala 153:36]
  wire  MEMInPB = _T_34 == 32'h2000; // @[mmu.scala 153:65]
  wire [31:0] _T_36 = io_DM_addr & 32'hffffe000; // @[mmu.scala 154:36]
  wire  MEMInSP = _T_36 == 32'h0; // @[mmu.scala 154:65]
  wire  _T_37 = ~MEMInSP; // @[mmu.scala 155:24]
  wire  _T_38 = ~MEMInPB; // @[mmu.scala 155:35]
  wire  MEMInBus = _T_37 & _T_38; // @[mmu.scala 155:33]
  wire  _T_39 = ~io_DM_ready; // @[mmu.scala 158:48]
  wire  _T_40 = io_DM_valid & _T_39; // @[mmu.scala 158:46]
  reg  late_valid; // @[mmu.scala 158:33]
  wire  _T_41 = ~late_valid; // @[mmu.scala 159:22]
  wire  newtran = _T_41 & io_DM_valid; // @[mmu.scala 159:34]
  wire  _T_42 = MEMInPB | MEMInSP; // @[mmu.scala 160:50]
  wire  _T_43 = _T_42 & newtran; // @[mmu.scala 160:60]
  wire  endtran = MI_io_out_valid | _T_43; // @[mmu.scala 160:38]
  reg  waitR; // @[mmu.scala 162:28]
  wire  _T_44 = ~endtran; // @[mmu.scala 163:24]
  wire  _T_45 = newtran & _T_44; // @[mmu.scala 163:22]
  wire  _GEN_9 = endtran ? 1'h0 : waitR; // @[mmu.scala 165:28]
  wire  _GEN_10 = _T_45 | _GEN_9; // @[mmu.scala 163:33]
  wire  _T_46 = io_DM_size == 2'h1; // @[mmu.scala 171:24]
  wire  _T_47 = _T_46 & io_DM_we; // @[mmu.scala 171:31]
  wire [3:0] _T_49 = 4'h1 << io_DM_addr[1:0]; // @[mmu.scala 172:33]
  wire  _T_50 = io_DM_size == 2'h2; // @[mmu.scala 174:29]
  wire  _T_51 = _T_50 & io_DM_we; // @[mmu.scala 174:35]
  wire [2:0] _T_53 = 3'h3 << io_DM_addr[1]; // @[mmu.scala 175:33]
  wire  _T_54 = io_DM_size == 2'h3; // @[mmu.scala 177:29]
  wire  _T_55 = _T_54 & io_DM_we; // @[mmu.scala 177:36]
  wire [3:0] _GEN_11 = _T_55 ? 4'hf : 4'h0; // @[mmu.scala 177:47]
  wire [3:0] _GEN_12 = _T_51 ? {{1'd0}, _T_53} : _GEN_11; // @[mmu.scala 174:46]
  wire [3:0] wen_mask = _T_47 ? _T_49 : _GEN_12; // @[mmu.scala 171:42]
  wire  _T_56 = MEMInPB & newtran; // @[mmu.scala 183:22]
  wire  _T_57 = MEMInSP & newtran; // @[mmu.scala 187:30]
  wire  _T_59 = waitR & _T_44; // @[mmu.scala 191:51]
  wire  _T_60 = newtran | _T_59; // @[mmu.scala 191:42]
  wire  _T_61 = MEMInBus & _T_60; // @[mmu.scala 191:30]
  wire [3:0] _GEN_16 = _T_57 ? wen_mask : 4'h0; // @[mmu.scala 187:41]
  wire  _GEN_17 = _T_57 ? 1'h0 : _T_61; // @[mmu.scala 187:41]
  reg  _T_62; // @[mmu.scala 205:36]
  wire [31:0] Memory_io_out_data_B = DPSRAM_fpga_out_data_B; // @[mmu.scala 54:31 mmu.scala 61:34]
  wire [31:0] _T_63 = MI_io_out_valid ? MI_io_out_data : Memory_io_out_data_B; // @[mmu.scala 205:82]
  wire [3:0] _GEN_28 = {{2'd0}, io_DM_addr[1:0]}; // @[mmu.scala 212:67]
  wire [5:0] _T_68 = _GEN_28 * 4'h8; // @[mmu.scala 212:67]
  wire [70:0] _GEN_29 = {{63'd0}, io_DM_data_w[7:0]}; // @[mmu.scala 212:49]
  wire [70:0] _T_69 = _GEN_29 << _T_68; // @[mmu.scala 212:49]
  wire [4:0] _GEN_30 = {{4'd0}, io_DM_addr[1]}; // @[mmu.scala 215:65]
  wire [5:0] _T_73 = _GEN_30 * 5'h10; // @[mmu.scala 215:65]
  wire [78:0] _GEN_31 = {{63'd0}, io_DM_data_w[15:0]}; // @[mmu.scala 215:49]
  wire [78:0] _T_74 = _GEN_31 << _T_73; // @[mmu.scala 215:49]
  wire [31:0] _GEN_22 = _T_54 ? io_DM_data_w : 32'h0; // @[mmu.scala 217:36]
  wire [78:0] _GEN_23 = _T_50 ? _T_74 : {{47'd0}, _GEN_22}; // @[mmu.scala 214:36]
  wire [78:0] _GEN_24 = _T_46 ? {{8'd0}, _T_69} : _GEN_23; // @[mmu.scala 211:31]
  wire [1:0] _GEN_26 = _T_50 ? 2'h1 : 2'h2; // @[mmu.scala 226:36]
  DPSRAM_fpga #(.memory("boot.mem"), .nbits(32), .length(8192)) DPSRAM_fpga ( // @[mmu.scala 60:42]
    .addr_A(DPSRAM_fpga_addr_A),
    .out_data_A(DPSRAM_fpga_out_data_A),
    .data_A(DPSRAM_fpga_data_A),
    .WE_A(DPSRAM_fpga_WE_A),
    .addr_B(DPSRAM_fpga_addr_B),
    .out_data_B(DPSRAM_fpga_out_data_B),
    .data_B(DPSRAM_fpga_data_B),
    .WE_B(DPSRAM_fpga_WE_B),
    .clock(DPSRAM_fpga_clock)
  );
  Condor_MI IF_MI ( // @[mmu.scala 72:27]
    .clock(IF_MI_clock),
    .reset(IF_MI_reset),
    .io_in_data(IF_MI_io_in_data),
    .io_in_addr(IF_MI_io_in_addr),
    .io_in_wr(IF_MI_io_in_wr),
    .io_in_wsize(IF_MI_io_in_wsize),
    .io_in_valid(IF_MI_io_in_valid),
    .io_out_data(IF_MI_io_out_data),
    .io_out_valid(IF_MI_io_out_valid),
    .io_condor_caddr(IF_MI_io_condor_caddr),
    .io_condor_cwrite(IF_MI_io_condor_cwrite),
    .io_condor_creq(IF_MI_io_condor_creq),
    .io_condor_cvalid(IF_MI_io_condor_cvalid),
    .io_condor_csize(IF_MI_io_condor_csize),
    .io_condor_cwdata(IF_MI_io_condor_cwdata),
    .io_condor_crdata(IF_MI_io_condor_crdata),
    .io_condor_cready(IF_MI_io_condor_cready)
  );
  Condor_MI MI ( // @[mmu.scala 74:24]
    .clock(MI_clock),
    .reset(MI_reset),
    .io_in_data(MI_io_in_data),
    .io_in_addr(MI_io_in_addr),
    .io_in_wr(MI_io_in_wr),
    .io_in_wsize(MI_io_in_wsize),
    .io_in_valid(MI_io_in_valid),
    .io_out_data(MI_io_out_data),
    .io_out_valid(MI_io_out_valid),
    .io_condor_caddr(MI_io_condor_caddr),
    .io_condor_cwrite(MI_io_condor_cwrite),
    .io_condor_creq(MI_io_condor_creq),
    .io_condor_cvalid(MI_io_condor_cvalid),
    .io_condor_csize(MI_io_condor_csize),
    .io_condor_cwdata(MI_io_condor_cwdata),
    .io_condor_crdata(MI_io_condor_crdata),
    .io_condor_cready(MI_io_condor_cready)
  );
  assign io_IM_data_r = io_dma_pmode ? 32'h13 : instruction; // @[mmu.scala 132:33]
  assign io_IM_ready = _T_24 | _T_26; // @[mmu.scala 130:33]
  assign io_DM_data_r = _T_62 ? io_progBuffAc_data_r : _T_63; // @[mmu.scala 205:21]
  assign io_DM_ready = MI_io_out_valid | _T_43; // @[mmu.scala 203:33]
  assign io_progBuffAc_we = _T_56 & io_DM_we; // @[mmu.scala 186:33 mmu.scala 190:33 mmu.scala 194:33 mmu.scala 198:33]
  assign io_progBuffAc_data_w = _GEN_24[31:0]; // @[mmu.scala 238:29]
  assign io_progBuffAc_addr_wr = {{2'd0}, io_DM_addr[31:2]}; // @[mmu.scala 148:33]
  assign io_progBuffAc_IF_addr = {{2'd0}, io_IM_addr[31:2]}; // @[mmu.scala 88:31]
  assign io_D_condor_caddr = MI_io_condor_caddr; // @[mmu.scala 75:21]
  assign io_D_condor_cwrite = MI_io_condor_cwrite; // @[mmu.scala 75:21]
  assign io_D_condor_creq = MI_io_condor_creq; // @[mmu.scala 75:21]
  assign io_D_condor_cvalid = MI_io_condor_cvalid; // @[mmu.scala 75:21]
  assign io_D_condor_csize = MI_io_condor_csize; // @[mmu.scala 75:21]
  assign io_D_condor_cwdata = MI_io_condor_cwdata; // @[mmu.scala 75:21]
  assign io_I_condor_caddr = IF_MI_io_condor_caddr; // @[mmu.scala 73:20]
  assign io_I_condor_cwrite = IF_MI_io_condor_cwrite; // @[mmu.scala 73:20]
  assign io_I_condor_creq = IF_MI_io_condor_creq; // @[mmu.scala 73:20]
  assign io_I_condor_cvalid = IF_MI_io_condor_cvalid; // @[mmu.scala 73:20]
  assign io_I_condor_csize = IF_MI_io_condor_csize; // @[mmu.scala 73:20]
  assign io_I_condor_cwdata = IF_MI_io_condor_cwdata; // @[mmu.scala 73:20]
  assign DPSRAM_fpga_addr_A = _T_9[10:0]; // @[mmu.scala 61:34]
  assign DPSRAM_fpga_data_A = io_dma_data; // @[mmu.scala 61:34]
  assign DPSRAM_fpga_WE_A = _T_29 ? 4'hf : 4'h0; // @[mmu.scala 61:34]
  assign DPSRAM_fpga_addr_B = {{2'd0}, io_DM_addr[10:2]}; // @[mmu.scala 61:34]
  assign DPSRAM_fpga_data_B = _GEN_24[31:0]; // @[mmu.scala 61:34]
  assign DPSRAM_fpga_WE_B = _T_56 ? 4'h0 : _GEN_16; // @[mmu.scala 61:34]
  assign DPSRAM_fpga_clock = clock; // @[mmu.scala 61:34]
  assign IF_MI_clock = clock;
  assign IF_MI_reset = reset;
  assign IF_MI_io_in_data = 32'h0; // @[mmu.scala 97:33]
  assign IF_MI_io_in_addr = io_IM_addr; // @[mmu.scala 89:49]
  assign IF_MI_io_in_wr = 1'h0; // @[mmu.scala 96:33]
  assign IF_MI_io_in_wsize = 2'h2; // @[mmu.scala 98:33]
  assign IF_MI_io_in_valid = IfInBus & _T_12; // @[mmu.scala 95:33]
  assign IF_MI_io_condor_crdata = io_I_condor_crdata; // @[mmu.scala 73:20]
  assign IF_MI_io_condor_cready = io_I_condor_cready; // @[mmu.scala 73:20]
  assign MI_clock = clock;
  assign MI_reset = reset;
  assign MI_io_in_data = _GEN_24[31:0]; // @[mmu.scala 240:23]
  assign MI_io_in_addr = io_DM_addr; // @[mmu.scala 149:49]
  assign MI_io_in_wr = io_DM_we; // @[mmu.scala 236:23]
  assign MI_io_in_wsize = _T_46 ? 2'h0 : _GEN_26; // @[mmu.scala 224:31 mmu.scala 227:31 mmu.scala 230:31 mmu.scala 233:31]
  assign MI_io_in_valid = _T_56 ? 1'h0 : _GEN_17; // @[mmu.scala 185:33 mmu.scala 189:33 mmu.scala 193:41 mmu.scala 197:33]
  assign MI_io_condor_crdata = io_D_condor_crdata; // @[mmu.scala 75:21]
  assign MI_io_condor_cready = io_D_condor_cready; // @[mmu.scala 75:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  _T_26 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  late_valid = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  waitR = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  _T_62 = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;
    end else if (_T_14) begin
      if (IfInBus) begin
        state <= 2'h1;
      end
    end else if (_T_15) begin
      if (_T_16) begin
        state <= 2'h1;
      end else if (_T_17) begin
        state <= 2'h2;
      end else if (_T_19) begin
        state <= 2'h0;
      end else begin
        state <= 2'h1;
      end
    end else if (_T_20) begin
      if (_T_16) begin
        state <= 2'h1;
      end
    end else begin
      state <= 2'h0;
    end
    if (reset) begin
      _T_26 <= 1'h0;
    end else begin
      _T_26 <= _T_25;
    end
    if (reset) begin
      late_valid <= 1'h0;
    end else begin
      late_valid <= _T_40;
    end
    if (reset) begin
      waitR <= 1'h0;
    end else begin
      waitR <= _GEN_10;
    end
    if (reset) begin
      _T_62 <= 1'h0;
    end else begin
      _T_62 <= MEMInPB;
    end
  end
endmodule
module FU(
  input        clock,
  input        reset,
  input        io_reg_write_mem,
  input        io_reg_write_wb,
  input  [4:0] io_rs1_ex,
  input  [4:0] io_rs2_ex,
  input  [4:0] io_rd_mem,
  input  [4:0] io_rd_wb,
  input  [5:0] io_ID_cmd,
  output [1:0] io_mux1_ctr_ex,
  output [1:0] io_mux2_ctr_ex
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] EX_cmd; // @[Reg.scala 27:20]
  wire  _T = io_rd_mem != 5'h0; // @[ForwardingUnit.scala 48:47]
  wire  _T_1 = io_reg_write_mem & _T; // @[ForwardingUnit.scala 48:34]
  wire  _T_2 = io_rd_mem == io_rs1_ex; // @[ForwardingUnit.scala 48:69]
  wire  ex1 = _T_1 & _T_2; // @[ForwardingUnit.scala 48:56]
  wire  _T_6 = io_rd_mem == io_rs2_ex; // @[ForwardingUnit.scala 49:69]
  wire  ex2 = _T_1 & _T_6; // @[ForwardingUnit.scala 49:56]
  wire  _T_8 = io_rd_wb != 5'h0; // @[ForwardingUnit.scala 53:45]
  wire  _T_9 = io_reg_write_wb & _T_8; // @[ForwardingUnit.scala 53:33]
  wire  _T_10 = ~ex1; // @[ForwardingUnit.scala 53:56]
  wire  _T_11 = _T_9 & _T_10; // @[ForwardingUnit.scala 53:54]
  wire  _T_12 = io_rd_wb == io_rs1_ex; // @[ForwardingUnit.scala 53:73]
  wire  mem1 = _T_11 & _T_12; // @[ForwardingUnit.scala 53:61]
  wire  _T_16 = ~ex2; // @[ForwardingUnit.scala 54:56]
  wire  _T_17 = _T_9 & _T_16; // @[ForwardingUnit.scala 54:54]
  wire  _T_18 = io_rd_wb == io_rs2_ex; // @[ForwardingUnit.scala 54:73]
  wire  mem2 = _T_17 & _T_18; // @[ForwardingUnit.scala 54:61]
  wire  _T_20 = EX_cmd != 6'h2; // @[ForwardingUnit.scala 58:29]
  wire  _T_21 = ex1 & _T_20; // @[ForwardingUnit.scala 58:19]
  wire  _T_23 = mem1 & _T_20; // @[ForwardingUnit.scala 60:26]
  wire [1:0] _GEN_1 = _T_23 ? 2'h2 : 2'h1; // @[ForwardingUnit.scala 60:50]
  wire  _T_24 = EX_cmd != 6'h3; // @[ForwardingUnit.scala 66:29]
  wire  _T_25 = ex2 & _T_24; // @[ForwardingUnit.scala 66:19]
  wire  _T_26 = EX_cmd != 6'hd; // @[ForwardingUnit.scala 66:51]
  wire  _T_27 = _T_25 & _T_26; // @[ForwardingUnit.scala 66:41]
  wire  _T_29 = mem2 & _T_24; // @[ForwardingUnit.scala 68:26]
  wire  _T_31 = _T_29 & _T_26; // @[ForwardingUnit.scala 68:48]
  wire [1:0] _GEN_3 = _T_31 ? 2'h2 : 2'h1; // @[ForwardingUnit.scala 68:71]
  assign io_mux1_ctr_ex = _T_21 ? 2'h3 : _GEN_1; // @[ForwardingUnit.scala 59:32 ForwardingUnit.scala 61:32 ForwardingUnit.scala 63:32]
  assign io_mux2_ctr_ex = _T_27 ? 2'h3 : _GEN_3; // @[ForwardingUnit.scala 67:32 ForwardingUnit.scala 69:32 ForwardingUnit.scala 71:32]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  EX_cmd = _RAND_0[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      EX_cmd <= 6'h0;
    end else begin
      EX_cmd <= io_ID_cmd;
    end
  end
endmodule
module HDU(
  input  [2:0] io_dm_read_ex,
  input  [4:0] io_rs1_id,
  input  [4:0] io_rs2_id,
  input  [4:0] io_rd_ex,
  input  [4:0] io_rd_mem,
  input        io_is_jalr,
  output       io_mux3_ctr_id,
  output       io_flop_ctr_if
);
  wire  _T = io_dm_read_ex != 3'h0; // @[HazardDetectionUnit.scala 37:35]
  wire  _T_1 = io_rd_ex == io_rs1_id; // @[HazardDetectionUnit.scala 37:57]
  wire  _T_2 = io_rd_ex == io_rs2_id; // @[HazardDetectionUnit.scala 37:84]
  wire  _T_3 = _T_1 | _T_2; // @[HazardDetectionUnit.scala 37:72]
  wire  mem_hazard = _T & _T_3; // @[HazardDetectionUnit.scala 37:44]
  wire  _T_6 = io_rd_mem == io_rs1_id; // @[HazardDetectionUnit.scala 38:72]
  wire  _T_7 = _T_1 | _T_6; // @[HazardDetectionUnit.scala 38:59]
  wire  jalr_hazard = io_is_jalr & _T_7; // @[HazardDetectionUnit.scala 38:31]
  wire  _T_9 = mem_hazard | jalr_hazard; // @[HazardDetectionUnit.scala 42:27]
  assign io_mux3_ctr_id = mem_hazard | jalr_hazard; // @[HazardDetectionUnit.scala 45:32 HazardDetectionUnit.scala 50:32]
  assign io_flop_ctr_if = _T_9 ? 1'h0 : 1'h1; // @[HazardDetectionUnit.scala 44:32 HazardDetectionUnit.scala 49:32]
endmodule
module BPU(
  input   clock,
  input   reset,
  input   io_preevent,
  input   io_answer,
  output  io_fail,
  output  io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  event_; // @[BPU.scala 27:34]
  reg  guess; // @[BPU.scala 28:28]
  wire  _T = ~io_out; // @[BPU.scala 31:28]
  wire  _T_1 = guess ^ io_answer; // @[BPU.scala 32:36]
  reg [1:0] state; // @[BPU.scala 37:22]
  wire  _T_3 = state == 2'h0; // @[BPU.scala 40:20]
  wire  _T_4 = state == 2'h1; // @[BPU.scala 47:26]
  wire  _T_5 = state == 2'h2; // @[BPU.scala 54:26]
  wire  _T_6 = state == 2'h3; // @[BPU.scala 61:26]
  wire  _GEN_10 = _T_5 | _T_6; // @[BPU.scala 54:36]
  wire  _GEN_12 = _T_4 ? 1'h0 : _GEN_10; // @[BPU.scala 47:36]
  assign io_fail = event_ & _T_1; // @[BPU.scala 32:17]
  assign io_out = _T_3 ? 1'h0 : _GEN_12; // @[BPU.scala 39:16 BPU.scala 41:24 BPU.scala 48:24 BPU.scala 55:24 BPU.scala 62:24]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  event_ = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  guess = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      event_ <= 1'h0;
    end else begin
      event_ <= io_preevent;
    end
    if (reset) begin
      guess <= 1'h0;
    end else begin
      guess <= _T;
    end
    if (reset) begin
      state <= 2'h1;
    end else if (_T_3) begin
      if (event_) begin
        if (io_fail) begin
          state <= 2'h1;
        end else begin
          state <= 2'h0;
        end
      end
    end else if (_T_4) begin
      if (event_) begin
        if (io_fail) begin
          state <= 2'h2;
        end else begin
          state <= 2'h0;
        end
      end
    end else if (_T_5) begin
      if (event_) begin
        if (io_fail) begin
          state <= 2'h1;
        end else begin
          state <= 2'h3;
        end
      end
    end else if (_T_6) begin
      if (event_) begin
        if (io_fail) begin
          state <= 2'h2;
        end else begin
          state <= 2'h3;
        end
      end
    end
  end
endmodule
module Control_decode(
  input  [5:0] io_cmd,
  input        io_stopp,
  input        io_ifNoStall,
  input        io_BPU_out,
  output       io_preevent,
  output       io_jump,
  output       io_preaccess,
  output       io_jalr,
  output       io_out_IF_mux1,
  output [1:0] io_out_ID_mux1,
  output       io_out_ID_mux2,
  output       io_out_ID_mux4,
  output       io_out_ID_mux5,
  output       io_out_EX_mux3,
  output [4:0] io_out_EX_ALU,
  output [2:0] io_out_MEM_DM_read,
  output [1:0] io_out_MEM_DM_write,
  output [1:0] io_out_WB_mux1,
  output       io_out_WB_reg_write
);
  wire  _T = 6'he == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_1 = ~io_stopp; // @[Control_decode.scala 100:76]
  wire  _T_2 = 6'hf == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_4 = 6'h10 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_6 = 6'h11 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_8 = 6'h12 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_10 = 6'ha == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_12 = 6'hb == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_14 = 6'hc == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_16 = 6'h26 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_17 = 6'h19 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_18 = 6'h2e == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_19 = 6'h1a == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_20 = 6'h30 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_21 = 6'h1b == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_22 = 6'h23 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_23 = 6'h13 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_24 = 6'h25 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_25 = 6'h1 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_26 = 6'h2 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_27 = 6'h2c == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_28 = 6'h16 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_29 = 6'h31 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_30 = 6'h17 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_31 = 6'h33 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_32 = 6'h18 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_33 = 6'h28 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_34 = 6'h14 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_35 = 6'h2a == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_36 = 6'h15 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_37 = 6'h4 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_38 = 6'h5 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_39 = 6'h6 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_41 = 6'h7 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_43 = 6'h8 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_45 = 6'h9 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_47 = 6'h3 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_48 = 6'hd == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_49 = 6'h24 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_51 = 6'h27 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_53 = 6'h29 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_55 = 6'h2b == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_57 = 6'h2d == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_59 = 6'h2f == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_61 = 6'h32 == io_cmd; // @[Conditional.scala 37:30]
  wire  _T_63 = 6'h34 == io_cmd; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_2 = _T_63 ? 2'h2 : 2'h0; // @[Conditional.scala 39:67]
  wire  _GEN_4 = _T_61 | _T_63; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_6 = _T_61 ? 2'h2 : _GEN_2; // @[Conditional.scala 39:67]
  wire  _GEN_8 = _T_59 | _GEN_4; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_10 = _T_59 ? 2'h2 : _GEN_6; // @[Conditional.scala 39:67]
  wire  _GEN_12 = _T_57 | _GEN_8; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_14 = _T_57 ? 2'h2 : _GEN_10; // @[Conditional.scala 39:67]
  wire  _GEN_16 = _T_55 | _GEN_12; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_18 = _T_55 ? 2'h2 : _GEN_14; // @[Conditional.scala 39:67]
  wire  _GEN_20 = _T_53 | _GEN_16; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_22 = _T_53 ? 2'h2 : _GEN_18; // @[Conditional.scala 39:67]
  wire  _GEN_24 = _T_51 | _GEN_20; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_26 = _T_51 ? 2'h2 : _GEN_22; // @[Conditional.scala 39:67]
  wire  _GEN_28 = _T_49 | _GEN_24; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_30 = _T_49 ? 2'h2 : _GEN_26; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_48 ? 1'h0 : 1'h1; // @[Conditional.scala 39:67]
  wire  _GEN_34 = _T_48 | _GEN_28; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_36 = _T_48 ? 2'h0 : _GEN_30; // @[Conditional.scala 39:67]
  wire  _GEN_37 = _T_48 & io_ifNoStall; // @[Conditional.scala 39:67]
  wire  _GEN_41 = _T_47 ? 1'h0 : _GEN_32; // @[Conditional.scala 39:67]
  wire  _GEN_42 = _T_47 ? 1'h0 : _T_48; // @[Conditional.scala 39:67]
  wire  _GEN_43 = _T_47 | _GEN_34; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_45 = _T_47 ? 2'h0 : _GEN_36; // @[Conditional.scala 39:67]
  wire  _GEN_46 = _T_47 | _GEN_37; // @[Conditional.scala 39:67]
  wire  _GEN_50 = _T_45 ? io_BPU_out : _GEN_41; // @[Conditional.scala 39:67]
  wire  _GEN_51 = _T_45 ? 1'h0 : _GEN_42; // @[Conditional.scala 39:67]
  wire  _GEN_52 = _T_45 | _GEN_41; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_45 | _GEN_43; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_54 = _T_45 ? 4'hd : 4'hf; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_56 = _T_45 ? 2'h0 : _GEN_45; // @[Conditional.scala 39:67]
  wire  _GEN_57 = _T_45 ? 1'h0 : _GEN_43; // @[Conditional.scala 39:67]
  wire  _GEN_58 = _T_45 & _T_1; // @[Conditional.scala 39:67]
  wire  _GEN_59 = _T_45 ? 1'h0 : _GEN_46; // @[Conditional.scala 39:67]
  wire  _GEN_63 = _T_43 ? io_BPU_out : _GEN_50; // @[Conditional.scala 39:67]
  wire  _GEN_64 = _T_43 ? 1'h0 : _GEN_51; // @[Conditional.scala 39:67]
  wire  _GEN_65 = _T_43 | _GEN_52; // @[Conditional.scala 39:67]
  wire  _GEN_66 = _T_43 | _GEN_53; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_67 = _T_43 ? 4'h9 : _GEN_54; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_69 = _T_43 ? 2'h0 : _GEN_56; // @[Conditional.scala 39:67]
  wire  _GEN_70 = _T_43 ? 1'h0 : _GEN_57; // @[Conditional.scala 39:67]
  wire  _GEN_71 = _T_43 ? _T_1 : _GEN_58; // @[Conditional.scala 39:67]
  wire  _GEN_72 = _T_43 ? 1'h0 : _GEN_59; // @[Conditional.scala 39:67]
  wire  _GEN_76 = _T_41 ? io_BPU_out : _GEN_63; // @[Conditional.scala 39:67]
  wire  _GEN_77 = _T_41 ? 1'h0 : _GEN_64; // @[Conditional.scala 39:67]
  wire  _GEN_78 = _T_41 | _GEN_65; // @[Conditional.scala 39:67]
  wire  _GEN_79 = _T_41 | _GEN_66; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_80 = _T_41 ? 4'hc : _GEN_67; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_82 = _T_41 ? 2'h0 : _GEN_69; // @[Conditional.scala 39:67]
  wire  _GEN_83 = _T_41 ? 1'h0 : _GEN_70; // @[Conditional.scala 39:67]
  wire  _GEN_84 = _T_41 ? _T_1 : _GEN_71; // @[Conditional.scala 39:67]
  wire  _GEN_85 = _T_41 ? 1'h0 : _GEN_72; // @[Conditional.scala 39:67]
  wire  _GEN_89 = _T_39 ? io_BPU_out : _GEN_76; // @[Conditional.scala 39:67]
  wire  _GEN_90 = _T_39 ? 1'h0 : _GEN_77; // @[Conditional.scala 39:67]
  wire  _GEN_91 = _T_39 | _GEN_78; // @[Conditional.scala 39:67]
  wire  _GEN_92 = _T_39 | _GEN_79; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_93 = _T_39 ? 4'h8 : _GEN_80; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_95 = _T_39 ? 2'h0 : _GEN_82; // @[Conditional.scala 39:67]
  wire  _GEN_96 = _T_39 ? 1'h0 : _GEN_83; // @[Conditional.scala 39:67]
  wire  _GEN_97 = _T_39 ? _T_1 : _GEN_84; // @[Conditional.scala 39:67]
  wire  _GEN_98 = _T_39 ? 1'h0 : _GEN_85; // @[Conditional.scala 39:67]
  wire  _GEN_102 = _T_38 ? io_BPU_out : _GEN_89; // @[Conditional.scala 39:67]
  wire  _GEN_103 = _T_38 ? 1'h0 : _GEN_90; // @[Conditional.scala 39:67]
  wire  _GEN_104 = _T_38 | _GEN_91; // @[Conditional.scala 39:67]
  wire  _GEN_105 = _T_38 | _GEN_92; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_106 = _T_38 ? 4'hb : _GEN_93; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_108 = _T_38 ? 2'h0 : _GEN_95; // @[Conditional.scala 39:67]
  wire  _GEN_109 = _T_38 ? 1'h0 : _GEN_96; // @[Conditional.scala 39:67]
  wire  _GEN_110 = _T_38 ? io_ifNoStall : _GEN_97; // @[Conditional.scala 39:67]
  wire  _GEN_111 = _T_38 ? 1'h0 : _GEN_98; // @[Conditional.scala 39:67]
  wire  _GEN_115 = _T_37 ? io_BPU_out : _GEN_102; // @[Conditional.scala 39:67]
  wire  _GEN_116 = _T_37 ? 1'h0 : _GEN_103; // @[Conditional.scala 39:67]
  wire  _GEN_117 = _T_37 | _GEN_104; // @[Conditional.scala 39:67]
  wire  _GEN_118 = _T_37 | _GEN_105; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_119 = _T_37 ? 4'ha : _GEN_106; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_121 = _T_37 ? 2'h0 : _GEN_108; // @[Conditional.scala 39:67]
  wire  _GEN_122 = _T_37 ? 1'h0 : _GEN_109; // @[Conditional.scala 39:67]
  wire  _GEN_123 = _T_37 ? io_ifNoStall : _GEN_110; // @[Conditional.scala 39:67]
  wire  _GEN_124 = _T_37 ? 1'h0 : _GEN_111; // @[Conditional.scala 39:67]
  wire  _GEN_128 = _T_36 ? 1'h0 : _GEN_118; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_129 = _T_36 ? 4'h9 : _GEN_119; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_131 = _T_36 ? 2'h0 : _GEN_121; // @[Conditional.scala 39:67]
  wire  _GEN_132 = _T_36 | _GEN_122; // @[Conditional.scala 39:67]
  wire  _GEN_133 = _T_36 | _GEN_115; // @[Conditional.scala 39:67]
  wire  _GEN_134 = _T_36 ? 1'h0 : _GEN_116; // @[Conditional.scala 39:67]
  wire  _GEN_135 = _T_36 | _GEN_117; // @[Conditional.scala 39:67]
  wire  _GEN_136 = _T_36 ? 1'h0 : _GEN_123; // @[Conditional.scala 39:67]
  wire  _GEN_137 = _T_36 ? 1'h0 : _GEN_124; // @[Conditional.scala 39:67]
  wire  _GEN_141 = _T_35 | _GEN_128; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_142 = _T_35 ? 4'h9 : _GEN_129; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_144 = _T_35 ? 2'h0 : _GEN_131; // @[Conditional.scala 39:67]
  wire  _GEN_145 = _T_35 | _GEN_132; // @[Conditional.scala 39:67]
  wire  _GEN_146 = _T_35 | _GEN_133; // @[Conditional.scala 39:67]
  wire  _GEN_147 = _T_35 ? 1'h0 : _GEN_134; // @[Conditional.scala 39:67]
  wire  _GEN_148 = _T_35 | _GEN_135; // @[Conditional.scala 39:67]
  wire  _GEN_149 = _T_35 ? 1'h0 : _GEN_136; // @[Conditional.scala 39:67]
  wire  _GEN_150 = _T_35 ? 1'h0 : _GEN_137; // @[Conditional.scala 39:67]
  wire  _GEN_154 = _T_34 ? 1'h0 : _GEN_141; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_155 = _T_34 ? 4'h8 : _GEN_142; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_157 = _T_34 ? 2'h0 : _GEN_144; // @[Conditional.scala 39:67]
  wire  _GEN_158 = _T_34 | _GEN_145; // @[Conditional.scala 39:67]
  wire  _GEN_159 = _T_34 | _GEN_146; // @[Conditional.scala 39:67]
  wire  _GEN_160 = _T_34 ? 1'h0 : _GEN_147; // @[Conditional.scala 39:67]
  wire  _GEN_161 = _T_34 | _GEN_148; // @[Conditional.scala 39:67]
  wire  _GEN_162 = _T_34 ? 1'h0 : _GEN_149; // @[Conditional.scala 39:67]
  wire  _GEN_163 = _T_34 ? 1'h0 : _GEN_150; // @[Conditional.scala 39:67]
  wire  _GEN_167 = _T_33 | _GEN_154; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_168 = _T_33 ? 4'h8 : _GEN_155; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_170 = _T_33 ? 2'h0 : _GEN_157; // @[Conditional.scala 39:67]
  wire  _GEN_171 = _T_33 | _GEN_158; // @[Conditional.scala 39:67]
  wire  _GEN_172 = _T_33 | _GEN_159; // @[Conditional.scala 39:67]
  wire  _GEN_173 = _T_33 ? 1'h0 : _GEN_160; // @[Conditional.scala 39:67]
  wire  _GEN_174 = _T_33 | _GEN_161; // @[Conditional.scala 39:67]
  wire  _GEN_175 = _T_33 ? 1'h0 : _GEN_162; // @[Conditional.scala 39:67]
  wire  _GEN_176 = _T_33 ? 1'h0 : _GEN_163; // @[Conditional.scala 39:67]
  wire  _GEN_180 = _T_32 ? 1'h0 : _GEN_167; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_181 = _T_32 ? 4'h7 : _GEN_168; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_183 = _T_32 ? 2'h0 : _GEN_170; // @[Conditional.scala 39:67]
  wire  _GEN_184 = _T_32 | _GEN_171; // @[Conditional.scala 39:67]
  wire  _GEN_185 = _T_32 | _GEN_172; // @[Conditional.scala 39:67]
  wire  _GEN_186 = _T_32 ? 1'h0 : _GEN_173; // @[Conditional.scala 39:67]
  wire  _GEN_187 = _T_32 | _GEN_174; // @[Conditional.scala 39:67]
  wire  _GEN_188 = _T_32 ? 1'h0 : _GEN_175; // @[Conditional.scala 39:67]
  wire  _GEN_189 = _T_32 ? 1'h0 : _GEN_176; // @[Conditional.scala 39:67]
  wire  _GEN_193 = _T_31 | _GEN_180; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_194 = _T_31 ? 4'h7 : _GEN_181; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_196 = _T_31 ? 2'h0 : _GEN_183; // @[Conditional.scala 39:67]
  wire  _GEN_197 = _T_31 | _GEN_184; // @[Conditional.scala 39:67]
  wire  _GEN_198 = _T_31 | _GEN_185; // @[Conditional.scala 39:67]
  wire  _GEN_199 = _T_31 ? 1'h0 : _GEN_186; // @[Conditional.scala 39:67]
  wire  _GEN_200 = _T_31 | _GEN_187; // @[Conditional.scala 39:67]
  wire  _GEN_201 = _T_31 ? 1'h0 : _GEN_188; // @[Conditional.scala 39:67]
  wire  _GEN_202 = _T_31 ? 1'h0 : _GEN_189; // @[Conditional.scala 39:67]
  wire  _GEN_206 = _T_30 ? 1'h0 : _GEN_193; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_207 = _T_30 ? 4'h6 : _GEN_194; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_209 = _T_30 ? 2'h0 : _GEN_196; // @[Conditional.scala 39:67]
  wire  _GEN_210 = _T_30 | _GEN_197; // @[Conditional.scala 39:67]
  wire  _GEN_211 = _T_30 | _GEN_198; // @[Conditional.scala 39:67]
  wire  _GEN_212 = _T_30 ? 1'h0 : _GEN_199; // @[Conditional.scala 39:67]
  wire  _GEN_213 = _T_30 | _GEN_200; // @[Conditional.scala 39:67]
  wire  _GEN_214 = _T_30 ? 1'h0 : _GEN_201; // @[Conditional.scala 39:67]
  wire  _GEN_215 = _T_30 ? 1'h0 : _GEN_202; // @[Conditional.scala 39:67]
  wire  _GEN_219 = _T_29 | _GEN_206; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_220 = _T_29 ? 4'h6 : _GEN_207; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_222 = _T_29 ? 2'h0 : _GEN_209; // @[Conditional.scala 39:67]
  wire  _GEN_223 = _T_29 | _GEN_210; // @[Conditional.scala 39:67]
  wire  _GEN_224 = _T_29 | _GEN_211; // @[Conditional.scala 39:67]
  wire  _GEN_225 = _T_29 ? 1'h0 : _GEN_212; // @[Conditional.scala 39:67]
  wire  _GEN_226 = _T_29 | _GEN_213; // @[Conditional.scala 39:67]
  wire  _GEN_227 = _T_29 ? 1'h0 : _GEN_214; // @[Conditional.scala 39:67]
  wire  _GEN_228 = _T_29 ? 1'h0 : _GEN_215; // @[Conditional.scala 39:67]
  wire  _GEN_232 = _T_28 ? 1'h0 : _GEN_219; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_233 = _T_28 ? 4'h5 : _GEN_220; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_235 = _T_28 ? 2'h0 : _GEN_222; // @[Conditional.scala 39:67]
  wire  _GEN_236 = _T_28 | _GEN_223; // @[Conditional.scala 39:67]
  wire  _GEN_237 = _T_28 | _GEN_224; // @[Conditional.scala 39:67]
  wire  _GEN_238 = _T_28 ? 1'h0 : _GEN_225; // @[Conditional.scala 39:67]
  wire  _GEN_239 = _T_28 | _GEN_226; // @[Conditional.scala 39:67]
  wire  _GEN_240 = _T_28 ? 1'h0 : _GEN_227; // @[Conditional.scala 39:67]
  wire  _GEN_241 = _T_28 ? 1'h0 : _GEN_228; // @[Conditional.scala 39:67]
  wire  _GEN_245 = _T_27 | _GEN_232; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_246 = _T_27 ? 4'h5 : _GEN_233; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_248 = _T_27 ? 2'h0 : _GEN_235; // @[Conditional.scala 39:67]
  wire  _GEN_249 = _T_27 | _GEN_236; // @[Conditional.scala 39:67]
  wire  _GEN_250 = _T_27 | _GEN_237; // @[Conditional.scala 39:67]
  wire  _GEN_251 = _T_27 ? 1'h0 : _GEN_238; // @[Conditional.scala 39:67]
  wire  _GEN_252 = _T_27 | _GEN_239; // @[Conditional.scala 39:67]
  wire  _GEN_253 = _T_27 ? 1'h0 : _GEN_240; // @[Conditional.scala 39:67]
  wire  _GEN_254 = _T_27 ? 1'h0 : _GEN_241; // @[Conditional.scala 39:67]
  wire  _GEN_258 = _T_26 ? 1'h0 : _GEN_251; // @[Conditional.scala 39:67]
  wire  _GEN_259 = _T_26 ? 1'h0 : _GEN_252; // @[Conditional.scala 39:67]
  wire  _GEN_260 = _T_26 ? 1'h0 : _GEN_245; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_261 = _T_26 ? 4'he : _GEN_246; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_263 = _T_26 ? 2'h0 : _GEN_248; // @[Conditional.scala 39:67]
  wire  _GEN_264 = _T_26 | _GEN_249; // @[Conditional.scala 39:67]
  wire  _GEN_265 = _T_26 | _GEN_250; // @[Conditional.scala 39:67]
  wire  _GEN_266 = _T_26 | _GEN_252; // @[Conditional.scala 39:67]
  wire  _GEN_267 = _T_26 ? 1'h0 : _GEN_253; // @[Conditional.scala 39:67]
  wire  _GEN_268 = _T_26 ? 1'h0 : _GEN_254; // @[Conditional.scala 39:67]
  wire  _GEN_272 = _T_25 ? 1'h0 : _GEN_260; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_273 = _T_25 ? 4'hf : _GEN_261; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_275 = _T_25 ? 2'h0 : _GEN_263; // @[Conditional.scala 39:67]
  wire  _GEN_276 = _T_25 | _GEN_264; // @[Conditional.scala 39:67]
  wire  _GEN_277 = _T_25 ? 1'h0 : _GEN_258; // @[Conditional.scala 39:67]
  wire  _GEN_278 = _T_25 | _GEN_259; // @[Conditional.scala 39:67]
  wire  _GEN_279 = _T_25 | _GEN_265; // @[Conditional.scala 39:67]
  wire  _GEN_280 = _T_25 | _GEN_266; // @[Conditional.scala 39:67]
  wire  _GEN_281 = _T_25 ? 1'h0 : _GEN_267; // @[Conditional.scala 39:67]
  wire  _GEN_282 = _T_25 ? 1'h0 : _GEN_268; // @[Conditional.scala 39:67]
  wire  _GEN_286 = _T_24 | _GEN_272; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_287 = _T_24 ? 4'h4 : _GEN_273; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_289 = _T_24 ? 2'h0 : _GEN_275; // @[Conditional.scala 39:67]
  wire  _GEN_290 = _T_24 | _GEN_276; // @[Conditional.scala 39:67]
  wire  _GEN_291 = _T_24 ? 1'h0 : _GEN_277; // @[Conditional.scala 39:67]
  wire  _GEN_292 = _T_24 | _GEN_278; // @[Conditional.scala 39:67]
  wire  _GEN_293 = _T_24 | _GEN_279; // @[Conditional.scala 39:67]
  wire  _GEN_294 = _T_24 | _GEN_280; // @[Conditional.scala 39:67]
  wire  _GEN_295 = _T_24 ? 1'h0 : _GEN_281; // @[Conditional.scala 39:67]
  wire  _GEN_296 = _T_24 ? 1'h0 : _GEN_282; // @[Conditional.scala 39:67]
  wire  _GEN_300 = _T_23 ? 1'h0 : _GEN_286; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_301 = _T_23 ? 4'h3 : _GEN_287; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_303 = _T_23 ? 2'h0 : _GEN_289; // @[Conditional.scala 39:67]
  wire  _GEN_304 = _T_23 | _GEN_290; // @[Conditional.scala 39:67]
  wire  _GEN_305 = _T_23 ? 1'h0 : _GEN_291; // @[Conditional.scala 39:67]
  wire  _GEN_306 = _T_23 | _GEN_292; // @[Conditional.scala 39:67]
  wire  _GEN_307 = _T_23 | _GEN_293; // @[Conditional.scala 39:67]
  wire  _GEN_308 = _T_23 | _GEN_294; // @[Conditional.scala 39:67]
  wire  _GEN_309 = _T_23 ? 1'h0 : _GEN_295; // @[Conditional.scala 39:67]
  wire  _GEN_310 = _T_23 ? 1'h0 : _GEN_296; // @[Conditional.scala 39:67]
  wire  _GEN_314 = _T_22 | _GEN_300; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_315 = _T_22 ? 4'h3 : _GEN_301; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_317 = _T_22 ? 2'h0 : _GEN_303; // @[Conditional.scala 39:67]
  wire  _GEN_318 = _T_22 | _GEN_304; // @[Conditional.scala 39:67]
  wire  _GEN_319 = _T_22 ? 1'h0 : _GEN_305; // @[Conditional.scala 39:67]
  wire  _GEN_320 = _T_22 | _GEN_306; // @[Conditional.scala 39:67]
  wire  _GEN_321 = _T_22 | _GEN_307; // @[Conditional.scala 39:67]
  wire  _GEN_322 = _T_22 | _GEN_308; // @[Conditional.scala 39:67]
  wire  _GEN_323 = _T_22 ? 1'h0 : _GEN_309; // @[Conditional.scala 39:67]
  wire  _GEN_324 = _T_22 ? 1'h0 : _GEN_310; // @[Conditional.scala 39:67]
  wire  _GEN_328 = _T_21 ? 1'h0 : _GEN_314; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_329 = _T_21 ? 4'h2 : _GEN_315; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_331 = _T_21 ? 2'h0 : _GEN_317; // @[Conditional.scala 39:67]
  wire  _GEN_332 = _T_21 | _GEN_318; // @[Conditional.scala 39:67]
  wire  _GEN_333 = _T_21 ? 1'h0 : _GEN_319; // @[Conditional.scala 39:67]
  wire  _GEN_334 = _T_21 | _GEN_320; // @[Conditional.scala 39:67]
  wire  _GEN_335 = _T_21 | _GEN_321; // @[Conditional.scala 39:67]
  wire  _GEN_336 = _T_21 | _GEN_322; // @[Conditional.scala 39:67]
  wire  _GEN_337 = _T_21 ? 1'h0 : _GEN_323; // @[Conditional.scala 39:67]
  wire  _GEN_338 = _T_21 ? 1'h0 : _GEN_324; // @[Conditional.scala 39:67]
  wire  _GEN_342 = _T_20 | _GEN_328; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_343 = _T_20 ? 4'h2 : _GEN_329; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_345 = _T_20 ? 2'h0 : _GEN_331; // @[Conditional.scala 39:67]
  wire  _GEN_346 = _T_20 | _GEN_332; // @[Conditional.scala 39:67]
  wire  _GEN_347 = _T_20 ? 1'h0 : _GEN_333; // @[Conditional.scala 39:67]
  wire  _GEN_348 = _T_20 | _GEN_334; // @[Conditional.scala 39:67]
  wire  _GEN_349 = _T_20 | _GEN_335; // @[Conditional.scala 39:67]
  wire  _GEN_350 = _T_20 | _GEN_336; // @[Conditional.scala 39:67]
  wire  _GEN_351 = _T_20 ? 1'h0 : _GEN_337; // @[Conditional.scala 39:67]
  wire  _GEN_352 = _T_20 ? 1'h0 : _GEN_338; // @[Conditional.scala 39:67]
  wire  _GEN_356 = _T_19 ? 1'h0 : _GEN_342; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_357 = _T_19 ? 4'h1 : _GEN_343; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_359 = _T_19 ? 2'h0 : _GEN_345; // @[Conditional.scala 39:67]
  wire  _GEN_360 = _T_19 | _GEN_346; // @[Conditional.scala 39:67]
  wire  _GEN_361 = _T_19 ? 1'h0 : _GEN_347; // @[Conditional.scala 39:67]
  wire  _GEN_362 = _T_19 | _GEN_348; // @[Conditional.scala 39:67]
  wire  _GEN_363 = _T_19 | _GEN_349; // @[Conditional.scala 39:67]
  wire  _GEN_364 = _T_19 | _GEN_350; // @[Conditional.scala 39:67]
  wire  _GEN_365 = _T_19 ? 1'h0 : _GEN_351; // @[Conditional.scala 39:67]
  wire  _GEN_366 = _T_19 ? 1'h0 : _GEN_352; // @[Conditional.scala 39:67]
  wire  _GEN_370 = _T_18 | _GEN_356; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_371 = _T_18 ? 4'h1 : _GEN_357; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_373 = _T_18 ? 2'h0 : _GEN_359; // @[Conditional.scala 39:67]
  wire  _GEN_374 = _T_18 | _GEN_360; // @[Conditional.scala 39:67]
  wire  _GEN_375 = _T_18 ? 1'h0 : _GEN_361; // @[Conditional.scala 39:67]
  wire  _GEN_376 = _T_18 | _GEN_362; // @[Conditional.scala 39:67]
  wire  _GEN_377 = _T_18 | _GEN_363; // @[Conditional.scala 39:67]
  wire  _GEN_378 = _T_18 | _GEN_364; // @[Conditional.scala 39:67]
  wire  _GEN_379 = _T_18 ? 1'h0 : _GEN_365; // @[Conditional.scala 39:67]
  wire  _GEN_380 = _T_18 ? 1'h0 : _GEN_366; // @[Conditional.scala 39:67]
  wire  _GEN_384 = _T_17 ? 1'h0 : _GEN_370; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_385 = _T_17 ? 4'h0 : _GEN_371; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_387 = _T_17 ? 2'h0 : _GEN_373; // @[Conditional.scala 39:67]
  wire  _GEN_388 = _T_17 | _GEN_374; // @[Conditional.scala 39:67]
  wire  _GEN_389 = _T_17 ? 1'h0 : _GEN_375; // @[Conditional.scala 39:67]
  wire  _GEN_390 = _T_17 | _GEN_376; // @[Conditional.scala 39:67]
  wire  _GEN_391 = _T_17 | _GEN_377; // @[Conditional.scala 39:67]
  wire  _GEN_392 = _T_17 | _GEN_378; // @[Conditional.scala 39:67]
  wire  _GEN_393 = _T_17 ? 1'h0 : _GEN_379; // @[Conditional.scala 39:67]
  wire  _GEN_394 = _T_17 ? 1'h0 : _GEN_380; // @[Conditional.scala 39:67]
  wire  _GEN_398 = _T_16 | _GEN_384; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_399 = _T_16 ? 4'h0 : _GEN_385; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_401 = _T_16 ? 2'h0 : _GEN_387; // @[Conditional.scala 39:67]
  wire  _GEN_402 = _T_16 | _GEN_388; // @[Conditional.scala 39:67]
  wire  _GEN_403 = _T_16 ? 1'h0 : _GEN_389; // @[Conditional.scala 39:67]
  wire  _GEN_404 = _T_16 | _GEN_390; // @[Conditional.scala 39:67]
  wire  _GEN_405 = _T_16 | _GEN_391; // @[Conditional.scala 39:67]
  wire  _GEN_406 = _T_16 | _GEN_392; // @[Conditional.scala 39:67]
  wire  _GEN_407 = _T_16 ? 1'h0 : _GEN_393; // @[Conditional.scala 39:67]
  wire  _GEN_408 = _T_16 ? 1'h0 : _GEN_394; // @[Conditional.scala 39:67]
  wire  _GEN_412 = _T_14 ? 1'h0 : _GEN_398; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_413 = _T_14 ? 4'h3 : _GEN_399; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_414 = _T_14 ? 2'h3 : 2'h0; // @[Conditional.scala 39:67]
  wire  _GEN_416 = _T_14 ? 1'h0 : _GEN_402; // @[Conditional.scala 39:67]
  wire  _GEN_417 = _T_14 & _T_1; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_418 = _T_14 ? 2'h0 : _GEN_401; // @[Conditional.scala 39:67]
  wire  _GEN_419 = _T_14 ? 1'h0 : _GEN_403; // @[Conditional.scala 39:67]
  wire  _GEN_420 = _T_14 | _GEN_404; // @[Conditional.scala 39:67]
  wire  _GEN_421 = _T_14 | _GEN_405; // @[Conditional.scala 39:67]
  wire  _GEN_422 = _T_14 | _GEN_406; // @[Conditional.scala 39:67]
  wire  _GEN_423 = _T_14 ? 1'h0 : _GEN_407; // @[Conditional.scala 39:67]
  wire  _GEN_424 = _T_14 ? 1'h0 : _GEN_408; // @[Conditional.scala 39:67]
  wire  _GEN_428 = _T_12 ? 1'h0 : _GEN_412; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_429 = _T_12 ? 4'h3 : _GEN_413; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_430 = _T_12 ? 2'h2 : _GEN_414; // @[Conditional.scala 39:67]
  wire  _GEN_432 = _T_12 ? 1'h0 : _GEN_416; // @[Conditional.scala 39:67]
  wire  _GEN_433 = _T_12 ? _T_1 : _GEN_417; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_434 = _T_12 ? 2'h0 : _GEN_418; // @[Conditional.scala 39:67]
  wire  _GEN_435 = _T_12 ? 1'h0 : _GEN_419; // @[Conditional.scala 39:67]
  wire  _GEN_436 = _T_12 | _GEN_420; // @[Conditional.scala 39:67]
  wire  _GEN_437 = _T_12 | _GEN_421; // @[Conditional.scala 39:67]
  wire  _GEN_438 = _T_12 | _GEN_422; // @[Conditional.scala 39:67]
  wire  _GEN_439 = _T_12 ? 1'h0 : _GEN_423; // @[Conditional.scala 39:67]
  wire  _GEN_440 = _T_12 ? 1'h0 : _GEN_424; // @[Conditional.scala 39:67]
  wire  _GEN_444 = _T_10 ? 1'h0 : _GEN_428; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_445 = _T_10 ? 4'h3 : _GEN_429; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_446 = _T_10 ? 2'h1 : _GEN_430; // @[Conditional.scala 39:67]
  wire  _GEN_448 = _T_10 ? 1'h0 : _GEN_432; // @[Conditional.scala 39:67]
  wire  _GEN_449 = _T_10 ? _T_1 : _GEN_433; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_450 = _T_10 ? 2'h0 : _GEN_434; // @[Conditional.scala 39:67]
  wire  _GEN_451 = _T_10 ? 1'h0 : _GEN_435; // @[Conditional.scala 39:67]
  wire  _GEN_452 = _T_10 | _GEN_436; // @[Conditional.scala 39:67]
  wire  _GEN_453 = _T_10 | _GEN_437; // @[Conditional.scala 39:67]
  wire  _GEN_454 = _T_10 | _GEN_438; // @[Conditional.scala 39:67]
  wire  _GEN_455 = _T_10 ? 1'h0 : _GEN_439; // @[Conditional.scala 39:67]
  wire  _GEN_456 = _T_10 ? 1'h0 : _GEN_440; // @[Conditional.scala 39:67]
  wire  _GEN_460 = _T_8 ? 1'h0 : _GEN_444; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_461 = _T_8 ? 4'h3 : _GEN_445; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_462 = _T_8 ? 2'h0 : _GEN_446; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_463 = _T_8 ? 3'h5 : 3'h0; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_464 = _T_8 ? 2'h1 : _GEN_450; // @[Conditional.scala 39:67]
  wire  _GEN_465 = _T_8 | _GEN_448; // @[Conditional.scala 39:67]
  wire  _GEN_466 = _T_8 ? _T_1 : _GEN_449; // @[Conditional.scala 39:67]
  wire  _GEN_467 = _T_8 ? 1'h0 : _GEN_451; // @[Conditional.scala 39:67]
  wire  _GEN_468 = _T_8 | _GEN_452; // @[Conditional.scala 39:67]
  wire  _GEN_469 = _T_8 | _GEN_453; // @[Conditional.scala 39:67]
  wire  _GEN_470 = _T_8 | _GEN_454; // @[Conditional.scala 39:67]
  wire  _GEN_471 = _T_8 ? 1'h0 : _GEN_455; // @[Conditional.scala 39:67]
  wire  _GEN_472 = _T_8 ? 1'h0 : _GEN_456; // @[Conditional.scala 39:67]
  wire  _GEN_476 = _T_6 ? 1'h0 : _GEN_460; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_477 = _T_6 ? 4'h3 : _GEN_461; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_478 = _T_6 ? 2'h0 : _GEN_462; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_479 = _T_6 ? 3'h4 : _GEN_463; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_480 = _T_6 ? 2'h1 : _GEN_464; // @[Conditional.scala 39:67]
  wire  _GEN_481 = _T_6 | _GEN_465; // @[Conditional.scala 39:67]
  wire  _GEN_482 = _T_6 ? _T_1 : _GEN_466; // @[Conditional.scala 39:67]
  wire  _GEN_483 = _T_6 ? 1'h0 : _GEN_467; // @[Conditional.scala 39:67]
  wire  _GEN_484 = _T_6 | _GEN_468; // @[Conditional.scala 39:67]
  wire  _GEN_485 = _T_6 | _GEN_469; // @[Conditional.scala 39:67]
  wire  _GEN_486 = _T_6 | _GEN_470; // @[Conditional.scala 39:67]
  wire  _GEN_487 = _T_6 ? 1'h0 : _GEN_471; // @[Conditional.scala 39:67]
  wire  _GEN_488 = _T_6 ? 1'h0 : _GEN_472; // @[Conditional.scala 39:67]
  wire  _GEN_492 = _T_4 ? 1'h0 : _GEN_476; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_493 = _T_4 ? 4'h3 : _GEN_477; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_494 = _T_4 ? 2'h0 : _GEN_478; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_495 = _T_4 ? 3'h3 : _GEN_479; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_496 = _T_4 ? 2'h1 : _GEN_480; // @[Conditional.scala 39:67]
  wire  _GEN_497 = _T_4 | _GEN_481; // @[Conditional.scala 39:67]
  wire  _GEN_498 = _T_4 ? _T_1 : _GEN_482; // @[Conditional.scala 39:67]
  wire  _GEN_499 = _T_4 ? 1'h0 : _GEN_483; // @[Conditional.scala 39:67]
  wire  _GEN_500 = _T_4 | _GEN_484; // @[Conditional.scala 39:67]
  wire  _GEN_501 = _T_4 | _GEN_485; // @[Conditional.scala 39:67]
  wire  _GEN_502 = _T_4 | _GEN_486; // @[Conditional.scala 39:67]
  wire  _GEN_503 = _T_4 ? 1'h0 : _GEN_487; // @[Conditional.scala 39:67]
  wire  _GEN_504 = _T_4 ? 1'h0 : _GEN_488; // @[Conditional.scala 39:67]
  wire  _GEN_508 = _T_2 ? 1'h0 : _GEN_492; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_509 = _T_2 ? 4'h3 : _GEN_493; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_510 = _T_2 ? 2'h0 : _GEN_494; // @[Conditional.scala 39:67]
  wire [2:0] _GEN_511 = _T_2 ? 3'h2 : _GEN_495; // @[Conditional.scala 39:67]
  wire [1:0] _GEN_512 = _T_2 ? 2'h1 : _GEN_496; // @[Conditional.scala 39:67]
  wire  _GEN_513 = _T_2 | _GEN_497; // @[Conditional.scala 39:67]
  wire  _GEN_514 = _T_2 ? _T_1 : _GEN_498; // @[Conditional.scala 39:67]
  wire  _GEN_515 = _T_2 ? 1'h0 : _GEN_499; // @[Conditional.scala 39:67]
  wire  _GEN_516 = _T_2 | _GEN_500; // @[Conditional.scala 39:67]
  wire  _GEN_517 = _T_2 | _GEN_501; // @[Conditional.scala 39:67]
  wire  _GEN_518 = _T_2 | _GEN_502; // @[Conditional.scala 39:67]
  wire  _GEN_519 = _T_2 ? 1'h0 : _GEN_503; // @[Conditional.scala 39:67]
  wire  _GEN_520 = _T_2 ? 1'h0 : _GEN_504; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_525 = _T ? 4'h3 : _GEN_509; // @[Conditional.scala 40:58]
  wire  control_ID_mux2 = _T ? 1'h0 : _GEN_515; // @[Conditional.scala 40:58]
  assign io_preevent = _T ? 1'h0 : _GEN_519; // @[Control_decode.scala 82:33 Control_decode.scala 457:45 Control_decode.scala 477:45 Control_decode.scala 497:45 Control_decode.scala 517:45 Control_decode.scala 537:45 Control_decode.scala 557:45]
  assign io_jump = _T ? 1'h0 : _GEN_520; // @[Control_decode.scala 83:49 Control_decode.scala 577:41 Control_decode.scala 594:41]
  assign io_preaccess = _T ? _T_1 : _GEN_514; // @[Control_decode.scala 85:33 Control_decode.scala 100:73 Control_decode.scala 113:49 Control_decode.scala 126:49 Control_decode.scala 139:49 Control_decode.scala 152:49 Control_decode.scala 166:49 Control_decode.scala 178:49 Control_decode.scala 190:49]
  assign io_jalr = _T ? 1'h0 : _GEN_515; // @[Control_decode.scala 86:49 Control_decode.scala 595:41]
  assign io_out_IF_mux1 = _T | _GEN_517; // @[Control_decode.scala 60:15]
  assign io_out_ID_mux1 = {{1'd0}, control_ID_mux2}; // @[Control_decode.scala 60:15]
  assign io_out_ID_mux2 = _T ? 1'h0 : _GEN_515; // @[Control_decode.scala 60:15]
  assign io_out_ID_mux4 = _T | _GEN_516; // @[Control_decode.scala 60:15]
  assign io_out_ID_mux5 = _T | _GEN_518; // @[Control_decode.scala 60:15]
  assign io_out_EX_mux3 = _T ? 1'h0 : _GEN_508; // @[Control_decode.scala 60:15]
  assign io_out_EX_ALU = {{1'd0}, _GEN_525}; // @[Control_decode.scala 60:15]
  assign io_out_MEM_DM_read = _T ? 3'h1 : _GEN_511; // @[Control_decode.scala 60:15]
  assign io_out_MEM_DM_write = _T ? 2'h0 : _GEN_510; // @[Control_decode.scala 60:15]
  assign io_out_WB_mux1 = _T ? 2'h1 : _GEN_512; // @[Control_decode.scala 60:15]
  assign io_out_WB_reg_write = _T | _GEN_513; // @[Control_decode.scala 60:15]
endmodule
module stall_unit(
  input   clock,
  input   reset,
  input   io_preaccess,
  input   io_HDU_wait,
  input   io_MEM_done,
  output  io_BUS_trans,
  output  io_IF_ID_stall,
  output  io_MEM_WB_stall,
  output  io_EX_MEM_stall,
  output  io_nWait
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  late_memwait; // @[stall_unit.scala 43:42]
  reg  later_memwait; // @[stall_unit.scala 44:36]
  reg  memstop; // @[stall_unit.scala 45:50]
  reg  access; // @[stall_unit.scala 46:58]
  wire  _T_2 = ~memstop; // @[stall_unit.scala 54:22]
  wire  _T_6 = ~io_MEM_done; // @[stall_unit.scala 62:46]
  wire  _T_7 = memstop & _T_6; // @[stall_unit.scala 62:44]
  wire  memwait = io_BUS_trans | _T_7; // @[stall_unit.scala 62:33]
  wire  _T_21 = late_memwait & later_memwait; // @[stall_unit.scala 86:42]
  assign io_BUS_trans = access; // @[stall_unit.scala 52:25]
  assign io_IF_ID_stall = io_HDU_wait | memwait; // @[stall_unit.scala 85:25]
  assign io_MEM_WB_stall = _T_21 & _T_6; // @[stall_unit.scala 86:25]
  assign io_EX_MEM_stall = memwait & late_memwait; // @[stall_unit.scala 64:24]
  assign io_nWait = ~memwait; // @[stall_unit.scala 90:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  late_memwait = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  later_memwait = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  memstop = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  access = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      late_memwait <= 1'h0;
    end else begin
      late_memwait <= memwait;
    end
    if (reset) begin
      later_memwait <= 1'h0;
    end else begin
      later_memwait <= late_memwait;
    end
    if (reset) begin
      memstop <= 1'h0;
    end else if (_T_2) begin
      memstop <= io_BUS_trans;
    end else if (memstop) begin
      if (io_MEM_done) begin
        memstop <= 1'h0;
      end else begin
        memstop <= 1'h1;
      end
    end
    if (reset) begin
      access <= 1'h0;
    end else begin
      access <= io_preaccess;
    end
  end
endmodule
module Control(
  input        clock,
  input        reset,
  output       io_IF_mux1_select,
  output [1:0] io_IF_mux2_select,
  output       io_IF_en,
  output       io_ID_wen,
  input  [5:0] io_ID_cmd,
  input  [4:0] io_ID_rs1,
  input  [4:0] io_ID_rs2,
  output [1:0] io_ID_mux1_select,
  output       io_ID_mux2_select,
  output       io_ID_mux4_select,
  output       io_ID_mux5_select,
  output [4:0] io_EX_alu_sel,
  output [1:0] io_EX_mux1_select,
  output [1:0] io_EX_mux2_select,
  output       io_EX_mux3_select,
  input  [4:0] io_EX_rd_addr,
  input  [4:0] io_EX_r1_addr,
  input  [4:0] io_EX_r2_addr,
  input        io_EX_alu_ans,
  output [1:0] io_MEM_write,
  output [2:0] io_MEM_read,
  input  [4:0] io_MEM_rd_addr,
  input        io_MEM_done,
  output [1:0] io_WB_mux1_select,
  input  [4:0] io_WB_rd_addr,
  output       io_PIPE_IF_flush,
  output       io_PIPE_IF_en,
  output       io_PIPE_MEM_WB_stall,
  output       io_PIPE_EX_MEM_stall
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire  FU_clock; // @[Control.scala 66:33]
  wire  FU_reset; // @[Control.scala 66:33]
  wire  FU_io_reg_write_mem; // @[Control.scala 66:33]
  wire  FU_io_reg_write_wb; // @[Control.scala 66:33]
  wire [4:0] FU_io_rs1_ex; // @[Control.scala 66:33]
  wire [4:0] FU_io_rs2_ex; // @[Control.scala 66:33]
  wire [4:0] FU_io_rd_mem; // @[Control.scala 66:33]
  wire [4:0] FU_io_rd_wb; // @[Control.scala 66:33]
  wire [5:0] FU_io_ID_cmd; // @[Control.scala 66:33]
  wire [1:0] FU_io_mux1_ctr_ex; // @[Control.scala 66:33]
  wire [1:0] FU_io_mux2_ctr_ex; // @[Control.scala 66:33]
  wire [2:0] HDU_io_dm_read_ex; // @[Control.scala 67:33]
  wire [4:0] HDU_io_rs1_id; // @[Control.scala 67:33]
  wire [4:0] HDU_io_rs2_id; // @[Control.scala 67:33]
  wire [4:0] HDU_io_rd_ex; // @[Control.scala 67:33]
  wire [4:0] HDU_io_rd_mem; // @[Control.scala 67:33]
  wire  HDU_io_is_jalr; // @[Control.scala 67:33]
  wire  HDU_io_mux3_ctr_id; // @[Control.scala 67:33]
  wire  HDU_io_flop_ctr_if; // @[Control.scala 67:33]
  wire  BPU_clock; // @[Control.scala 68:33]
  wire  BPU_reset; // @[Control.scala 68:33]
  wire  BPU_io_preevent; // @[Control.scala 68:33]
  wire  BPU_io_answer; // @[Control.scala 68:33]
  wire  BPU_io_fail; // @[Control.scala 68:33]
  wire  BPU_io_out; // @[Control.scala 68:33]
  wire [5:0] DECO_io_cmd; // @[Control.scala 69:33]
  wire  DECO_io_stopp; // @[Control.scala 69:33]
  wire  DECO_io_ifNoStall; // @[Control.scala 69:33]
  wire  DECO_io_BPU_out; // @[Control.scala 69:33]
  wire  DECO_io_preevent; // @[Control.scala 69:33]
  wire  DECO_io_jump; // @[Control.scala 69:33]
  wire  DECO_io_preaccess; // @[Control.scala 69:33]
  wire  DECO_io_jalr; // @[Control.scala 69:33]
  wire  DECO_io_out_IF_mux1; // @[Control.scala 69:33]
  wire [1:0] DECO_io_out_ID_mux1; // @[Control.scala 69:33]
  wire  DECO_io_out_ID_mux2; // @[Control.scala 69:33]
  wire  DECO_io_out_ID_mux4; // @[Control.scala 69:33]
  wire  DECO_io_out_ID_mux5; // @[Control.scala 69:33]
  wire  DECO_io_out_EX_mux3; // @[Control.scala 69:33]
  wire [4:0] DECO_io_out_EX_ALU; // @[Control.scala 69:33]
  wire [2:0] DECO_io_out_MEM_DM_read; // @[Control.scala 69:33]
  wire [1:0] DECO_io_out_MEM_DM_write; // @[Control.scala 69:33]
  wire [1:0] DECO_io_out_WB_mux1; // @[Control.scala 69:33]
  wire  DECO_io_out_WB_reg_write; // @[Control.scala 69:33]
  wire  SU_clock; // @[Control.scala 70:33]
  wire  SU_reset; // @[Control.scala 70:33]
  wire  SU_io_preaccess; // @[Control.scala 70:33]
  wire  SU_io_HDU_wait; // @[Control.scala 70:33]
  wire  SU_io_MEM_done; // @[Control.scala 70:33]
  wire  SU_io_BUS_trans; // @[Control.scala 70:33]
  wire  SU_io_IF_ID_stall; // @[Control.scala 70:33]
  wire  SU_io_MEM_WB_stall; // @[Control.scala 70:33]
  wire  SU_io_EX_MEM_stall; // @[Control.scala 70:33]
  wire  SU_io_nWait; // @[Control.scala 70:33]
  wire  _T_1 = BPU_io_fail; // @[Control.scala 80:52]
  wire  _T_5 = ~BPU_io_out; // @[Control.scala 85:70]
  wire  _T_6 = DECO_io_preevent & _T_5; // @[Control.scala 85:68]
  wire  _T_7 = BPU_io_fail | _T_6; // @[Control.scala 85:48]
  reg  EX_EX_mux3; // @[Control.scala 99:25]
  reg [4:0] EX_EX_ALU; // @[Control.scala 99:25]
  reg [2:0] EX_MEM_DM_read; // @[Control.scala 99:25]
  reg [1:0] EX_MEM_DM_write; // @[Control.scala 99:25]
  reg [1:0] EX_WB_mux1; // @[Control.scala 99:25]
  reg  EX_WB_reg_write; // @[Control.scala 99:25]
  wire  ID_flush = BPU_io_fail | SU_io_IF_ID_stall; // @[Control.scala 102:47]
  wire  _T_10 = ~ID_flush; // @[Control.scala 103:24]
  wire  _GEN_0 = _T_10 & DECO_io_out_EX_mux3; // @[Control.scala 103:32]
  wire  _GEN_7 = _T_10 & DECO_io_out_WB_reg_write; // @[Control.scala 103:32]
  reg [2:0] MEM_MEM_DM_read; // @[Control.scala 152:26]
  reg [1:0] MEM_MEM_DM_write; // @[Control.scala 152:26]
  reg [1:0] MEM_WB_mux1; // @[Control.scala 152:26]
  reg  MEM_WB_reg_write; // @[Control.scala 152:26]
  reg [1:0] WB_WB_mux1; // @[Control.scala 179:25]
  reg  WB_WB_reg_write; // @[Control.scala 179:25]
  wire  _T_15 = SU_io_MEM_WB_stall & SU_io_BUS_trans; // @[Control.scala 192:99]
  wire  _T_16 = ~SU_io_MEM_WB_stall; // @[Control.scala 192:121]
  wire  _T_17 = _T_15 | _T_16; // @[Control.scala 192:119]
  FU FU ( // @[Control.scala 66:33]
    .clock(FU_clock),
    .reset(FU_reset),
    .io_reg_write_mem(FU_io_reg_write_mem),
    .io_reg_write_wb(FU_io_reg_write_wb),
    .io_rs1_ex(FU_io_rs1_ex),
    .io_rs2_ex(FU_io_rs2_ex),
    .io_rd_mem(FU_io_rd_mem),
    .io_rd_wb(FU_io_rd_wb),
    .io_ID_cmd(FU_io_ID_cmd),
    .io_mux1_ctr_ex(FU_io_mux1_ctr_ex),
    .io_mux2_ctr_ex(FU_io_mux2_ctr_ex)
  );
  HDU HDU ( // @[Control.scala 67:33]
    .io_dm_read_ex(HDU_io_dm_read_ex),
    .io_rs1_id(HDU_io_rs1_id),
    .io_rs2_id(HDU_io_rs2_id),
    .io_rd_ex(HDU_io_rd_ex),
    .io_rd_mem(HDU_io_rd_mem),
    .io_is_jalr(HDU_io_is_jalr),
    .io_mux3_ctr_id(HDU_io_mux3_ctr_id),
    .io_flop_ctr_if(HDU_io_flop_ctr_if)
  );
  BPU BPU ( // @[Control.scala 68:33]
    .clock(BPU_clock),
    .reset(BPU_reset),
    .io_preevent(BPU_io_preevent),
    .io_answer(BPU_io_answer),
    .io_fail(BPU_io_fail),
    .io_out(BPU_io_out)
  );
  Control_decode DECO ( // @[Control.scala 69:33]
    .io_cmd(DECO_io_cmd),
    .io_stopp(DECO_io_stopp),
    .io_ifNoStall(DECO_io_ifNoStall),
    .io_BPU_out(DECO_io_BPU_out),
    .io_preevent(DECO_io_preevent),
    .io_jump(DECO_io_jump),
    .io_preaccess(DECO_io_preaccess),
    .io_jalr(DECO_io_jalr),
    .io_out_IF_mux1(DECO_io_out_IF_mux1),
    .io_out_ID_mux1(DECO_io_out_ID_mux1),
    .io_out_ID_mux2(DECO_io_out_ID_mux2),
    .io_out_ID_mux4(DECO_io_out_ID_mux4),
    .io_out_ID_mux5(DECO_io_out_ID_mux5),
    .io_out_EX_mux3(DECO_io_out_EX_mux3),
    .io_out_EX_ALU(DECO_io_out_EX_ALU),
    .io_out_MEM_DM_read(DECO_io_out_MEM_DM_read),
    .io_out_MEM_DM_write(DECO_io_out_MEM_DM_write),
    .io_out_WB_mux1(DECO_io_out_WB_mux1),
    .io_out_WB_reg_write(DECO_io_out_WB_reg_write)
  );
  stall_unit SU ( // @[Control.scala 70:33]
    .clock(SU_clock),
    .reset(SU_reset),
    .io_preaccess(SU_io_preaccess),
    .io_HDU_wait(SU_io_HDU_wait),
    .io_MEM_done(SU_io_MEM_done),
    .io_BUS_trans(SU_io_BUS_trans),
    .io_IF_ID_stall(SU_io_IF_ID_stall),
    .io_MEM_WB_stall(SU_io_MEM_WB_stall),
    .io_EX_MEM_stall(SU_io_EX_MEM_stall),
    .io_nWait(SU_io_nWait)
  );
  assign io_IF_mux1_select = DECO_io_out_IF_mux1; // @[Control.scala 79:33]
  assign io_IF_mux2_select = _T_1 ? {{1'd0}, BPU_io_answer} : 2'h2; // @[Control.scala 80:33]
  assign io_IF_en = ~SU_io_IF_ID_stall; // @[Control.scala 81:57]
  assign io_ID_wen = WB_WB_reg_write & _T_17; // @[Control.scala 192:57]
  assign io_ID_mux1_select = DECO_io_out_ID_mux1; // @[Control.scala 88:33]
  assign io_ID_mux2_select = DECO_io_out_ID_mux2; // @[Control.scala 89:33]
  assign io_ID_mux4_select = DECO_io_out_ID_mux4; // @[Control.scala 90:33]
  assign io_ID_mux5_select = DECO_io_out_ID_mux5; // @[Control.scala 91:33]
  assign io_EX_alu_sel = EX_EX_ALU; // @[Control.scala 133:33]
  assign io_EX_mux1_select = FU_io_mux1_ctr_ex; // @[Control.scala 129:33]
  assign io_EX_mux2_select = FU_io_mux2_ctr_ex; // @[Control.scala 130:33]
  assign io_EX_mux3_select = EX_EX_mux3; // @[Control.scala 132:33]
  assign io_MEM_write = MEM_MEM_DM_write; // @[Control.scala 163:49]
  assign io_MEM_read = MEM_MEM_DM_read; // @[Control.scala 162:49]
  assign io_WB_mux1_select = WB_WB_mux1; // @[Control.scala 187:33]
  assign io_PIPE_IF_flush = _T_7 | DECO_io_jump; // @[Control.scala 85:33]
  assign io_PIPE_IF_en = ~SU_io_IF_ID_stall; // @[Control.scala 84:41]
  assign io_PIPE_MEM_WB_stall = SU_io_MEM_WB_stall; // @[Control.scala 176:29]
  assign io_PIPE_EX_MEM_stall = SU_io_EX_MEM_stall; // @[Control.scala 154:29]
  assign FU_clock = clock;
  assign FU_reset = reset;
  assign FU_io_reg_write_mem = MEM_WB_reg_write; // @[Control.scala 165:33]
  assign FU_io_reg_write_wb = WB_WB_reg_write; // @[Control.scala 189:27]
  assign FU_io_rs1_ex = io_EX_r1_addr; // @[Control.scala 136:49]
  assign FU_io_rs2_ex = io_EX_r2_addr; // @[Control.scala 137:49]
  assign FU_io_rd_mem = io_MEM_rd_addr; // @[Control.scala 166:49]
  assign FU_io_rd_wb = io_WB_rd_addr; // @[Control.scala 190:49]
  assign FU_io_ID_cmd = io_ID_cmd; // @[Control.scala 138:49]
  assign HDU_io_dm_read_ex = EX_MEM_DM_read; // @[Control.scala 140:41]
  assign HDU_io_rs1_id = io_ID_rs1; // @[Control.scala 93:25]
  assign HDU_io_rs2_id = io_ID_rs2; // @[Control.scala 94:25]
  assign HDU_io_rd_ex = io_EX_rd_addr; // @[Control.scala 141:49]
  assign HDU_io_rd_mem = io_MEM_rd_addr; // @[Control.scala 168:41]
  assign HDU_io_is_jalr = DECO_io_jalr; // @[Control.scala 95:23]
  assign BPU_clock = clock;
  assign BPU_reset = reset;
  assign BPU_io_preevent = DECO_io_preevent; // @[Control.scala 76:41]
  assign BPU_io_answer = io_EX_alu_ans; // @[Control.scala 143:49]
  assign DECO_io_cmd = io_ID_cmd; // @[Control.scala 74:57]
  assign DECO_io_stopp = SU_io_IF_ID_stall; // @[Control.scala 73:49]
  assign DECO_io_ifNoStall = HDU_io_flop_ctr_if & SU_io_nWait; // @[Control.scala 75:41]
  assign DECO_io_BPU_out = BPU_io_out; // @[Control.scala 72:41]
  assign SU_clock = clock;
  assign SU_reset = reset;
  assign SU_io_preaccess = _T_10 & DECO_io_preaccess; // @[Control.scala 113:33 Control.scala 124:33]
  assign SU_io_HDU_wait = HDU_io_mux3_ctr_id; // @[Control.scala 148:41]
  assign SU_io_MEM_done = io_MEM_done; // @[Control.scala 173:41]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  EX_EX_mux3 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  EX_EX_ALU = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  EX_MEM_DM_read = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  EX_MEM_DM_write = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  EX_WB_mux1 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  EX_WB_reg_write = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  MEM_MEM_DM_read = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  MEM_MEM_DM_write = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  MEM_WB_mux1 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  MEM_WB_reg_write = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  WB_WB_mux1 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  WB_WB_reg_write = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      EX_EX_mux3 <= 1'h0;
    end else begin
      EX_EX_mux3 <= _GEN_0;
    end
    if (reset) begin
      EX_EX_ALU <= 5'h0;
    end else if (_T_10) begin
      EX_EX_ALU <= DECO_io_out_EX_ALU;
    end else begin
      EX_EX_ALU <= 5'hf;
    end
    if (reset) begin
      EX_MEM_DM_read <= 3'h0;
    end else if (_T_10) begin
      EX_MEM_DM_read <= DECO_io_out_MEM_DM_read;
    end else begin
      EX_MEM_DM_read <= 3'h0;
    end
    if (reset) begin
      EX_MEM_DM_write <= 2'h0;
    end else if (_T_10) begin
      EX_MEM_DM_write <= DECO_io_out_MEM_DM_write;
    end else begin
      EX_MEM_DM_write <= 2'h0;
    end
    if (reset) begin
      EX_WB_mux1 <= 2'h0;
    end else if (_T_10) begin
      EX_WB_mux1 <= DECO_io_out_WB_mux1;
    end else begin
      EX_WB_mux1 <= 2'h0;
    end
    if (reset) begin
      EX_WB_reg_write <= 1'h0;
    end else begin
      EX_WB_reg_write <= _GEN_7;
    end
    if (reset) begin
      MEM_MEM_DM_read <= 3'h0;
    end else if (!(SU_io_EX_MEM_stall)) begin
      MEM_MEM_DM_read <= EX_MEM_DM_read;
    end
    if (reset) begin
      MEM_MEM_DM_write <= 2'h0;
    end else if (!(SU_io_EX_MEM_stall)) begin
      MEM_MEM_DM_write <= EX_MEM_DM_write;
    end
    if (reset) begin
      MEM_WB_mux1 <= 2'h0;
    end else begin
      MEM_WB_mux1 <= EX_WB_mux1;
    end
    if (reset) begin
      MEM_WB_reg_write <= 1'h0;
    end else begin
      MEM_WB_reg_write <= EX_WB_reg_write;
    end
    if (reset) begin
      WB_WB_mux1 <= 2'h0;
    end else if (!(SU_io_MEM_WB_stall)) begin
      WB_WB_mux1 <= MEM_WB_mux1;
    end
    if (reset) begin
      WB_WB_reg_write <= 1'h0;
    end else if (!(SU_io_MEM_WB_stall)) begin
      WB_WB_reg_write <= MEM_WB_reg_write;
    end
  end
endmodule
module IF(
  input         clock,
  input         reset,
  input  [31:0] io_in_pc,
  output [31:0] io_out_pc,
  input  [31:0] io_A,
  input  [31:0] io_B,
  output [31:0] io_instruction,
  output [31:0] io_IM_addr,
  input  [31:0] io_IM_data,
  input         io_ctrl_mux1_select,
  input  [1:0]  io_ctrl_mux2_select,
  input         io_ctrl_en,
  input         io_halt,
  input         io_reset,
  input  [31:0] io_mtvec,
  input         io_jtomtvec
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [29:0] next_pc; // @[IF.scala 42:30]
  wire [29:0] _T_1 = next_pc + 30'h1; // @[IF.scala 43:49]
  wire [29:0] db_pc = io_halt ? next_pc : _T_1; // @[IF.scala 43:23]
  wire  _T_2 = ~io_ctrl_mux1_select; // @[IF.scala 48:38]
  wire [29:0] j_pc = _T_2 ? io_in_pc[31:2] : db_pc; // @[IF.scala 48:18]
  wire  _T_5 = io_ctrl_mux2_select == 2'h0; // @[IF.scala 51:33]
  wire  _T_7 = io_ctrl_mux2_select == 2'h1; // @[IF.scala 54:38]
  wire [29:0] _GEN_0 = _T_7 ? io_B[31:2] : j_pc; // @[IF.scala 54:45]
  wire [29:0] pc = _T_5 ? io_A[31:2] : _GEN_0; // @[IF.scala 51:40]
  wire [29:0] int_pc = io_jtomtvec ? io_mtvec[31:2] : pc; // @[IF.scala 63:25]
  wire [29:0] _T_10 = io_ctrl_en ? int_pc : next_pc; // @[IF.scala 66:57]
  wire [29:0] actual_pc = io_reset ? 30'h1 : _T_10; // @[IF.scala 66:23]
  assign io_out_pc = {next_pc, 2'h0}; // @[IF.scala 69:41]
  assign io_instruction = io_IM_data; // @[IF.scala 71:23]
  assign io_IM_addr = {actual_pc, 2'h0}; // @[IF.scala 70:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  next_pc = _RAND_0[29:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      next_pc <= 30'h1;
    end else if (io_reset) begin
      next_pc <= 30'h1;
    end else if (io_ctrl_en) begin
      if (io_jtomtvec) begin
        next_pc <= io_mtvec[31:2];
      end else if (_T_5) begin
        next_pc <= io_A[31:2];
      end else if (_T_7) begin
        next_pc <= io_B[31:2];
      end else if (_T_2) begin
        next_pc <= io_in_pc[31:2];
      end else if (!(io_halt)) begin
        next_pc <= _T_1;
      end
    end
  end
endmodule
module CSR(
  input         clock,
  input         reset,
  input         io_we,
  input  [11:0] io_addr,
  input  [31:0] io_data_w,
  output [31:0] io_data_r,
  input  [31:0] io_PC,
  input         io_interruption,
  output        io_jtomtvec,
  output        io_instertbubble,
  output [31:0] io_OUT_CSR_0,
  output [31:0] io_OUT_CSR_2,
  output [31:0] io_OUT_CSR_3,
  output [31:0] io_OUT_CSR_4
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mstatus; // @[CSR.scala 19:58]
  reg [31:0] mtvec; // @[CSR.scala 23:46]
  reg [31:0] mepc; // @[CSR.scala 23:46]
  reg [31:0] tdata1; // @[CSR.scala 23:46]
  reg [31:0] tdata2; // @[CSR.scala 23:46]
  reg  _T; // @[CSR.scala 72:55]
  wire  _T_1 = ~_T; // @[CSR.scala 72:47]
  wire  rising_intrup = io_interruption & _T_1; // @[CSR.scala 72:44]
  wire  _T_2 = io_addr == 12'h7a1; // @[CSR.scala 77:37]
  wire  _T_3 = io_we & _T_2; // @[CSR.scala 77:28]
  wire [31:0] _GEN_1 = _T_2 ? tdata1 : 32'h0; // @[CSR.scala 80:39]
  wire  _T_5 = io_addr == 12'h341; // @[CSR.scala 77:37]
  wire  _T_6 = io_we & _T_5; // @[CSR.scala 77:28]
  wire [31:0] _GEN_3 = _T_5 ? mepc : _GEN_1; // @[CSR.scala 80:39]
  wire  _T_9 = rising_intrup & mstatus[3]; // @[CSR.scala 85:53]
  wire  _T_10 = io_addr == 12'h300; // @[CSR.scala 77:37]
  wire  _T_11 = io_we & _T_10; // @[CSR.scala 77:28]
  wire [31:0] _GEN_6 = _T_10 ? mstatus : _GEN_3; // @[CSR.scala 80:39]
  wire  _T_13 = io_addr == 12'h305; // @[CSR.scala 77:37]
  wire  _T_14 = io_we & _T_13; // @[CSR.scala 77:28]
  wire [31:0] _GEN_8 = _T_13 ? mtvec : _GEN_6; // @[CSR.scala 80:39]
  wire  _T_16 = io_addr == 12'h7a2; // @[CSR.scala 77:37]
  wire  _T_17 = io_we & _T_16; // @[CSR.scala 77:28]
  reg  _T_19; // @[CSR.scala 93:29]
  reg  instertbubble; // @[CSR.scala 98:34]
  wire  _T_20 = ~instertbubble; // @[CSR.scala 99:31]
  wire  _T_21 = rising_intrup & _T_20; // @[CSR.scala 99:28]
  wire  _T_22 = io_jtomtvec & instertbubble; // @[CSR.scala 101:33]
  wire  _GEN_11 = _T_22 ? 1'h0 : instertbubble; // @[CSR.scala 101:51]
  wire  _GEN_12 = _T_21 | _GEN_11; // @[CSR.scala 99:47]
  assign io_data_r = _T_16 ? tdata2 : _GEN_8; // @[CSR.scala 69:12 CSR.scala 81:34 CSR.scala 81:34 CSR.scala 81:34 CSR.scala 81:34 CSR.scala 81:34]
  assign io_jtomtvec = _T_19; // @[CSR.scala 93:20]
  assign io_instertbubble = _T_21 | instertbubble; // @[CSR.scala 104:25]
  assign io_OUT_CSR_0 = tdata1; // @[CSR.scala 89:30]
  assign io_OUT_CSR_2 = mstatus; // @[CSR.scala 89:30]
  assign io_OUT_CSR_3 = mtvec; // @[CSR.scala 89:30]
  assign io_OUT_CSR_4 = tdata2; // @[CSR.scala 89:30]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mstatus = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mtvec = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  tdata1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  tdata2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  _T = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  _T_19 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  instertbubble = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      mstatus <= 32'h0;
    end else if (_T_11) begin
      mstatus <= io_data_w;
    end
    if (reset) begin
      mtvec <= 32'h4;
    end else if (_T_14) begin
      mtvec <= io_data_w;
    end
    if (reset) begin
      mepc <= 32'h4;
    end else if (_T_9) begin
      mepc <= io_PC;
    end else if (_T_6) begin
      mepc <= io_data_w;
    end
    if (reset) begin
      tdata1 <= 32'h4;
    end else if (_T_3) begin
      tdata1 <= io_data_w;
    end
    if (reset) begin
      tdata2 <= 32'h4;
    end else if (_T_17) begin
      tdata2 <= io_data_w;
    end
    _T <= io_interruption;
    if (reset) begin
      _T_19 <= 1'h0;
    end else begin
      _T_19 <= rising_intrup;
    end
    if (reset) begin
      instertbubble <= 1'h0;
    end else begin
      instertbubble <= _GEN_12;
    end
  end
endmodule
module breakpoint(
  input  [31:0] io_mstatus,
  input  [31:0] io_tdata1,
  input  [31:0] io_tdata2,
  input  [31:0] io_pc,
  input  [31:0] io_ea,
  output        io_bpInterruption,
  output        io_bpHalt
);
  wire [3:0] triggertype = io_tdata1[31:28]; // @[breakpoint.scala 18:36]
  wire  enable = io_mstatus[3]; // @[breakpoint.scala 19:32]
  wire  _T = triggertype == 4'h2; // @[breakpoint.scala 21:26]
  wire  _T_11 = enable & io_tdata1[6]; // @[breakpoint.scala 32:29]
  wire  _T_12 = io_tdata1[17:16] == 2'h0; // @[breakpoint.scala 32:42]
  wire  _T_13 = io_tdata1[17:16] == 2'h3; // @[breakpoint.scala 32:57]
  wire  _T_14 = _T_12 | _T_13; // @[breakpoint.scala 32:49]
  wire  _T_15 = _T_11 & _T_14; // @[breakpoint.scala 32:33]
  wire  _T_16 = ~io_tdata1[11]; // @[breakpoint.scala 32:67]
  wire  _T_17 = _T_15 & _T_16; // @[breakpoint.scala 32:65]
  wire  _T_18 = ~io_tdata1[18]; // @[breakpoint.scala 32:76]
  wire  _T_19 = _T_17 & _T_18; // @[breakpoint.scala 32:74]
  wire  _T_20 = io_tdata1[10:7] == 4'h0; // @[breakpoint.scala 34:46]
  wire  _T_21 = io_tdata2 == io_ea; // @[breakpoint.scala 35:81]
  wire [3:0] _GEN_18 = {{3'd0}, _T_21}; // @[breakpoint.scala 35:68]
  wire [3:0] _T_22 = io_tdata1[15:12] & _GEN_18; // @[breakpoint.scala 35:68]
  wire [3:0] _T_23 = ~io_tdata1[15:12]; // @[breakpoint.scala 36:54]
  wire [3:0] _T_25 = _T_23 & _GEN_18; // @[breakpoint.scala 36:62]
  wire  _T_26 = io_tdata1[10:7] == 4'h2; // @[breakpoint.scala 38:51]
  wire  _T_27 = io_tdata2 <= io_ea; // @[breakpoint.scala 39:81]
  wire [3:0] _GEN_20 = {{3'd0}, _T_27}; // @[breakpoint.scala 39:68]
  wire [3:0] _T_28 = io_tdata1[15:12] & _GEN_20; // @[breakpoint.scala 39:68]
  wire [3:0] _T_31 = _T_23 & _GEN_20; // @[breakpoint.scala 40:62]
  wire  _T_32 = io_tdata1[10:7] == 4'h3; // @[breakpoint.scala 42:51]
  wire  _T_33 = io_tdata2 > io_ea; // @[breakpoint.scala 43:81]
  wire [3:0] _GEN_22 = {{3'd0}, _T_33}; // @[breakpoint.scala 43:68]
  wire [3:0] _T_34 = io_tdata1[15:12] & _GEN_22; // @[breakpoint.scala 43:68]
  wire [3:0] _T_37 = _T_23 & _GEN_22; // @[breakpoint.scala 44:62]
  wire [3:0] _GEN_0 = _T_32 ? _T_34 : 4'h0; // @[breakpoint.scala 42:58]
  wire [3:0] _GEN_1 = _T_32 ? _T_37 : 4'h0; // @[breakpoint.scala 42:58]
  wire [3:0] _GEN_2 = _T_26 ? _T_28 : _GEN_0; // @[breakpoint.scala 38:58]
  wire [3:0] _GEN_3 = _T_26 ? _T_31 : _GEN_1; // @[breakpoint.scala 38:58]
  wire [3:0] _GEN_4 = _T_20 ? _T_22 : _GEN_2; // @[breakpoint.scala 34:53]
  wire [3:0] _GEN_5 = _T_20 ? _T_25 : _GEN_3; // @[breakpoint.scala 34:53]
  wire  _T_39 = io_tdata2 == io_pc; // @[breakpoint.scala 53:81]
  wire [3:0] _GEN_24 = {{3'd0}, _T_39}; // @[breakpoint.scala 53:68]
  wire [3:0] _T_40 = io_tdata1[15:12] & _GEN_24; // @[breakpoint.scala 53:68]
  wire [3:0] _T_43 = _T_23 & _GEN_24; // @[breakpoint.scala 54:62]
  wire  _T_45 = io_tdata2 <= io_pc; // @[breakpoint.scala 57:81]
  wire [3:0] _GEN_26 = {{3'd0}, _T_45}; // @[breakpoint.scala 57:68]
  wire [3:0] _T_46 = io_tdata1[15:12] & _GEN_26; // @[breakpoint.scala 57:68]
  wire [3:0] _T_49 = _T_23 & _GEN_26; // @[breakpoint.scala 58:62]
  wire  _T_51 = io_tdata2 > io_pc; // @[breakpoint.scala 61:81]
  wire [3:0] _GEN_28 = {{3'd0}, _T_51}; // @[breakpoint.scala 61:68]
  wire [3:0] _T_52 = io_tdata1[15:12] & _GEN_28; // @[breakpoint.scala 61:68]
  wire [3:0] _T_55 = _T_23 & _GEN_28; // @[breakpoint.scala 62:62]
  wire [3:0] _GEN_6 = _T_32 ? _T_52 : 4'h0; // @[breakpoint.scala 60:58]
  wire [3:0] _GEN_7 = _T_32 ? _T_55 : 4'h0; // @[breakpoint.scala 60:58]
  wire [3:0] _GEN_8 = _T_26 ? _T_46 : _GEN_6; // @[breakpoint.scala 56:58]
  wire [3:0] _GEN_9 = _T_26 ? _T_49 : _GEN_7; // @[breakpoint.scala 56:58]
  wire [3:0] _GEN_10 = _T_20 ? _T_40 : _GEN_8; // @[breakpoint.scala 52:53]
  wire [3:0] _GEN_11 = _T_20 ? _T_43 : _GEN_9; // @[breakpoint.scala 52:53]
  wire [3:0] _GEN_12 = io_tdata1[19] ? _GEN_4 : _GEN_10; // @[breakpoint.scala 33:37]
  wire [3:0] _GEN_13 = io_tdata1[19] ? _GEN_5 : _GEN_11; // @[breakpoint.scala 33:37]
  wire [3:0] _GEN_14 = _T_19 ? _GEN_12 : 4'h0; // @[breakpoint.scala 32:85]
  wire [3:0] _GEN_15 = _T_19 ? _GEN_13 : 4'h0; // @[breakpoint.scala 32:85]
  wire [3:0] _GEN_16 = _T ? _GEN_14 : 4'h0; // @[breakpoint.scala 21:34]
  wire [3:0] _GEN_17 = _T ? _GEN_15 : 4'h0; // @[breakpoint.scala 21:34]
  assign io_bpInterruption = _GEN_16[0]; // @[breakpoint.scala 16:21 breakpoint.scala 35:58 breakpoint.scala 39:58 breakpoint.scala 43:58 breakpoint.scala 47:59 breakpoint.scala 53:58 breakpoint.scala 57:58 breakpoint.scala 61:58 breakpoint.scala 65:59 breakpoint.scala 71:43 breakpoint.scala 80:35]
  assign io_bpHalt = _GEN_17[0]; // @[breakpoint.scala 17:13 breakpoint.scala 36:51 breakpoint.scala 40:51 breakpoint.scala 44:51 breakpoint.scala 48:51 breakpoint.scala 54:51 breakpoint.scala 58:51 breakpoint.scala 62:51 breakpoint.scala 66:51 breakpoint.scala 72:29 breakpoint.scala 81:21]
endmodule
module InstDeco(
  input  [31:0] io_instruc,
  output [4:0]  io_rd,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  output [31:0] io_imm,
  output [5:0]  io_state
);
  wire [6:0] opcode = io_instruc[6:0]; // @[InstDeco.scala 56:27]
  wire [2:0] funct3 = io_instruc[14:12]; // @[InstDeco.scala 59:27]
  wire [6:0] funct7 = io_instruc[31:25]; // @[InstDeco.scala 62:27]
  wire  _T_7 = 7'h37 == opcode; // @[Conditional.scala 37:30]
  wire [31:0] _T_10 = {io_instruc[31:12],12'h0}; // @[InstDeco.scala 81:76]
  wire  _T_11 = 7'h17 == opcode; // @[Conditional.scala 37:30]
  wire  _T_15 = 7'h6f == opcode; // @[Conditional.scala 37:30]
  wire [20:0] _T_24 = {io_instruc[31],io_instruc[19:12],io_instruc[20],io_instruc[30:21],1'h0}; // @[InstDeco.scala 90:123]
  wire  _T_25 = 7'h67 == opcode; // @[Conditional.scala 37:30]
  wire [11:0] _T_27 = io_instruc[31:20]; // @[InstDeco.scala 95:61]
  wire  _T_28 = 7'h63 == opcode; // @[Conditional.scala 37:30]
  wire [12:0] _T_37 = {io_instruc[31],io_instruc[7],io_instruc[30:25],io_instruc[11:8],1'h0}; // @[InstDeco.scala 100:121]
  wire  _T_38 = 3'h0 == funct3; // @[Conditional.scala 37:30]
  wire  _T_39 = 3'h1 == funct3; // @[Conditional.scala 37:30]
  wire  _T_40 = 3'h4 == funct3; // @[Conditional.scala 37:30]
  wire  _T_41 = 3'h5 == funct3; // @[Conditional.scala 37:30]
  wire  _T_42 = 3'h6 == funct3; // @[Conditional.scala 37:30]
  wire  _T_43 = 3'h7 == funct3; // @[Conditional.scala 37:30]
  wire [5:0] _GEN_0 = _T_43 ? 6'h9 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_1 = _T_42 ? 6'h8 : _GEN_0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_2 = _T_41 ? 6'h7 : _GEN_1; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_3 = _T_40 ? 6'h6 : _GEN_2; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_4 = _T_39 ? 6'h5 : _GEN_3; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_5 = _T_38 ? 6'h4 : _GEN_4; // @[Conditional.scala 40:58]
  wire  _T_44 = 7'h3 == opcode; // @[Conditional.scala 37:30]
  wire  _T_49 = 3'h2 == funct3; // @[Conditional.scala 37:30]
  wire [5:0] _GEN_6 = _T_41 ? 6'h12 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_7 = _T_40 ? 6'h11 : _GEN_6; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_8 = _T_49 ? 6'h10 : _GEN_7; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_9 = _T_39 ? 6'hf : _GEN_8; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_10 = _T_38 ? 6'he : _GEN_9; // @[Conditional.scala 40:58]
  wire  _T_52 = 7'h23 == opcode; // @[Conditional.scala 37:30]
  wire [11:0] _T_56 = {funct7,io_instruc[11:7]}; // @[InstDeco.scala 147:83]
  wire [5:0] _GEN_11 = _T_49 ? 6'hc : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_12 = _T_39 ? 6'hb : _GEN_11; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_13 = _T_38 ? 6'ha : _GEN_12; // @[Conditional.scala 40:58]
  wire  _T_60 = 7'h13 == opcode; // @[Conditional.scala 37:30]
  wire  _T_65 = 3'h3 == funct3; // @[Conditional.scala 37:30]
  wire [4:0] _T_71 = io_instruc[24:20]; // @[InstDeco.scala 188:77]
  wire  _T_75 = 7'h0 == funct7; // @[Conditional.scala 37:30]
  wire  _T_76 = 7'h20 == funct7; // @[Conditional.scala 37:30]
  wire [5:0] _GEN_14 = _T_76 ? 6'h1b : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_15 = _T_75 ? 6'h1a : _GEN_14; // @[Conditional.scala 40:58]
  wire [11:0] _GEN_16 = _T_41 ? $signed({{7{_T_71[4]}},_T_71}) : $signed(_T_27); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_17 = _T_41 ? _GEN_15 : 6'h0; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_18 = _T_39 ? $signed({{7{_T_71[4]}},_T_71}) : $signed(_GEN_16); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_19 = _T_39 ? 6'h19 : _GEN_17; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_20 = _T_43 ? 6'h18 : _GEN_19; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_21 = _T_43 ? $signed(_T_27) : $signed(_GEN_18); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_22 = _T_42 ? 6'h17 : _GEN_20; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_23 = _T_42 ? $signed(_T_27) : $signed(_GEN_21); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_24 = _T_40 ? 6'h16 : _GEN_22; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_25 = _T_40 ? $signed(_T_27) : $signed(_GEN_23); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_26 = _T_65 ? 6'h15 : _GEN_24; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_27 = _T_65 ? $signed(_T_27) : $signed(_GEN_25); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_28 = _T_49 ? 6'h14 : _GEN_26; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_29 = _T_49 ? $signed(_T_27) : $signed(_GEN_27); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_30 = _T_38 ? 6'h13 : _GEN_28; // @[Conditional.scala 40:58]
  wire [11:0] _GEN_31 = _T_38 ? $signed(_T_27) : $signed(_GEN_29); // @[Conditional.scala 40:58]
  wire  _T_77 = 7'h33 == opcode; // @[Conditional.scala 37:30]
  wire  _T_80 = 7'h1 == funct7; // @[Conditional.scala 37:30]
  wire [5:0] _GEN_32 = _T_76 ? 6'h25 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_33 = _T_80 ? 6'h24 : _GEN_32; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_34 = _T_75 ? 6'h23 : _GEN_33; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_35 = _T_80 ? 6'h27 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_36 = _T_75 ? 6'h26 : _GEN_35; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_37 = _T_80 ? 6'h29 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_38 = _T_75 ? 6'h28 : _GEN_37; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_39 = _T_80 ? 6'h2b : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_40 = _T_75 ? 6'h2a : _GEN_39; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_41 = _T_80 ? 6'h2d : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_42 = _T_75 ? 6'h2c : _GEN_41; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_43 = _T_76 ? 6'h30 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_44 = _T_80 ? 6'h2f : _GEN_43; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_45 = _T_75 ? 6'h2e : _GEN_44; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_46 = _T_80 ? 6'h32 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_47 = _T_75 ? 6'h31 : _GEN_46; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_48 = _T_80 ? 6'h34 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_49 = _T_75 ? 6'h33 : _GEN_48; // @[Conditional.scala 40:58]
  wire [5:0] _GEN_50 = _T_43 ? _GEN_49 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_51 = _T_42 ? _GEN_47 : _GEN_50; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_52 = _T_41 ? _GEN_45 : _GEN_51; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_53 = _T_40 ? _GEN_42 : _GEN_52; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_54 = _T_65 ? _GEN_40 : _GEN_53; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_55 = _T_49 ? _GEN_38 : _GEN_54; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_56 = _T_39 ? _GEN_36 : _GEN_55; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_57 = _T_38 ? _GEN_34 : _GEN_56; // @[Conditional.scala 40:58]
  wire  _T_104 = 7'h73 == opcode; // @[Conditional.scala 37:30]
  wire [31:0] _T_107 = {20'h0,io_instruc[31:20]}; // @[InstDeco.scala 321:68]
  wire [5:0] _GEN_58 = _T_43 ? 6'h22 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_59 = _T_42 ? 6'h21 : _GEN_58; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_60 = _T_41 ? 6'h20 : _GEN_59; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_61 = _T_65 ? 6'h1f : _GEN_60; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_62 = _T_49 ? 6'h1e : _GEN_61; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_63 = _T_39 ? 6'h1d : _GEN_62; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_64 = _T_38 ? 6'h1c : _GEN_63; // @[Conditional.scala 40:58]
  wire [31:0] _GEN_65 = _T_104 ? $signed(_T_107) : $signed(32'sh0); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_66 = _T_104 ? _GEN_64 : 6'h0; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_67 = _T_77 ? _GEN_57 : _GEN_66; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_68 = _T_77 ? $signed(32'sh0) : $signed(_GEN_65); // @[Conditional.scala 39:67]
  wire [31:0] _GEN_69 = _T_60 ? $signed({{20{_GEN_31[11]}},_GEN_31}) : $signed(_GEN_68); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_70 = _T_60 ? _GEN_30 : _GEN_67; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_71 = _T_52 ? $signed({{20{_T_56[11]}},_T_56}) : $signed(_GEN_69); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_72 = _T_52 ? _GEN_13 : _GEN_70; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_73 = _T_44 ? $signed({{20{_T_27[11]}},_T_27}) : $signed(_GEN_71); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_74 = _T_44 ? _GEN_10 : _GEN_72; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_75 = _T_28 ? $signed({{19{_T_37[12]}},_T_37}) : $signed(_GEN_73); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_76 = _T_28 ? _GEN_5 : _GEN_74; // @[Conditional.scala 39:67]
  wire [5:0] _GEN_77 = _T_25 ? 6'hd : _GEN_76; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_78 = _T_25 ? $signed({{20{_T_27[11]}},_T_27}) : $signed(_GEN_75); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_79 = _T_15 ? 6'h3 : _GEN_77; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_80 = _T_15 ? $signed({{11{_T_24[20]}},_T_24}) : $signed(_GEN_78); // @[Conditional.scala 39:67]
  wire [5:0] _GEN_81 = _T_11 ? 6'h2 : _GEN_79; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_82 = _T_11 ? $signed(_T_10) : $signed(_GEN_80); // @[Conditional.scala 39:67]
  assign io_rd = io_instruc[11:7]; // @[InstDeco.scala 66:14]
  assign io_rs1 = io_instruc[19:15]; // @[InstDeco.scala 69:15]
  assign io_rs2 = io_instruc[24:20]; // @[InstDeco.scala 71:15]
  assign io_imm = _T_7 ? $signed(_T_10) : $signed(_GEN_82); // @[InstDeco.scala 73:15 InstDeco.scala 81:39 InstDeco.scala 85:39 InstDeco.scala 90:39 InstDeco.scala 95:39 InstDeco.scala 100:39 InstDeco.scala 125:39 InstDeco.scala 147:39 InstDeco.scala 163:39 InstDeco.scala 188:55 InstDeco.scala 192:63 InstDeco.scala 321:31]
  assign io_state = _T_7 ? 6'h1 : _GEN_81; // @[InstDeco.scala 64:17 InstDeco.scala 80:41 InstDeco.scala 84:41 InstDeco.scala 89:41 InstDeco.scala 94:41 InstDeco.scala 101:41 InstDeco.scala 105:57 InstDeco.scala 108:57 InstDeco.scala 111:57 InstDeco.scala 114:57 InstDeco.scala 117:57 InstDeco.scala 120:58 InstDeco.scala 126:41 InstDeco.scala 130:57 InstDeco.scala 133:57 InstDeco.scala 136:57 InstDeco.scala 139:57 InstDeco.scala 142:57 InstDeco.scala 148:41 InstDeco.scala 152:57 InstDeco.scala 155:57 InstDeco.scala 158:57 InstDeco.scala 164:41 InstDeco.scala 170:57 InstDeco.scala 173:57 InstDeco.scala 176:57 InstDeco.scala 179:57 InstDeco.scala 182:57 InstDeco.scala 185:57 InstDeco.scala 189:57 InstDeco.scala 193:65 InstDeco.scala 197:81 InstDeco.scala 200:81 InstDeco.scala 207:41 InstDeco.scala 211:65 InstDeco.scala 215:73 InstDeco.scala 218:73 InstDeco.scala 221:73 InstDeco.scala 226:65 InstDeco.scala 230:73 InstDeco.scala 233:73 InstDeco.scala 238:65 InstDeco.scala 242:73 InstDeco.scala 245:73 InstDeco.scala 250:65 InstDeco.scala 254:73 InstDeco.scala 257:73 InstDeco.scala 263:65 InstDeco.scala 267:73 InstDeco.scala 270:73 InstDeco.scala 275:65 InstDeco.scala 279:73 InstDeco.scala 282:73 InstDeco.scala 285:73 InstDeco.scala 291:65 InstDeco.scala 295:73 InstDeco.scala 298:73 InstDeco.scala 306:65 InstDeco.scala 310:73 InstDeco.scala 313:73 InstDeco.scala 322:33 InstDeco.scala 326:57 InstDeco.scala 329:57 InstDeco.scala 332:57 InstDeco.scala 335:57 InstDeco.scala 338:57 InstDeco.scala 341:57 InstDeco.scala 344:57]
endmodule
module ID(
  input         clock,
  output [31:0] io_rs1,
  output [31:0] io_rs2,
  input  [31:0] io_rd,
  input  [4:0]  io_waddr,
  input         io_ctrl_wen,
  output [5:0]  io_ctrl_cmd,
  output [4:0]  io_ctrl_rs1,
  output [4:0]  io_ctrl_rs2,
  input  [1:0]  io_ctrl_mux1_select,
  input         io_ctrl_mux2_select,
  input         io_ctrl_mux4_select,
  input         io_ctrl_mux5_select,
  input  [31:0] io_instruction,
  output [31:0] io_imm,
  output [4:0]  io_out_rd,
  output [4:0]  io_out_r1,
  output [4:0]  io_out_r2,
  input  [31:0] io_in_pc,
  output [31:0] io_out_pc,
  output [31:0] io_A,
  input         io_RegsAc_we,
  input  [31:0] io_RegsAc_reg_addr,
  input  [31:0] io_RegsAc_data_w,
  output [31:0] io_RegsAc_data_r
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  wire [31:0] deco_io_instruc; // @[ID.scala 76:24]
  wire [4:0] deco_io_rd; // @[ID.scala 76:24]
  wire [4:0] deco_io_rs1; // @[ID.scala 76:24]
  wire [4:0] deco_io_rs2; // @[ID.scala 76:24]
  wire [31:0] deco_io_imm; // @[ID.scala 76:24]
  wire [5:0] deco_io_state; // @[ID.scala 76:24]
  reg [31:0] regs [0:30]; // @[ID.scala 97:31]
  wire [31:0] regs__T_15_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_15_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_16_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_16_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_17_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_17_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_18_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_18_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_19_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_19_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_20_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_20_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_21_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_21_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_22_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_22_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_23_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_23_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_24_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_24_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_25_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_25_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_26_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_26_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_27_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_27_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_28_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_28_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_29_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_29_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_30_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_30_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_31_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_31_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_32_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_32_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_33_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_33_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_34_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_34_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_35_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_35_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_36_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_36_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_37_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_37_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_38_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_38_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_39_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_39_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_40_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_40_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_41_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_41_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_42_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_42_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_43_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_43_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_44_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_44_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_45_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_45_addr; // @[ID.scala 97:31]
  wire [31:0] regs__T_9_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_9_addr; // @[ID.scala 97:31]
  wire  regs__T_9_mask; // @[ID.scala 97:31]
  wire  regs__T_9_en; // @[ID.scala 97:31]
  wire [31:0] regs__T_14_data; // @[ID.scala 97:31]
  wire [4:0] regs__T_14_addr; // @[ID.scala 97:31]
  wire  regs__T_14_mask; // @[ID.scala 97:31]
  wire  regs__T_14_en; // @[ID.scala 97:31]
  wire  _T = io_RegsAc_reg_addr != 32'h1000; // @[ID.scala 100:56]
  wire  _T_2 = _T & io_RegsAc_reg_addr[12]; // @[ID.scala 100:69]
  wire  _T_4 = |io_RegsAc_reg_addr[31:13]; // @[ID.scala 100:131]
  wire  _T_5 = ~_T_4; // @[ID.scala 100:96]
  wire  GPR_Debug_cond = _T_2 & _T_5; // @[ID.scala 100:94]
  wire  _T_8 = io_RegsAc_we & GPR_Debug_cond; // @[ID.scala 104:36]
  wire  _T_10 = io_waddr != 5'h0; // @[ID.scala 108:49]
  wire  _T_11 = io_ctrl_wen & _T_10; // @[ID.scala 108:40]
  wire [4:0] addr_rs1 = deco_io_rs1; // @[ID.scala 69:28 ID.scala 91:17]
  wire  _T_46 = addr_rs1 != 5'h0; // @[ID.scala 120:37]
  wire  _T_47 = addr_rs1 == io_waddr; // @[ID.scala 120:58]
  wire  _T_48 = _T_47 & io_ctrl_wen; // @[ID.scala 120:69]
  wire [31:0] regs_out_1 = regs__T_15_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_16 = 5'h1 == addr_rs1 ? regs_out_1 : 32'h0; // @[ID.scala 120:49]
  wire [31:0] regs_out_2 = regs__T_16_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_17 = 5'h2 == addr_rs1 ? regs_out_2 : _GEN_16; // @[ID.scala 120:49]
  wire [31:0] regs_out_3 = regs__T_17_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_18 = 5'h3 == addr_rs1 ? regs_out_3 : _GEN_17; // @[ID.scala 120:49]
  wire [31:0] regs_out_4 = regs__T_18_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_19 = 5'h4 == addr_rs1 ? regs_out_4 : _GEN_18; // @[ID.scala 120:49]
  wire [31:0] regs_out_5 = regs__T_19_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_20 = 5'h5 == addr_rs1 ? regs_out_5 : _GEN_19; // @[ID.scala 120:49]
  wire [31:0] regs_out_6 = regs__T_20_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_21 = 5'h6 == addr_rs1 ? regs_out_6 : _GEN_20; // @[ID.scala 120:49]
  wire [31:0] regs_out_7 = regs__T_21_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_22 = 5'h7 == addr_rs1 ? regs_out_7 : _GEN_21; // @[ID.scala 120:49]
  wire [31:0] regs_out_8 = regs__T_22_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_23 = 5'h8 == addr_rs1 ? regs_out_8 : _GEN_22; // @[ID.scala 120:49]
  wire [31:0] regs_out_9 = regs__T_23_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_24 = 5'h9 == addr_rs1 ? regs_out_9 : _GEN_23; // @[ID.scala 120:49]
  wire [31:0] regs_out_10 = regs__T_24_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_25 = 5'ha == addr_rs1 ? regs_out_10 : _GEN_24; // @[ID.scala 120:49]
  wire [31:0] regs_out_11 = regs__T_25_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_26 = 5'hb == addr_rs1 ? regs_out_11 : _GEN_25; // @[ID.scala 120:49]
  wire [31:0] regs_out_12 = regs__T_26_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_27 = 5'hc == addr_rs1 ? regs_out_12 : _GEN_26; // @[ID.scala 120:49]
  wire [31:0] regs_out_13 = regs__T_27_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_28 = 5'hd == addr_rs1 ? regs_out_13 : _GEN_27; // @[ID.scala 120:49]
  wire [31:0] regs_out_14 = regs__T_28_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_29 = 5'he == addr_rs1 ? regs_out_14 : _GEN_28; // @[ID.scala 120:49]
  wire [31:0] regs_out_15 = regs__T_29_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_30 = 5'hf == addr_rs1 ? regs_out_15 : _GEN_29; // @[ID.scala 120:49]
  wire [31:0] regs_out_16 = regs__T_30_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_31 = 5'h10 == addr_rs1 ? regs_out_16 : _GEN_30; // @[ID.scala 120:49]
  wire [31:0] regs_out_17 = regs__T_31_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_32 = 5'h11 == addr_rs1 ? regs_out_17 : _GEN_31; // @[ID.scala 120:49]
  wire [31:0] regs_out_18 = regs__T_32_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_33 = 5'h12 == addr_rs1 ? regs_out_18 : _GEN_32; // @[ID.scala 120:49]
  wire [31:0] regs_out_19 = regs__T_33_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_34 = 5'h13 == addr_rs1 ? regs_out_19 : _GEN_33; // @[ID.scala 120:49]
  wire [31:0] regs_out_20 = regs__T_34_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_35 = 5'h14 == addr_rs1 ? regs_out_20 : _GEN_34; // @[ID.scala 120:49]
  wire [31:0] regs_out_21 = regs__T_35_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_36 = 5'h15 == addr_rs1 ? regs_out_21 : _GEN_35; // @[ID.scala 120:49]
  wire [31:0] regs_out_22 = regs__T_36_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_37 = 5'h16 == addr_rs1 ? regs_out_22 : _GEN_36; // @[ID.scala 120:49]
  wire [31:0] regs_out_23 = regs__T_37_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_38 = 5'h17 == addr_rs1 ? regs_out_23 : _GEN_37; // @[ID.scala 120:49]
  wire [31:0] regs_out_24 = regs__T_38_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_39 = 5'h18 == addr_rs1 ? regs_out_24 : _GEN_38; // @[ID.scala 120:49]
  wire [31:0] regs_out_25 = regs__T_39_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_40 = 5'h19 == addr_rs1 ? regs_out_25 : _GEN_39; // @[ID.scala 120:49]
  wire [31:0] regs_out_26 = regs__T_40_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_41 = 5'h1a == addr_rs1 ? regs_out_26 : _GEN_40; // @[ID.scala 120:49]
  wire [31:0] regs_out_27 = regs__T_41_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_42 = 5'h1b == addr_rs1 ? regs_out_27 : _GEN_41; // @[ID.scala 120:49]
  wire [31:0] regs_out_28 = regs__T_42_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_43 = 5'h1c == addr_rs1 ? regs_out_28 : _GEN_42; // @[ID.scala 120:49]
  wire [31:0] regs_out_29 = regs__T_43_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_44 = 5'h1d == addr_rs1 ? regs_out_29 : _GEN_43; // @[ID.scala 120:49]
  wire [31:0] regs_out_30 = regs__T_44_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_45 = 5'h1e == addr_rs1 ? regs_out_30 : _GEN_44; // @[ID.scala 120:49]
  wire [31:0] regs_out_31 = regs__T_45_data; // @[ID.scala 113:36 ID.scala 118:61]
  wire [31:0] _GEN_46 = 5'h1f == addr_rs1 ? regs_out_31 : _GEN_45; // @[ID.scala 120:49]
  wire [31:0] _T_49 = _T_48 ? io_rd : _GEN_46; // @[ID.scala 120:49]
  wire [31:0] rs1_r = _T_46 ? _T_49 : 32'h0; // @[ID.scala 120:27]
  wire [4:0] addr_rs2 = deco_io_rs2; // @[ID.scala 70:28 ID.scala 92:17]
  wire  _T_51 = addr_rs2 != 5'h0; // @[ID.scala 121:37]
  wire  _T_52 = addr_rs2 == io_waddr; // @[ID.scala 121:58]
  wire  _T_53 = _T_52 & io_ctrl_wen; // @[ID.scala 121:69]
  wire [31:0] _GEN_48 = 5'h1 == addr_rs2 ? regs_out_1 : 32'h0; // @[ID.scala 121:49]
  wire [31:0] _GEN_49 = 5'h2 == addr_rs2 ? regs_out_2 : _GEN_48; // @[ID.scala 121:49]
  wire [31:0] _GEN_50 = 5'h3 == addr_rs2 ? regs_out_3 : _GEN_49; // @[ID.scala 121:49]
  wire [31:0] _GEN_51 = 5'h4 == addr_rs2 ? regs_out_4 : _GEN_50; // @[ID.scala 121:49]
  wire [31:0] _GEN_52 = 5'h5 == addr_rs2 ? regs_out_5 : _GEN_51; // @[ID.scala 121:49]
  wire [31:0] _GEN_53 = 5'h6 == addr_rs2 ? regs_out_6 : _GEN_52; // @[ID.scala 121:49]
  wire [31:0] _GEN_54 = 5'h7 == addr_rs2 ? regs_out_7 : _GEN_53; // @[ID.scala 121:49]
  wire [31:0] _GEN_55 = 5'h8 == addr_rs2 ? regs_out_8 : _GEN_54; // @[ID.scala 121:49]
  wire [31:0] _GEN_56 = 5'h9 == addr_rs2 ? regs_out_9 : _GEN_55; // @[ID.scala 121:49]
  wire [31:0] _GEN_57 = 5'ha == addr_rs2 ? regs_out_10 : _GEN_56; // @[ID.scala 121:49]
  wire [31:0] _GEN_58 = 5'hb == addr_rs2 ? regs_out_11 : _GEN_57; // @[ID.scala 121:49]
  wire [31:0] _GEN_59 = 5'hc == addr_rs2 ? regs_out_12 : _GEN_58; // @[ID.scala 121:49]
  wire [31:0] _GEN_60 = 5'hd == addr_rs2 ? regs_out_13 : _GEN_59; // @[ID.scala 121:49]
  wire [31:0] _GEN_61 = 5'he == addr_rs2 ? regs_out_14 : _GEN_60; // @[ID.scala 121:49]
  wire [31:0] _GEN_62 = 5'hf == addr_rs2 ? regs_out_15 : _GEN_61; // @[ID.scala 121:49]
  wire [31:0] _GEN_63 = 5'h10 == addr_rs2 ? regs_out_16 : _GEN_62; // @[ID.scala 121:49]
  wire [31:0] _GEN_64 = 5'h11 == addr_rs2 ? regs_out_17 : _GEN_63; // @[ID.scala 121:49]
  wire [31:0] _GEN_65 = 5'h12 == addr_rs2 ? regs_out_18 : _GEN_64; // @[ID.scala 121:49]
  wire [31:0] _GEN_66 = 5'h13 == addr_rs2 ? regs_out_19 : _GEN_65; // @[ID.scala 121:49]
  wire [31:0] _GEN_67 = 5'h14 == addr_rs2 ? regs_out_20 : _GEN_66; // @[ID.scala 121:49]
  wire [31:0] _GEN_68 = 5'h15 == addr_rs2 ? regs_out_21 : _GEN_67; // @[ID.scala 121:49]
  wire [31:0] _GEN_69 = 5'h16 == addr_rs2 ? regs_out_22 : _GEN_68; // @[ID.scala 121:49]
  wire [31:0] _GEN_70 = 5'h17 == addr_rs2 ? regs_out_23 : _GEN_69; // @[ID.scala 121:49]
  wire [31:0] _GEN_71 = 5'h18 == addr_rs2 ? regs_out_24 : _GEN_70; // @[ID.scala 121:49]
  wire [31:0] _GEN_72 = 5'h19 == addr_rs2 ? regs_out_25 : _GEN_71; // @[ID.scala 121:49]
  wire [31:0] _GEN_73 = 5'h1a == addr_rs2 ? regs_out_26 : _GEN_72; // @[ID.scala 121:49]
  wire [31:0] _GEN_74 = 5'h1b == addr_rs2 ? regs_out_27 : _GEN_73; // @[ID.scala 121:49]
  wire [31:0] _GEN_75 = 5'h1c == addr_rs2 ? regs_out_28 : _GEN_74; // @[ID.scala 121:49]
  wire [31:0] _GEN_76 = 5'h1d == addr_rs2 ? regs_out_29 : _GEN_75; // @[ID.scala 121:49]
  wire [31:0] _GEN_77 = 5'h1e == addr_rs2 ? regs_out_30 : _GEN_76; // @[ID.scala 121:49]
  wire [31:0] _GEN_78 = 5'h1f == addr_rs2 ? regs_out_31 : _GEN_77; // @[ID.scala 121:49]
  wire [31:0] _T_54 = _T_53 ? io_rd : _GEN_78; // @[ID.scala 121:49]
  wire [31:0] rs2_r = _T_51 ? _T_54 : 32'h0; // @[ID.scala 121:27]
  wire [31:0] _GEN_80 = 5'h1 == io_RegsAc_reg_addr[4:0] ? regs_out_1 : 32'h0; // @[ID.scala 123:38]
  wire [31:0] _GEN_81 = 5'h2 == io_RegsAc_reg_addr[4:0] ? regs_out_2 : _GEN_80; // @[ID.scala 123:38]
  wire [31:0] _GEN_82 = 5'h3 == io_RegsAc_reg_addr[4:0] ? regs_out_3 : _GEN_81; // @[ID.scala 123:38]
  wire [31:0] _GEN_83 = 5'h4 == io_RegsAc_reg_addr[4:0] ? regs_out_4 : _GEN_82; // @[ID.scala 123:38]
  wire [31:0] _GEN_84 = 5'h5 == io_RegsAc_reg_addr[4:0] ? regs_out_5 : _GEN_83; // @[ID.scala 123:38]
  wire [31:0] _GEN_85 = 5'h6 == io_RegsAc_reg_addr[4:0] ? regs_out_6 : _GEN_84; // @[ID.scala 123:38]
  wire [31:0] _GEN_86 = 5'h7 == io_RegsAc_reg_addr[4:0] ? regs_out_7 : _GEN_85; // @[ID.scala 123:38]
  wire [31:0] _GEN_87 = 5'h8 == io_RegsAc_reg_addr[4:0] ? regs_out_8 : _GEN_86; // @[ID.scala 123:38]
  wire [31:0] _GEN_88 = 5'h9 == io_RegsAc_reg_addr[4:0] ? regs_out_9 : _GEN_87; // @[ID.scala 123:38]
  wire [31:0] _GEN_89 = 5'ha == io_RegsAc_reg_addr[4:0] ? regs_out_10 : _GEN_88; // @[ID.scala 123:38]
  wire [31:0] _GEN_90 = 5'hb == io_RegsAc_reg_addr[4:0] ? regs_out_11 : _GEN_89; // @[ID.scala 123:38]
  wire [31:0] _GEN_91 = 5'hc == io_RegsAc_reg_addr[4:0] ? regs_out_12 : _GEN_90; // @[ID.scala 123:38]
  wire [31:0] _GEN_92 = 5'hd == io_RegsAc_reg_addr[4:0] ? regs_out_13 : _GEN_91; // @[ID.scala 123:38]
  wire [31:0] _GEN_93 = 5'he == io_RegsAc_reg_addr[4:0] ? regs_out_14 : _GEN_92; // @[ID.scala 123:38]
  wire [31:0] _GEN_94 = 5'hf == io_RegsAc_reg_addr[4:0] ? regs_out_15 : _GEN_93; // @[ID.scala 123:38]
  wire [31:0] _GEN_95 = 5'h10 == io_RegsAc_reg_addr[4:0] ? regs_out_16 : _GEN_94; // @[ID.scala 123:38]
  wire [31:0] _GEN_96 = 5'h11 == io_RegsAc_reg_addr[4:0] ? regs_out_17 : _GEN_95; // @[ID.scala 123:38]
  wire [31:0] _GEN_97 = 5'h12 == io_RegsAc_reg_addr[4:0] ? regs_out_18 : _GEN_96; // @[ID.scala 123:38]
  wire [31:0] _GEN_98 = 5'h13 == io_RegsAc_reg_addr[4:0] ? regs_out_19 : _GEN_97; // @[ID.scala 123:38]
  wire [31:0] _GEN_99 = 5'h14 == io_RegsAc_reg_addr[4:0] ? regs_out_20 : _GEN_98; // @[ID.scala 123:38]
  wire [31:0] _GEN_100 = 5'h15 == io_RegsAc_reg_addr[4:0] ? regs_out_21 : _GEN_99; // @[ID.scala 123:38]
  wire [31:0] _GEN_101 = 5'h16 == io_RegsAc_reg_addr[4:0] ? regs_out_22 : _GEN_100; // @[ID.scala 123:38]
  wire [31:0] _GEN_102 = 5'h17 == io_RegsAc_reg_addr[4:0] ? regs_out_23 : _GEN_101; // @[ID.scala 123:38]
  wire [31:0] _GEN_103 = 5'h18 == io_RegsAc_reg_addr[4:0] ? regs_out_24 : _GEN_102; // @[ID.scala 123:38]
  wire [31:0] _GEN_104 = 5'h19 == io_RegsAc_reg_addr[4:0] ? regs_out_25 : _GEN_103; // @[ID.scala 123:38]
  wire [31:0] _GEN_105 = 5'h1a == io_RegsAc_reg_addr[4:0] ? regs_out_26 : _GEN_104; // @[ID.scala 123:38]
  wire [31:0] _GEN_106 = 5'h1b == io_RegsAc_reg_addr[4:0] ? regs_out_27 : _GEN_105; // @[ID.scala 123:38]
  wire [31:0] _GEN_107 = 5'h1c == io_RegsAc_reg_addr[4:0] ? regs_out_28 : _GEN_106; // @[ID.scala 123:38]
  wire [31:0] _GEN_108 = 5'h1d == io_RegsAc_reg_addr[4:0] ? regs_out_29 : _GEN_107; // @[ID.scala 123:38]
  wire [31:0] _GEN_109 = 5'h1e == io_RegsAc_reg_addr[4:0] ? regs_out_30 : _GEN_108; // @[ID.scala 123:38]
  wire [31:0] _GEN_110 = 5'h1f == io_RegsAc_reg_addr[4:0] ? regs_out_31 : _GEN_109; // @[ID.scala 123:38]
  wire  _T_58 = io_ctrl_mux1_select == 2'h1; // @[ID.scala 129:45]
  wire [31:0] _T_60 = {deco_io_imm[31:1],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] op1 = _T_58 ? _T_60 : deco_io_imm; // @[ID.scala 129:25]
  wire [31:0] _T_65 = {rs1_r[31:1],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] op2 = io_ctrl_mux2_select ? _T_65 : io_in_pc; // @[ID.scala 130:25]
  wire [31:0] _T_73 = io_in_pc + 32'h4; // @[ID.scala 135:71]
  InstDeco deco ( // @[ID.scala 76:24]
    .io_instruc(deco_io_instruc),
    .io_rd(deco_io_rd),
    .io_rs1(deco_io_rs1),
    .io_rs2(deco_io_rs2),
    .io_imm(deco_io_imm),
    .io_state(deco_io_state)
  );
  assign regs__T_15_addr = 5'h0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_15_data = regs[regs__T_15_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_15_data = regs__T_15_addr >= 5'h1f ? _RAND_1[31:0] : regs[regs__T_15_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_16_addr = 5'h1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_16_data = regs[regs__T_16_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_16_data = regs__T_16_addr >= 5'h1f ? _RAND_2[31:0] : regs[regs__T_16_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_17_addr = 5'h2;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_17_data = regs[regs__T_17_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_17_data = regs__T_17_addr >= 5'h1f ? _RAND_3[31:0] : regs[regs__T_17_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_18_addr = 5'h3;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_18_data = regs[regs__T_18_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_18_data = regs__T_18_addr >= 5'h1f ? _RAND_4[31:0] : regs[regs__T_18_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_19_addr = 5'h4;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_19_data = regs[regs__T_19_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_19_data = regs__T_19_addr >= 5'h1f ? _RAND_5[31:0] : regs[regs__T_19_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_20_addr = 5'h5;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_20_data = regs[regs__T_20_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_20_data = regs__T_20_addr >= 5'h1f ? _RAND_6[31:0] : regs[regs__T_20_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_21_addr = 5'h6;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_21_data = regs[regs__T_21_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_21_data = regs__T_21_addr >= 5'h1f ? _RAND_7[31:0] : regs[regs__T_21_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_22_addr = 5'h7;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_22_data = regs[regs__T_22_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_22_data = regs__T_22_addr >= 5'h1f ? _RAND_8[31:0] : regs[regs__T_22_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_23_addr = 5'h8;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_23_data = regs[regs__T_23_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_23_data = regs__T_23_addr >= 5'h1f ? _RAND_9[31:0] : regs[regs__T_23_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_24_addr = 5'h9;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_24_data = regs[regs__T_24_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_24_data = regs__T_24_addr >= 5'h1f ? _RAND_10[31:0] : regs[regs__T_24_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_25_addr = 5'ha;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_25_data = regs[regs__T_25_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_25_data = regs__T_25_addr >= 5'h1f ? _RAND_11[31:0] : regs[regs__T_25_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_26_addr = 5'hb;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_26_data = regs[regs__T_26_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_26_data = regs__T_26_addr >= 5'h1f ? _RAND_12[31:0] : regs[regs__T_26_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_27_addr = 5'hc;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_27_data = regs[regs__T_27_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_27_data = regs__T_27_addr >= 5'h1f ? _RAND_13[31:0] : regs[regs__T_27_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_28_addr = 5'hd;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_28_data = regs[regs__T_28_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_28_data = regs__T_28_addr >= 5'h1f ? _RAND_14[31:0] : regs[regs__T_28_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_29_addr = 5'he;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_29_data = regs[regs__T_29_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_29_data = regs__T_29_addr >= 5'h1f ? _RAND_15[31:0] : regs[regs__T_29_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_30_addr = 5'hf;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_30_data = regs[regs__T_30_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_30_data = regs__T_30_addr >= 5'h1f ? _RAND_16[31:0] : regs[regs__T_30_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_31_addr = 5'h10;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_31_data = regs[regs__T_31_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_31_data = regs__T_31_addr >= 5'h1f ? _RAND_17[31:0] : regs[regs__T_31_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_32_addr = 5'h11;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_32_data = regs[regs__T_32_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_32_data = regs__T_32_addr >= 5'h1f ? _RAND_18[31:0] : regs[regs__T_32_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_33_addr = 5'h12;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_33_data = regs[regs__T_33_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_33_data = regs__T_33_addr >= 5'h1f ? _RAND_19[31:0] : regs[regs__T_33_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_34_addr = 5'h13;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_34_data = regs[regs__T_34_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_34_data = regs__T_34_addr >= 5'h1f ? _RAND_20[31:0] : regs[regs__T_34_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_35_addr = 5'h14;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_35_data = regs[regs__T_35_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_35_data = regs__T_35_addr >= 5'h1f ? _RAND_21[31:0] : regs[regs__T_35_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_36_addr = 5'h15;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_36_data = regs[regs__T_36_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_36_data = regs__T_36_addr >= 5'h1f ? _RAND_22[31:0] : regs[regs__T_36_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_37_addr = 5'h16;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_37_data = regs[regs__T_37_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_37_data = regs__T_37_addr >= 5'h1f ? _RAND_23[31:0] : regs[regs__T_37_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_38_addr = 5'h17;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_38_data = regs[regs__T_38_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_38_data = regs__T_38_addr >= 5'h1f ? _RAND_24[31:0] : regs[regs__T_38_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_39_addr = 5'h18;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_39_data = regs[regs__T_39_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_39_data = regs__T_39_addr >= 5'h1f ? _RAND_25[31:0] : regs[regs__T_39_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_40_addr = 5'h19;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_40_data = regs[regs__T_40_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_40_data = regs__T_40_addr >= 5'h1f ? _RAND_26[31:0] : regs[regs__T_40_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_41_addr = 5'h1a;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_41_data = regs[regs__T_41_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_41_data = regs__T_41_addr >= 5'h1f ? _RAND_27[31:0] : regs[regs__T_41_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_42_addr = 5'h1b;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_42_data = regs[regs__T_42_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_42_data = regs__T_42_addr >= 5'h1f ? _RAND_28[31:0] : regs[regs__T_42_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_43_addr = 5'h1c;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_43_data = regs[regs__T_43_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_43_data = regs__T_43_addr >= 5'h1f ? _RAND_29[31:0] : regs[regs__T_43_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_44_addr = 5'h1d;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_44_data = regs[regs__T_44_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_44_data = regs__T_44_addr >= 5'h1f ? _RAND_30[31:0] : regs[regs__T_44_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_45_addr = 5'h1e;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_45_data = regs[regs__T_45_addr]; // @[ID.scala 97:31]
  `else
  assign regs__T_45_data = regs__T_45_addr >= 5'h1f ? _RAND_31[31:0] : regs[regs__T_45_addr]; // @[ID.scala 97:31]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign regs__T_9_data = io_RegsAc_data_w;
  assign regs__T_9_addr = io_RegsAc_reg_addr[4:0] - 5'h1;
  assign regs__T_9_mask = 1'h1;
  assign regs__T_9_en = io_RegsAc_we & GPR_Debug_cond;
  assign regs__T_14_data = io_rd;
  assign regs__T_14_addr = io_waddr - 5'h1;
  assign regs__T_14_mask = 1'h1;
  assign regs__T_14_en = _T_8 ? 1'h0 : _T_11;
  assign io_rs1 = io_ctrl_mux4_select ? rs1_r : io_out_pc; // @[ID.scala 134:23]
  assign io_rs2 = io_ctrl_mux5_select ? rs2_r : _T_73; // @[ID.scala 135:23]
  assign io_ctrl_cmd = deco_io_state; // @[ID.scala 86:20]
  assign io_ctrl_rs1 = deco_io_rs1; // @[ID.scala 87:20]
  assign io_ctrl_rs2 = deco_io_rs2; // @[ID.scala 88:20]
  assign io_imm = deco_io_imm; // @[ID.scala 84:15]
  assign io_out_rd = deco_io_rd; // @[ID.scala 81:18]
  assign io_out_r1 = deco_io_rs1; // @[ID.scala 82:18]
  assign io_out_r2 = deco_io_rs2; // @[ID.scala 83:18]
  assign io_out_pc = op1 + op2; // @[ID.scala 131:26]
  assign io_A = io_in_pc; // @[ID.scala 73:13]
  assign io_RegsAc_data_r = GPR_Debug_cond ? _GEN_110 : 32'h0; // @[ID.scala 123:33]
  assign deco_io_instruc = io_instruction; // @[ID.scala 78:24]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
  _RAND_2 = {1{`RANDOM}};
  _RAND_3 = {1{`RANDOM}};
  _RAND_4 = {1{`RANDOM}};
  _RAND_5 = {1{`RANDOM}};
  _RAND_6 = {1{`RANDOM}};
  _RAND_7 = {1{`RANDOM}};
  _RAND_8 = {1{`RANDOM}};
  _RAND_9 = {1{`RANDOM}};
  _RAND_10 = {1{`RANDOM}};
  _RAND_11 = {1{`RANDOM}};
  _RAND_12 = {1{`RANDOM}};
  _RAND_13 = {1{`RANDOM}};
  _RAND_14 = {1{`RANDOM}};
  _RAND_15 = {1{`RANDOM}};
  _RAND_16 = {1{`RANDOM}};
  _RAND_17 = {1{`RANDOM}};
  _RAND_18 = {1{`RANDOM}};
  _RAND_19 = {1{`RANDOM}};
  _RAND_20 = {1{`RANDOM}};
  _RAND_21 = {1{`RANDOM}};
  _RAND_22 = {1{`RANDOM}};
  _RAND_23 = {1{`RANDOM}};
  _RAND_24 = {1{`RANDOM}};
  _RAND_25 = {1{`RANDOM}};
  _RAND_26 = {1{`RANDOM}};
  _RAND_27 = {1{`RANDOM}};
  _RAND_28 = {1{`RANDOM}};
  _RAND_29 = {1{`RANDOM}};
  _RAND_30 = {1{`RANDOM}};
  _RAND_31 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 31; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(regs__T_9_en & regs__T_9_mask) begin
      regs[regs__T_9_addr] <= regs__T_9_data; // @[ID.scala 97:31]
    end
    if(regs__T_14_en & regs__T_14_mask) begin
      regs[regs__T_14_addr] <= regs__T_14_data; // @[ID.scala 97:31]
    end
  end
endmodule
module ALU(
  input  [4:0]  io_sel,
  input  [31:0] io_in1,
  input  [31:0] io_in2,
  output [31:0] io_out,
  output        io_ans
);
  wire [31:0] shifted = io_in1 >> io_in2[4:0]; // @[ALU.scala 37:19]
  wire [31:0] _T_3 = io_in1 + io_in2; // @[ALU.scala 42:20]
  wire [31:0] _T_5 = io_in1 - io_in2; // @[ALU.scala 47:20]
  wire  _T_6 = 5'h0 == io_sel; // @[Conditional.scala 37:30]
  wire [62:0] _GEN_36 = {{31'd0}, io_in1}; // @[ALU.scala 59:42]
  wire [62:0] _T_8 = _GEN_36 << io_in2[4:0]; // @[ALU.scala 59:42]
  wire  _T_9 = 5'h1 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_12 = 5'h2 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_14 = ~io_in1[31]; // @[ALU.scala 67:46]
  wire [5:0] _GEN_37 = {{1'd0}, io_in2[4:0]}; // @[ALU.scala 68:82]
  wire [5:0] _T_17 = 6'h20 - _GEN_37; // @[ALU.scala 68:82]
  wire [94:0] _T_18 = 95'hffffffff << _T_17; // @[ALU.scala 68:73]
  wire [94:0] _GEN_38 = {{63'd0}, shifted}; // @[ALU.scala 68:55]
  wire [94:0] _T_19 = _GEN_38 | _T_18; // @[ALU.scala 68:55]
  wire [94:0] _GEN_0 = _T_14 ? {{63'd0}, shifted} : _T_19; // @[ALU.scala 67:54]
  wire  _T_20 = 5'h3 == io_sel; // @[Conditional.scala 37:30]
  wire [32:0] totalsum = {{1'd0}, _T_3}; // @[ALU.scala 41:20 ALU.scala 42:10]
  wire  _T_23 = 5'h4 == io_sel; // @[Conditional.scala 37:30]
  wire [32:0] totalsub = {{1'd0}, _T_5}; // @[ALU.scala 46:20 ALU.scala 47:10]
  wire  _T_26 = 5'h5 == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _T_27 = io_in1 ^ io_in2; // @[ALU.scala 82:42]
  wire  _T_28 = 5'h6 == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _T_29 = io_in1 | io_in2; // @[ALU.scala 86:42]
  wire  _T_30 = 5'h7 == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _T_31 = io_in1 & io_in2; // @[ALU.scala 90:42]
  wire  _T_32 = 5'h8 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_35 = $signed(io_in1) < $signed(io_in2); // @[ALU.scala 94:50]
  wire  _T_39 = 5'h9 == io_sel; // @[Conditional.scala 37:30]
  wire  _T_40 = io_in1 < io_in2; // @[ALU.scala 99:46]
  wire  _T_44 = 5'ha == io_sel; // @[Conditional.scala 37:30]
  wire  _T_45 = io_in1 == io_in2; // @[ALU.scala 104:46]
  wire  _T_49 = 5'hb == io_sel; // @[Conditional.scala 37:30]
  wire  _T_51 = _T_45 ? 1'h0 : 1'h1; // @[ALU.scala 109:38]
  wire  _T_54 = 5'hc == io_sel; // @[Conditional.scala 37:30]
  wire  _T_58 = _T_35 ^ 1'h1; // @[ALU.scala 114:75]
  wire  _T_63 = 5'hd == io_sel; // @[Conditional.scala 37:30]
  wire  _T_65 = _T_40 ? 1'h0 : 1'h1; // @[ALU.scala 119:38]
  wire  _T_68 = 5'he == io_sel; // @[Conditional.scala 37:30]
  wire  _T_69 = 5'hf == io_sel; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_1 = _T_69 ? io_in2 : 32'h0; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_2 = _T_68 ? io_in1 : _GEN_1; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_3 = _T_63 ? {{31'd0}, _T_65} : _GEN_2; // @[Conditional.scala 39:67]
  wire  _GEN_4 = _T_63 & _T_65; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_5 = _T_54 ? {{31'd0}, _T_58} : _GEN_3; // @[Conditional.scala 39:67]
  wire  _GEN_6 = _T_54 ? _T_58 : _GEN_4; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_7 = _T_49 ? {{31'd0}, _T_51} : _GEN_5; // @[Conditional.scala 39:67]
  wire  _GEN_8 = _T_49 ? _T_51 : _GEN_6; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_9 = _T_44 ? {{31'd0}, _T_45} : _GEN_7; // @[Conditional.scala 39:67]
  wire  _GEN_10 = _T_44 ? _T_45 : _GEN_8; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_11 = _T_39 ? {{31'd0}, _T_40} : _GEN_9; // @[Conditional.scala 39:67]
  wire  _GEN_12 = _T_39 ? _T_40 : _GEN_10; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_13 = _T_32 ? {{31'd0}, _T_35} : _GEN_11; // @[Conditional.scala 39:67]
  wire  _GEN_14 = _T_32 ? _T_35 : _GEN_12; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_15 = _T_30 ? _T_31 : _GEN_13; // @[Conditional.scala 39:67]
  wire  _GEN_16 = _T_30 ? 1'h0 : _GEN_14; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_17 = _T_28 ? _T_29 : _GEN_15; // @[Conditional.scala 39:67]
  wire  _GEN_18 = _T_28 ? 1'h0 : _GEN_16; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_19 = _T_26 ? _T_27 : _GEN_17; // @[Conditional.scala 39:67]
  wire  _GEN_20 = _T_26 ? 1'h0 : _GEN_18; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_21 = _T_23 ? totalsub[31:0] : _GEN_19; // @[Conditional.scala 39:67]
  wire  _GEN_23 = _T_23 ? 1'h0 : _GEN_20; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_24 = _T_20 ? totalsum[31:0] : _GEN_21; // @[Conditional.scala 39:67]
  wire  _GEN_26 = _T_20 ? 1'h0 : _GEN_23; // @[Conditional.scala 39:67]
  wire [94:0] _GEN_27 = _T_12 ? _GEN_0 : {{63'd0}, _GEN_24}; // @[Conditional.scala 39:67]
  wire  _GEN_29 = _T_12 ? 1'h0 : _GEN_26; // @[Conditional.scala 39:67]
  wire [94:0] _GEN_30 = _T_9 ? {{63'd0}, shifted} : _GEN_27; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_9 ? 1'h0 : _GEN_29; // @[Conditional.scala 39:67]
  wire [94:0] _GEN_33 = _T_6 ? {{32'd0}, _T_8} : _GEN_30; // @[Conditional.scala 40:58]
  assign io_out = _GEN_33[31:0]; // @[ALU.scala 52:8 ALU.scala 59:32 ALU.scala 63:32 ALU.scala 67:63 ALU.scala 68:44 ALU.scala 72:32 ALU.scala 77:32 ALU.scala 82:32 ALU.scala 86:32 ALU.scala 90:32 ALU.scala 94:32 ALU.scala 99:32 ALU.scala 104:32 ALU.scala 109:32 ALU.scala 114:32 ALU.scala 119:32 ALU.scala 123:39 ALU.scala 125:39]
  assign io_ans = _T_6 ? 1'h0 : _GEN_32; // @[ALU.scala 54:8 ALU.scala 95:32 ALU.scala 100:32 ALU.scala 105:32 ALU.scala 110:32 ALU.scala 115:32 ALU.scala 120:32]
endmodule
module EX(
  input  [31:0] io_rs1,
  input  [31:0] io_rs2,
  input  [4:0]  io_in_addr_rd,
  input  [4:0]  io_in_addr_r1,
  input  [4:0]  io_in_addr_r2,
  input  [31:0] io_imm,
  output [31:0] io_out_wr_data,
  input  [31:0] io_fw1,
  input  [31:0] io_fw2,
  output [31:0] io_rd,
  output [4:0]  io_addr_rd,
  input  [4:0]  io_ctrl_alu_sel,
  input  [1:0]  io_ctrl_mux1_select,
  input  [1:0]  io_ctrl_mux2_select,
  input         io_ctrl_mux3_select,
  output [4:0]  io_ctrl_rd_addr,
  output [4:0]  io_ctrl_r1_addr,
  output [4:0]  io_ctrl_r2_addr,
  output        io_ctrl_alu_ans,
  input  [31:0] io_in_pc,
  output [31:0] io_B
);
  wire [4:0] ALU_io_sel; // @[EX.scala 78:24]
  wire [31:0] ALU_io_in1; // @[EX.scala 78:24]
  wire [31:0] ALU_io_in2; // @[EX.scala 78:24]
  wire [31:0] ALU_io_out; // @[EX.scala 78:24]
  wire  ALU_io_ans; // @[EX.scala 78:24]
  wire  _T = io_ctrl_mux1_select == 2'h3; // @[EX.scala 82:43]
  wire  _T_1 = io_ctrl_mux1_select == 2'h2; // @[EX.scala 82:83]
  wire [31:0] _T_2 = _T_1 ? io_fw2 : io_rs1; // @[EX.scala 82:63]
  wire  _T_4 = io_ctrl_mux2_select == 2'h3; // @[EX.scala 85:43]
  wire  _T_5 = io_ctrl_mux2_select == 2'h2; // @[EX.scala 85:83]
  wire [31:0] _T_6 = _T_5 ? io_fw2 : io_rs2; // @[EX.scala 85:63]
  wire [31:0] tmp_in2 = _T_4 ? io_fw1 : _T_6; // @[EX.scala 85:23]
  ALU ALU ( // @[EX.scala 78:24]
    .io_sel(ALU_io_sel),
    .io_in1(ALU_io_in1),
    .io_in2(ALU_io_in2),
    .io_out(ALU_io_out),
    .io_ans(ALU_io_ans)
  );
  assign io_out_wr_data = _T_4 ? io_fw1 : _T_6; // @[EX.scala 103:23]
  assign io_rd = ALU_io_out; // @[EX.scala 102:49]
  assign io_addr_rd = io_in_addr_rd; // @[EX.scala 104:33]
  assign io_ctrl_rd_addr = io_in_addr_rd; // @[EX.scala 107:24]
  assign io_ctrl_r1_addr = io_in_addr_r1; // @[EX.scala 108:24]
  assign io_ctrl_r2_addr = io_in_addr_r2; // @[EX.scala 109:24]
  assign io_ctrl_alu_ans = ALU_io_ans; // @[EX.scala 110:24]
  assign io_B = io_in_pc; // @[EX.scala 72:13]
  assign ALU_io_sel = io_ctrl_alu_sel; // @[EX.scala 79:20]
  assign ALU_io_in1 = _T ? io_fw1 : _T_2; // @[EX.scala 83:20]
  assign ALU_io_in2 = io_ctrl_mux3_select ? tmp_in2 : io_imm; // @[EX.scala 86:20]
endmodule
module MEM(
  input         clock,
  input         reset,
  input  [1:0]  io_ctrl_write,
  input  [2:0]  io_ctrl_read,
  output [4:0]  io_ctrl_rd_addr,
  output        io_ctrl_done,
  input  [4:0]  io_addr_rd,
  input  [31:0] io_in_ALUdata,
  input  [31:0] io_in_data,
  output [4:0]  io_out_addr_rd,
  output [31:0] io_out_ALUdata,
  output [31:0] io_out_data,
  output [31:0] io_out_fwd1,
  input  [31:0] io_IM_addr,
  output [31:0] io_IM_data,
  input         io_debug_halt,
  output        io_IF_halt,
  output        io_imem_abort,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_data_r,
  input         io_imem_ready,
  output        io_dmem_valid,
  output        io_dmem_we,
  output [31:0] io_dmem_addr,
  output [1:0]  io_dmem_size,
  output [31:0] io_dmem_data_w,
  input  [31:0] io_dmem_data_r,
  input         io_dmem_ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  _T = ~io_imem_ready; // @[Mem.scala 54:28]
  reg [31:0] _T_1; // @[Mem.scala 54:67]
  wire  _T_2 = io_IM_addr != _T_1; // @[Mem.scala 54:56]
  wire  _T_6 = io_debug_halt | _T; // @[Mem.scala 60:55]
  wire  _T_8 = io_ctrl_write != 2'h0; // @[Mem.scala 63:34]
  wire  _T_9 = io_ctrl_read != 3'h0; // @[Mem.scala 63:57]
  wire  _T_10 = io_ctrl_read != 3'h6; // @[Mem.scala 63:78]
  wire  _T_11 = _T_9 & _T_10; // @[Mem.scala 63:64]
  wire  _T_12 = io_ctrl_read != 3'h7; // @[Mem.scala 63:99]
  wire  _T_13 = _T_11 & _T_12; // @[Mem.scala 63:85]
  reg [2:0] pre_read; // @[Mem.scala 84:32]
  reg [1:0] addr_LSB_R; // @[Mem.scala 88:32]
  wire  _T_16 = pre_read != io_ctrl_read; // @[Mem.scala 89:23]
  wire  _T_18 = pre_read == 3'h1; // @[Mem.scala 92:22]
  wire [4:0] _T_19 = {addr_LSB_R, 3'h0}; // @[Mem.scala 93:57]
  wire [31:0] _T_20 = io_dmem_data_r >> _T_19; // @[Mem.scala 93:43]
  wire [7:0] _T_22 = _T_20[7:0]; // @[Mem.scala 93:70]
  wire  _T_23 = pre_read == 3'h2; // @[Mem.scala 95:27]
  wire [4:0] _T_25 = {addr_LSB_R[1], 4'h0}; // @[Mem.scala 96:57]
  wire [31:0] _T_26 = io_dmem_data_r >> _T_25; // @[Mem.scala 96:40]
  wire [15:0] _T_28 = _T_26[15:0]; // @[Mem.scala 96:70]
  wire  _T_29 = pre_read == 3'h4; // @[Mem.scala 98:27]
  wire [31:0] _T_34 = {24'h0,_T_20[7:0]}; // @[Mem.scala 99:84]
  wire  _T_35 = pre_read == 3'h5; // @[Mem.scala 101:27]
  wire [31:0] _T_41 = {16'h0,_T_26[15:0]}; // @[Mem.scala 102:85]
  wire  _T_42 = pre_read == 3'h3; // @[Mem.scala 104:27]
  wire [31:0] _GEN_1 = _T_42 ? $signed(io_dmem_data_r) : $signed(32'sh0); // @[Mem.scala 104:34]
  wire [31:0] _GEN_2 = _T_35 ? $signed(_T_41) : $signed(_GEN_1); // @[Mem.scala 101:34]
  wire [31:0] _GEN_3 = _T_29 ? $signed(_T_34) : $signed(_GEN_2); // @[Mem.scala 98:34]
  wire [31:0] _GEN_4 = _T_23 ? $signed({{16{_T_28[15]}},_T_28}) : $signed(_GEN_3); // @[Mem.scala 95:34]
  assign io_ctrl_rd_addr = io_addr_rd; // @[Mem.scala 77:25]
  assign io_ctrl_done = io_dmem_ready; // @[Mem.scala 78:33]
  assign io_out_addr_rd = io_addr_rd; // @[Mem.scala 74:25]
  assign io_out_ALUdata = io_in_ALUdata; // @[Mem.scala 75:25]
  assign io_out_data = _T_18 ? $signed({{24{_T_22[7]}},_T_22}) : $signed(_GEN_4); // @[Mem.scala 93:28 Mem.scala 96:28 Mem.scala 99:28 Mem.scala 102:28 Mem.scala 105:28 Mem.scala 108:28]
  assign io_out_fwd1 = io_in_ALUdata; // @[Mem.scala 76:33]
  assign io_IM_data = _T_6 ? 32'h13 : io_imem_data_r; // @[Mem.scala 60:33]
  assign io_IF_halt = ~io_imem_ready; // @[Mem.scala 59:33]
  assign io_imem_abort = _T & _T_2; // @[Mem.scala 54:25]
  assign io_imem_addr = io_IM_addr; // @[Mem.scala 56:17]
  assign io_dmem_valid = _T_8 | _T_13; // @[Mem.scala 63:17]
  assign io_dmem_we = io_ctrl_write != 2'h0; // @[Mem.scala 66:33]
  assign io_dmem_addr = io_in_ALUdata; // @[Mem.scala 67:17]
  assign io_dmem_size = io_ctrl_write; // @[Mem.scala 68:17]
  assign io_dmem_data_w = io_in_data; // @[Mem.scala 65:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  pre_read = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  addr_LSB_R = _RAND_2[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      _T_1 <= 32'h0;
    end else begin
      _T_1 <= io_IM_addr;
    end
    if (reset) begin
      pre_read <= 3'h0;
    end else begin
      pre_read <= io_ctrl_read;
    end
    if (reset) begin
      addr_LSB_R <= 2'h0;
    end else if (_T_16) begin
      addr_LSB_R <= io_in_ALUdata[1:0];
    end
  end
endmodule
module WB(
  input  [31:0] io_mem_out,
  input  [31:0] io_alu_out,
  input  [4:0]  io_addr_rd,
  output [4:0]  io_out_addr_rd,
  output [31:0] io_out,
  input  [1:0]  io_ctrl_mux1_select,
  output [4:0]  io_ctrl_rd_addr
);
  wire  _T = io_ctrl_mux1_select == 2'h0; // @[WB.scala 39:35]
  wire  _T_1 = io_ctrl_mux1_select == 2'h1; // @[WB.scala 42:40]
  wire [31:0] _GEN_0 = _T_1 ? io_mem_out : 32'h0; // @[WB.scala 42:48]
  assign io_out_addr_rd = io_addr_rd; // @[WB.scala 49:23]
  assign io_out = _T ? io_alu_out : _GEN_0; // @[WB.scala 40:24 WB.scala 43:24 WB.scala 46:24]
  assign io_ctrl_rd_addr = io_addr_rd; // @[WB.scala 51:24]
endmodule
module datapath(
  input         clock,
  input         reset,
  input         io_IF_mux1_select,
  input  [1:0]  io_IF_mux2_select,
  input         io_IF_en,
  input         io_ID_wen,
  output [5:0]  io_ID_cmd,
  output [4:0]  io_ID_rs1,
  output [4:0]  io_ID_rs2,
  input  [1:0]  io_ID_mux1_select,
  input         io_ID_mux2_select,
  input         io_ID_mux4_select,
  input         io_ID_mux5_select,
  input  [4:0]  io_EX_alu_sel,
  input  [1:0]  io_EX_mux1_select,
  input  [1:0]  io_EX_mux2_select,
  input         io_EX_mux3_select,
  output [4:0]  io_EX_rd_addr,
  output [4:0]  io_EX_r1_addr,
  output [4:0]  io_EX_r2_addr,
  output        io_EX_alu_ans,
  input  [1:0]  io_MEM_write,
  input  [2:0]  io_MEM_read,
  output [4:0]  io_MEM_rd_addr,
  output        io_MEM_done,
  input  [1:0]  io_WB_mux1_select,
  output [4:0]  io_WB_rd_addr,
  input         io_PIPE_IF_flush,
  input         io_PIPE_IF_en,
  input         io_PIPE_MEM_WB_stall,
  input         io_PIPE_EX_MEM_stall,
  output        io_imem_abort,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_data_r,
  input         io_imem_ready,
  output        io_dmem_valid,
  output        io_dmem_we,
  output [31:0] io_dmem_addr,
  output [1:0]  io_dmem_size,
  output [31:0] io_dmem_data_w,
  input  [31:0] io_dmem_data_r,
  input         io_dmem_ready,
  input         io_debug_rst,
  input         io_debug_halt,
  input         io_debug_RegsAc_we,
  input  [31:0] io_debug_RegsAc_reg_addr,
  input  [31:0] io_debug_RegsAc_data_w,
  output [31:0] io_debug_RegsAc_data_r,
  input         io_debug_interruption,
  output        io_debug_breakpoint
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  wire  IF_clock; // @[datapath.scala 98:23]
  wire  IF_reset; // @[datapath.scala 98:23]
  wire [31:0] IF_io_in_pc; // @[datapath.scala 98:23]
  wire [31:0] IF_io_out_pc; // @[datapath.scala 98:23]
  wire [31:0] IF_io_A; // @[datapath.scala 98:23]
  wire [31:0] IF_io_B; // @[datapath.scala 98:23]
  wire [31:0] IF_io_instruction; // @[datapath.scala 98:23]
  wire [31:0] IF_io_IM_addr; // @[datapath.scala 98:23]
  wire [31:0] IF_io_IM_data; // @[datapath.scala 98:23]
  wire  IF_io_ctrl_mux1_select; // @[datapath.scala 98:23]
  wire [1:0] IF_io_ctrl_mux2_select; // @[datapath.scala 98:23]
  wire  IF_io_ctrl_en; // @[datapath.scala 98:23]
  wire  IF_io_halt; // @[datapath.scala 98:23]
  wire  IF_io_reset; // @[datapath.scala 98:23]
  wire [31:0] IF_io_mtvec; // @[datapath.scala 98:23]
  wire  IF_io_jtomtvec; // @[datapath.scala 98:23]
  wire  CSR_clock; // @[datapath.scala 103:24]
  wire  CSR_reset; // @[datapath.scala 103:24]
  wire  CSR_io_we; // @[datapath.scala 103:24]
  wire [11:0] CSR_io_addr; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_data_w; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_data_r; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_PC; // @[datapath.scala 103:24]
  wire  CSR_io_interruption; // @[datapath.scala 103:24]
  wire  CSR_io_jtomtvec; // @[datapath.scala 103:24]
  wire  CSR_io_instertbubble; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_OUT_CSR_0; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_OUT_CSR_2; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_OUT_CSR_3; // @[datapath.scala 103:24]
  wire [31:0] CSR_io_OUT_CSR_4; // @[datapath.scala 103:24]
  wire [31:0] breakpoint_io_mstatus; // @[datapath.scala 130:40]
  wire [31:0] breakpoint_io_tdata1; // @[datapath.scala 130:40]
  wire [31:0] breakpoint_io_tdata2; // @[datapath.scala 130:40]
  wire [31:0] breakpoint_io_pc; // @[datapath.scala 130:40]
  wire [31:0] breakpoint_io_ea; // @[datapath.scala 130:40]
  wire  breakpoint_io_bpInterruption; // @[datapath.scala 130:40]
  wire  breakpoint_io_bpHalt; // @[datapath.scala 130:40]
  wire  ID_clock; // @[datapath.scala 141:23]
  wire [31:0] ID_io_rs1; // @[datapath.scala 141:23]
  wire [31:0] ID_io_rs2; // @[datapath.scala 141:23]
  wire [31:0] ID_io_rd; // @[datapath.scala 141:23]
  wire [4:0] ID_io_waddr; // @[datapath.scala 141:23]
  wire  ID_io_ctrl_wen; // @[datapath.scala 141:23]
  wire [5:0] ID_io_ctrl_cmd; // @[datapath.scala 141:23]
  wire [4:0] ID_io_ctrl_rs1; // @[datapath.scala 141:23]
  wire [4:0] ID_io_ctrl_rs2; // @[datapath.scala 141:23]
  wire [1:0] ID_io_ctrl_mux1_select; // @[datapath.scala 141:23]
  wire  ID_io_ctrl_mux2_select; // @[datapath.scala 141:23]
  wire  ID_io_ctrl_mux4_select; // @[datapath.scala 141:23]
  wire  ID_io_ctrl_mux5_select; // @[datapath.scala 141:23]
  wire [31:0] ID_io_instruction; // @[datapath.scala 141:23]
  wire [31:0] ID_io_imm; // @[datapath.scala 141:23]
  wire [4:0] ID_io_out_rd; // @[datapath.scala 141:23]
  wire [4:0] ID_io_out_r1; // @[datapath.scala 141:23]
  wire [4:0] ID_io_out_r2; // @[datapath.scala 141:23]
  wire [31:0] ID_io_in_pc; // @[datapath.scala 141:23]
  wire [31:0] ID_io_out_pc; // @[datapath.scala 141:23]
  wire [31:0] ID_io_A; // @[datapath.scala 141:23]
  wire  ID_io_RegsAc_we; // @[datapath.scala 141:23]
  wire [31:0] ID_io_RegsAc_reg_addr; // @[datapath.scala 141:23]
  wire [31:0] ID_io_RegsAc_data_w; // @[datapath.scala 141:23]
  wire [31:0] ID_io_RegsAc_data_r; // @[datapath.scala 141:23]
  wire [31:0] EX_io_rs1; // @[datapath.scala 182:23]
  wire [31:0] EX_io_rs2; // @[datapath.scala 182:23]
  wire [4:0] EX_io_in_addr_rd; // @[datapath.scala 182:23]
  wire [4:0] EX_io_in_addr_r1; // @[datapath.scala 182:23]
  wire [4:0] EX_io_in_addr_r2; // @[datapath.scala 182:23]
  wire [31:0] EX_io_imm; // @[datapath.scala 182:23]
  wire [31:0] EX_io_out_wr_data; // @[datapath.scala 182:23]
  wire [31:0] EX_io_fw1; // @[datapath.scala 182:23]
  wire [31:0] EX_io_fw2; // @[datapath.scala 182:23]
  wire [31:0] EX_io_rd; // @[datapath.scala 182:23]
  wire [4:0] EX_io_addr_rd; // @[datapath.scala 182:23]
  wire [4:0] EX_io_ctrl_alu_sel; // @[datapath.scala 182:23]
  wire [1:0] EX_io_ctrl_mux1_select; // @[datapath.scala 182:23]
  wire [1:0] EX_io_ctrl_mux2_select; // @[datapath.scala 182:23]
  wire  EX_io_ctrl_mux3_select; // @[datapath.scala 182:23]
  wire [4:0] EX_io_ctrl_rd_addr; // @[datapath.scala 182:23]
  wire [4:0] EX_io_ctrl_r1_addr; // @[datapath.scala 182:23]
  wire [4:0] EX_io_ctrl_r2_addr; // @[datapath.scala 182:23]
  wire  EX_io_ctrl_alu_ans; // @[datapath.scala 182:23]
  wire [31:0] EX_io_in_pc; // @[datapath.scala 182:23]
  wire [31:0] EX_io_B; // @[datapath.scala 182:23]
  wire  MEM_clock; // @[datapath.scala 211:23]
  wire  MEM_reset; // @[datapath.scala 211:23]
  wire [1:0] MEM_io_ctrl_write; // @[datapath.scala 211:23]
  wire [2:0] MEM_io_ctrl_read; // @[datapath.scala 211:23]
  wire [4:0] MEM_io_ctrl_rd_addr; // @[datapath.scala 211:23]
  wire  MEM_io_ctrl_done; // @[datapath.scala 211:23]
  wire [4:0] MEM_io_addr_rd; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_in_ALUdata; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_in_data; // @[datapath.scala 211:23]
  wire [4:0] MEM_io_out_addr_rd; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_out_ALUdata; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_out_data; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_out_fwd1; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_IM_addr; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_IM_data; // @[datapath.scala 211:23]
  wire  MEM_io_debug_halt; // @[datapath.scala 211:23]
  wire  MEM_io_IF_halt; // @[datapath.scala 211:23]
  wire  MEM_io_imem_abort; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_imem_addr; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_imem_data_r; // @[datapath.scala 211:23]
  wire  MEM_io_imem_ready; // @[datapath.scala 211:23]
  wire  MEM_io_dmem_valid; // @[datapath.scala 211:23]
  wire  MEM_io_dmem_we; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_dmem_addr; // @[datapath.scala 211:23]
  wire [1:0] MEM_io_dmem_size; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_dmem_data_w; // @[datapath.scala 211:23]
  wire [31:0] MEM_io_dmem_data_r; // @[datapath.scala 211:23]
  wire  MEM_io_dmem_ready; // @[datapath.scala 211:23]
  wire [31:0] WB_io_mem_out; // @[datapath.scala 249:23]
  wire [31:0] WB_io_alu_out; // @[datapath.scala 249:23]
  wire [4:0] WB_io_addr_rd; // @[datapath.scala 249:23]
  wire [4:0] WB_io_out_addr_rd; // @[datapath.scala 249:23]
  wire [31:0] WB_io_out; // @[datapath.scala 249:23]
  wire [1:0] WB_io_ctrl_mux1_select; // @[datapath.scala 249:23]
  wire [4:0] WB_io_ctrl_rd_addr; // @[datapath.scala 249:23]
  wire  _T_1 = |io_debug_RegsAc_reg_addr[31:12]; // @[datapath.scala 102:70]
  wire  CSR_Debug_cond = ~_T_1; // @[datapath.scala 102:29]
  reg [31:0] IF_ID_instruction; // @[datapath.scala 113:38]
  reg [31:0] IF_ID_out_pc; // @[datapath.scala 114:33]
  wire  _T_4 = ~io_PIPE_IF_en; // @[datapath.scala 121:14]
  wire  breakpointinterruption = breakpoint_io_bpInterruption; // @[datapath.scala 136:40]
  wire  _T_5 = breakpointinterruption | io_debug_interruption; // @[datapath.scala 143:54]
  wire  _T_6 = ID_io_ctrl_cmd == 6'h0; // @[datapath.scala 143:97]
  wire  _T_7 = _T_5 | _T_6; // @[datapath.scala 143:81]
  wire  _T_8 = ~io_debug_halt; // @[datapath.scala 143:125]
  reg [31:0] ID_EX_rs1; // @[datapath.scala 163:30]
  reg [31:0] ID_EX_rs2; // @[datapath.scala 164:30]
  reg [31:0] ID_EX_imm; // @[datapath.scala 165:30]
  reg [4:0] ID_EX_out_rd; // @[datapath.scala 166:33]
  reg [4:0] ID_EX_out_r1; // @[datapath.scala 167:33]
  reg [4:0] ID_EX_out_r2; // @[datapath.scala 168:33]
  reg [31:0] ID_EX_B; // @[datapath.scala 169:28]
  reg [31:0] EX_MEM_rd; // @[datapath.scala 199:30]
  reg [4:0] EX_MEM_addr_rd; // @[datapath.scala 200:35]
  reg [31:0] EX_MEM_wr_data; // @[datapath.scala 201:35]
  wire  _T_12 = ~io_PIPE_EX_MEM_stall; // @[datapath.scala 204:14]
  reg [4:0] MEM_WB_out_addr_rd; // @[datapath.scala 232:39]
  reg [31:0] MEM_WB_out_ALUdata; // @[datapath.scala 233:39]
  IF IF ( // @[datapath.scala 98:23]
    .clock(IF_clock),
    .reset(IF_reset),
    .io_in_pc(IF_io_in_pc),
    .io_out_pc(IF_io_out_pc),
    .io_A(IF_io_A),
    .io_B(IF_io_B),
    .io_instruction(IF_io_instruction),
    .io_IM_addr(IF_io_IM_addr),
    .io_IM_data(IF_io_IM_data),
    .io_ctrl_mux1_select(IF_io_ctrl_mux1_select),
    .io_ctrl_mux2_select(IF_io_ctrl_mux2_select),
    .io_ctrl_en(IF_io_ctrl_en),
    .io_halt(IF_io_halt),
    .io_reset(IF_io_reset),
    .io_mtvec(IF_io_mtvec),
    .io_jtomtvec(IF_io_jtomtvec)
  );
  CSR CSR ( // @[datapath.scala 103:24]
    .clock(CSR_clock),
    .reset(CSR_reset),
    .io_we(CSR_io_we),
    .io_addr(CSR_io_addr),
    .io_data_w(CSR_io_data_w),
    .io_data_r(CSR_io_data_r),
    .io_PC(CSR_io_PC),
    .io_interruption(CSR_io_interruption),
    .io_jtomtvec(CSR_io_jtomtvec),
    .io_instertbubble(CSR_io_instertbubble),
    .io_OUT_CSR_0(CSR_io_OUT_CSR_0),
    .io_OUT_CSR_2(CSR_io_OUT_CSR_2),
    .io_OUT_CSR_3(CSR_io_OUT_CSR_3),
    .io_OUT_CSR_4(CSR_io_OUT_CSR_4)
  );
  breakpoint breakpoint ( // @[datapath.scala 130:40]
    .io_mstatus(breakpoint_io_mstatus),
    .io_tdata1(breakpoint_io_tdata1),
    .io_tdata2(breakpoint_io_tdata2),
    .io_pc(breakpoint_io_pc),
    .io_ea(breakpoint_io_ea),
    .io_bpInterruption(breakpoint_io_bpInterruption),
    .io_bpHalt(breakpoint_io_bpHalt)
  );
  ID ID ( // @[datapath.scala 141:23]
    .clock(ID_clock),
    .io_rs1(ID_io_rs1),
    .io_rs2(ID_io_rs2),
    .io_rd(ID_io_rd),
    .io_waddr(ID_io_waddr),
    .io_ctrl_wen(ID_io_ctrl_wen),
    .io_ctrl_cmd(ID_io_ctrl_cmd),
    .io_ctrl_rs1(ID_io_ctrl_rs1),
    .io_ctrl_rs2(ID_io_ctrl_rs2),
    .io_ctrl_mux1_select(ID_io_ctrl_mux1_select),
    .io_ctrl_mux2_select(ID_io_ctrl_mux2_select),
    .io_ctrl_mux4_select(ID_io_ctrl_mux4_select),
    .io_ctrl_mux5_select(ID_io_ctrl_mux5_select),
    .io_instruction(ID_io_instruction),
    .io_imm(ID_io_imm),
    .io_out_rd(ID_io_out_rd),
    .io_out_r1(ID_io_out_r1),
    .io_out_r2(ID_io_out_r2),
    .io_in_pc(ID_io_in_pc),
    .io_out_pc(ID_io_out_pc),
    .io_A(ID_io_A),
    .io_RegsAc_we(ID_io_RegsAc_we),
    .io_RegsAc_reg_addr(ID_io_RegsAc_reg_addr),
    .io_RegsAc_data_w(ID_io_RegsAc_data_w),
    .io_RegsAc_data_r(ID_io_RegsAc_data_r)
  );
  EX EX ( // @[datapath.scala 182:23]
    .io_rs1(EX_io_rs1),
    .io_rs2(EX_io_rs2),
    .io_in_addr_rd(EX_io_in_addr_rd),
    .io_in_addr_r1(EX_io_in_addr_r1),
    .io_in_addr_r2(EX_io_in_addr_r2),
    .io_imm(EX_io_imm),
    .io_out_wr_data(EX_io_out_wr_data),
    .io_fw1(EX_io_fw1),
    .io_fw2(EX_io_fw2),
    .io_rd(EX_io_rd),
    .io_addr_rd(EX_io_addr_rd),
    .io_ctrl_alu_sel(EX_io_ctrl_alu_sel),
    .io_ctrl_mux1_select(EX_io_ctrl_mux1_select),
    .io_ctrl_mux2_select(EX_io_ctrl_mux2_select),
    .io_ctrl_mux3_select(EX_io_ctrl_mux3_select),
    .io_ctrl_rd_addr(EX_io_ctrl_rd_addr),
    .io_ctrl_r1_addr(EX_io_ctrl_r1_addr),
    .io_ctrl_r2_addr(EX_io_ctrl_r2_addr),
    .io_ctrl_alu_ans(EX_io_ctrl_alu_ans),
    .io_in_pc(EX_io_in_pc),
    .io_B(EX_io_B)
  );
  MEM MEM ( // @[datapath.scala 211:23]
    .clock(MEM_clock),
    .reset(MEM_reset),
    .io_ctrl_write(MEM_io_ctrl_write),
    .io_ctrl_read(MEM_io_ctrl_read),
    .io_ctrl_rd_addr(MEM_io_ctrl_rd_addr),
    .io_ctrl_done(MEM_io_ctrl_done),
    .io_addr_rd(MEM_io_addr_rd),
    .io_in_ALUdata(MEM_io_in_ALUdata),
    .io_in_data(MEM_io_in_data),
    .io_out_addr_rd(MEM_io_out_addr_rd),
    .io_out_ALUdata(MEM_io_out_ALUdata),
    .io_out_data(MEM_io_out_data),
    .io_out_fwd1(MEM_io_out_fwd1),
    .io_IM_addr(MEM_io_IM_addr),
    .io_IM_data(MEM_io_IM_data),
    .io_debug_halt(MEM_io_debug_halt),
    .io_IF_halt(MEM_io_IF_halt),
    .io_imem_abort(MEM_io_imem_abort),
    .io_imem_addr(MEM_io_imem_addr),
    .io_imem_data_r(MEM_io_imem_data_r),
    .io_imem_ready(MEM_io_imem_ready),
    .io_dmem_valid(MEM_io_dmem_valid),
    .io_dmem_we(MEM_io_dmem_we),
    .io_dmem_addr(MEM_io_dmem_addr),
    .io_dmem_size(MEM_io_dmem_size),
    .io_dmem_data_w(MEM_io_dmem_data_w),
    .io_dmem_data_r(MEM_io_dmem_data_r),
    .io_dmem_ready(MEM_io_dmem_ready)
  );
  WB WB ( // @[datapath.scala 249:23]
    .io_mem_out(WB_io_mem_out),
    .io_alu_out(WB_io_alu_out),
    .io_addr_rd(WB_io_addr_rd),
    .io_out_addr_rd(WB_io_out_addr_rd),
    .io_out(WB_io_out),
    .io_ctrl_mux1_select(WB_io_ctrl_mux1_select),
    .io_ctrl_rd_addr(WB_io_ctrl_rd_addr)
  );
  assign io_ID_cmd = ID_io_ctrl_cmd; // @[datapath.scala 160:14]
  assign io_ID_rs1 = ID_io_ctrl_rs1; // @[datapath.scala 160:14]
  assign io_ID_rs2 = ID_io_ctrl_rs2; // @[datapath.scala 160:14]
  assign io_EX_rd_addr = EX_io_ctrl_rd_addr; // @[datapath.scala 196:14]
  assign io_EX_r1_addr = EX_io_ctrl_r1_addr; // @[datapath.scala 196:14]
  assign io_EX_r2_addr = EX_io_ctrl_r2_addr; // @[datapath.scala 196:14]
  assign io_EX_alu_ans = EX_io_ctrl_alu_ans; // @[datapath.scala 196:14]
  assign io_MEM_rd_addr = MEM_io_ctrl_rd_addr; // @[datapath.scala 226:15]
  assign io_MEM_done = MEM_io_ctrl_done; // @[datapath.scala 226:15]
  assign io_WB_rd_addr = WB_io_ctrl_rd_addr; // @[datapath.scala 264:14]
  assign io_imem_abort = MEM_io_imem_abort; // @[datapath.scala 215:18]
  assign io_imem_addr = MEM_io_imem_addr; // @[datapath.scala 215:18]
  assign io_dmem_valid = MEM_io_dmem_valid; // @[datapath.scala 214:18]
  assign io_dmem_we = MEM_io_dmem_we; // @[datapath.scala 214:18]
  assign io_dmem_addr = MEM_io_dmem_addr; // @[datapath.scala 214:18]
  assign io_dmem_size = MEM_io_dmem_size; // @[datapath.scala 214:18]
  assign io_dmem_data_w = MEM_io_dmem_data_w; // @[datapath.scala 214:18]
  assign io_debug_RegsAc_data_r = CSR_Debug_cond ? CSR_io_data_r : ID_io_RegsAc_data_r; // @[datapath.scala 150:31]
  assign io_debug_breakpoint = breakpoint_io_bpHalt; // @[datapath.scala 137:37]
  assign IF_clock = clock;
  assign IF_reset = reset;
  assign IF_io_in_pc = ID_io_out_pc; // @[datapath.scala 157:20]
  assign IF_io_A = ID_io_A; // @[datapath.scala 156:16]
  assign IF_io_B = EX_io_B; // @[datapath.scala 184:16]
  assign IF_io_IM_data = MEM_io_IM_data; // @[datapath.scala 229:18]
  assign IF_io_ctrl_mux1_select = io_IF_mux1_select; // @[datapath.scala 99:14]
  assign IF_io_ctrl_mux2_select = io_IF_mux2_select; // @[datapath.scala 99:14]
  assign IF_io_ctrl_en = io_IF_en; // @[datapath.scala 99:14]
  assign IF_io_halt = io_debug_halt | MEM_io_IF_halt; // @[datapath.scala 213:19]
  assign IF_io_reset = io_debug_rst; // @[datapath.scala 100:20]
  assign IF_io_mtvec = CSR_io_OUT_CSR_3; // @[datapath.scala 110:20]
  assign IF_io_jtomtvec = CSR_io_jtomtvec; // @[datapath.scala 109:23]
  assign CSR_clock = clock;
  assign CSR_reset = reset;
  assign CSR_io_we = CSR_Debug_cond & io_debug_RegsAc_we; // @[datapath.scala 105:41]
  assign CSR_io_addr = io_debug_RegsAc_reg_addr[11:0]; // @[datapath.scala 106:33]
  assign CSR_io_data_w = io_debug_RegsAc_data_w; // @[datapath.scala 107:25]
  assign CSR_io_PC = IF_io_out_pc; // @[datapath.scala 108:41]
  assign CSR_io_interruption = _T_7 & _T_8; // @[datapath.scala 143:28]
  assign breakpoint_io_mstatus = CSR_io_OUT_CSR_2; // @[datapath.scala 131:39]
  assign breakpoint_io_tdata1 = CSR_io_OUT_CSR_0; // @[datapath.scala 132:38]
  assign breakpoint_io_tdata2 = CSR_io_OUT_CSR_4; // @[datapath.scala 133:38]
  assign breakpoint_io_pc = IF_ID_out_pc; // @[datapath.scala 134:34]
  assign breakpoint_io_ea = IF_ID_instruction; // @[datapath.scala 135:34]
  assign ID_clock = clock;
  assign ID_io_rd = WB_io_out; // @[datapath.scala 267:17]
  assign ID_io_waddr = WB_io_out_addr_rd; // @[datapath.scala 266:20]
  assign ID_io_ctrl_wen = io_ID_wen; // @[datapath.scala 160:14]
  assign ID_io_ctrl_mux1_select = io_ID_mux1_select; // @[datapath.scala 160:14]
  assign ID_io_ctrl_mux2_select = io_ID_mux2_select; // @[datapath.scala 160:14]
  assign ID_io_ctrl_mux4_select = io_ID_mux4_select; // @[datapath.scala 160:14]
  assign ID_io_ctrl_mux5_select = io_ID_mux5_select; // @[datapath.scala 160:14]
  assign ID_io_instruction = IF_ID_instruction; // @[datapath.scala 153:26]
  assign ID_io_in_pc = IF_ID_out_pc; // @[datapath.scala 152:20]
  assign ID_io_RegsAc_we = io_debug_RegsAc_we; // @[datapath.scala 146:49]
  assign ID_io_RegsAc_reg_addr = io_debug_RegsAc_reg_addr; // @[datapath.scala 147:31]
  assign ID_io_RegsAc_data_w = io_debug_RegsAc_data_w; // @[datapath.scala 148:41]
  assign EX_io_rs1 = ID_EX_rs1; // @[datapath.scala 187:18]
  assign EX_io_rs2 = ID_EX_rs2; // @[datapath.scala 188:18]
  assign EX_io_in_addr_rd = ID_EX_out_rd; // @[datapath.scala 190:25]
  assign EX_io_in_addr_r1 = ID_EX_out_r1; // @[datapath.scala 191:25]
  assign EX_io_in_addr_r2 = ID_EX_out_r2; // @[datapath.scala 192:25]
  assign EX_io_imm = ID_EX_imm; // @[datapath.scala 189:18]
  assign EX_io_fw1 = MEM_io_out_fwd1; // @[datapath.scala 270:18]
  assign EX_io_fw2 = WB_io_out; // @[datapath.scala 272:18]
  assign EX_io_ctrl_alu_sel = io_EX_alu_sel; // @[datapath.scala 196:14]
  assign EX_io_ctrl_mux1_select = io_EX_mux1_select; // @[datapath.scala 196:14]
  assign EX_io_ctrl_mux2_select = io_EX_mux2_select; // @[datapath.scala 196:14]
  assign EX_io_ctrl_mux3_select = io_EX_mux3_select; // @[datapath.scala 196:14]
  assign EX_io_in_pc = ID_EX_B; // @[datapath.scala 193:20]
  assign MEM_clock = clock;
  assign MEM_reset = reset;
  assign MEM_io_ctrl_write = io_MEM_write; // @[datapath.scala 226:15]
  assign MEM_io_ctrl_read = io_MEM_read; // @[datapath.scala 226:15]
  assign MEM_io_addr_rd = EX_MEM_addr_rd; // @[datapath.scala 223:23]
  assign MEM_io_in_ALUdata = EX_MEM_rd; // @[datapath.scala 218:27]
  assign MEM_io_in_data = EX_MEM_wr_data; // @[datapath.scala 222:24]
  assign MEM_io_IM_addr = IF_io_IM_addr; // @[datapath.scala 229:18]
  assign MEM_io_debug_halt = io_debug_halt; // @[datapath.scala 212:26]
  assign MEM_io_imem_data_r = io_imem_data_r; // @[datapath.scala 215:18]
  assign MEM_io_imem_ready = io_imem_ready; // @[datapath.scala 215:18]
  assign MEM_io_dmem_data_r = io_dmem_data_r; // @[datapath.scala 214:18]
  assign MEM_io_dmem_ready = io_dmem_ready; // @[datapath.scala 214:18]
  assign WB_io_mem_out = MEM_io_out_data; // @[datapath.scala 259:22]
  assign WB_io_alu_out = MEM_WB_out_ALUdata; // @[datapath.scala 261:22]
  assign WB_io_addr_rd = MEM_WB_out_addr_rd; // @[datapath.scala 263:23]
  assign WB_io_ctrl_mux1_select = io_WB_mux1_select; // @[datapath.scala 264:14]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  IF_ID_instruction = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  IF_ID_out_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  ID_EX_rs1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  ID_EX_rs2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  ID_EX_imm = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  ID_EX_out_rd = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  ID_EX_out_r1 = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  ID_EX_out_r2 = _RAND_7[4:0];
  _RAND_8 = {1{`RANDOM}};
  ID_EX_B = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  EX_MEM_rd = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  EX_MEM_addr_rd = _RAND_10[4:0];
  _RAND_11 = {1{`RANDOM}};
  EX_MEM_wr_data = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  MEM_WB_out_addr_rd = _RAND_12[4:0];
  _RAND_13 = {1{`RANDOM}};
  MEM_WB_out_ALUdata = _RAND_13[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      IF_ID_instruction <= 32'h13;
    end else if (!(_T_4)) begin
      if (io_PIPE_IF_flush) begin
        IF_ID_instruction <= 32'h13;
      end else if (CSR_io_instertbubble) begin
        IF_ID_instruction <= 32'h13;
      end else begin
        IF_ID_instruction <= IF_io_instruction;
      end
    end
    if (reset) begin
      IF_ID_out_pc <= 32'h4;
    end else if (!(_T_4)) begin
      IF_ID_out_pc <= IF_io_out_pc;
    end
    if (reset) begin
      ID_EX_rs1 <= 32'h0;
    end else begin
      ID_EX_rs1 <= ID_io_rs1;
    end
    if (reset) begin
      ID_EX_rs2 <= 32'h0;
    end else begin
      ID_EX_rs2 <= ID_io_rs2;
    end
    if (reset) begin
      ID_EX_imm <= 32'sh0;
    end else begin
      ID_EX_imm <= ID_io_imm;
    end
    if (reset) begin
      ID_EX_out_rd <= 5'h0;
    end else begin
      ID_EX_out_rd <= ID_io_out_rd;
    end
    if (reset) begin
      ID_EX_out_r1 <= 5'h0;
    end else begin
      ID_EX_out_r1 <= ID_io_out_r1;
    end
    if (reset) begin
      ID_EX_out_r2 <= 5'h0;
    end else begin
      ID_EX_out_r2 <= ID_io_out_r2;
    end
    if (reset) begin
      ID_EX_B <= 32'h0;
    end else begin
      ID_EX_B <= ID_io_out_pc;
    end
    if (reset) begin
      EX_MEM_rd <= 32'h0;
    end else if (_T_12) begin
      EX_MEM_rd <= EX_io_rd;
    end
    if (reset) begin
      EX_MEM_addr_rd <= 5'h0;
    end else if (_T_12) begin
      EX_MEM_addr_rd <= EX_io_addr_rd;
    end
    if (reset) begin
      EX_MEM_wr_data <= 32'h0;
    end else if (_T_12) begin
      EX_MEM_wr_data <= EX_io_out_wr_data;
    end
    if (reset) begin
      MEM_WB_out_addr_rd <= 5'h0;
    end else if (!(io_PIPE_MEM_WB_stall)) begin
      MEM_WB_out_addr_rd <= MEM_io_out_addr_rd;
    end
    if (reset) begin
      MEM_WB_out_ALUdata <= 32'h0;
    end else begin
      MEM_WB_out_ALUdata <= MEM_io_out_ALUdata;
    end
  end
endmodule
module processor(
  input         clock,
  input         reset,
  output        io_imem_abort,
  output [31:0] io_imem_addr,
  input  [31:0] io_imem_data_r,
  input         io_imem_ready,
  output        io_dmem_valid,
  output        io_dmem_we,
  output [31:0] io_dmem_addr,
  output [1:0]  io_dmem_size,
  output [31:0] io_dmem_data_w,
  input  [31:0] io_dmem_data_r,
  input         io_dmem_ready,
  input         io_debug_rst,
  input         io_debug_halt,
  input         io_debug_RegsAc_we,
  input  [31:0] io_debug_RegsAc_reg_addr,
  input  [31:0] io_debug_RegsAc_data_w,
  output [31:0] io_debug_RegsAc_data_r,
  input         io_debug_interruption,
  output        io_debug_breakpoint
);
  wire  CONTROL_clock; // @[processor.scala 35:29]
  wire  CONTROL_reset; // @[processor.scala 35:29]
  wire  CONTROL_io_IF_mux1_select; // @[processor.scala 35:29]
  wire [1:0] CONTROL_io_IF_mux2_select; // @[processor.scala 35:29]
  wire  CONTROL_io_IF_en; // @[processor.scala 35:29]
  wire  CONTROL_io_ID_wen; // @[processor.scala 35:29]
  wire [5:0] CONTROL_io_ID_cmd; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_ID_rs1; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_ID_rs2; // @[processor.scala 35:29]
  wire [1:0] CONTROL_io_ID_mux1_select; // @[processor.scala 35:29]
  wire  CONTROL_io_ID_mux2_select; // @[processor.scala 35:29]
  wire  CONTROL_io_ID_mux4_select; // @[processor.scala 35:29]
  wire  CONTROL_io_ID_mux5_select; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_EX_alu_sel; // @[processor.scala 35:29]
  wire [1:0] CONTROL_io_EX_mux1_select; // @[processor.scala 35:29]
  wire [1:0] CONTROL_io_EX_mux2_select; // @[processor.scala 35:29]
  wire  CONTROL_io_EX_mux3_select; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_EX_rd_addr; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_EX_r1_addr; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_EX_r2_addr; // @[processor.scala 35:29]
  wire  CONTROL_io_EX_alu_ans; // @[processor.scala 35:29]
  wire [1:0] CONTROL_io_MEM_write; // @[processor.scala 35:29]
  wire [2:0] CONTROL_io_MEM_read; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_MEM_rd_addr; // @[processor.scala 35:29]
  wire  CONTROL_io_MEM_done; // @[processor.scala 35:29]
  wire [1:0] CONTROL_io_WB_mux1_select; // @[processor.scala 35:29]
  wire [4:0] CONTROL_io_WB_rd_addr; // @[processor.scala 35:29]
  wire  CONTROL_io_PIPE_IF_flush; // @[processor.scala 35:29]
  wire  CONTROL_io_PIPE_IF_en; // @[processor.scala 35:29]
  wire  CONTROL_io_PIPE_MEM_WB_stall; // @[processor.scala 35:29]
  wire  CONTROL_io_PIPE_EX_MEM_stall; // @[processor.scala 35:29]
  wire  DATA_clock; // @[processor.scala 36:29]
  wire  DATA_reset; // @[processor.scala 36:29]
  wire  DATA_io_IF_mux1_select; // @[processor.scala 36:29]
  wire [1:0] DATA_io_IF_mux2_select; // @[processor.scala 36:29]
  wire  DATA_io_IF_en; // @[processor.scala 36:29]
  wire  DATA_io_ID_wen; // @[processor.scala 36:29]
  wire [5:0] DATA_io_ID_cmd; // @[processor.scala 36:29]
  wire [4:0] DATA_io_ID_rs1; // @[processor.scala 36:29]
  wire [4:0] DATA_io_ID_rs2; // @[processor.scala 36:29]
  wire [1:0] DATA_io_ID_mux1_select; // @[processor.scala 36:29]
  wire  DATA_io_ID_mux2_select; // @[processor.scala 36:29]
  wire  DATA_io_ID_mux4_select; // @[processor.scala 36:29]
  wire  DATA_io_ID_mux5_select; // @[processor.scala 36:29]
  wire [4:0] DATA_io_EX_alu_sel; // @[processor.scala 36:29]
  wire [1:0] DATA_io_EX_mux1_select; // @[processor.scala 36:29]
  wire [1:0] DATA_io_EX_mux2_select; // @[processor.scala 36:29]
  wire  DATA_io_EX_mux3_select; // @[processor.scala 36:29]
  wire [4:0] DATA_io_EX_rd_addr; // @[processor.scala 36:29]
  wire [4:0] DATA_io_EX_r1_addr; // @[processor.scala 36:29]
  wire [4:0] DATA_io_EX_r2_addr; // @[processor.scala 36:29]
  wire  DATA_io_EX_alu_ans; // @[processor.scala 36:29]
  wire [1:0] DATA_io_MEM_write; // @[processor.scala 36:29]
  wire [2:0] DATA_io_MEM_read; // @[processor.scala 36:29]
  wire [4:0] DATA_io_MEM_rd_addr; // @[processor.scala 36:29]
  wire  DATA_io_MEM_done; // @[processor.scala 36:29]
  wire [1:0] DATA_io_WB_mux1_select; // @[processor.scala 36:29]
  wire [4:0] DATA_io_WB_rd_addr; // @[processor.scala 36:29]
  wire  DATA_io_PIPE_IF_flush; // @[processor.scala 36:29]
  wire  DATA_io_PIPE_IF_en; // @[processor.scala 36:29]
  wire  DATA_io_PIPE_MEM_WB_stall; // @[processor.scala 36:29]
  wire  DATA_io_PIPE_EX_MEM_stall; // @[processor.scala 36:29]
  wire  DATA_io_imem_abort; // @[processor.scala 36:29]
  wire [31:0] DATA_io_imem_addr; // @[processor.scala 36:29]
  wire [31:0] DATA_io_imem_data_r; // @[processor.scala 36:29]
  wire  DATA_io_imem_ready; // @[processor.scala 36:29]
  wire  DATA_io_dmem_valid; // @[processor.scala 36:29]
  wire  DATA_io_dmem_we; // @[processor.scala 36:29]
  wire [31:0] DATA_io_dmem_addr; // @[processor.scala 36:29]
  wire [1:0] DATA_io_dmem_size; // @[processor.scala 36:29]
  wire [31:0] DATA_io_dmem_data_w; // @[processor.scala 36:29]
  wire [31:0] DATA_io_dmem_data_r; // @[processor.scala 36:29]
  wire  DATA_io_dmem_ready; // @[processor.scala 36:29]
  wire  DATA_io_debug_rst; // @[processor.scala 36:29]
  wire  DATA_io_debug_halt; // @[processor.scala 36:29]
  wire  DATA_io_debug_RegsAc_we; // @[processor.scala 36:29]
  wire [31:0] DATA_io_debug_RegsAc_reg_addr; // @[processor.scala 36:29]
  wire [31:0] DATA_io_debug_RegsAc_data_w; // @[processor.scala 36:29]
  wire [31:0] DATA_io_debug_RegsAc_data_r; // @[processor.scala 36:29]
  wire  DATA_io_debug_interruption; // @[processor.scala 36:29]
  wire  DATA_io_debug_breakpoint; // @[processor.scala 36:29]
  Control CONTROL ( // @[processor.scala 35:29]
    .clock(CONTROL_clock),
    .reset(CONTROL_reset),
    .io_IF_mux1_select(CONTROL_io_IF_mux1_select),
    .io_IF_mux2_select(CONTROL_io_IF_mux2_select),
    .io_IF_en(CONTROL_io_IF_en),
    .io_ID_wen(CONTROL_io_ID_wen),
    .io_ID_cmd(CONTROL_io_ID_cmd),
    .io_ID_rs1(CONTROL_io_ID_rs1),
    .io_ID_rs2(CONTROL_io_ID_rs2),
    .io_ID_mux1_select(CONTROL_io_ID_mux1_select),
    .io_ID_mux2_select(CONTROL_io_ID_mux2_select),
    .io_ID_mux4_select(CONTROL_io_ID_mux4_select),
    .io_ID_mux5_select(CONTROL_io_ID_mux5_select),
    .io_EX_alu_sel(CONTROL_io_EX_alu_sel),
    .io_EX_mux1_select(CONTROL_io_EX_mux1_select),
    .io_EX_mux2_select(CONTROL_io_EX_mux2_select),
    .io_EX_mux3_select(CONTROL_io_EX_mux3_select),
    .io_EX_rd_addr(CONTROL_io_EX_rd_addr),
    .io_EX_r1_addr(CONTROL_io_EX_r1_addr),
    .io_EX_r2_addr(CONTROL_io_EX_r2_addr),
    .io_EX_alu_ans(CONTROL_io_EX_alu_ans),
    .io_MEM_write(CONTROL_io_MEM_write),
    .io_MEM_read(CONTROL_io_MEM_read),
    .io_MEM_rd_addr(CONTROL_io_MEM_rd_addr),
    .io_MEM_done(CONTROL_io_MEM_done),
    .io_WB_mux1_select(CONTROL_io_WB_mux1_select),
    .io_WB_rd_addr(CONTROL_io_WB_rd_addr),
    .io_PIPE_IF_flush(CONTROL_io_PIPE_IF_flush),
    .io_PIPE_IF_en(CONTROL_io_PIPE_IF_en),
    .io_PIPE_MEM_WB_stall(CONTROL_io_PIPE_MEM_WB_stall),
    .io_PIPE_EX_MEM_stall(CONTROL_io_PIPE_EX_MEM_stall)
  );
  datapath DATA ( // @[processor.scala 36:29]
    .clock(DATA_clock),
    .reset(DATA_reset),
    .io_IF_mux1_select(DATA_io_IF_mux1_select),
    .io_IF_mux2_select(DATA_io_IF_mux2_select),
    .io_IF_en(DATA_io_IF_en),
    .io_ID_wen(DATA_io_ID_wen),
    .io_ID_cmd(DATA_io_ID_cmd),
    .io_ID_rs1(DATA_io_ID_rs1),
    .io_ID_rs2(DATA_io_ID_rs2),
    .io_ID_mux1_select(DATA_io_ID_mux1_select),
    .io_ID_mux2_select(DATA_io_ID_mux2_select),
    .io_ID_mux4_select(DATA_io_ID_mux4_select),
    .io_ID_mux5_select(DATA_io_ID_mux5_select),
    .io_EX_alu_sel(DATA_io_EX_alu_sel),
    .io_EX_mux1_select(DATA_io_EX_mux1_select),
    .io_EX_mux2_select(DATA_io_EX_mux2_select),
    .io_EX_mux3_select(DATA_io_EX_mux3_select),
    .io_EX_rd_addr(DATA_io_EX_rd_addr),
    .io_EX_r1_addr(DATA_io_EX_r1_addr),
    .io_EX_r2_addr(DATA_io_EX_r2_addr),
    .io_EX_alu_ans(DATA_io_EX_alu_ans),
    .io_MEM_write(DATA_io_MEM_write),
    .io_MEM_read(DATA_io_MEM_read),
    .io_MEM_rd_addr(DATA_io_MEM_rd_addr),
    .io_MEM_done(DATA_io_MEM_done),
    .io_WB_mux1_select(DATA_io_WB_mux1_select),
    .io_WB_rd_addr(DATA_io_WB_rd_addr),
    .io_PIPE_IF_flush(DATA_io_PIPE_IF_flush),
    .io_PIPE_IF_en(DATA_io_PIPE_IF_en),
    .io_PIPE_MEM_WB_stall(DATA_io_PIPE_MEM_WB_stall),
    .io_PIPE_EX_MEM_stall(DATA_io_PIPE_EX_MEM_stall),
    .io_imem_abort(DATA_io_imem_abort),
    .io_imem_addr(DATA_io_imem_addr),
    .io_imem_data_r(DATA_io_imem_data_r),
    .io_imem_ready(DATA_io_imem_ready),
    .io_dmem_valid(DATA_io_dmem_valid),
    .io_dmem_we(DATA_io_dmem_we),
    .io_dmem_addr(DATA_io_dmem_addr),
    .io_dmem_size(DATA_io_dmem_size),
    .io_dmem_data_w(DATA_io_dmem_data_w),
    .io_dmem_data_r(DATA_io_dmem_data_r),
    .io_dmem_ready(DATA_io_dmem_ready),
    .io_debug_rst(DATA_io_debug_rst),
    .io_debug_halt(DATA_io_debug_halt),
    .io_debug_RegsAc_we(DATA_io_debug_RegsAc_we),
    .io_debug_RegsAc_reg_addr(DATA_io_debug_RegsAc_reg_addr),
    .io_debug_RegsAc_data_w(DATA_io_debug_RegsAc_data_w),
    .io_debug_RegsAc_data_r(DATA_io_debug_RegsAc_data_r),
    .io_debug_interruption(DATA_io_debug_interruption),
    .io_debug_breakpoint(DATA_io_debug_breakpoint)
  );
  assign io_imem_abort = DATA_io_imem_abort; // @[processor.scala 50:49]
  assign io_imem_addr = DATA_io_imem_addr; // @[processor.scala 50:49]
  assign io_dmem_valid = DATA_io_dmem_valid; // @[processor.scala 49:33]
  assign io_dmem_we = DATA_io_dmem_we; // @[processor.scala 49:33]
  assign io_dmem_addr = DATA_io_dmem_addr; // @[processor.scala 49:33]
  assign io_dmem_size = DATA_io_dmem_size; // @[processor.scala 49:33]
  assign io_dmem_data_w = DATA_io_dmem_data_w; // @[processor.scala 49:33]
  assign io_debug_RegsAc_data_r = DATA_io_debug_RegsAc_data_r; // @[processor.scala 51:25]
  assign io_debug_breakpoint = DATA_io_debug_breakpoint; // @[processor.scala 51:25]
  assign CONTROL_clock = clock;
  assign CONTROL_reset = reset;
  assign CONTROL_io_ID_cmd = DATA_io_ID_cmd; // @[processor.scala 44:33]
  assign CONTROL_io_ID_rs1 = DATA_io_ID_rs1; // @[processor.scala 44:33]
  assign CONTROL_io_ID_rs2 = DATA_io_ID_rs2; // @[processor.scala 44:33]
  assign CONTROL_io_EX_rd_addr = DATA_io_EX_rd_addr; // @[processor.scala 45:25]
  assign CONTROL_io_EX_r1_addr = DATA_io_EX_r1_addr; // @[processor.scala 45:25]
  assign CONTROL_io_EX_r2_addr = DATA_io_EX_r2_addr; // @[processor.scala 45:25]
  assign CONTROL_io_EX_alu_ans = DATA_io_EX_alu_ans; // @[processor.scala 45:25]
  assign CONTROL_io_MEM_rd_addr = DATA_io_MEM_rd_addr; // @[processor.scala 46:25]
  assign CONTROL_io_MEM_done = DATA_io_MEM_done; // @[processor.scala 46:25]
  assign CONTROL_io_WB_rd_addr = DATA_io_WB_rd_addr; // @[processor.scala 47:33]
  assign DATA_clock = clock;
  assign DATA_reset = reset;
  assign DATA_io_IF_mux1_select = CONTROL_io_IF_mux1_select; // @[processor.scala 43:33]
  assign DATA_io_IF_mux2_select = CONTROL_io_IF_mux2_select; // @[processor.scala 43:33]
  assign DATA_io_IF_en = CONTROL_io_IF_en; // @[processor.scala 43:33]
  assign DATA_io_ID_wen = CONTROL_io_ID_wen; // @[processor.scala 44:33]
  assign DATA_io_ID_mux1_select = CONTROL_io_ID_mux1_select; // @[processor.scala 44:33]
  assign DATA_io_ID_mux2_select = CONTROL_io_ID_mux2_select; // @[processor.scala 44:33]
  assign DATA_io_ID_mux4_select = CONTROL_io_ID_mux4_select; // @[processor.scala 44:33]
  assign DATA_io_ID_mux5_select = CONTROL_io_ID_mux5_select; // @[processor.scala 44:33]
  assign DATA_io_EX_alu_sel = CONTROL_io_EX_alu_sel; // @[processor.scala 45:25]
  assign DATA_io_EX_mux1_select = CONTROL_io_EX_mux1_select; // @[processor.scala 45:25]
  assign DATA_io_EX_mux2_select = CONTROL_io_EX_mux2_select; // @[processor.scala 45:25]
  assign DATA_io_EX_mux3_select = CONTROL_io_EX_mux3_select; // @[processor.scala 45:25]
  assign DATA_io_MEM_write = CONTROL_io_MEM_write; // @[processor.scala 46:25]
  assign DATA_io_MEM_read = CONTROL_io_MEM_read; // @[processor.scala 46:25]
  assign DATA_io_WB_mux1_select = CONTROL_io_WB_mux1_select; // @[processor.scala 47:33]
  assign DATA_io_PIPE_IF_flush = CONTROL_io_PIPE_IF_flush; // @[processor.scala 48:25]
  assign DATA_io_PIPE_IF_en = CONTROL_io_PIPE_IF_en; // @[processor.scala 48:25]
  assign DATA_io_PIPE_MEM_WB_stall = CONTROL_io_PIPE_MEM_WB_stall; // @[processor.scala 48:25]
  assign DATA_io_PIPE_EX_MEM_stall = CONTROL_io_PIPE_EX_MEM_stall; // @[processor.scala 48:25]
  assign DATA_io_imem_data_r = io_imem_data_r; // @[processor.scala 50:49]
  assign DATA_io_imem_ready = io_imem_ready; // @[processor.scala 50:49]
  assign DATA_io_dmem_data_r = io_dmem_data_r; // @[processor.scala 49:33]
  assign DATA_io_dmem_ready = io_dmem_ready; // @[processor.scala 49:33]
  assign DATA_io_debug_rst = io_debug_rst; // @[processor.scala 51:25]
  assign DATA_io_debug_halt = io_debug_halt; // @[processor.scala 51:25]
  assign DATA_io_debug_RegsAc_we = io_debug_RegsAc_we; // @[processor.scala 51:25]
  assign DATA_io_debug_RegsAc_reg_addr = io_debug_RegsAc_reg_addr; // @[processor.scala 51:25]
  assign DATA_io_debug_RegsAc_data_w = io_debug_RegsAc_data_w; // @[processor.scala 51:25]
  assign DATA_io_debug_interruption = io_debug_interruption; // @[processor.scala 51:25]
endmodule
module Ottocore(
  input         clock,
  input         reset,
  output [31:0] io_condor_caddr,
  output        io_condor_cwrite,
  output        io_condor_creq,
  output        io_condor_cvalid,
  output [2:0]  io_condor_csize,
  output [31:0] io_condor_cwdata,
  input  [31:0] io_condor_crdata,
  input         io_condor_cready,
  output [31:0] io_IF_condor_caddr,
  output        io_IF_condor_cwrite,
  output        io_IF_condor_creq,
  output        io_IF_condor_cvalid,
  output [2:0]  io_IF_condor_csize,
  output [31:0] io_IF_condor_cwdata,
  input  [31:0] io_IF_condor_crdata,
  input         io_IF_condor_cready,
  input         io_dma_pmode,
  input  [31:0] io_dma_addr,
  input  [31:0] io_dma_data,
  input         io_dma_we,
  output        io_debug_progBuffAc_we,
  output [31:0] io_debug_progBuffAc_data_w,
  output [31:0] io_debug_progBuffAc_addr_wr,
  input  [31:0] io_debug_progBuffAc_data_r,
  output [31:0] io_debug_progBuffAc_IF_addr,
  input  [31:0] io_debug_progBuffAc_IF_data_r,
  input         io_debug_nPB_rst,
  input         io_debug_nPB_halt,
  input         io_debug_nPB_RegsAc_we,
  input  [31:0] io_debug_nPB_RegsAc_reg_addr,
  input  [31:0] io_debug_nPB_RegsAc_data_w,
  output [31:0] io_debug_nPB_RegsAc_data_r,
  input         io_debug_nPB_interruption,
  output        io_debug_nPB_breakpoint
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  mmu_clock; // @[Ottocore.scala 45:26]
  wire  mmu_reset; // @[Ottocore.scala 45:26]
  wire  mmu_io_IM_abort; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_IM_addr; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_IM_data_r; // @[Ottocore.scala 45:26]
  wire  mmu_io_IM_ready; // @[Ottocore.scala 45:26]
  wire  mmu_io_DM_valid; // @[Ottocore.scala 45:26]
  wire  mmu_io_DM_we; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_DM_addr; // @[Ottocore.scala 45:26]
  wire [1:0] mmu_io_DM_size; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_DM_data_w; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_DM_data_r; // @[Ottocore.scala 45:26]
  wire  mmu_io_DM_ready; // @[Ottocore.scala 45:26]
  wire  mmu_io_dma_pmode; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_dma_addr; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_dma_data; // @[Ottocore.scala 45:26]
  wire  mmu_io_dma_we; // @[Ottocore.scala 45:26]
  wire  mmu_io_progBuffAc_we; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_progBuffAc_data_w; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_progBuffAc_addr_wr; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_progBuffAc_data_r; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_progBuffAc_IF_addr; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_progBuffAc_IF_data_r; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_D_condor_caddr; // @[Ottocore.scala 45:26]
  wire  mmu_io_D_condor_cwrite; // @[Ottocore.scala 45:26]
  wire  mmu_io_D_condor_creq; // @[Ottocore.scala 45:26]
  wire  mmu_io_D_condor_cvalid; // @[Ottocore.scala 45:26]
  wire [2:0] mmu_io_D_condor_csize; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_D_condor_cwdata; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_D_condor_crdata; // @[Ottocore.scala 45:26]
  wire  mmu_io_D_condor_cready; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_I_condor_caddr; // @[Ottocore.scala 45:26]
  wire  mmu_io_I_condor_cwrite; // @[Ottocore.scala 45:26]
  wire  mmu_io_I_condor_creq; // @[Ottocore.scala 45:26]
  wire  mmu_io_I_condor_cvalid; // @[Ottocore.scala 45:26]
  wire [2:0] mmu_io_I_condor_csize; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_I_condor_cwdata; // @[Ottocore.scala 45:26]
  wire [31:0] mmu_io_I_condor_crdata; // @[Ottocore.scala 45:26]
  wire  mmu_io_I_condor_cready; // @[Ottocore.scala 45:26]
  wire  core_clock; // @[Ottocore.scala 46:26]
  wire  core_reset; // @[Ottocore.scala 46:26]
  wire  core_io_imem_abort; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_imem_addr; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_imem_data_r; // @[Ottocore.scala 46:26]
  wire  core_io_imem_ready; // @[Ottocore.scala 46:26]
  wire  core_io_dmem_valid; // @[Ottocore.scala 46:26]
  wire  core_io_dmem_we; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_dmem_addr; // @[Ottocore.scala 46:26]
  wire [1:0] core_io_dmem_size; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_dmem_data_w; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_dmem_data_r; // @[Ottocore.scala 46:26]
  wire  core_io_dmem_ready; // @[Ottocore.scala 46:26]
  wire  core_io_debug_rst; // @[Ottocore.scala 46:26]
  wire  core_io_debug_halt; // @[Ottocore.scala 46:26]
  wire  core_io_debug_RegsAc_we; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_debug_RegsAc_reg_addr; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_debug_RegsAc_data_w; // @[Ottocore.scala 46:26]
  wire [31:0] core_io_debug_RegsAc_data_r; // @[Ottocore.scala 46:26]
  wire  core_io_debug_interruption; // @[Ottocore.scala 46:26]
  wire  core_io_debug_breakpoint; // @[Ottocore.scala 46:26]
  wire  _T_1 = io_debug_nPB_rst | io_dma_pmode; // @[Ottocore.scala 50:59]
  reg  _T_2; // @[Ottocore.scala 50:41]
  MemoryManagementUnit mmu ( // @[Ottocore.scala 45:26]
    .clock(mmu_clock),
    .reset(mmu_reset),
    .io_IM_abort(mmu_io_IM_abort),
    .io_IM_addr(mmu_io_IM_addr),
    .io_IM_data_r(mmu_io_IM_data_r),
    .io_IM_ready(mmu_io_IM_ready),
    .io_DM_valid(mmu_io_DM_valid),
    .io_DM_we(mmu_io_DM_we),
    .io_DM_addr(mmu_io_DM_addr),
    .io_DM_size(mmu_io_DM_size),
    .io_DM_data_w(mmu_io_DM_data_w),
    .io_DM_data_r(mmu_io_DM_data_r),
    .io_DM_ready(mmu_io_DM_ready),
    .io_dma_pmode(mmu_io_dma_pmode),
    .io_dma_addr(mmu_io_dma_addr),
    .io_dma_data(mmu_io_dma_data),
    .io_dma_we(mmu_io_dma_we),
    .io_progBuffAc_we(mmu_io_progBuffAc_we),
    .io_progBuffAc_data_w(mmu_io_progBuffAc_data_w),
    .io_progBuffAc_addr_wr(mmu_io_progBuffAc_addr_wr),
    .io_progBuffAc_data_r(mmu_io_progBuffAc_data_r),
    .io_progBuffAc_IF_addr(mmu_io_progBuffAc_IF_addr),
    .io_progBuffAc_IF_data_r(mmu_io_progBuffAc_IF_data_r),
    .io_D_condor_caddr(mmu_io_D_condor_caddr),
    .io_D_condor_cwrite(mmu_io_D_condor_cwrite),
    .io_D_condor_creq(mmu_io_D_condor_creq),
    .io_D_condor_cvalid(mmu_io_D_condor_cvalid),
    .io_D_condor_csize(mmu_io_D_condor_csize),
    .io_D_condor_cwdata(mmu_io_D_condor_cwdata),
    .io_D_condor_crdata(mmu_io_D_condor_crdata),
    .io_D_condor_cready(mmu_io_D_condor_cready),
    .io_I_condor_caddr(mmu_io_I_condor_caddr),
    .io_I_condor_cwrite(mmu_io_I_condor_cwrite),
    .io_I_condor_creq(mmu_io_I_condor_creq),
    .io_I_condor_cvalid(mmu_io_I_condor_cvalid),
    .io_I_condor_csize(mmu_io_I_condor_csize),
    .io_I_condor_cwdata(mmu_io_I_condor_cwdata),
    .io_I_condor_crdata(mmu_io_I_condor_crdata),
    .io_I_condor_cready(mmu_io_I_condor_cready)
  );
  processor core ( // @[Ottocore.scala 46:26]
    .clock(core_clock),
    .reset(core_reset),
    .io_imem_abort(core_io_imem_abort),
    .io_imem_addr(core_io_imem_addr),
    .io_imem_data_r(core_io_imem_data_r),
    .io_imem_ready(core_io_imem_ready),
    .io_dmem_valid(core_io_dmem_valid),
    .io_dmem_we(core_io_dmem_we),
    .io_dmem_addr(core_io_dmem_addr),
    .io_dmem_size(core_io_dmem_size),
    .io_dmem_data_w(core_io_dmem_data_w),
    .io_dmem_data_r(core_io_dmem_data_r),
    .io_dmem_ready(core_io_dmem_ready),
    .io_debug_rst(core_io_debug_rst),
    .io_debug_halt(core_io_debug_halt),
    .io_debug_RegsAc_we(core_io_debug_RegsAc_we),
    .io_debug_RegsAc_reg_addr(core_io_debug_RegsAc_reg_addr),
    .io_debug_RegsAc_data_w(core_io_debug_RegsAc_data_w),
    .io_debug_RegsAc_data_r(core_io_debug_RegsAc_data_r),
    .io_debug_interruption(core_io_debug_interruption),
    .io_debug_breakpoint(core_io_debug_breakpoint)
  );
  assign io_condor_caddr = mmu_io_D_condor_caddr; // @[Ottocore.scala 57:25]
  assign io_condor_cwrite = mmu_io_D_condor_cwrite; // @[Ottocore.scala 57:25]
  assign io_condor_creq = mmu_io_D_condor_creq; // @[Ottocore.scala 57:25]
  assign io_condor_cvalid = mmu_io_D_condor_cvalid; // @[Ottocore.scala 57:25]
  assign io_condor_csize = mmu_io_D_condor_csize; // @[Ottocore.scala 57:25]
  assign io_condor_cwdata = mmu_io_D_condor_cwdata; // @[Ottocore.scala 57:25]
  assign io_IF_condor_caddr = mmu_io_I_condor_caddr; // @[Ottocore.scala 58:25]
  assign io_IF_condor_cwrite = mmu_io_I_condor_cwrite; // @[Ottocore.scala 58:25]
  assign io_IF_condor_creq = mmu_io_I_condor_creq; // @[Ottocore.scala 58:25]
  assign io_IF_condor_cvalid = mmu_io_I_condor_cvalid; // @[Ottocore.scala 58:25]
  assign io_IF_condor_csize = mmu_io_I_condor_csize; // @[Ottocore.scala 58:25]
  assign io_IF_condor_cwdata = mmu_io_I_condor_cwdata; // @[Ottocore.scala 58:25]
  assign io_debug_progBuffAc_we = mmu_io_progBuffAc_we; // @[Ottocore.scala 61:33]
  assign io_debug_progBuffAc_data_w = mmu_io_progBuffAc_data_w; // @[Ottocore.scala 61:33]
  assign io_debug_progBuffAc_addr_wr = mmu_io_progBuffAc_addr_wr; // @[Ottocore.scala 61:33]
  assign io_debug_progBuffAc_IF_addr = mmu_io_progBuffAc_IF_addr; // @[Ottocore.scala 61:33]
  assign io_debug_nPB_RegsAc_data_r = core_io_debug_RegsAc_data_r; // @[Ottocore.scala 62:22]
  assign io_debug_nPB_breakpoint = core_io_debug_breakpoint; // @[Ottocore.scala 62:22]
  assign mmu_clock = clock;
  assign mmu_reset = reset | _T_2; // @[Ottocore.scala 51:19]
  assign mmu_io_IM_abort = core_io_imem_abort; // @[Ottocore.scala 55:49]
  assign mmu_io_IM_addr = core_io_imem_addr; // @[Ottocore.scala 55:49]
  assign mmu_io_DM_valid = core_io_dmem_valid; // @[Ottocore.scala 56:49]
  assign mmu_io_DM_we = core_io_dmem_we; // @[Ottocore.scala 56:49]
  assign mmu_io_DM_addr = core_io_dmem_addr; // @[Ottocore.scala 56:49]
  assign mmu_io_DM_size = core_io_dmem_size; // @[Ottocore.scala 56:49]
  assign mmu_io_DM_data_w = core_io_dmem_data_w; // @[Ottocore.scala 56:49]
  assign mmu_io_dma_pmode = io_dma_pmode; // @[Ottocore.scala 59:49]
  assign mmu_io_dma_addr = io_dma_addr; // @[Ottocore.scala 59:49]
  assign mmu_io_dma_data = io_dma_data; // @[Ottocore.scala 59:49]
  assign mmu_io_dma_we = io_dma_we; // @[Ottocore.scala 59:49]
  assign mmu_io_progBuffAc_data_r = io_debug_progBuffAc_data_r; // @[Ottocore.scala 61:33]
  assign mmu_io_progBuffAc_IF_data_r = io_debug_progBuffAc_IF_data_r; // @[Ottocore.scala 61:33]
  assign mmu_io_D_condor_crdata = io_condor_crdata; // @[Ottocore.scala 57:25]
  assign mmu_io_D_condor_cready = io_condor_cready; // @[Ottocore.scala 57:25]
  assign mmu_io_I_condor_crdata = io_IF_condor_crdata; // @[Ottocore.scala 58:25]
  assign mmu_io_I_condor_cready = io_IF_condor_cready; // @[Ottocore.scala 58:25]
  assign core_clock = clock;
  assign core_reset = reset | _T_2; // @[Ottocore.scala 52:20]
  assign core_io_imem_data_r = mmu_io_IM_data_r; // @[Ottocore.scala 55:49]
  assign core_io_imem_ready = mmu_io_IM_ready; // @[Ottocore.scala 55:49]
  assign core_io_dmem_data_r = mmu_io_DM_data_r; // @[Ottocore.scala 56:49]
  assign core_io_dmem_ready = mmu_io_DM_ready; // @[Ottocore.scala 56:49]
  assign core_io_debug_rst = io_debug_nPB_rst; // @[Ottocore.scala 62:22]
  assign core_io_debug_halt = io_debug_nPB_halt; // @[Ottocore.scala 62:22]
  assign core_io_debug_RegsAc_we = io_debug_nPB_RegsAc_we; // @[Ottocore.scala 62:22]
  assign core_io_debug_RegsAc_reg_addr = io_debug_nPB_RegsAc_reg_addr; // @[Ottocore.scala 62:22]
  assign core_io_debug_RegsAc_data_w = io_debug_nPB_RegsAc_data_w; // @[Ottocore.scala 62:22]
  assign core_io_debug_interruption = io_debug_nPB_interruption; // @[Ottocore.scala 62:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_2 = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      _T_2 <= 1'h0;
    end else begin
      _T_2 <= _T_1;
    end
  end
endmodule
module JTagStateMachine(
  input   io_TCK,
  input   io_TMS,
  output  io_out_test_logic_reset,
  output  io_out_run_test_idle,
  output  io_out_select_dr_scan,
  output  io_out_capture_dr,
  output  io_out_shift_dr,
  output  io_out_update_dr,
  output  io_out_capture_ir,
  output  io_out_shift_ir,
  output  io_out_update_ir,
  input   io_TRST
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  _T = ~io_TRST; // @[JTagStateMachine.scala 41:27]
  reg [3:0] Nexstate_reg; // @[BlackBoxes.scala 77:24]
  wire  _T_5 = 4'h0 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_6 = ~io_TMS; // @[JTagStateMachine.scala 46:13]
  wire  _T_7 = 4'h1 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_8 = 4'h2 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_9 = 4'h3 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_10 = 4'h4 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_11 = 4'h5 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_12 = 4'h6 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_13 = 4'h7 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_14 = 4'h8 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_15 = 4'h9 == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_16 = 4'ha == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_17 = 4'hb == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_18 = 4'hc == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_19 = 4'hd == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_20 = 4'he == Nexstate_reg; // @[Conditional.scala 37:30]
  wire  _T_21 = 4'hf == Nexstate_reg; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_54 = _T_21 ? 16'h8000 : 16'h0; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_55 = _T_20 ? 16'h4000 : _GEN_54; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_56 = _T_19 ? 16'h2000 : _GEN_55; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_57 = _T_18 ? 16'h1000 : _GEN_56; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_58 = _T_17 ? 16'h800 : _GEN_57; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_59 = _T_16 ? 16'h400 : _GEN_58; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_60 = _T_15 ? 16'h200 : _GEN_59; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_61 = _T_14 ? 16'h100 : _GEN_60; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_62 = _T_13 ? 16'h80 : _GEN_61; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_63 = _T_12 ? 16'h40 : _GEN_62; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_64 = _T_11 ? 16'h20 : _GEN_63; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_65 = _T_10 ? 16'h10 : _GEN_64; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_66 = _T_9 ? 16'h8 : _GEN_65; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_67 = _T_8 ? 16'h4 : _GEN_66; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_68 = _T_7 ? 16'h2 : _GEN_67; // @[Conditional.scala 39:67]
  wire [15:0] inst_outs = _T_5 ? 16'h1 : _GEN_68; // @[Conditional.scala 40:58]
  assign io_out_test_logic_reset = inst_outs[0]; // @[JTagStateMachine.scala 195:25]
  assign io_out_run_test_idle = inst_outs[1]; // @[JTagStateMachine.scala 196:22]
  assign io_out_select_dr_scan = inst_outs[2]; // @[JTagStateMachine.scala 197:23]
  assign io_out_capture_dr = inst_outs[3]; // @[JTagStateMachine.scala 198:19]
  assign io_out_shift_dr = inst_outs[4]; // @[JTagStateMachine.scala 199:17]
  assign io_out_update_dr = inst_outs[8]; // @[JTagStateMachine.scala 203:18]
  assign io_out_capture_ir = inst_outs[10]; // @[JTagStateMachine.scala 205:19]
  assign io_out_shift_ir = inst_outs[11]; // @[JTagStateMachine.scala 206:17]
  assign io_out_update_ir = inst_outs[15]; // @[JTagStateMachine.scala 210:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Nexstate_reg = _RAND_0[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_TCK) begin
    if (_T) begin
      Nexstate_reg <= 4'h0;
    end else if (_T_5) begin
      if (_T_6) begin
        Nexstate_reg <= 4'h1;
      end
    end else if (_T_7) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h2;
      end
    end else if (_T_8) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h9;
      end else begin
        Nexstate_reg <= 4'h3;
      end
    end else if (_T_9) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h5;
      end else begin
        Nexstate_reg <= 4'h4;
      end
    end else if (_T_10) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h5;
      end
    end else if (_T_11) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h8;
      end else begin
        Nexstate_reg <= 4'h6;
      end
    end else if (_T_12) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h7;
      end
    end else if (_T_13) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h8;
      end else begin
        Nexstate_reg <= 4'h4;
      end
    end else if (_T_14) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h2;
      end else begin
        Nexstate_reg <= 4'h1;
      end
    end else if (_T_15) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h0;
      end else begin
        Nexstate_reg <= 4'ha;
      end
    end else if (_T_16) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'hc;
      end else begin
        Nexstate_reg <= 4'hb;
      end
    end else if (_T_17) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'hc;
      end
    end else if (_T_18) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'hf;
      end else begin
        Nexstate_reg <= 4'hd;
      end
    end else if (_T_19) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'he;
      end
    end else if (_T_20) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'hf;
      end else begin
        Nexstate_reg <= 4'hb;
      end
    end else if (_T_21) begin
      if (io_TMS) begin
        Nexstate_reg <= 4'h2;
      end else begin
        Nexstate_reg <= 4'h1;
      end
    end
  end
endmodule
module InstReg(
  input        reset,
  input        io_TCK,
  input        io_TDI_in,
  input        io_JtagState_test_logic_reset,
  input        io_JtagState_capture_ir,
  input        io_JtagState_shift_ir,
  input        io_JtagState_update_ir,
  output [3:0] io_JtagRegLatched,
  output       io_InstRegister
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] JtagIR1; // @[BlackBoxes.scala 77:24]
  wire  _T_3 = io_JtagState_test_logic_reset | io_JtagState_update_ir; // @[JTag.scala 84:64]
  wire  _T_5 = ~io_TCK; // @[BlackBoxes.scala 76:23]
  reg [3:0] JtagIR; // @[BlackBoxes.scala 77:24]
  wire [3:0] _T_7 = {io_TDI_in,JtagIR1[3:1]}; // @[Cat.scala 29:58]
  reg  io_instreg; // @[Reg.scala 15:16]
  assign io_JtagRegLatched = JtagIR; // @[JTag.scala 98:35]
  assign io_InstRegister = io_instreg; // @[JTag.scala 93:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  JtagIR1 = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  JtagIR = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  io_instreg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    JtagIR1 = 4'h0;
  end
  if (reset) begin
    JtagIR = 4'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge _T_5) begin
    io_instreg <= JtagIR1[0];
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      JtagIR1 <= 4'h0;
    end else if (io_JtagState_test_logic_reset) begin
      JtagIR1 <= 4'h0;
    end else if (io_JtagState_capture_ir) begin
      JtagIR1 <= 4'h1;
    end else if (io_JtagState_shift_ir) begin
      JtagIR1 <= _T_7;
    end
  end
  always @(posedge _T_5 or posedge reset) begin
    if (reset) begin
      JtagIR <= 4'h0;
    end else if (_T_3) begin
      if (io_JtagState_test_logic_reset) begin
        JtagIR <= 4'h2;
      end else if (io_JtagState_update_ir) begin
        JtagIR <= JtagIR1;
      end else begin
        JtagIR <= 4'h0;
      end
    end
  end
endmodule
module DataReg(
  input         reset,
  input         io_TCK,
  input         io_TDI_in,
  input         io_JtagState_test_logic_reset,
  input         io_JtagState_run_test_idle,
  input         io_JtagState_select_dr_scan,
  input         io_JtagState_capture_dr,
  input         io_JtagState_shift_dr,
  input         io_JtagState_update_dr,
  input  [3:0]  io_JtagReg,
  output        io_SerialOut,
  output [43:0] io_DMIout,
  input         io_dmstatuscontrol_DM_actived,
  input         io_dmstatuscontrol_Halted,
  input         io_dmstatuscontrol_Reseted,
  input         io_dmstatuscontrol_PcMode,
  input  [4:0]  io_dmstatuscontrol_PBCellsProg,
  input  [4:0]  io_dmstatuscontrol_AHBTrans,
  input  [5:0]  io_dmstatuscontrol_DMTotalAcess,
  output        io_dmstatuscontrol_ResetDM,
  output        io_dmstatuscontrol_ClearProB,
  output        io_dmstatuscontrol_ClearAHBcells,
  output        io_dmstatuscontrol_ResetCounters,
  input  [33:0] io_DMIin
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [63:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] RInst; // @[Reg.scala 15:16]
  reg [6:0] Rcounter; // @[BlackBoxes.scala 77:24]
  reg  Bypass_reg; // @[BlackBoxes.scala 77:24]
  reg [31:0] Idcode_reg; // @[BlackBoxes.scala 77:24]
  reg [43:0] DMIaccess_reg; // @[BlackBoxes.scala 77:24]
  reg [31:0] DMStatusControl_reg; // @[BlackBoxes.scala 77:24]
  reg [31:0] DMStatusControl_reg_real; // @[BlackBoxes.scala 77:24]
  reg [3:0] DMScontrol; // @[BlackBoxes.scala 77:24]
  reg [33:0] dmiresponse_reg; // @[BlackBoxes.scala 77:24]
  wire  _T_20 = ~io_TCK; // @[BlackBoxes.scala 87:31]
  reg [33:0] dmiDataResponse_reg; // @[BlackBoxes.scala 88:24]
  reg  Bypass_reg_serial; // @[Reg.scala 15:16]
  reg  Idcode_reg_serial; // @[Reg.scala 15:16]
  reg  DMIaccess_reg_serial; // @[Reg.scala 15:16]
  reg  DMStatusControl_reg_serial; // @[Reg.scala 15:16]
  reg  DMIResponse_Serial; // @[Reg.scala 15:16]
  reg [3:0] DataRegSel; // @[Reg.scala 15:16]
  wire  _T_40 = io_JtagState_update_dr & DataRegSel[2]; // @[JTag.scala 156:88]
  wire  _T_41 = io_JtagState_test_logic_reset | _T_40; // @[JTag.scala 156:59]
  reg [43:0] DMI_OUT; // @[Reg.scala 15:16]
  wire  _T_46 = DMI_OUT[1:0] == 2'h2; // @[JTag.scala 161:21]
  wire  _T_47 = RInst != io_JtagReg; // @[JTag.scala 166:17]
  wire  _T_49 = io_JtagReg == 4'hf; // @[JTag.scala 171:26]
  wire  _T_50 = io_JtagReg == 4'h2; // @[JTag.scala 172:30]
  wire  _T_51 = io_JtagReg == 4'h8; // @[JTag.scala 173:30]
  wire  _T_52 = io_JtagReg == 4'h9; // @[JTag.scala 174:30]
  wire [6:0] _T_58 = Rcounter + 7'h1; // @[JTag.scala 183:53]
  wire  _T_59 = Rcounter <= 7'h2b; // @[JTag.scala 186:17]
  wire  _T_60 = Rcounter >= 7'h1; // @[JTag.scala 190:19]
  wire  _T_61 = Rcounter <= 7'h23; // @[JTag.scala 190:40]
  wire  _T_62 = _T_60 & _T_61; // @[JTag.scala 190:27]
  wire  _T_63 = Rcounter <= 7'h1f; // @[JTag.scala 193:27]
  wire  _T_65 = io_JtagState_capture_dr & DataRegSel[1]; // @[JTag.scala 200:45]
  wire  _T_67 = io_JtagState_shift_dr & DataRegSel[1]; // @[JTag.scala 202:43]
  wire [31:0] _T_69 = {io_TDI_in,Idcode_reg[31:1]}; // @[Cat.scala 29:58]
  wire  _T_71 = io_JtagState_capture_dr & DataRegSel[0]; // @[JTag.scala 213:46]
  wire  _T_73 = io_JtagState_shift_dr & DataRegSel[0]; // @[JTag.scala 215:44]
  wire  _T_75 = io_JtagState_capture_dr & DataRegSel[2]; // @[JTag.scala 225:46]
  wire  _T_77 = io_JtagState_shift_dr & DataRegSel[2]; // @[JTag.scala 228:44]
  wire  _T_78 = _T_77 & _T_59; // @[JTag.scala 228:72]
  wire [43:0] _T_80 = {io_TDI_in,DMIaccess_reg[43:1]}; // @[Cat.scala 29:58]
  wire  _T_83 = _T_75 & _T_46; // @[JTag.scala 236:74]
  wire  _T_86 = _T_77 & _T_62; // @[JTag.scala 238:72]
  wire [33:0] _T_89 = {dmiresponse_reg[0],dmiresponse_reg[33:1]}; // @[Cat.scala 29:58]
  wire [7:0] _T_93 = {io_dmstatuscontrol_PcMode,io_dmstatuscontrol_Reseted,io_dmstatuscontrol_Halted,io_dmstatuscontrol_DM_actived,4'h1}; // @[Cat.scala 29:58]
  wire [30:0] _T_99 = {DMScontrol,1'h1,2'h0,io_dmstatuscontrol_DMTotalAcess,io_dmstatuscontrol_AHBTrans,io_dmstatuscontrol_PBCellsProg,_T_93}; // @[Cat.scala 29:58]
  wire  _T_100 = io_JtagState_test_logic_reset | io_JtagState_run_test_idle; // @[JTag.scala 249:41]
  wire  _T_101 = _T_100 | io_JtagState_select_dr_scan; // @[JTag.scala 249:73]
  wire  _T_103 = io_JtagState_capture_dr & DataRegSel[3]; // @[JTag.scala 251:39]
  wire  _T_105 = io_JtagState_shift_dr & DataRegSel[3]; // @[JTag.scala 253:39]
  wire  _T_106 = _T_105 & _T_63; // @[JTag.scala 253:67]
  wire [31:0] _T_108 = {io_TDI_in,DMStatusControl_reg[31:1]}; // @[Cat.scala 29:58]
  wire  _T_110 = io_JtagState_update_dr & DataRegSel[3]; // @[JTag.scala 255:40]
  wire  _T_119 = ~_T_46; // @[JTag.scala 275:61]
  wire  _T_120 = _T_51 & _T_119; // @[JTag.scala 275:57]
  wire  _T_122 = _T_51 & _T_46; // @[JTag.scala 276:57]
  wire  _GEN_38 = _T_52 ? DMStatusControl_reg_serial : Bypass_reg_serial; // @[JTag.scala 277:55]
  wire  _GEN_39 = _T_122 ? DMIResponse_Serial : _GEN_38; // @[JTag.scala 276:72]
  wire  _GEN_40 = _T_120 ? DMIaccess_reg_serial : _GEN_39; // @[JTag.scala 275:73]
  wire  _GEN_41 = _T_50 ? Idcode_reg_serial : _GEN_40; // @[JTag.scala 274:51]
  assign io_SerialOut = _T_49 ? Bypass_reg_serial : _GEN_41; // @[JTag.scala 273:62 JTag.scala 274:65 JTag.scala 275:87 JTag.scala 276:86 JTag.scala 277:69 JTag.scala 278:33]
  assign io_DMIout = DMI_OUT; // @[JTag.scala 232:19]
  assign io_dmstatuscontrol_ResetDM = DMScontrol[0]; // @[JTag.scala 259:30]
  assign io_dmstatuscontrol_ClearProB = DMScontrol[1]; // @[JTag.scala 260:32]
  assign io_dmstatuscontrol_ClearAHBcells = DMScontrol[2]; // @[JTag.scala 261:36]
  assign io_dmstatuscontrol_ResetCounters = DMScontrol[3]; // @[JTag.scala 262:36]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RInst = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  Rcounter = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  Bypass_reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  Idcode_reg = _RAND_3[31:0];
  _RAND_4 = {2{`RANDOM}};
  DMIaccess_reg = _RAND_4[43:0];
  _RAND_5 = {1{`RANDOM}};
  DMStatusControl_reg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  DMStatusControl_reg_real = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  DMScontrol = _RAND_7[3:0];
  _RAND_8 = {2{`RANDOM}};
  dmiresponse_reg = _RAND_8[33:0];
  _RAND_9 = {2{`RANDOM}};
  dmiDataResponse_reg = _RAND_9[33:0];
  _RAND_10 = {1{`RANDOM}};
  Bypass_reg_serial = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  Idcode_reg_serial = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  DMIaccess_reg_serial = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  DMStatusControl_reg_serial = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  DMIResponse_Serial = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  DataRegSel = _RAND_15[3:0];
  _RAND_16 = {2{`RANDOM}};
  DMI_OUT = _RAND_16[43:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    Rcounter = 7'h0;
  end
  if (reset) begin
    Bypass_reg = 1'h0;
  end
  if (reset) begin
    Idcode_reg = 32'h0;
  end
  if (reset) begin
    DMIaccess_reg = 44'h0;
  end
  if (reset) begin
    DMStatusControl_reg = 32'h0;
  end
  if (reset) begin
    DMStatusControl_reg_real = 32'h0;
  end
  if (reset) begin
    DMScontrol = 4'h0;
  end
  if (reset) begin
    dmiresponse_reg = 34'h0;
  end
  if (reset) begin
    dmiDataResponse_reg = 34'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_TCK) begin
    RInst <= io_JtagReg;
    if (_T_47) begin
      if (_T_49) begin
        DataRegSel <= 4'h1;
      end else if (_T_50) begin
        DataRegSel <= 4'h2;
      end else if (_T_51) begin
        DataRegSel <= 4'h4;
      end else if (_T_52) begin
        DataRegSel <= 4'h8;
      end else begin
        DataRegSel <= 4'h2;
      end
    end
  end
  always @(posedge _T_20) begin
    Bypass_reg_serial <= Bypass_reg;
    Idcode_reg_serial <= Idcode_reg[0];
    DMIaccess_reg_serial <= DMIaccess_reg[43];
    DMStatusControl_reg_serial <= DMStatusControl_reg[0];
    DMIResponse_Serial <= dmiresponse_reg[0];
    if (_T_41) begin
      DMI_OUT <= DMIaccess_reg;
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      Rcounter <= 7'h0;
    end else if (io_JtagState_shift_dr) begin
      Rcounter <= _T_58;
    end else begin
      Rcounter <= 7'h0;
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      Bypass_reg <= 1'h0;
    end else if (io_JtagState_test_logic_reset) begin
      Bypass_reg <= 1'h0;
    end else if (_T_71) begin
      Bypass_reg <= 1'h0;
    end else if (_T_73) begin
      Bypass_reg <= io_TDI_in;
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      Idcode_reg <= 32'h0;
    end else if (io_JtagState_test_logic_reset) begin
      Idcode_reg <= 32'h10000001;
    end else if (_T_65) begin
      Idcode_reg <= 32'h10000001;
    end else if (_T_67) begin
      Idcode_reg <= _T_69;
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      DMIaccess_reg <= 44'h0;
    end else if (io_JtagState_test_logic_reset) begin
      DMIaccess_reg <= 44'h0;
    end else if (_T_75) begin
      DMIaccess_reg <= {{10'd0}, dmiDataResponse_reg};
    end else if (_T_78) begin
      DMIaccess_reg <= _T_80;
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      DMStatusControl_reg <= 32'h0;
    end else if (!(_T_101)) begin
      if (_T_103) begin
        DMStatusControl_reg <= DMStatusControl_reg_real;
      end else if (_T_106) begin
        DMStatusControl_reg <= _T_108;
      end
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      DMStatusControl_reg_real <= 32'h0;
    end else begin
      DMStatusControl_reg_real <= {{1'd0}, _T_99};
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      DMScontrol <= 4'h0;
    end else if (_T_101) begin
      DMScontrol <= 4'h0;
    end else if (!(_T_103)) begin
      if (!(_T_106)) begin
        if (_T_110) begin
          DMScontrol <= DMStatusControl_reg[31:28];
        end
      end
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      dmiresponse_reg <= 34'h0;
    end else if (io_JtagState_test_logic_reset) begin
      dmiresponse_reg <= 34'h0;
    end else if (_T_83) begin
      dmiresponse_reg <= dmiDataResponse_reg;
    end else if (_T_86) begin
      dmiresponse_reg <= _T_89;
    end
  end
  always @(posedge _T_20 or posedge reset) begin
    if (reset) begin
      dmiDataResponse_reg <= 34'h0;
    end else if (io_DMIin[0]) begin
      dmiDataResponse_reg <= io_DMIin;
    end
  end
endmodule
module BoundaryScanCell(
  input   io_Sin,
  input   io_IN,
  input   io_ShiftDR,
  input   io_Mode,
  input   io_ClockDR,
  input   io_EnableDR,
  input   io_UpdateDR,
  output  io_Sout,
  output  io_OUT
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  QAreg; // @[Reg.scala 15:16]
  reg  QBreg; // @[Reg.scala 15:16]
  assign io_Sout = QAreg; // @[BoundaryScanCell.scala 24:17]
  assign io_OUT = io_Mode ? QBreg : io_IN; // @[BoundaryScanCell.scala 25:16]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  QAreg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  QBreg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_ClockDR) begin
    if (io_EnableDR) begin
      if (io_ShiftDR) begin
        QAreg <= io_Sin;
      end else begin
        QAreg <= io_IN;
      end
    end
    if (io_UpdateDR) begin
      QBreg <= QAreg;
    end
  end
endmodule
module BoundaryScanReg(
  input        reset,
  input        io_TCK,
  input        io_TDI_in,
  input        io_JtagState_test_logic_reset,
  input        io_JtagState_capture_dr,
  input        io_JtagState_shift_dr,
  input        io_JtagState_update_dr,
  input  [3:0] io_JtagReg,
  input        io_pincontrol_core_0_PE,
  input        io_pincontrol_core_0_IE,
  input        io_pincontrol_core_0_DS,
  input        io_pincontrol_core_0_I,
  input        io_pincontrol_core_0_OEN,
  output       io_pincontrol_core_0_C,
  input        io_pincontrol_core_1_PE,
  input        io_pincontrol_core_1_IE,
  input        io_pincontrol_core_1_DS,
  input        io_pincontrol_core_1_I,
  input        io_pincontrol_core_1_OEN,
  output       io_pincontrol_core_1_C,
  output       io_pincontrol_IO_0_PE,
  output       io_pincontrol_IO_0_IE,
  output       io_pincontrol_IO_0_DS,
  output       io_pincontrol_IO_0_I,
  output       io_pincontrol_IO_0_OEN,
  input        io_pincontrol_IO_0_C,
  output       io_pincontrol_IO_1_PE,
  output       io_pincontrol_IO_1_IE,
  output       io_pincontrol_IO_1_DS,
  output       io_pincontrol_IO_1_I,
  output       io_pincontrol_IO_1_OEN,
  input        io_pincontrol_IO_1_C,
  output       io_SerialOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  BoundaryScanCell_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_1_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_2_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_3_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_4_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_5_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_6_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_7_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_8_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_9_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_10_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_Sin; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_IN; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_ShiftDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_Mode; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_ClockDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_EnableDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_UpdateDR; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_Sout; // @[BoundaryScanRegister.scala 100:51]
  wire  BoundaryScanCell_11_io_OUT; // @[BoundaryScanRegister.scala 100:51]
  reg  ChainOUtreg; // @[Reg.scala 15:16]
  wire  BSRgCells_11_Sout = BoundaryScanCell_11_io_Sout; // @[BoundaryScanRegister.scala 100:24 BoundaryScanRegister.scala 100:24]
  wire  _GEN_13 = io_JtagState_shift_dr & BSRgCells_11_Sout; // @[BoundaryScanRegister.scala 207:44]
  wire  _T_3 = ~io_TCK; // @[BlackBoxes.scala 53:31]
  reg  BS_reg_serial; // @[Reg.scala 15:16]
  reg  ShiftDR; // @[BlackBoxes.scala 88:24]
  reg [31:0] rcounter_BS; // @[BlackBoxes.scala 77:24]
  wire [31:0] _T_13 = rcounter_BS + 32'h1; // @[BoundaryScanRegister.scala 70:51]
  wire  _T_14 = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 77:46]
  wire  _T_15 = io_JtagReg == 4'h1; // @[BoundaryScanRegister.scala 77:82]
  wire  _T_16 = _T_14 | _T_15; // @[BoundaryScanRegister.scala 77:68]
  wire  _T_17 = io_JtagState_capture_dr & _T_16; // @[BoundaryScanRegister.scala 77:31]
  wire  _T_18 = rcounter_BS <= 32'hc; // @[BoundaryScanRegister.scala 78:46]
  wire  _T_19 = io_JtagState_shift_dr & _T_18; // @[BoundaryScanRegister.scala 78:33]
  wire  _T_23 = _T_19 & _T_16; // @[BoundaryScanRegister.scala 78:63]
  wire  _GEN_15 = _T_15 & BS_reg_serial; // @[BoundaryScanRegister.scala 216:59]
  BoundaryScanCell BoundaryScanCell ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_io_Sin),
    .io_IN(BoundaryScanCell_io_IN),
    .io_ShiftDR(BoundaryScanCell_io_ShiftDR),
    .io_Mode(BoundaryScanCell_io_Mode),
    .io_ClockDR(BoundaryScanCell_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_io_UpdateDR),
    .io_Sout(BoundaryScanCell_io_Sout),
    .io_OUT(BoundaryScanCell_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_1 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_1_io_Sin),
    .io_IN(BoundaryScanCell_1_io_IN),
    .io_ShiftDR(BoundaryScanCell_1_io_ShiftDR),
    .io_Mode(BoundaryScanCell_1_io_Mode),
    .io_ClockDR(BoundaryScanCell_1_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_1_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_1_io_UpdateDR),
    .io_Sout(BoundaryScanCell_1_io_Sout),
    .io_OUT(BoundaryScanCell_1_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_2 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_2_io_Sin),
    .io_IN(BoundaryScanCell_2_io_IN),
    .io_ShiftDR(BoundaryScanCell_2_io_ShiftDR),
    .io_Mode(BoundaryScanCell_2_io_Mode),
    .io_ClockDR(BoundaryScanCell_2_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_2_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_2_io_UpdateDR),
    .io_Sout(BoundaryScanCell_2_io_Sout),
    .io_OUT(BoundaryScanCell_2_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_3 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_3_io_Sin),
    .io_IN(BoundaryScanCell_3_io_IN),
    .io_ShiftDR(BoundaryScanCell_3_io_ShiftDR),
    .io_Mode(BoundaryScanCell_3_io_Mode),
    .io_ClockDR(BoundaryScanCell_3_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_3_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_3_io_UpdateDR),
    .io_Sout(BoundaryScanCell_3_io_Sout),
    .io_OUT(BoundaryScanCell_3_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_4 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_4_io_Sin),
    .io_IN(BoundaryScanCell_4_io_IN),
    .io_ShiftDR(BoundaryScanCell_4_io_ShiftDR),
    .io_Mode(BoundaryScanCell_4_io_Mode),
    .io_ClockDR(BoundaryScanCell_4_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_4_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_4_io_UpdateDR),
    .io_Sout(BoundaryScanCell_4_io_Sout),
    .io_OUT(BoundaryScanCell_4_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_5 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_5_io_Sin),
    .io_IN(BoundaryScanCell_5_io_IN),
    .io_ShiftDR(BoundaryScanCell_5_io_ShiftDR),
    .io_Mode(BoundaryScanCell_5_io_Mode),
    .io_ClockDR(BoundaryScanCell_5_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_5_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_5_io_UpdateDR),
    .io_Sout(BoundaryScanCell_5_io_Sout),
    .io_OUT(BoundaryScanCell_5_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_6 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_6_io_Sin),
    .io_IN(BoundaryScanCell_6_io_IN),
    .io_ShiftDR(BoundaryScanCell_6_io_ShiftDR),
    .io_Mode(BoundaryScanCell_6_io_Mode),
    .io_ClockDR(BoundaryScanCell_6_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_6_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_6_io_UpdateDR),
    .io_Sout(BoundaryScanCell_6_io_Sout),
    .io_OUT(BoundaryScanCell_6_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_7 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_7_io_Sin),
    .io_IN(BoundaryScanCell_7_io_IN),
    .io_ShiftDR(BoundaryScanCell_7_io_ShiftDR),
    .io_Mode(BoundaryScanCell_7_io_Mode),
    .io_ClockDR(BoundaryScanCell_7_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_7_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_7_io_UpdateDR),
    .io_Sout(BoundaryScanCell_7_io_Sout),
    .io_OUT(BoundaryScanCell_7_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_8 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_8_io_Sin),
    .io_IN(BoundaryScanCell_8_io_IN),
    .io_ShiftDR(BoundaryScanCell_8_io_ShiftDR),
    .io_Mode(BoundaryScanCell_8_io_Mode),
    .io_ClockDR(BoundaryScanCell_8_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_8_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_8_io_UpdateDR),
    .io_Sout(BoundaryScanCell_8_io_Sout),
    .io_OUT(BoundaryScanCell_8_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_9 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_9_io_Sin),
    .io_IN(BoundaryScanCell_9_io_IN),
    .io_ShiftDR(BoundaryScanCell_9_io_ShiftDR),
    .io_Mode(BoundaryScanCell_9_io_Mode),
    .io_ClockDR(BoundaryScanCell_9_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_9_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_9_io_UpdateDR),
    .io_Sout(BoundaryScanCell_9_io_Sout),
    .io_OUT(BoundaryScanCell_9_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_10 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_10_io_Sin),
    .io_IN(BoundaryScanCell_10_io_IN),
    .io_ShiftDR(BoundaryScanCell_10_io_ShiftDR),
    .io_Mode(BoundaryScanCell_10_io_Mode),
    .io_ClockDR(BoundaryScanCell_10_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_10_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_10_io_UpdateDR),
    .io_Sout(BoundaryScanCell_10_io_Sout),
    .io_OUT(BoundaryScanCell_10_io_OUT)
  );
  BoundaryScanCell BoundaryScanCell_11 ( // @[BoundaryScanRegister.scala 100:51]
    .io_Sin(BoundaryScanCell_11_io_Sin),
    .io_IN(BoundaryScanCell_11_io_IN),
    .io_ShiftDR(BoundaryScanCell_11_io_ShiftDR),
    .io_Mode(BoundaryScanCell_11_io_Mode),
    .io_ClockDR(BoundaryScanCell_11_io_ClockDR),
    .io_EnableDR(BoundaryScanCell_11_io_EnableDR),
    .io_UpdateDR(BoundaryScanCell_11_io_UpdateDR),
    .io_Sout(BoundaryScanCell_11_io_Sout),
    .io_OUT(BoundaryScanCell_11_io_OUT)
  );
  assign io_pincontrol_core_0_C = BoundaryScanCell_5_io_OUT; // @[BoundaryScanRegister.scala 173:31]
  assign io_pincontrol_core_1_C = BoundaryScanCell_11_io_OUT; // @[BoundaryScanRegister.scala 173:31]
  assign io_pincontrol_IO_0_PE = BoundaryScanCell_1_io_OUT; // @[BoundaryScanRegister.scala 117:32]
  assign io_pincontrol_IO_0_IE = BoundaryScanCell_3_io_OUT; // @[BoundaryScanRegister.scala 115:32]
  assign io_pincontrol_IO_0_DS = BoundaryScanCell_io_OUT; // @[BoundaryScanRegister.scala 118:32]
  assign io_pincontrol_IO_0_I = BoundaryScanCell_4_io_OUT; // @[BoundaryScanRegister.scala 114:31]
  assign io_pincontrol_IO_0_OEN = BoundaryScanCell_2_io_OUT; // @[BoundaryScanRegister.scala 116:33]
  assign io_pincontrol_IO_1_PE = BoundaryScanCell_7_io_OUT; // @[BoundaryScanRegister.scala 117:32]
  assign io_pincontrol_IO_1_IE = BoundaryScanCell_9_io_OUT; // @[BoundaryScanRegister.scala 115:32]
  assign io_pincontrol_IO_1_DS = BoundaryScanCell_6_io_OUT; // @[BoundaryScanRegister.scala 118:32]
  assign io_pincontrol_IO_1_I = BoundaryScanCell_10_io_OUT; // @[BoundaryScanRegister.scala 114:31]
  assign io_pincontrol_IO_1_OEN = BoundaryScanCell_8_io_OUT; // @[BoundaryScanRegister.scala 116:33]
  assign io_SerialOut = _T_14 ? BS_reg_serial : _GEN_15; // @[BoundaryScanRegister.scala 215:62 BoundaryScanRegister.scala 216:73 BoundaryScanRegister.scala 217:33]
  assign BoundaryScanCell_io_Sin = io_TDI_in; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_io_IN = io_pincontrol_core_0_DS; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_Sin = BoundaryScanCell_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_IN = io_pincontrol_core_0_PE; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_1_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_Sin = BoundaryScanCell_1_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_IN = io_pincontrol_core_0_OEN; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_2_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_Sin = BoundaryScanCell_2_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_IN = io_pincontrol_core_0_IE; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_3_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_Sin = BoundaryScanCell_3_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_IN = io_pincontrol_core_0_I; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_4_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_Sin = BoundaryScanCell_4_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_IN = io_pincontrol_IO_0_C; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_5_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_Sin = BoundaryScanCell_5_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_IN = io_pincontrol_core_1_DS; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_6_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_Sin = BoundaryScanCell_6_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_IN = io_pincontrol_core_1_PE; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_7_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_Sin = BoundaryScanCell_7_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_IN = io_pincontrol_core_1_OEN; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_8_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_Sin = BoundaryScanCell_8_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_IN = io_pincontrol_core_1_IE; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_9_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_Sin = BoundaryScanCell_9_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_IN = io_pincontrol_core_1_I; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_10_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_Sin = BoundaryScanCell_10_io_Sout; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_IN = io_pincontrol_IO_1_C; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_ShiftDR = ShiftDR; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_Mode = io_JtagReg == 4'h4; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_ClockDR = io_TCK; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_EnableDR = _T_17 | _T_23; // @[BoundaryScanRegister.scala 100:24]
  assign BoundaryScanCell_11_io_UpdateDR = io_JtagState_update_dr & _T_16; // @[BoundaryScanRegister.scala 100:24]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ChainOUtreg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  BS_reg_serial = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  ShiftDR = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rcounter_BS = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    ShiftDR = 1'h0;
  end
  if (reset) begin
    rcounter_BS = 32'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_TCK) begin
    if (io_JtagState_test_logic_reset) begin
      ChainOUtreg <= 1'h0;
    end else begin
      ChainOUtreg <= _GEN_13;
    end
  end
  always @(posedge _T_3) begin
    BS_reg_serial <= ChainOUtreg;
  end
  always @(posedge _T_3 or posedge reset) begin
    if (reset) begin
      ShiftDR <= 1'h0;
    end else begin
      ShiftDR <= io_JtagState_shift_dr & _T_16;
    end
  end
  always @(posedge io_TCK or posedge reset) begin
    if (reset) begin
      rcounter_BS <= 32'h0;
    end else if (io_JtagState_shift_dr) begin
      rcounter_BS <= _T_13;
    end else begin
      rcounter_BS <= 32'h0;
    end
  end
endmodule
module JTag_TAP(
  input         reset,
  input         io_TMS,
  input         io_TCK,
  input         io_TDI,
  input         io_TRSTn,
  output        io_TDO,
  input         io_PinCTRL_CORE_0_PE,
  input         io_PinCTRL_CORE_0_IE,
  input         io_PinCTRL_CORE_0_DS,
  input         io_PinCTRL_CORE_0_I,
  input         io_PinCTRL_CORE_0_OEN,
  output        io_PinCTRL_CORE_0_C,
  input         io_PinCTRL_CORE_1_PE,
  input         io_PinCTRL_CORE_1_IE,
  input         io_PinCTRL_CORE_1_DS,
  input         io_PinCTRL_CORE_1_I,
  input         io_PinCTRL_CORE_1_OEN,
  output        io_PinCTRL_CORE_1_C,
  output        io_PinCTRL_IO_0_PE,
  output        io_PinCTRL_IO_0_IE,
  output        io_PinCTRL_IO_0_DS,
  output        io_PinCTRL_IO_0_I,
  output        io_PinCTRL_IO_0_OEN,
  input         io_PinCTRL_IO_0_C,
  output        io_PinCTRL_IO_1_PE,
  output        io_PinCTRL_IO_1_IE,
  output        io_PinCTRL_IO_1_DS,
  output        io_PinCTRL_IO_1_I,
  output        io_PinCTRL_IO_1_OEN,
  input         io_PinCTRL_IO_1_C,
  input         io_dmi_req_ready,
  output        io_dmi_req_valid,
  output [1:0]  io_dmi_req_bits_op,
  output [9:0]  io_dmi_req_bits_addr,
  output [31:0] io_dmi_req_bits_data,
  input         io_dmi_resp_valid,
  input  [31:0] io_dmi_resp_bits_data,
  input         io_dmstatuscontrol_DM_actived,
  input         io_dmstatuscontrol_Halted,
  input         io_dmstatuscontrol_Reseted,
  input         io_dmstatuscontrol_PcMode,
  input  [4:0]  io_dmstatuscontrol_PBCellsProg,
  input  [4:0]  io_dmstatuscontrol_AHBTrans,
  input  [5:0]  io_dmstatuscontrol_DMTotalAcess,
  output        io_dmstatuscontrol_ResetDM,
  output        io_dmstatuscontrol_ClearProB,
  output        io_dmstatuscontrol_ClearAHBcells,
  output        io_dmstatuscontrol_ResetCounters
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  JTagFSM_io_TCK; // @[JTag.scala 309:23]
  wire  JTagFSM_io_TMS; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_test_logic_reset; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_run_test_idle; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_select_dr_scan; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_capture_dr; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_shift_dr; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_update_dr; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_capture_ir; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_shift_ir; // @[JTag.scala 309:23]
  wire  JTagFSM_io_out_update_ir; // @[JTag.scala 309:23]
  wire  JTagFSM_io_TRST; // @[JTag.scala 309:23]
  wire  InstReg_reset; // @[JTag.scala 310:38]
  wire  InstReg_io_TCK; // @[JTag.scala 310:38]
  wire  InstReg_io_TDI_in; // @[JTag.scala 310:38]
  wire  InstReg_io_JtagState_test_logic_reset; // @[JTag.scala 310:38]
  wire  InstReg_io_JtagState_capture_ir; // @[JTag.scala 310:38]
  wire  InstReg_io_JtagState_shift_ir; // @[JTag.scala 310:38]
  wire  InstReg_io_JtagState_update_ir; // @[JTag.scala 310:38]
  wire [3:0] InstReg_io_JtagRegLatched; // @[JTag.scala 310:38]
  wire  InstReg_io_InstRegister; // @[JTag.scala 310:38]
  wire  DataReg_reset; // @[JTag.scala 311:38]
  wire  DataReg_io_TCK; // @[JTag.scala 311:38]
  wire  DataReg_io_TDI_in; // @[JTag.scala 311:38]
  wire  DataReg_io_JtagState_test_logic_reset; // @[JTag.scala 311:38]
  wire  DataReg_io_JtagState_run_test_idle; // @[JTag.scala 311:38]
  wire  DataReg_io_JtagState_select_dr_scan; // @[JTag.scala 311:38]
  wire  DataReg_io_JtagState_capture_dr; // @[JTag.scala 311:38]
  wire  DataReg_io_JtagState_shift_dr; // @[JTag.scala 311:38]
  wire  DataReg_io_JtagState_update_dr; // @[JTag.scala 311:38]
  wire [3:0] DataReg_io_JtagReg; // @[JTag.scala 311:38]
  wire  DataReg_io_SerialOut; // @[JTag.scala 311:38]
  wire [43:0] DataReg_io_DMIout; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_DM_actived; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_Halted; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_Reseted; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_PcMode; // @[JTag.scala 311:38]
  wire [4:0] DataReg_io_dmstatuscontrol_PBCellsProg; // @[JTag.scala 311:38]
  wire [4:0] DataReg_io_dmstatuscontrol_AHBTrans; // @[JTag.scala 311:38]
  wire [5:0] DataReg_io_dmstatuscontrol_DMTotalAcess; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_ResetDM; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_ClearProB; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_ClearAHBcells; // @[JTag.scala 311:38]
  wire  DataReg_io_dmstatuscontrol_ResetCounters; // @[JTag.scala 311:38]
  wire [33:0] DataReg_io_DMIin; // @[JTag.scala 311:38]
  wire  BoundaryScanRegister_reset; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_TCK; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_TDI_in; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_JtagState_test_logic_reset; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_JtagState_capture_dr; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_JtagState_shift_dr; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_JtagState_update_dr; // @[JTag.scala 312:51]
  wire [3:0] BoundaryScanRegister_io_JtagReg; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_0_PE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_0_IE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_0_DS; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_0_I; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_0_OEN; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_0_C; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_1_PE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_1_IE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_1_DS; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_1_I; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_1_OEN; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_core_1_C; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_0_PE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_0_IE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_0_DS; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_0_I; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_0_OEN; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_0_C; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_1_PE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_1_IE; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_1_DS; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_1_I; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_1_OEN; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_pincontrol_IO_1_C; // @[JTag.scala 312:51]
  wire  BoundaryScanRegister_io_SerialOut; // @[JTag.scala 312:51]
  wire  Tristate_ctrl; // @[JTag.scala 405:24]
  wire  Tristate_in; // @[JTag.scala 405:24]
  wire  Tristate_out; // @[JTag.scala 405:24]
  wire  _T_1 = ~io_TRSTn; // @[JTag.scala 307:32]
  wire  data_dmi_0 = DataReg_io_DMIout[12]; // @[JTag.scala 354:37]
  wire  data_dmi_1 = DataReg_io_DMIout[13]; // @[JTag.scala 354:37]
  wire  data_dmi_2 = DataReg_io_DMIout[14]; // @[JTag.scala 354:37]
  wire  data_dmi_3 = DataReg_io_DMIout[15]; // @[JTag.scala 354:37]
  wire  data_dmi_4 = DataReg_io_DMIout[16]; // @[JTag.scala 354:37]
  wire  data_dmi_5 = DataReg_io_DMIout[17]; // @[JTag.scala 354:37]
  wire  data_dmi_6 = DataReg_io_DMIout[18]; // @[JTag.scala 354:37]
  wire  data_dmi_7 = DataReg_io_DMIout[19]; // @[JTag.scala 354:37]
  wire  data_dmi_8 = DataReg_io_DMIout[20]; // @[JTag.scala 354:37]
  wire  data_dmi_9 = DataReg_io_DMIout[21]; // @[JTag.scala 354:37]
  wire  data_dmi_10 = DataReg_io_DMIout[22]; // @[JTag.scala 354:37]
  wire  data_dmi_11 = DataReg_io_DMIout[23]; // @[JTag.scala 354:37]
  wire  data_dmi_12 = DataReg_io_DMIout[24]; // @[JTag.scala 354:37]
  wire  data_dmi_13 = DataReg_io_DMIout[25]; // @[JTag.scala 354:37]
  wire  data_dmi_14 = DataReg_io_DMIout[26]; // @[JTag.scala 354:37]
  wire  data_dmi_15 = DataReg_io_DMIout[27]; // @[JTag.scala 354:37]
  wire  data_dmi_16 = DataReg_io_DMIout[28]; // @[JTag.scala 354:37]
  wire  data_dmi_17 = DataReg_io_DMIout[29]; // @[JTag.scala 354:37]
  wire  data_dmi_18 = DataReg_io_DMIout[30]; // @[JTag.scala 354:37]
  wire  data_dmi_19 = DataReg_io_DMIout[31]; // @[JTag.scala 354:37]
  wire  data_dmi_20 = DataReg_io_DMIout[32]; // @[JTag.scala 354:37]
  wire  data_dmi_21 = DataReg_io_DMIout[33]; // @[JTag.scala 354:37]
  wire  data_dmi_22 = DataReg_io_DMIout[34]; // @[JTag.scala 354:37]
  wire  data_dmi_23 = DataReg_io_DMIout[35]; // @[JTag.scala 354:37]
  wire  data_dmi_24 = DataReg_io_DMIout[36]; // @[JTag.scala 354:37]
  wire  data_dmi_25 = DataReg_io_DMIout[37]; // @[JTag.scala 354:37]
  wire  data_dmi_26 = DataReg_io_DMIout[38]; // @[JTag.scala 354:37]
  wire  data_dmi_27 = DataReg_io_DMIout[39]; // @[JTag.scala 354:37]
  wire  data_dmi_28 = DataReg_io_DMIout[40]; // @[JTag.scala 354:37]
  wire  data_dmi_29 = DataReg_io_DMIout[41]; // @[JTag.scala 354:37]
  wire  data_dmi_30 = DataReg_io_DMIout[42]; // @[JTag.scala 354:37]
  wire  data_dmi_31 = DataReg_io_DMIout[43]; // @[JTag.scala 354:37]
  wire  addr_dmi_0 = DataReg_io_DMIout[2]; // @[JTag.scala 357:37]
  wire  addr_dmi_1 = DataReg_io_DMIout[3]; // @[JTag.scala 357:37]
  wire  addr_dmi_2 = DataReg_io_DMIout[4]; // @[JTag.scala 357:37]
  wire  addr_dmi_3 = DataReg_io_DMIout[5]; // @[JTag.scala 357:37]
  wire  addr_dmi_4 = DataReg_io_DMIout[6]; // @[JTag.scala 357:37]
  wire  addr_dmi_5 = DataReg_io_DMIout[7]; // @[JTag.scala 357:37]
  wire  addr_dmi_6 = DataReg_io_DMIout[8]; // @[JTag.scala 357:37]
  wire  addr_dmi_7 = DataReg_io_DMIout[9]; // @[JTag.scala 357:37]
  wire  addr_dmi_8 = DataReg_io_DMIout[10]; // @[JTag.scala 357:37]
  wire  addr_dmi_9 = DataReg_io_DMIout[11]; // @[JTag.scala 357:37]
  wire  op_dmi_0 = DataReg_io_DMIout[0]; // @[JTag.scala 359:33]
  wire  op_dmi_1 = DataReg_io_DMIout[1]; // @[JTag.scala 360:33]
  wire  _T_48 = InstReg_io_JtagRegLatched == 4'h8; // @[JTag.scala 364:58]
  wire  _T_49 = io_dmi_req_ready & _T_48; // @[JTag.scala 364:28]
  wire  _T_50 = _T_49 & JTagFSM_io_out_update_dr; // @[JTag.scala 364:85]
  wire [7:0] _T_57 = {data_dmi_7,data_dmi_6,data_dmi_5,data_dmi_4,data_dmi_3,data_dmi_2,data_dmi_1,data_dmi_0}; // @[JTag.scala 365:30]
  wire [15:0] _T_65 = {data_dmi_15,data_dmi_14,data_dmi_13,data_dmi_12,data_dmi_11,data_dmi_10,data_dmi_9,data_dmi_8,_T_57}; // @[JTag.scala 365:30]
  wire [7:0] _T_72 = {data_dmi_23,data_dmi_22,data_dmi_21,data_dmi_20,data_dmi_19,data_dmi_18,data_dmi_17,data_dmi_16}; // @[JTag.scala 365:30]
  wire [31:0] _T_81 = {data_dmi_31,data_dmi_30,data_dmi_29,data_dmi_28,data_dmi_27,data_dmi_26,data_dmi_25,data_dmi_24,_T_72,_T_65}; // @[JTag.scala 365:30]
  wire [9:0] _T_90 = {addr_dmi_9,addr_dmi_8,addr_dmi_7,addr_dmi_6,addr_dmi_5,addr_dmi_4,addr_dmi_3,addr_dmi_2,addr_dmi_1,addr_dmi_0}; // @[JTag.scala 366:30]
  wire [1:0] _T_91 = {op_dmi_1,op_dmi_0}; // @[JTag.scala 367:26]
  wire [1:0] dmi_resp_in = io_dmi_resp_valid ? 2'h3 : 2'h0; // @[Bitwise.scala 72:12]
  wire  _T_95 = InstReg_io_JtagRegLatched == 4'h4; // @[JTag.scala 389:35]
  wire  _T_96 = InstReg_io_JtagRegLatched == 4'h1; // @[JTag.scala 389:88]
  wire  Reg_selection = _T_95 | _T_96; // @[JTag.scala 389:58]
  wire  _GEN_5 = InstReg_io_InstRegister; // @[JTag.scala 394:39]
  wire  TDO_out_IDR = JTagFSM_io_out_shift_dr ? DataReg_io_SerialOut : _GEN_5; // @[JTag.scala 392:33]
  wire  TDO_out_BSR = BoundaryScanRegister_io_SerialOut; // @[JTag.scala 384:25 JTag.scala 400:15]
  wire  _T_102 = ~io_TCK; // @[BlackBoxes.scala 53:31]
  reg  Rctrl; // @[Reg.scala 15:16]
  JTagStateMachine JTagFSM ( // @[JTag.scala 309:23]
    .io_TCK(JTagFSM_io_TCK),
    .io_TMS(JTagFSM_io_TMS),
    .io_out_test_logic_reset(JTagFSM_io_out_test_logic_reset),
    .io_out_run_test_idle(JTagFSM_io_out_run_test_idle),
    .io_out_select_dr_scan(JTagFSM_io_out_select_dr_scan),
    .io_out_capture_dr(JTagFSM_io_out_capture_dr),
    .io_out_shift_dr(JTagFSM_io_out_shift_dr),
    .io_out_update_dr(JTagFSM_io_out_update_dr),
    .io_out_capture_ir(JTagFSM_io_out_capture_ir),
    .io_out_shift_ir(JTagFSM_io_out_shift_ir),
    .io_out_update_ir(JTagFSM_io_out_update_ir),
    .io_TRST(JTagFSM_io_TRST)
  );
  InstReg InstReg ( // @[JTag.scala 310:38]
    .reset(InstReg_reset),
    .io_TCK(InstReg_io_TCK),
    .io_TDI_in(InstReg_io_TDI_in),
    .io_JtagState_test_logic_reset(InstReg_io_JtagState_test_logic_reset),
    .io_JtagState_capture_ir(InstReg_io_JtagState_capture_ir),
    .io_JtagState_shift_ir(InstReg_io_JtagState_shift_ir),
    .io_JtagState_update_ir(InstReg_io_JtagState_update_ir),
    .io_JtagRegLatched(InstReg_io_JtagRegLatched),
    .io_InstRegister(InstReg_io_InstRegister)
  );
  DataReg DataReg ( // @[JTag.scala 311:38]
    .reset(DataReg_reset),
    .io_TCK(DataReg_io_TCK),
    .io_TDI_in(DataReg_io_TDI_in),
    .io_JtagState_test_logic_reset(DataReg_io_JtagState_test_logic_reset),
    .io_JtagState_run_test_idle(DataReg_io_JtagState_run_test_idle),
    .io_JtagState_select_dr_scan(DataReg_io_JtagState_select_dr_scan),
    .io_JtagState_capture_dr(DataReg_io_JtagState_capture_dr),
    .io_JtagState_shift_dr(DataReg_io_JtagState_shift_dr),
    .io_JtagState_update_dr(DataReg_io_JtagState_update_dr),
    .io_JtagReg(DataReg_io_JtagReg),
    .io_SerialOut(DataReg_io_SerialOut),
    .io_DMIout(DataReg_io_DMIout),
    .io_dmstatuscontrol_DM_actived(DataReg_io_dmstatuscontrol_DM_actived),
    .io_dmstatuscontrol_Halted(DataReg_io_dmstatuscontrol_Halted),
    .io_dmstatuscontrol_Reseted(DataReg_io_dmstatuscontrol_Reseted),
    .io_dmstatuscontrol_PcMode(DataReg_io_dmstatuscontrol_PcMode),
    .io_dmstatuscontrol_PBCellsProg(DataReg_io_dmstatuscontrol_PBCellsProg),
    .io_dmstatuscontrol_AHBTrans(DataReg_io_dmstatuscontrol_AHBTrans),
    .io_dmstatuscontrol_DMTotalAcess(DataReg_io_dmstatuscontrol_DMTotalAcess),
    .io_dmstatuscontrol_ResetDM(DataReg_io_dmstatuscontrol_ResetDM),
    .io_dmstatuscontrol_ClearProB(DataReg_io_dmstatuscontrol_ClearProB),
    .io_dmstatuscontrol_ClearAHBcells(DataReg_io_dmstatuscontrol_ClearAHBcells),
    .io_dmstatuscontrol_ResetCounters(DataReg_io_dmstatuscontrol_ResetCounters),
    .io_DMIin(DataReg_io_DMIin)
  );
  BoundaryScanReg BoundaryScanRegister ( // @[JTag.scala 312:51]
    .reset(BoundaryScanRegister_reset),
    .io_TCK(BoundaryScanRegister_io_TCK),
    .io_TDI_in(BoundaryScanRegister_io_TDI_in),
    .io_JtagState_test_logic_reset(BoundaryScanRegister_io_JtagState_test_logic_reset),
    .io_JtagState_capture_dr(BoundaryScanRegister_io_JtagState_capture_dr),
    .io_JtagState_shift_dr(BoundaryScanRegister_io_JtagState_shift_dr),
    .io_JtagState_update_dr(BoundaryScanRegister_io_JtagState_update_dr),
    .io_JtagReg(BoundaryScanRegister_io_JtagReg),
    .io_pincontrol_core_0_PE(BoundaryScanRegister_io_pincontrol_core_0_PE),
    .io_pincontrol_core_0_IE(BoundaryScanRegister_io_pincontrol_core_0_IE),
    .io_pincontrol_core_0_DS(BoundaryScanRegister_io_pincontrol_core_0_DS),
    .io_pincontrol_core_0_I(BoundaryScanRegister_io_pincontrol_core_0_I),
    .io_pincontrol_core_0_OEN(BoundaryScanRegister_io_pincontrol_core_0_OEN),
    .io_pincontrol_core_0_C(BoundaryScanRegister_io_pincontrol_core_0_C),
    .io_pincontrol_core_1_PE(BoundaryScanRegister_io_pincontrol_core_1_PE),
    .io_pincontrol_core_1_IE(BoundaryScanRegister_io_pincontrol_core_1_IE),
    .io_pincontrol_core_1_DS(BoundaryScanRegister_io_pincontrol_core_1_DS),
    .io_pincontrol_core_1_I(BoundaryScanRegister_io_pincontrol_core_1_I),
    .io_pincontrol_core_1_OEN(BoundaryScanRegister_io_pincontrol_core_1_OEN),
    .io_pincontrol_core_1_C(BoundaryScanRegister_io_pincontrol_core_1_C),
    .io_pincontrol_IO_0_PE(BoundaryScanRegister_io_pincontrol_IO_0_PE),
    .io_pincontrol_IO_0_IE(BoundaryScanRegister_io_pincontrol_IO_0_IE),
    .io_pincontrol_IO_0_DS(BoundaryScanRegister_io_pincontrol_IO_0_DS),
    .io_pincontrol_IO_0_I(BoundaryScanRegister_io_pincontrol_IO_0_I),
    .io_pincontrol_IO_0_OEN(BoundaryScanRegister_io_pincontrol_IO_0_OEN),
    .io_pincontrol_IO_0_C(BoundaryScanRegister_io_pincontrol_IO_0_C),
    .io_pincontrol_IO_1_PE(BoundaryScanRegister_io_pincontrol_IO_1_PE),
    .io_pincontrol_IO_1_IE(BoundaryScanRegister_io_pincontrol_IO_1_IE),
    .io_pincontrol_IO_1_DS(BoundaryScanRegister_io_pincontrol_IO_1_DS),
    .io_pincontrol_IO_1_I(BoundaryScanRegister_io_pincontrol_IO_1_I),
    .io_pincontrol_IO_1_OEN(BoundaryScanRegister_io_pincontrol_IO_1_OEN),
    .io_pincontrol_IO_1_C(BoundaryScanRegister_io_pincontrol_IO_1_C),
    .io_SerialOut(BoundaryScanRegister_io_SerialOut)
  );
  Tristate Tristate ( // @[JTag.scala 405:24]
    .ctrl(Tristate_ctrl),
    .in(Tristate_in),
    .out(Tristate_out)
  );
  assign io_TDO = Tristate_out; // @[JTag.scala 408:10]
  assign io_PinCTRL_CORE_0_C = BoundaryScanRegister_io_pincontrol_core_0_C; // @[JTag.scala 341:43]
  assign io_PinCTRL_CORE_1_C = BoundaryScanRegister_io_pincontrol_core_1_C; // @[JTag.scala 341:43]
  assign io_PinCTRL_IO_0_PE = BoundaryScanRegister_io_pincontrol_IO_0_PE; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_0_IE = BoundaryScanRegister_io_pincontrol_IO_0_IE; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_0_DS = BoundaryScanRegister_io_pincontrol_IO_0_DS; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_0_I = BoundaryScanRegister_io_pincontrol_IO_0_I; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_0_OEN = BoundaryScanRegister_io_pincontrol_IO_0_OEN; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_1_PE = BoundaryScanRegister_io_pincontrol_IO_1_PE; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_1_IE = BoundaryScanRegister_io_pincontrol_IO_1_IE; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_1_DS = BoundaryScanRegister_io_pincontrol_IO_1_DS; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_1_I = BoundaryScanRegister_io_pincontrol_IO_1_I; // @[JTag.scala 342:41]
  assign io_PinCTRL_IO_1_OEN = BoundaryScanRegister_io_pincontrol_IO_1_OEN; // @[JTag.scala 342:41]
  assign io_dmi_req_valid = _T_49 & JTagFSM_io_out_update_dr; // @[JTag.scala 363:20 JTag.scala 368:22]
  assign io_dmi_req_bits_op = _T_50 ? _T_91 : 2'h0; // @[JTag.scala 373:22]
  assign io_dmi_req_bits_addr = _T_50 ? _T_90 : 10'h0; // @[JTag.scala 372:24]
  assign io_dmi_req_bits_data = _T_50 ? _T_81 : 32'h0; // @[JTag.scala 371:24]
  assign io_dmstatuscontrol_ResetDM = DataReg_io_dmstatuscontrol_ResetDM; // @[JTag.scala 334:33]
  assign io_dmstatuscontrol_ClearProB = DataReg_io_dmstatuscontrol_ClearProB; // @[JTag.scala 334:33]
  assign io_dmstatuscontrol_ClearAHBcells = DataReg_io_dmstatuscontrol_ClearAHBcells; // @[JTag.scala 334:33]
  assign io_dmstatuscontrol_ResetCounters = DataReg_io_dmstatuscontrol_ResetCounters; // @[JTag.scala 334:33]
  assign JTagFSM_io_TCK = io_TCK; // @[JTag.scala 322:18]
  assign JTagFSM_io_TMS = io_TMS; // @[JTag.scala 321:18]
  assign JTagFSM_io_TRST = io_TRSTn; // @[JTag.scala 323:19]
  assign InstReg_reset = reset | _T_1;
  assign InstReg_io_TCK = io_TCK; // @[JTag.scala 327:18]
  assign InstReg_io_TDI_in = io_TDI; // @[JTag.scala 326:21]
  assign InstReg_io_JtagState_test_logic_reset = JTagFSM_io_out_test_logic_reset; // @[JTag.scala 325:24]
  assign InstReg_io_JtagState_capture_ir = JTagFSM_io_out_capture_ir; // @[JTag.scala 325:24]
  assign InstReg_io_JtagState_shift_ir = JTagFSM_io_out_shift_ir; // @[JTag.scala 325:24]
  assign InstReg_io_JtagState_update_ir = JTagFSM_io_out_update_ir; // @[JTag.scala 325:24]
  assign DataReg_reset = reset | _T_1;
  assign DataReg_io_TCK = io_TCK; // @[JTag.scala 332:18]
  assign DataReg_io_TDI_in = io_TDI; // @[JTag.scala 330:21]
  assign DataReg_io_JtagState_test_logic_reset = JTagFSM_io_out_test_logic_reset; // @[JTag.scala 329:24]
  assign DataReg_io_JtagState_run_test_idle = JTagFSM_io_out_run_test_idle; // @[JTag.scala 329:24]
  assign DataReg_io_JtagState_select_dr_scan = JTagFSM_io_out_select_dr_scan; // @[JTag.scala 329:24]
  assign DataReg_io_JtagState_capture_dr = JTagFSM_io_out_capture_dr; // @[JTag.scala 329:24]
  assign DataReg_io_JtagState_shift_dr = JTagFSM_io_out_shift_dr; // @[JTag.scala 329:24]
  assign DataReg_io_JtagState_update_dr = JTagFSM_io_out_update_dr; // @[JTag.scala 329:24]
  assign DataReg_io_JtagReg = InstReg_io_JtagRegLatched; // @[JTag.scala 331:22]
  assign DataReg_io_dmstatuscontrol_DM_actived = io_dmstatuscontrol_DM_actived; // @[JTag.scala 334:33]
  assign DataReg_io_dmstatuscontrol_Halted = io_dmstatuscontrol_Halted; // @[JTag.scala 334:33]
  assign DataReg_io_dmstatuscontrol_Reseted = io_dmstatuscontrol_Reseted; // @[JTag.scala 334:33]
  assign DataReg_io_dmstatuscontrol_PcMode = io_dmstatuscontrol_PcMode; // @[JTag.scala 334:33]
  assign DataReg_io_dmstatuscontrol_PBCellsProg = io_dmstatuscontrol_PBCellsProg; // @[JTag.scala 334:33]
  assign DataReg_io_dmstatuscontrol_AHBTrans = io_dmstatuscontrol_AHBTrans; // @[JTag.scala 334:33]
  assign DataReg_io_dmstatuscontrol_DMTotalAcess = io_dmstatuscontrol_DMTotalAcess; // @[JTag.scala 334:33]
  assign DataReg_io_DMIin = {io_dmi_resp_bits_data,dmi_resp_in}; // @[JTag.scala 333:20]
  assign BoundaryScanRegister_reset = reset | _T_1;
  assign BoundaryScanRegister_io_TCK = io_TCK; // @[JTag.scala 340:31]
  assign BoundaryScanRegister_io_TDI_in = io_TDI; // @[JTag.scala 337:34]
  assign BoundaryScanRegister_io_JtagState_test_logic_reset = JTagFSM_io_out_test_logic_reset; // @[JTag.scala 338:37]
  assign BoundaryScanRegister_io_JtagState_capture_dr = JTagFSM_io_out_capture_dr; // @[JTag.scala 338:37]
  assign BoundaryScanRegister_io_JtagState_shift_dr = JTagFSM_io_out_shift_dr; // @[JTag.scala 338:37]
  assign BoundaryScanRegister_io_JtagState_update_dr = JTagFSM_io_out_update_dr; // @[JTag.scala 338:37]
  assign BoundaryScanRegister_io_JtagReg = InstReg_io_JtagRegLatched; // @[JTag.scala 339:34]
  assign BoundaryScanRegister_io_pincontrol_core_0_PE = io_PinCTRL_CORE_0_PE; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_0_IE = io_PinCTRL_CORE_0_IE; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_0_DS = io_PinCTRL_CORE_0_DS; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_0_I = io_PinCTRL_CORE_0_I; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_0_OEN = io_PinCTRL_CORE_0_OEN; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_1_PE = io_PinCTRL_CORE_1_PE; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_1_IE = io_PinCTRL_CORE_1_IE; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_1_DS = io_PinCTRL_CORE_1_DS; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_1_I = io_PinCTRL_CORE_1_I; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_core_1_OEN = io_PinCTRL_CORE_1_OEN; // @[JTag.scala 341:43]
  assign BoundaryScanRegister_io_pincontrol_IO_0_C = io_PinCTRL_IO_0_C; // @[JTag.scala 342:41]
  assign BoundaryScanRegister_io_pincontrol_IO_1_C = io_PinCTRL_IO_1_C; // @[JTag.scala 342:41]
  assign Tristate_ctrl = Rctrl; // @[JTag.scala 406:20]
  assign Tristate_in = Reg_selection ? TDO_out_BSR : TDO_out_IDR; // @[JTag.scala 407:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Rctrl = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge _T_102) begin
    Rctrl <= JTagFSM_io_out_shift_dr | JTagFSM_io_out_shift_ir;
  end
endmodule
module AsyncResetReg(
  input   io_d,
  output  io_q,
  input   io_clk,
  input   io_rst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  reg_; // @[Asyncqueue.scala 18:73]
  assign io_q = reg_; // @[Asyncqueue.scala 22:8]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  if (io_rst) begin
    reg_ = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_clk or posedge io_rst) begin
    if (io_rst) begin
      reg_ <= 1'h0;
    end else begin
      reg_ <= io_d;
    end
  end
endmodule
module AsyncResetRegVec(
  input   clock,
  input   reset,
  input   io_d,
  output  io_q
);
  wire  reg_0_io_d; // @[Asyncqueue.scala 28:39]
  wire  reg_0_io_q; // @[Asyncqueue.scala 28:39]
  wire  reg_0_io_clk; // @[Asyncqueue.scala 28:39]
  wire  reg_0_io_rst; // @[Asyncqueue.scala 28:39]
  AsyncResetReg reg_0 ( // @[Asyncqueue.scala 28:39]
    .io_d(reg_0_io_d),
    .io_q(reg_0_io_q),
    .io_clk(reg_0_io_clk),
    .io_rst(reg_0_io_rst)
  );
  assign io_q = reg_0_io_q; // @[Asyncqueue.scala 40:8]
  assign reg_0_io_d = io_d; // @[Asyncqueue.scala 34:16]
  assign reg_0_io_clk = clock; // @[Asyncqueue.scala 32:16]
  assign reg_0_io_rst = reset; // @[Asyncqueue.scala 33:16]
endmodule
module AsyncValidSync(
  input   clock,
  input   reset,
  output  io_out
);
  wire  source_valid_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_1_clock; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_1_reset; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_1_io_d; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_1_io_q; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_2_clock; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_2_reset; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_2_io_d; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_2_io_q; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_3_clock; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_3_reset; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_3_io_d; // @[Asyncqueue.scala 94:14]
  wire  source_valid_sync_3_io_q; // @[Asyncqueue.scala 94:14]
  AsyncResetRegVec source_valid_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(source_valid_sync_0_clock),
    .reset(source_valid_sync_0_reset),
    .io_d(source_valid_sync_0_io_d),
    .io_q(source_valid_sync_0_io_q)
  );
  AsyncResetRegVec source_valid_sync_1 ( // @[Asyncqueue.scala 94:14]
    .clock(source_valid_sync_1_clock),
    .reset(source_valid_sync_1_reset),
    .io_d(source_valid_sync_1_io_d),
    .io_q(source_valid_sync_1_io_q)
  );
  AsyncResetRegVec source_valid_sync_2 ( // @[Asyncqueue.scala 94:14]
    .clock(source_valid_sync_2_clock),
    .reset(source_valid_sync_2_reset),
    .io_d(source_valid_sync_2_io_d),
    .io_q(source_valid_sync_2_io_q)
  );
  AsyncResetRegVec source_valid_sync_3 ( // @[Asyncqueue.scala 94:14]
    .clock(source_valid_sync_3_clock),
    .reset(source_valid_sync_3_reset),
    .io_d(source_valid_sync_3_io_d),
    .io_q(source_valid_sync_3_io_q)
  );
  assign io_out = source_valid_sync_0_io_q; // @[Asyncqueue.scala 111:10]
  assign source_valid_sync_0_clock = clock;
  assign source_valid_sync_0_reset = reset;
  assign source_valid_sync_0_io_d = source_valid_sync_1_io_q; // @[Asyncqueue.scala 99:17]
  assign source_valid_sync_1_clock = clock;
  assign source_valid_sync_1_reset = reset;
  assign source_valid_sync_1_io_d = source_valid_sync_2_io_q; // @[Asyncqueue.scala 99:17]
  assign source_valid_sync_2_clock = clock;
  assign source_valid_sync_2_reset = reset;
  assign source_valid_sync_2_io_d = source_valid_sync_3_io_q; // @[Asyncqueue.scala 99:17]
  assign source_valid_sync_3_clock = clock;
  assign source_valid_sync_3_reset = reset;
  assign source_valid_sync_3_io_d = 1'h1; // @[Asyncqueue.scala 96:21]
endmodule
module AsyncValidSync_1(
  input   clock,
  input   reset,
  input   io_in,
  output  io_out
);
  wire  sink_extend_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  sink_extend_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  sink_extend_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  sink_extend_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  AsyncResetRegVec sink_extend_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(sink_extend_sync_0_clock),
    .reset(sink_extend_sync_0_reset),
    .io_d(sink_extend_sync_0_io_d),
    .io_q(sink_extend_sync_0_io_q)
  );
  assign io_out = sink_extend_sync_0_io_q; // @[Asyncqueue.scala 111:10]
  assign sink_extend_sync_0_clock = clock;
  assign sink_extend_sync_0_reset = reset;
  assign sink_extend_sync_0_io_d = io_in; // @[Asyncqueue.scala 96:21]
endmodule
module AsyncValidSync_2(
  input   clock,
  input   reset,
  input   io_in,
  output  io_out
);
  wire  sink_valid_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_1_clock; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_1_reset; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_1_io_d; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_1_io_q; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_2_clock; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_2_reset; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_2_io_d; // @[Asyncqueue.scala 94:14]
  wire  sink_valid_sync_2_io_q; // @[Asyncqueue.scala 94:14]
  AsyncResetRegVec sink_valid_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(sink_valid_sync_0_clock),
    .reset(sink_valid_sync_0_reset),
    .io_d(sink_valid_sync_0_io_d),
    .io_q(sink_valid_sync_0_io_q)
  );
  AsyncResetRegVec sink_valid_sync_1 ( // @[Asyncqueue.scala 94:14]
    .clock(sink_valid_sync_1_clock),
    .reset(sink_valid_sync_1_reset),
    .io_d(sink_valid_sync_1_io_d),
    .io_q(sink_valid_sync_1_io_q)
  );
  AsyncResetRegVec sink_valid_sync_2 ( // @[Asyncqueue.scala 94:14]
    .clock(sink_valid_sync_2_clock),
    .reset(sink_valid_sync_2_reset),
    .io_d(sink_valid_sync_2_io_d),
    .io_q(sink_valid_sync_2_io_q)
  );
  assign io_out = sink_valid_sync_0_io_q; // @[Asyncqueue.scala 111:10]
  assign sink_valid_sync_0_clock = clock;
  assign sink_valid_sync_0_reset = reset;
  assign sink_valid_sync_0_io_d = sink_valid_sync_1_io_q; // @[Asyncqueue.scala 99:17]
  assign sink_valid_sync_1_clock = clock;
  assign sink_valid_sync_1_reset = reset;
  assign sink_valid_sync_1_io_d = sink_valid_sync_2_io_q; // @[Asyncqueue.scala 99:17]
  assign sink_valid_sync_2_clock = clock;
  assign sink_valid_sync_2_reset = reset;
  assign sink_valid_sync_2_io_d = io_in; // @[Asyncqueue.scala 96:21]
endmodule
module AsyncQueueSource(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [1:0]  io_enq_bits_op,
  input  [9:0]  io_enq_bits_addr,
  input  [31:0] io_enq_bits_data,
  input         io_ridx,
  output        io_widx,
  output [1:0]  io_mem_0_op,
  output [9:0]  io_mem_0_addr,
  output [31:0] io_mem_0_data,
  input         io_sink_reset_n,
  input         io_ridx_valid,
  output        io_widx_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  widx_bin_clock; // @[Asyncqueue.scala 62:21]
  wire  widx_bin_reset; // @[Asyncqueue.scala 62:21]
  wire  widx_bin_io_d; // @[Asyncqueue.scala 62:21]
  wire  widx_bin_io_q; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_clock; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_reset; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_io_d; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_io_q; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_clock; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_reset; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_io_d; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_io_q; // @[Asyncqueue.scala 94:14]
  wire  ready_reg_clock; // @[Asyncqueue.scala 62:21]
  wire  ready_reg_reset; // @[Asyncqueue.scala 62:21]
  wire  ready_reg_io_d; // @[Asyncqueue.scala 62:21]
  wire  ready_reg_io_q; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_clock; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_reset; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_io_d; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_io_q; // @[Asyncqueue.scala 62:21]
  wire  AsyncValidSync_clock; // @[Asyncqueue.scala 149:30]
  wire  AsyncValidSync_reset; // @[Asyncqueue.scala 149:30]
  wire  AsyncValidSync_io_out; // @[Asyncqueue.scala 149:30]
  wire  AsyncValidSync_1_clock; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_1_reset; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_1_io_in; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_1_io_out; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_2_clock; // @[Asyncqueue.scala 151:30]
  wire  AsyncValidSync_2_reset; // @[Asyncqueue.scala 151:30]
  wire  AsyncValidSync_2_io_in; // @[Asyncqueue.scala 151:30]
  wire  AsyncValidSync_2_io_out; // @[Asyncqueue.scala 151:30]
  reg [1:0] mem_0_op; // @[Asyncqueue.scala 131:16]
  reg [9:0] mem_0_addr; // @[Asyncqueue.scala 131:16]
  reg [31:0] mem_0_data; // @[Asyncqueue.scala 131:16]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  sink_ready = AsyncValidSync_2_io_out; // @[Asyncqueue.scala 159:16]
  wire  _T_1 = ~sink_ready; // @[Asyncqueue.scala 132:49]
  wire  _T_4 = widx_bin_io_q + _T; // @[Asyncqueue.scala 86:47]
  wire  widx = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 86:23]
  wire  _T_7 = ridx_gray_sync_0_io_q ^ 1'h1; // @[Asyncqueue.scala 134:44]
  wire  _T_8 = widx != _T_7; // @[Asyncqueue.scala 134:34]
  wire  ready_reg_1 = ready_reg_io_q; // @[Asyncqueue.scala 139:59]
  wire  _T_12 = ~io_sink_reset_n; // @[Asyncqueue.scala 152:36]
  AsyncResetRegVec widx_bin ( // @[Asyncqueue.scala 62:21]
    .clock(widx_bin_clock),
    .reset(widx_bin_reset),
    .io_d(widx_bin_io_d),
    .io_q(widx_bin_io_q)
  );
  AsyncResetRegVec ridx_gray_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(ridx_gray_sync_0_clock),
    .reset(ridx_gray_sync_0_reset),
    .io_d(ridx_gray_sync_0_io_d),
    .io_q(ridx_gray_sync_0_io_q)
  );
  AsyncResetRegVec ridx_gray_sync_1 ( // @[Asyncqueue.scala 94:14]
    .clock(ridx_gray_sync_1_clock),
    .reset(ridx_gray_sync_1_reset),
    .io_d(ridx_gray_sync_1_io_d),
    .io_q(ridx_gray_sync_1_io_q)
  );
  AsyncResetRegVec ridx_gray_sync_2 ( // @[Asyncqueue.scala 94:14]
    .clock(ridx_gray_sync_2_clock),
    .reset(ridx_gray_sync_2_reset),
    .io_d(ridx_gray_sync_2_io_d),
    .io_q(ridx_gray_sync_2_io_q)
  );
  AsyncResetRegVec ready_reg ( // @[Asyncqueue.scala 62:21]
    .clock(ready_reg_clock),
    .reset(ready_reg_reset),
    .io_d(ready_reg_io_d),
    .io_q(ready_reg_io_q)
  );
  AsyncResetRegVec widx_gray ( // @[Asyncqueue.scala 62:21]
    .clock(widx_gray_clock),
    .reset(widx_gray_reset),
    .io_d(widx_gray_io_d),
    .io_q(widx_gray_io_q)
  );
  AsyncValidSync AsyncValidSync ( // @[Asyncqueue.scala 149:30]
    .clock(AsyncValidSync_clock),
    .reset(AsyncValidSync_reset),
    .io_out(AsyncValidSync_io_out)
  );
  AsyncValidSync_1 AsyncValidSync_1 ( // @[Asyncqueue.scala 150:30]
    .clock(AsyncValidSync_1_clock),
    .reset(AsyncValidSync_1_reset),
    .io_in(AsyncValidSync_1_io_in),
    .io_out(AsyncValidSync_1_io_out)
  );
  AsyncValidSync_2 AsyncValidSync_2 ( // @[Asyncqueue.scala 151:30]
    .clock(AsyncValidSync_2_clock),
    .reset(AsyncValidSync_2_reset),
    .io_in(AsyncValidSync_2_io_in),
    .io_out(AsyncValidSync_2_io_out)
  );
  assign io_enq_ready = ready_reg_1 & sink_ready; // @[Asyncqueue.scala 140:16]
  assign io_widx = widx_gray_io_q; // @[Asyncqueue.scala 143:11]
  assign io_mem_0_op = mem_0_op; // @[Asyncqueue.scala 145:61]
  assign io_mem_0_addr = mem_0_addr; // @[Asyncqueue.scala 145:61]
  assign io_mem_0_data = mem_0_data; // @[Asyncqueue.scala 145:61]
  assign io_widx_valid = AsyncValidSync_io_out; // @[Asyncqueue.scala 147:17 Asyncqueue.scala 156:19]
  assign widx_bin_clock = clock;
  assign widx_bin_reset = reset;
  assign widx_bin_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign ridx_gray_sync_0_clock = clock;
  assign ridx_gray_sync_0_reset = reset;
  assign ridx_gray_sync_0_io_d = ridx_gray_sync_1_io_q; // @[Asyncqueue.scala 99:17]
  assign ridx_gray_sync_1_clock = clock;
  assign ridx_gray_sync_1_reset = reset;
  assign ridx_gray_sync_1_io_d = ridx_gray_sync_2_io_q; // @[Asyncqueue.scala 99:17]
  assign ridx_gray_sync_2_clock = clock;
  assign ridx_gray_sync_2_reset = reset;
  assign ridx_gray_sync_2_io_d = io_ridx; // @[Asyncqueue.scala 96:21]
  assign ready_reg_clock = clock;
  assign ready_reg_reset = reset;
  assign ready_reg_io_d = sink_ready & _T_8; // @[Asyncqueue.scala 64:14]
  assign widx_gray_clock = clock;
  assign widx_gray_reset = reset;
  assign widx_gray_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign AsyncValidSync_clock = clock;
  assign AsyncValidSync_reset = reset | _T_12; // @[Asyncqueue.scala 152:24]
  assign AsyncValidSync_1_clock = clock;
  assign AsyncValidSync_1_reset = reset | _T_12; // @[Asyncqueue.scala 153:24]
  assign AsyncValidSync_1_io_in = io_ridx_valid; // @[Asyncqueue.scala 157:23]
  assign AsyncValidSync_2_clock = clock;
  assign AsyncValidSync_2_reset = reset;
  assign AsyncValidSync_2_io_in = AsyncValidSync_1_io_out; // @[Asyncqueue.scala 158:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mem_0_op = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  mem_0_addr = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_data = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T) begin
      mem_0_op <= io_enq_bits_op;
    end
    if (_T) begin
      mem_0_addr <= io_enq_bits_addr;
    end
    if (_T) begin
      mem_0_data <= io_enq_bits_data;
    end
  end
endmodule
module AsyncQueueSink(
  input         clock,
  input         reset,
  input         io_deq_ready,
  output        io_deq_valid,
  output [1:0]  io_deq_bits_op,
  output [9:0]  io_deq_bits_addr,
  output [31:0] io_deq_bits_data,
  output        io_ridx,
  input         io_widx,
  input  [1:0]  io_mem_0_op,
  input  [9:0]  io_mem_0_addr,
  input  [31:0] io_mem_0_data,
  input         io_source_reset_n,
  output        io_ridx_valid,
  input         io_widx_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  ridx_bin_clock; // @[Asyncqueue.scala 62:21]
  wire  ridx_bin_reset; // @[Asyncqueue.scala 62:21]
  wire  ridx_bin_io_d; // @[Asyncqueue.scala 62:21]
  wire  ridx_bin_io_q; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_clock; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_reset; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_io_d; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_io_q; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_clock; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_reset; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_io_d; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_io_q; // @[Asyncqueue.scala 94:14]
  wire  valid_reg_clock; // @[Asyncqueue.scala 62:21]
  wire  valid_reg_reset; // @[Asyncqueue.scala 62:21]
  wire  valid_reg_io_d; // @[Asyncqueue.scala 62:21]
  wire  valid_reg_io_q; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_clock; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_reset; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_io_d; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_io_q; // @[Asyncqueue.scala 62:21]
  wire  AsyncValidSync_clock; // @[Asyncqueue.scala 213:31]
  wire  AsyncValidSync_reset; // @[Asyncqueue.scala 213:31]
  wire  AsyncValidSync_io_out; // @[Asyncqueue.scala 213:31]
  wire  AsyncValidSync_1_clock; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_1_reset; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_1_io_in; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_1_io_out; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_2_clock; // @[Asyncqueue.scala 215:31]
  wire  AsyncValidSync_2_reset; // @[Asyncqueue.scala 215:31]
  wire  AsyncValidSync_2_io_in; // @[Asyncqueue.scala 215:31]
  wire  AsyncValidSync_2_io_out; // @[Asyncqueue.scala 215:31]
  wire  AsyncResetRegVec_clock; // @[Asyncqueue.scala 62:21]
  wire  AsyncResetRegVec_reset; // @[Asyncqueue.scala 62:21]
  wire  AsyncResetRegVec_io_d; // @[Asyncqueue.scala 62:21]
  wire  AsyncResetRegVec_io_q; // @[Asyncqueue.scala 62:21]
  wire  _T = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  source_ready = AsyncValidSync_2_io_out; // @[Asyncqueue.scala 223:18]
  wire  _T_1 = ~source_ready; // @[Asyncqueue.scala 189:49]
  wire  _T_4 = ridx_bin_io_q + _T; // @[Asyncqueue.scala 86:47]
  wire  ridx = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 86:23]
  wire  _T_7 = ridx != widx_gray_sync_0_io_q; // @[Asyncqueue.scala 191:36]
  wire  valid = source_ready & _T_7; // @[Asyncqueue.scala 191:28]
  reg [1:0] _T_8_op; // @[Reg.scala 15:16]
  reg [9:0] _T_8_addr; // @[Reg.scala 15:16]
  reg [31:0] _T_8_data; // @[Reg.scala 15:16]
  wire  valid_reg_1 = valid_reg_io_q; // @[Asyncqueue.scala 205:59]
  wire  _T_11 = ~io_source_reset_n; // @[Asyncqueue.scala 216:37]
  AsyncResetRegVec ridx_bin ( // @[Asyncqueue.scala 62:21]
    .clock(ridx_bin_clock),
    .reset(ridx_bin_reset),
    .io_d(ridx_bin_io_d),
    .io_q(ridx_bin_io_q)
  );
  AsyncResetRegVec widx_gray_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(widx_gray_sync_0_clock),
    .reset(widx_gray_sync_0_reset),
    .io_d(widx_gray_sync_0_io_d),
    .io_q(widx_gray_sync_0_io_q)
  );
  AsyncResetRegVec widx_gray_sync_1 ( // @[Asyncqueue.scala 94:14]
    .clock(widx_gray_sync_1_clock),
    .reset(widx_gray_sync_1_reset),
    .io_d(widx_gray_sync_1_io_d),
    .io_q(widx_gray_sync_1_io_q)
  );
  AsyncResetRegVec widx_gray_sync_2 ( // @[Asyncqueue.scala 94:14]
    .clock(widx_gray_sync_2_clock),
    .reset(widx_gray_sync_2_reset),
    .io_d(widx_gray_sync_2_io_d),
    .io_q(widx_gray_sync_2_io_q)
  );
  AsyncResetRegVec valid_reg ( // @[Asyncqueue.scala 62:21]
    .clock(valid_reg_clock),
    .reset(valid_reg_reset),
    .io_d(valid_reg_io_d),
    .io_q(valid_reg_io_q)
  );
  AsyncResetRegVec ridx_gray ( // @[Asyncqueue.scala 62:21]
    .clock(ridx_gray_clock),
    .reset(ridx_gray_reset),
    .io_d(ridx_gray_io_d),
    .io_q(ridx_gray_io_q)
  );
  AsyncValidSync AsyncValidSync ( // @[Asyncqueue.scala 213:31]
    .clock(AsyncValidSync_clock),
    .reset(AsyncValidSync_reset),
    .io_out(AsyncValidSync_io_out)
  );
  AsyncValidSync_1 AsyncValidSync_1 ( // @[Asyncqueue.scala 214:31]
    .clock(AsyncValidSync_1_clock),
    .reset(AsyncValidSync_1_reset),
    .io_in(AsyncValidSync_1_io_in),
    .io_out(AsyncValidSync_1_io_out)
  );
  AsyncValidSync_2 AsyncValidSync_2 ( // @[Asyncqueue.scala 215:31]
    .clock(AsyncValidSync_2_clock),
    .reset(AsyncValidSync_2_reset),
    .io_in(AsyncValidSync_2_io_in),
    .io_out(AsyncValidSync_2_io_out)
  );
  AsyncResetRegVec AsyncResetRegVec ( // @[Asyncqueue.scala 62:21]
    .clock(AsyncResetRegVec_clock),
    .reset(AsyncResetRegVec_reset),
    .io_d(AsyncResetRegVec_io_d),
    .io_q(AsyncResetRegVec_io_q)
  );
  assign io_deq_valid = valid_reg_1 & source_ready; // @[Asyncqueue.scala 206:16]
  assign io_deq_bits_op = _T_8_op; // @[Asyncqueue.scala 203:16]
  assign io_deq_bits_addr = _T_8_addr; // @[Asyncqueue.scala 203:16]
  assign io_deq_bits_data = _T_8_data; // @[Asyncqueue.scala 203:16]
  assign io_ridx = ridx_gray_io_q; // @[Asyncqueue.scala 209:11]
  assign io_ridx_valid = AsyncValidSync_io_out; // @[Asyncqueue.scala 211:17 Asyncqueue.scala 220:19]
  assign ridx_bin_clock = clock;
  assign ridx_bin_reset = reset;
  assign ridx_bin_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign widx_gray_sync_0_clock = clock;
  assign widx_gray_sync_0_reset = reset;
  assign widx_gray_sync_0_io_d = widx_gray_sync_1_io_q; // @[Asyncqueue.scala 99:17]
  assign widx_gray_sync_1_clock = clock;
  assign widx_gray_sync_1_reset = reset;
  assign widx_gray_sync_1_io_d = widx_gray_sync_2_io_q; // @[Asyncqueue.scala 99:17]
  assign widx_gray_sync_2_clock = clock;
  assign widx_gray_sync_2_reset = reset;
  assign widx_gray_sync_2_io_d = io_widx; // @[Asyncqueue.scala 96:21]
  assign valid_reg_clock = clock;
  assign valid_reg_reset = reset;
  assign valid_reg_io_d = source_ready & _T_7; // @[Asyncqueue.scala 64:14]
  assign ridx_gray_clock = clock;
  assign ridx_gray_reset = reset;
  assign ridx_gray_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign AsyncValidSync_clock = clock;
  assign AsyncValidSync_reset = reset | _T_11; // @[Asyncqueue.scala 216:25]
  assign AsyncValidSync_1_clock = clock;
  assign AsyncValidSync_1_reset = reset | _T_11; // @[Asyncqueue.scala 217:25]
  assign AsyncValidSync_1_io_in = io_widx_valid; // @[Asyncqueue.scala 221:25]
  assign AsyncValidSync_2_clock = clock;
  assign AsyncValidSync_2_reset = reset;
  assign AsyncValidSync_2_io_in = AsyncValidSync_1_io_out; // @[Asyncqueue.scala 222:24]
  assign AsyncResetRegVec_clock = clock;
  assign AsyncResetRegVec_reset = reset;
  assign AsyncResetRegVec_io_d = io_widx == io_ridx; // @[Asyncqueue.scala 64:14]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_8_op = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  _T_8_addr = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  _T_8_data = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (valid) begin
      _T_8_op <= io_mem_0_op;
    end
    if (valid) begin
      _T_8_addr <= io_mem_0_addr;
    end
    if (valid) begin
      _T_8_data <= io_mem_0_data;
    end
  end
endmodule
module AsyncQueue(
  input         io_enq_clock,
  input         io_enq_reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [1:0]  io_enq_bits_op,
  input  [9:0]  io_enq_bits_addr,
  input  [31:0] io_enq_bits_data,
  input         io_deq_clock,
  input         io_deq_reset,
  input         io_deq_ready,
  output        io_deq_valid,
  output [1:0]  io_deq_bits_op,
  output [9:0]  io_deq_bits_addr,
  output [31:0] io_deq_bits_data
);
  wire  source_clock; // @[Asyncqueue.scala 258:22]
  wire  source_reset; // @[Asyncqueue.scala 258:22]
  wire  source_io_enq_ready; // @[Asyncqueue.scala 258:22]
  wire  source_io_enq_valid; // @[Asyncqueue.scala 258:22]
  wire [1:0] source_io_enq_bits_op; // @[Asyncqueue.scala 258:22]
  wire [9:0] source_io_enq_bits_addr; // @[Asyncqueue.scala 258:22]
  wire [31:0] source_io_enq_bits_data; // @[Asyncqueue.scala 258:22]
  wire  source_io_ridx; // @[Asyncqueue.scala 258:22]
  wire  source_io_widx; // @[Asyncqueue.scala 258:22]
  wire [1:0] source_io_mem_0_op; // @[Asyncqueue.scala 258:22]
  wire [9:0] source_io_mem_0_addr; // @[Asyncqueue.scala 258:22]
  wire [31:0] source_io_mem_0_data; // @[Asyncqueue.scala 258:22]
  wire  source_io_sink_reset_n; // @[Asyncqueue.scala 258:22]
  wire  source_io_ridx_valid; // @[Asyncqueue.scala 258:22]
  wire  source_io_widx_valid; // @[Asyncqueue.scala 258:22]
  wire  sink_clock; // @[Asyncqueue.scala 259:22]
  wire  sink_reset; // @[Asyncqueue.scala 259:22]
  wire  sink_io_deq_ready; // @[Asyncqueue.scala 259:22]
  wire  sink_io_deq_valid; // @[Asyncqueue.scala 259:22]
  wire [1:0] sink_io_deq_bits_op; // @[Asyncqueue.scala 259:22]
  wire [9:0] sink_io_deq_bits_addr; // @[Asyncqueue.scala 259:22]
  wire [31:0] sink_io_deq_bits_data; // @[Asyncqueue.scala 259:22]
  wire  sink_io_ridx; // @[Asyncqueue.scala 259:22]
  wire  sink_io_widx; // @[Asyncqueue.scala 259:22]
  wire [1:0] sink_io_mem_0_op; // @[Asyncqueue.scala 259:22]
  wire [9:0] sink_io_mem_0_addr; // @[Asyncqueue.scala 259:22]
  wire [31:0] sink_io_mem_0_data; // @[Asyncqueue.scala 259:22]
  wire  sink_io_source_reset_n; // @[Asyncqueue.scala 259:22]
  wire  sink_io_ridx_valid; // @[Asyncqueue.scala 259:22]
  wire  sink_io_widx_valid; // @[Asyncqueue.scala 259:22]
  AsyncQueueSource source ( // @[Asyncqueue.scala 258:22]
    .clock(source_clock),
    .reset(source_reset),
    .io_enq_ready(source_io_enq_ready),
    .io_enq_valid(source_io_enq_valid),
    .io_enq_bits_op(source_io_enq_bits_op),
    .io_enq_bits_addr(source_io_enq_bits_addr),
    .io_enq_bits_data(source_io_enq_bits_data),
    .io_ridx(source_io_ridx),
    .io_widx(source_io_widx),
    .io_mem_0_op(source_io_mem_0_op),
    .io_mem_0_addr(source_io_mem_0_addr),
    .io_mem_0_data(source_io_mem_0_data),
    .io_sink_reset_n(source_io_sink_reset_n),
    .io_ridx_valid(source_io_ridx_valid),
    .io_widx_valid(source_io_widx_valid)
  );
  AsyncQueueSink sink ( // @[Asyncqueue.scala 259:22]
    .clock(sink_clock),
    .reset(sink_reset),
    .io_deq_ready(sink_io_deq_ready),
    .io_deq_valid(sink_io_deq_valid),
    .io_deq_bits_op(sink_io_deq_bits_op),
    .io_deq_bits_addr(sink_io_deq_bits_addr),
    .io_deq_bits_data(sink_io_deq_bits_data),
    .io_ridx(sink_io_ridx),
    .io_widx(sink_io_widx),
    .io_mem_0_op(sink_io_mem_0_op),
    .io_mem_0_addr(sink_io_mem_0_addr),
    .io_mem_0_data(sink_io_mem_0_data),
    .io_source_reset_n(sink_io_source_reset_n),
    .io_ridx_valid(sink_io_ridx_valid),
    .io_widx_valid(sink_io_widx_valid)
  );
  assign io_enq_ready = source_io_enq_ready; // @[Asyncqueue.scala 269:17]
  assign io_deq_valid = sink_io_deq_valid; // @[Asyncqueue.scala 270:10]
  assign io_deq_bits_op = sink_io_deq_bits_op; // @[Asyncqueue.scala 270:10]
  assign io_deq_bits_addr = sink_io_deq_bits_addr; // @[Asyncqueue.scala 270:10]
  assign io_deq_bits_data = sink_io_deq_bits_data; // @[Asyncqueue.scala 270:10]
  assign source_clock = io_enq_clock; // @[Asyncqueue.scala 261:16]
  assign source_reset = io_enq_reset; // @[Asyncqueue.scala 262:16]
  assign source_io_enq_valid = io_enq_valid; // @[Asyncqueue.scala 269:17]
  assign source_io_enq_bits_op = io_enq_bits_op; // @[Asyncqueue.scala 269:17]
  assign source_io_enq_bits_addr = io_enq_bits_addr; // @[Asyncqueue.scala 269:17]
  assign source_io_enq_bits_data = io_enq_bits_data; // @[Asyncqueue.scala 269:17]
  assign source_io_ridx = sink_io_ridx; // @[Asyncqueue.scala 275:18]
  assign source_io_sink_reset_n = ~io_deq_reset; // @[Asyncqueue.scala 266:26]
  assign source_io_ridx_valid = sink_io_ridx_valid; // @[Asyncqueue.scala 277:24]
  assign sink_clock = io_deq_clock; // @[Asyncqueue.scala 263:14]
  assign sink_reset = io_deq_reset; // @[Asyncqueue.scala 264:14]
  assign sink_io_deq_ready = io_deq_ready; // @[Asyncqueue.scala 270:10]
  assign sink_io_widx = source_io_widx; // @[Asyncqueue.scala 274:16]
  assign sink_io_mem_0_op = source_io_mem_0_op; // @[Asyncqueue.scala 272:15]
  assign sink_io_mem_0_addr = source_io_mem_0_addr; // @[Asyncqueue.scala 272:15]
  assign sink_io_mem_0_data = source_io_mem_0_data; // @[Asyncqueue.scala 272:15]
  assign sink_io_source_reset_n = ~io_enq_reset; // @[Asyncqueue.scala 267:26]
  assign sink_io_widx_valid = source_io_widx_valid; // @[Asyncqueue.scala 276:22]
endmodule
module AsyncQueueSource_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_data,
  input         io_ridx,
  output        io_widx,
  output [31:0] io_mem_0_data,
  input         io_sink_reset_n,
  input         io_ridx_valid,
  output        io_widx_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  widx_bin_clock; // @[Asyncqueue.scala 62:21]
  wire  widx_bin_reset; // @[Asyncqueue.scala 62:21]
  wire  widx_bin_io_d; // @[Asyncqueue.scala 62:21]
  wire  widx_bin_io_q; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_clock; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_reset; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_io_d; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_1_io_q; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_clock; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_reset; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_io_d; // @[Asyncqueue.scala 94:14]
  wire  ridx_gray_sync_2_io_q; // @[Asyncqueue.scala 94:14]
  wire  ready_reg_clock; // @[Asyncqueue.scala 62:21]
  wire  ready_reg_reset; // @[Asyncqueue.scala 62:21]
  wire  ready_reg_io_d; // @[Asyncqueue.scala 62:21]
  wire  ready_reg_io_q; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_clock; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_reset; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_io_d; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_io_q; // @[Asyncqueue.scala 62:21]
  wire  AsyncValidSync_clock; // @[Asyncqueue.scala 149:30]
  wire  AsyncValidSync_reset; // @[Asyncqueue.scala 149:30]
  wire  AsyncValidSync_io_out; // @[Asyncqueue.scala 149:30]
  wire  AsyncValidSync_1_clock; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_1_reset; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_1_io_in; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_1_io_out; // @[Asyncqueue.scala 150:30]
  wire  AsyncValidSync_2_clock; // @[Asyncqueue.scala 151:30]
  wire  AsyncValidSync_2_reset; // @[Asyncqueue.scala 151:30]
  wire  AsyncValidSync_2_io_in; // @[Asyncqueue.scala 151:30]
  wire  AsyncValidSync_2_io_out; // @[Asyncqueue.scala 151:30]
  reg [31:0] mem_0_data; // @[Asyncqueue.scala 131:16]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  sink_ready = AsyncValidSync_2_io_out; // @[Asyncqueue.scala 159:16]
  wire  _T_1 = ~sink_ready; // @[Asyncqueue.scala 132:49]
  wire  _T_4 = widx_bin_io_q + _T; // @[Asyncqueue.scala 86:47]
  wire  widx = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 86:23]
  wire  _T_7 = ridx_gray_sync_0_io_q ^ 1'h1; // @[Asyncqueue.scala 134:44]
  wire  _T_8 = widx != _T_7; // @[Asyncqueue.scala 134:34]
  wire  ready_reg_1 = ready_reg_io_q; // @[Asyncqueue.scala 139:59]
  wire  _T_12 = ~io_sink_reset_n; // @[Asyncqueue.scala 152:36]
  AsyncResetRegVec widx_bin ( // @[Asyncqueue.scala 62:21]
    .clock(widx_bin_clock),
    .reset(widx_bin_reset),
    .io_d(widx_bin_io_d),
    .io_q(widx_bin_io_q)
  );
  AsyncResetRegVec ridx_gray_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(ridx_gray_sync_0_clock),
    .reset(ridx_gray_sync_0_reset),
    .io_d(ridx_gray_sync_0_io_d),
    .io_q(ridx_gray_sync_0_io_q)
  );
  AsyncResetRegVec ridx_gray_sync_1 ( // @[Asyncqueue.scala 94:14]
    .clock(ridx_gray_sync_1_clock),
    .reset(ridx_gray_sync_1_reset),
    .io_d(ridx_gray_sync_1_io_d),
    .io_q(ridx_gray_sync_1_io_q)
  );
  AsyncResetRegVec ridx_gray_sync_2 ( // @[Asyncqueue.scala 94:14]
    .clock(ridx_gray_sync_2_clock),
    .reset(ridx_gray_sync_2_reset),
    .io_d(ridx_gray_sync_2_io_d),
    .io_q(ridx_gray_sync_2_io_q)
  );
  AsyncResetRegVec ready_reg ( // @[Asyncqueue.scala 62:21]
    .clock(ready_reg_clock),
    .reset(ready_reg_reset),
    .io_d(ready_reg_io_d),
    .io_q(ready_reg_io_q)
  );
  AsyncResetRegVec widx_gray ( // @[Asyncqueue.scala 62:21]
    .clock(widx_gray_clock),
    .reset(widx_gray_reset),
    .io_d(widx_gray_io_d),
    .io_q(widx_gray_io_q)
  );
  AsyncValidSync AsyncValidSync ( // @[Asyncqueue.scala 149:30]
    .clock(AsyncValidSync_clock),
    .reset(AsyncValidSync_reset),
    .io_out(AsyncValidSync_io_out)
  );
  AsyncValidSync_1 AsyncValidSync_1 ( // @[Asyncqueue.scala 150:30]
    .clock(AsyncValidSync_1_clock),
    .reset(AsyncValidSync_1_reset),
    .io_in(AsyncValidSync_1_io_in),
    .io_out(AsyncValidSync_1_io_out)
  );
  AsyncValidSync_2 AsyncValidSync_2 ( // @[Asyncqueue.scala 151:30]
    .clock(AsyncValidSync_2_clock),
    .reset(AsyncValidSync_2_reset),
    .io_in(AsyncValidSync_2_io_in),
    .io_out(AsyncValidSync_2_io_out)
  );
  assign io_enq_ready = ready_reg_1 & sink_ready; // @[Asyncqueue.scala 140:16]
  assign io_widx = widx_gray_io_q; // @[Asyncqueue.scala 143:11]
  assign io_mem_0_data = mem_0_data; // @[Asyncqueue.scala 145:61]
  assign io_widx_valid = AsyncValidSync_io_out; // @[Asyncqueue.scala 147:17 Asyncqueue.scala 156:19]
  assign widx_bin_clock = clock;
  assign widx_bin_reset = reset;
  assign widx_bin_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign ridx_gray_sync_0_clock = clock;
  assign ridx_gray_sync_0_reset = reset;
  assign ridx_gray_sync_0_io_d = ridx_gray_sync_1_io_q; // @[Asyncqueue.scala 99:17]
  assign ridx_gray_sync_1_clock = clock;
  assign ridx_gray_sync_1_reset = reset;
  assign ridx_gray_sync_1_io_d = ridx_gray_sync_2_io_q; // @[Asyncqueue.scala 99:17]
  assign ridx_gray_sync_2_clock = clock;
  assign ridx_gray_sync_2_reset = reset;
  assign ridx_gray_sync_2_io_d = io_ridx; // @[Asyncqueue.scala 96:21]
  assign ready_reg_clock = clock;
  assign ready_reg_reset = reset;
  assign ready_reg_io_d = sink_ready & _T_8; // @[Asyncqueue.scala 64:14]
  assign widx_gray_clock = clock;
  assign widx_gray_reset = reset;
  assign widx_gray_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign AsyncValidSync_clock = clock;
  assign AsyncValidSync_reset = reset | _T_12; // @[Asyncqueue.scala 152:24]
  assign AsyncValidSync_1_clock = clock;
  assign AsyncValidSync_1_reset = reset | _T_12; // @[Asyncqueue.scala 153:24]
  assign AsyncValidSync_1_io_in = io_ridx_valid; // @[Asyncqueue.scala 157:23]
  assign AsyncValidSync_2_clock = clock;
  assign AsyncValidSync_2_reset = reset;
  assign AsyncValidSync_2_io_in = AsyncValidSync_1_io_out; // @[Asyncqueue.scala 158:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mem_0_data = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T) begin
      mem_0_data <= io_enq_bits_data;
    end
  end
endmodule
module AsyncQueueSink_1(
  input         clock,
  input         reset,
  output        io_deq_valid,
  output [31:0] io_deq_bits_data,
  output        io_ridx,
  input         io_widx,
  input  [31:0] io_mem_0_data,
  input         io_source_reset_n,
  output        io_ridx_valid,
  input         io_widx_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  ridx_bin_clock; // @[Asyncqueue.scala 62:21]
  wire  ridx_bin_reset; // @[Asyncqueue.scala 62:21]
  wire  ridx_bin_io_d; // @[Asyncqueue.scala 62:21]
  wire  ridx_bin_io_q; // @[Asyncqueue.scala 62:21]
  wire  widx_gray_sync_0_clock; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_0_reset; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_0_io_d; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_0_io_q; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_clock; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_reset; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_io_d; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_1_io_q; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_clock; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_reset; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_io_d; // @[Asyncqueue.scala 94:14]
  wire  widx_gray_sync_2_io_q; // @[Asyncqueue.scala 94:14]
  wire  valid_reg_clock; // @[Asyncqueue.scala 62:21]
  wire  valid_reg_reset; // @[Asyncqueue.scala 62:21]
  wire  valid_reg_io_d; // @[Asyncqueue.scala 62:21]
  wire  valid_reg_io_q; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_clock; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_reset; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_io_d; // @[Asyncqueue.scala 62:21]
  wire  ridx_gray_io_q; // @[Asyncqueue.scala 62:21]
  wire  AsyncValidSync_clock; // @[Asyncqueue.scala 213:31]
  wire  AsyncValidSync_reset; // @[Asyncqueue.scala 213:31]
  wire  AsyncValidSync_io_out; // @[Asyncqueue.scala 213:31]
  wire  AsyncValidSync_1_clock; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_1_reset; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_1_io_in; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_1_io_out; // @[Asyncqueue.scala 214:31]
  wire  AsyncValidSync_2_clock; // @[Asyncqueue.scala 215:31]
  wire  AsyncValidSync_2_reset; // @[Asyncqueue.scala 215:31]
  wire  AsyncValidSync_2_io_in; // @[Asyncqueue.scala 215:31]
  wire  AsyncValidSync_2_io_out; // @[Asyncqueue.scala 215:31]
  wire  AsyncResetRegVec_clock; // @[Asyncqueue.scala 62:21]
  wire  AsyncResetRegVec_reset; // @[Asyncqueue.scala 62:21]
  wire  AsyncResetRegVec_io_d; // @[Asyncqueue.scala 62:21]
  wire  AsyncResetRegVec_io_q; // @[Asyncqueue.scala 62:21]
  wire  source_ready = AsyncValidSync_2_io_out; // @[Asyncqueue.scala 223:18]
  wire  _T_1 = ~source_ready; // @[Asyncqueue.scala 189:49]
  wire  _T_4 = ridx_bin_io_q + io_deq_valid; // @[Asyncqueue.scala 86:47]
  wire  ridx = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 86:23]
  wire  _T_7 = ridx != widx_gray_sync_0_io_q; // @[Asyncqueue.scala 191:36]
  wire  valid = source_ready & _T_7; // @[Asyncqueue.scala 191:28]
  reg [31:0] _T_8_data; // @[Reg.scala 15:16]
  wire  valid_reg_1 = valid_reg_io_q; // @[Asyncqueue.scala 205:59]
  wire  _T_11 = ~io_source_reset_n; // @[Asyncqueue.scala 216:37]
  AsyncResetRegVec ridx_bin ( // @[Asyncqueue.scala 62:21]
    .clock(ridx_bin_clock),
    .reset(ridx_bin_reset),
    .io_d(ridx_bin_io_d),
    .io_q(ridx_bin_io_q)
  );
  AsyncResetRegVec widx_gray_sync_0 ( // @[Asyncqueue.scala 94:14]
    .clock(widx_gray_sync_0_clock),
    .reset(widx_gray_sync_0_reset),
    .io_d(widx_gray_sync_0_io_d),
    .io_q(widx_gray_sync_0_io_q)
  );
  AsyncResetRegVec widx_gray_sync_1 ( // @[Asyncqueue.scala 94:14]
    .clock(widx_gray_sync_1_clock),
    .reset(widx_gray_sync_1_reset),
    .io_d(widx_gray_sync_1_io_d),
    .io_q(widx_gray_sync_1_io_q)
  );
  AsyncResetRegVec widx_gray_sync_2 ( // @[Asyncqueue.scala 94:14]
    .clock(widx_gray_sync_2_clock),
    .reset(widx_gray_sync_2_reset),
    .io_d(widx_gray_sync_2_io_d),
    .io_q(widx_gray_sync_2_io_q)
  );
  AsyncResetRegVec valid_reg ( // @[Asyncqueue.scala 62:21]
    .clock(valid_reg_clock),
    .reset(valid_reg_reset),
    .io_d(valid_reg_io_d),
    .io_q(valid_reg_io_q)
  );
  AsyncResetRegVec ridx_gray ( // @[Asyncqueue.scala 62:21]
    .clock(ridx_gray_clock),
    .reset(ridx_gray_reset),
    .io_d(ridx_gray_io_d),
    .io_q(ridx_gray_io_q)
  );
  AsyncValidSync AsyncValidSync ( // @[Asyncqueue.scala 213:31]
    .clock(AsyncValidSync_clock),
    .reset(AsyncValidSync_reset),
    .io_out(AsyncValidSync_io_out)
  );
  AsyncValidSync_1 AsyncValidSync_1 ( // @[Asyncqueue.scala 214:31]
    .clock(AsyncValidSync_1_clock),
    .reset(AsyncValidSync_1_reset),
    .io_in(AsyncValidSync_1_io_in),
    .io_out(AsyncValidSync_1_io_out)
  );
  AsyncValidSync_2 AsyncValidSync_2 ( // @[Asyncqueue.scala 215:31]
    .clock(AsyncValidSync_2_clock),
    .reset(AsyncValidSync_2_reset),
    .io_in(AsyncValidSync_2_io_in),
    .io_out(AsyncValidSync_2_io_out)
  );
  AsyncResetRegVec AsyncResetRegVec ( // @[Asyncqueue.scala 62:21]
    .clock(AsyncResetRegVec_clock),
    .reset(AsyncResetRegVec_reset),
    .io_d(AsyncResetRegVec_io_d),
    .io_q(AsyncResetRegVec_io_q)
  );
  assign io_deq_valid = valid_reg_1 & source_ready; // @[Asyncqueue.scala 206:16]
  assign io_deq_bits_data = _T_8_data; // @[Asyncqueue.scala 203:16]
  assign io_ridx = ridx_gray_io_q; // @[Asyncqueue.scala 209:11]
  assign io_ridx_valid = AsyncValidSync_io_out; // @[Asyncqueue.scala 211:17 Asyncqueue.scala 220:19]
  assign ridx_bin_clock = clock;
  assign ridx_bin_reset = reset;
  assign ridx_bin_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign widx_gray_sync_0_clock = clock;
  assign widx_gray_sync_0_reset = reset;
  assign widx_gray_sync_0_io_d = widx_gray_sync_1_io_q; // @[Asyncqueue.scala 99:17]
  assign widx_gray_sync_1_clock = clock;
  assign widx_gray_sync_1_reset = reset;
  assign widx_gray_sync_1_io_d = widx_gray_sync_2_io_q; // @[Asyncqueue.scala 99:17]
  assign widx_gray_sync_2_clock = clock;
  assign widx_gray_sync_2_reset = reset;
  assign widx_gray_sync_2_io_d = io_widx; // @[Asyncqueue.scala 96:21]
  assign valid_reg_clock = clock;
  assign valid_reg_reset = reset;
  assign valid_reg_io_d = source_ready & _T_7; // @[Asyncqueue.scala 64:14]
  assign ridx_gray_clock = clock;
  assign ridx_gray_reset = reset;
  assign ridx_gray_io_d = _T_1 ? 1'h0 : _T_4; // @[Asyncqueue.scala 64:14]
  assign AsyncValidSync_clock = clock;
  assign AsyncValidSync_reset = reset | _T_11; // @[Asyncqueue.scala 216:25]
  assign AsyncValidSync_1_clock = clock;
  assign AsyncValidSync_1_reset = reset | _T_11; // @[Asyncqueue.scala 217:25]
  assign AsyncValidSync_1_io_in = io_widx_valid; // @[Asyncqueue.scala 221:25]
  assign AsyncValidSync_2_clock = clock;
  assign AsyncValidSync_2_reset = reset;
  assign AsyncValidSync_2_io_in = AsyncValidSync_1_io_out; // @[Asyncqueue.scala 222:24]
  assign AsyncResetRegVec_clock = clock;
  assign AsyncResetRegVec_reset = reset;
  assign AsyncResetRegVec_io_d = io_widx == io_ridx; // @[Asyncqueue.scala 64:14]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_8_data = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (valid) begin
      _T_8_data <= io_mem_0_data;
    end
  end
endmodule
module AsyncQueue_1(
  input         io_enq_clock,
  input         io_enq_reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_data,
  input         io_deq_clock,
  input         io_deq_reset,
  output        io_deq_valid,
  output [31:0] io_deq_bits_data
);
  wire  source_clock; // @[Asyncqueue.scala 258:22]
  wire  source_reset; // @[Asyncqueue.scala 258:22]
  wire  source_io_enq_ready; // @[Asyncqueue.scala 258:22]
  wire  source_io_enq_valid; // @[Asyncqueue.scala 258:22]
  wire [31:0] source_io_enq_bits_data; // @[Asyncqueue.scala 258:22]
  wire  source_io_ridx; // @[Asyncqueue.scala 258:22]
  wire  source_io_widx; // @[Asyncqueue.scala 258:22]
  wire [31:0] source_io_mem_0_data; // @[Asyncqueue.scala 258:22]
  wire  source_io_sink_reset_n; // @[Asyncqueue.scala 258:22]
  wire  source_io_ridx_valid; // @[Asyncqueue.scala 258:22]
  wire  source_io_widx_valid; // @[Asyncqueue.scala 258:22]
  wire  sink_clock; // @[Asyncqueue.scala 259:22]
  wire  sink_reset; // @[Asyncqueue.scala 259:22]
  wire  sink_io_deq_valid; // @[Asyncqueue.scala 259:22]
  wire [31:0] sink_io_deq_bits_data; // @[Asyncqueue.scala 259:22]
  wire  sink_io_ridx; // @[Asyncqueue.scala 259:22]
  wire  sink_io_widx; // @[Asyncqueue.scala 259:22]
  wire [31:0] sink_io_mem_0_data; // @[Asyncqueue.scala 259:22]
  wire  sink_io_source_reset_n; // @[Asyncqueue.scala 259:22]
  wire  sink_io_ridx_valid; // @[Asyncqueue.scala 259:22]
  wire  sink_io_widx_valid; // @[Asyncqueue.scala 259:22]
  AsyncQueueSource_1 source ( // @[Asyncqueue.scala 258:22]
    .clock(source_clock),
    .reset(source_reset),
    .io_enq_ready(source_io_enq_ready),
    .io_enq_valid(source_io_enq_valid),
    .io_enq_bits_data(source_io_enq_bits_data),
    .io_ridx(source_io_ridx),
    .io_widx(source_io_widx),
    .io_mem_0_data(source_io_mem_0_data),
    .io_sink_reset_n(source_io_sink_reset_n),
    .io_ridx_valid(source_io_ridx_valid),
    .io_widx_valid(source_io_widx_valid)
  );
  AsyncQueueSink_1 sink ( // @[Asyncqueue.scala 259:22]
    .clock(sink_clock),
    .reset(sink_reset),
    .io_deq_valid(sink_io_deq_valid),
    .io_deq_bits_data(sink_io_deq_bits_data),
    .io_ridx(sink_io_ridx),
    .io_widx(sink_io_widx),
    .io_mem_0_data(sink_io_mem_0_data),
    .io_source_reset_n(sink_io_source_reset_n),
    .io_ridx_valid(sink_io_ridx_valid),
    .io_widx_valid(sink_io_widx_valid)
  );
  assign io_enq_ready = source_io_enq_ready; // @[Asyncqueue.scala 269:17]
  assign io_deq_valid = sink_io_deq_valid; // @[Asyncqueue.scala 270:10]
  assign io_deq_bits_data = sink_io_deq_bits_data; // @[Asyncqueue.scala 270:10]
  assign source_clock = io_enq_clock; // @[Asyncqueue.scala 261:16]
  assign source_reset = io_enq_reset; // @[Asyncqueue.scala 262:16]
  assign source_io_enq_valid = io_enq_valid; // @[Asyncqueue.scala 269:17]
  assign source_io_enq_bits_data = io_enq_bits_data; // @[Asyncqueue.scala 269:17]
  assign source_io_ridx = sink_io_ridx; // @[Asyncqueue.scala 275:18]
  assign source_io_sink_reset_n = ~io_deq_reset; // @[Asyncqueue.scala 266:26]
  assign source_io_ridx_valid = sink_io_ridx_valid; // @[Asyncqueue.scala 277:24]
  assign sink_clock = io_deq_clock; // @[Asyncqueue.scala 263:14]
  assign sink_reset = io_deq_reset; // @[Asyncqueue.scala 264:14]
  assign sink_io_widx = source_io_widx; // @[Asyncqueue.scala 274:16]
  assign sink_io_mem_0_data = source_io_mem_0_data; // @[Asyncqueue.scala 272:15]
  assign sink_io_source_reset_n = ~io_enq_reset; // @[Asyncqueue.scala 267:26]
  assign sink_io_widx_valid = source_io_widx_valid; // @[Asyncqueue.scala 276:22]
endmodule
module JtagToDM(
  output        io_Jtag_in_req_ready,
  input         io_Jtag_in_req_valid,
  input  [1:0]  io_Jtag_in_req_bits_op,
  input  [9:0]  io_Jtag_in_req_bits_addr,
  input  [31:0] io_Jtag_in_req_bits_data,
  input         io_DM_out_req_ready,
  output        io_DM_out_req_valid,
  output [1:0]  io_DM_out_req_bits_op,
  output [9:0]  io_DM_out_req_bits_addr,
  output [31:0] io_DM_out_req_bits_data,
  output        io_DM_in_resp_ready,
  input         io_DM_in_resp_valid,
  input  [31:0] io_DM_in_resp_bits_data,
  output        io_Jtag_out_resp_valid,
  output [31:0] io_Jtag_out_resp_bits_data,
  input         io_JtagReset,
  input         io_JtagClock,
  input         io_clock,
  input         io_reset
);
  wire  synchronizer_req_io_enq_clock; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_enq_reset; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_enq_ready; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_enq_valid; // @[Jtag2DM.scala 20:32]
  wire [1:0] synchronizer_req_io_enq_bits_op; // @[Jtag2DM.scala 20:32]
  wire [9:0] synchronizer_req_io_enq_bits_addr; // @[Jtag2DM.scala 20:32]
  wire [31:0] synchronizer_req_io_enq_bits_data; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_deq_clock; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_deq_reset; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_deq_ready; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_req_io_deq_valid; // @[Jtag2DM.scala 20:32]
  wire [1:0] synchronizer_req_io_deq_bits_op; // @[Jtag2DM.scala 20:32]
  wire [9:0] synchronizer_req_io_deq_bits_addr; // @[Jtag2DM.scala 20:32]
  wire [31:0] synchronizer_req_io_deq_bits_data; // @[Jtag2DM.scala 20:32]
  wire  synchronizer_resp_io_enq_clock; // @[Jtag2DM.scala 32:33]
  wire  synchronizer_resp_io_enq_reset; // @[Jtag2DM.scala 32:33]
  wire  synchronizer_resp_io_enq_ready; // @[Jtag2DM.scala 32:33]
  wire  synchronizer_resp_io_enq_valid; // @[Jtag2DM.scala 32:33]
  wire [31:0] synchronizer_resp_io_enq_bits_data; // @[Jtag2DM.scala 32:33]
  wire  synchronizer_resp_io_deq_clock; // @[Jtag2DM.scala 32:33]
  wire  synchronizer_resp_io_deq_reset; // @[Jtag2DM.scala 32:33]
  wire  synchronizer_resp_io_deq_valid; // @[Jtag2DM.scala 32:33]
  wire [31:0] synchronizer_resp_io_deq_bits_data; // @[Jtag2DM.scala 32:33]
  AsyncQueue synchronizer_req ( // @[Jtag2DM.scala 20:32]
    .io_enq_clock(synchronizer_req_io_enq_clock),
    .io_enq_reset(synchronizer_req_io_enq_reset),
    .io_enq_ready(synchronizer_req_io_enq_ready),
    .io_enq_valid(synchronizer_req_io_enq_valid),
    .io_enq_bits_op(synchronizer_req_io_enq_bits_op),
    .io_enq_bits_addr(synchronizer_req_io_enq_bits_addr),
    .io_enq_bits_data(synchronizer_req_io_enq_bits_data),
    .io_deq_clock(synchronizer_req_io_deq_clock),
    .io_deq_reset(synchronizer_req_io_deq_reset),
    .io_deq_ready(synchronizer_req_io_deq_ready),
    .io_deq_valid(synchronizer_req_io_deq_valid),
    .io_deq_bits_op(synchronizer_req_io_deq_bits_op),
    .io_deq_bits_addr(synchronizer_req_io_deq_bits_addr),
    .io_deq_bits_data(synchronizer_req_io_deq_bits_data)
  );
  AsyncQueue_1 synchronizer_resp ( // @[Jtag2DM.scala 32:33]
    .io_enq_clock(synchronizer_resp_io_enq_clock),
    .io_enq_reset(synchronizer_resp_io_enq_reset),
    .io_enq_ready(synchronizer_resp_io_enq_ready),
    .io_enq_valid(synchronizer_resp_io_enq_valid),
    .io_enq_bits_data(synchronizer_resp_io_enq_bits_data),
    .io_deq_clock(synchronizer_resp_io_deq_clock),
    .io_deq_reset(synchronizer_resp_io_deq_reset),
    .io_deq_valid(synchronizer_resp_io_deq_valid),
    .io_deq_bits_data(synchronizer_resp_io_deq_bits_data)
  );
  assign io_Jtag_in_req_ready = synchronizer_req_io_enq_ready; // @[Jtag2DM.scala 25:27]
  assign io_DM_out_req_valid = synchronizer_req_io_deq_valid; // @[Jtag2DM.scala 29:17]
  assign io_DM_out_req_bits_op = synchronizer_req_io_deq_bits_op; // @[Jtag2DM.scala 29:17]
  assign io_DM_out_req_bits_addr = synchronizer_req_io_deq_bits_addr; // @[Jtag2DM.scala 29:17]
  assign io_DM_out_req_bits_data = synchronizer_req_io_deq_bits_data; // @[Jtag2DM.scala 29:17]
  assign io_DM_in_resp_ready = synchronizer_resp_io_enq_ready; // @[Jtag2DM.scala 35:28]
  assign io_Jtag_out_resp_valid = synchronizer_resp_io_deq_valid; // @[Jtag2DM.scala 39:20]
  assign io_Jtag_out_resp_bits_data = synchronizer_resp_io_deq_bits_data; // @[Jtag2DM.scala 39:20]
  assign synchronizer_req_io_enq_clock = io_JtagClock; // @[Jtag2DM.scala 23:33]
  assign synchronizer_req_io_enq_reset = ~io_JtagReset; // @[Jtag2DM.scala 24:33]
  assign synchronizer_req_io_enq_valid = io_Jtag_in_req_valid; // @[Jtag2DM.scala 25:27]
  assign synchronizer_req_io_enq_bits_op = io_Jtag_in_req_bits_op; // @[Jtag2DM.scala 25:27]
  assign synchronizer_req_io_enq_bits_addr = io_Jtag_in_req_bits_addr; // @[Jtag2DM.scala 25:27]
  assign synchronizer_req_io_enq_bits_data = io_Jtag_in_req_bits_data; // @[Jtag2DM.scala 25:27]
  assign synchronizer_req_io_deq_clock = io_clock; // @[Jtag2DM.scala 27:33]
  assign synchronizer_req_io_deq_reset = io_reset; // @[Jtag2DM.scala 28:33]
  assign synchronizer_req_io_deq_ready = io_DM_out_req_ready; // @[Jtag2DM.scala 29:17]
  assign synchronizer_resp_io_enq_clock = io_clock; // @[Jtag2DM.scala 33:34]
  assign synchronizer_resp_io_enq_reset = io_reset; // @[Jtag2DM.scala 34:34]
  assign synchronizer_resp_io_enq_valid = io_DM_in_resp_valid; // @[Jtag2DM.scala 35:28]
  assign synchronizer_resp_io_enq_bits_data = io_DM_in_resp_bits_data; // @[Jtag2DM.scala 35:28]
  assign synchronizer_resp_io_deq_clock = io_JtagClock; // @[Jtag2DM.scala 37:34]
  assign synchronizer_resp_io_deq_reset = ~io_JtagReset; // @[Jtag2DM.scala 38:34]
endmodule
module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input         io_enq_bits_read,
  input  [5:0]  io_enq_bits_index,
  input  [31:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_deq_valid,
  output        io_deq_bits_read,
  output [5:0]  io_deq_bits_index,
  output [31:0] io_deq_bits_data,
  output [3:0]  io_deq_bits_mask
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg  ram_read [0:2]; // @[Decoupled.scala 218:16]
  wire  ram_read__T_15_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_read__T_15_addr; // @[Decoupled.scala 218:16]
  wire  ram_read__T_5_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_read__T_5_addr; // @[Decoupled.scala 218:16]
  wire  ram_read__T_5_mask; // @[Decoupled.scala 218:16]
  wire  ram_read__T_5_en; // @[Decoupled.scala 218:16]
  reg [5:0] ram_index [0:2]; // @[Decoupled.scala 218:16]
  wire [5:0] ram_index__T_15_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_index__T_15_addr; // @[Decoupled.scala 218:16]
  wire [5:0] ram_index__T_5_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_index__T_5_addr; // @[Decoupled.scala 218:16]
  wire  ram_index__T_5_mask; // @[Decoupled.scala 218:16]
  wire  ram_index__T_5_en; // @[Decoupled.scala 218:16]
  reg [31:0] ram_data [0:2]; // @[Decoupled.scala 218:16]
  wire [31:0] ram_data__T_15_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_data__T_15_addr; // @[Decoupled.scala 218:16]
  wire [31:0] ram_data__T_5_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_data__T_5_addr; // @[Decoupled.scala 218:16]
  wire  ram_data__T_5_mask; // @[Decoupled.scala 218:16]
  wire  ram_data__T_5_en; // @[Decoupled.scala 218:16]
  reg [3:0] ram_mask [0:2]; // @[Decoupled.scala 218:16]
  wire [3:0] ram_mask__T_15_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_mask__T_15_addr; // @[Decoupled.scala 218:16]
  wire [3:0] ram_mask__T_5_data; // @[Decoupled.scala 218:16]
  wire [1:0] ram_mask__T_5_addr; // @[Decoupled.scala 218:16]
  wire  ram_mask__T_5_mask; // @[Decoupled.scala 218:16]
  wire  ram_mask__T_5_en; // @[Decoupled.scala 218:16]
  reg [1:0] _T; // @[Counter.scala 29:33]
  reg [1:0] _T_1; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = _T == _T_1; // @[Decoupled.scala 223:33]
  wire  _T_2 = ~maybe_full; // @[Decoupled.scala 224:28]
  wire  empty = ptr_match & _T_2; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_6 = _T == 2'h2; // @[Counter.scala 38:24]
  wire [1:0] _T_8 = _T + 2'h1; // @[Counter.scala 39:22]
  wire  _T_9 = _T_1 == 2'h2; // @[Counter.scala 38:24]
  wire [1:0] _T_11 = _T_1 + 2'h1; // @[Counter.scala 39:22]
  wire  _T_12 = do_enq != do_deq; // @[Decoupled.scala 236:16]
  assign ram_read__T_15_addr = _T_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_read__T_15_data = ram_read[ram_read__T_15_addr]; // @[Decoupled.scala 218:16]
  `else
  assign ram_read__T_15_data = ram_read__T_15_addr >= 2'h3 ? _RAND_1[0:0] : ram_read[ram_read__T_15_addr]; // @[Decoupled.scala 218:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_read__T_5_data = io_enq_bits_read;
  assign ram_read__T_5_addr = _T;
  assign ram_read__T_5_mask = 1'h1;
  assign ram_read__T_5_en = io_enq_ready & io_enq_valid;
  assign ram_index__T_15_addr = _T_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_index__T_15_data = ram_index[ram_index__T_15_addr]; // @[Decoupled.scala 218:16]
  `else
  assign ram_index__T_15_data = ram_index__T_15_addr >= 2'h3 ? _RAND_3[5:0] : ram_index[ram_index__T_15_addr]; // @[Decoupled.scala 218:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_index__T_5_data = io_enq_bits_index;
  assign ram_index__T_5_addr = _T;
  assign ram_index__T_5_mask = 1'h1;
  assign ram_index__T_5_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_15_addr = _T_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_data__T_15_data = ram_data[ram_data__T_15_addr]; // @[Decoupled.scala 218:16]
  `else
  assign ram_data__T_15_data = ram_data__T_15_addr >= 2'h3 ? _RAND_5[31:0] : ram_data[ram_data__T_15_addr]; // @[Decoupled.scala 218:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_data__T_5_data = io_enq_bits_data;
  assign ram_data__T_5_addr = _T;
  assign ram_data__T_5_mask = 1'h1;
  assign ram_data__T_5_en = io_enq_ready & io_enq_valid;
  assign ram_mask__T_15_addr = _T_1;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_mask__T_15_data = ram_mask[ram_mask__T_15_addr]; // @[Decoupled.scala 218:16]
  `else
  assign ram_mask__T_15_data = ram_mask__T_15_addr >= 2'h3 ? _RAND_7[3:0] : ram_mask[ram_mask__T_15_addr]; // @[Decoupled.scala 218:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_mask__T_5_data = 4'hf;
  assign ram_mask__T_5_addr = _T;
  assign ram_mask__T_5_mask = 1'h1;
  assign ram_mask__T_5_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:16]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:16]
  assign io_deq_bits_read = ram_read__T_15_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_index = ram_index__T_15_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_data = ram_data__T_15_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_mask = ram_mask__T_15_data; // @[Decoupled.scala 242:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
  _RAND_3 = {1{`RANDOM}};
  _RAND_5 = {1{`RANDOM}};
  _RAND_7 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_read[initvar] = _RAND_0[0:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_index[initvar] = _RAND_2[5:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_data[initvar] = _RAND_4[31:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    ram_mask[initvar] = _RAND_6[3:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  _T_1 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  maybe_full = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_read__T_5_en & ram_read__T_5_mask) begin
      ram_read[ram_read__T_5_addr] <= ram_read__T_5_data; // @[Decoupled.scala 218:16]
    end
    if(ram_index__T_5_en & ram_index__T_5_mask) begin
      ram_index[ram_index__T_5_addr] <= ram_index__T_5_data; // @[Decoupled.scala 218:16]
    end
    if(ram_data__T_5_en & ram_data__T_5_mask) begin
      ram_data[ram_data__T_5_addr] <= ram_data__T_5_data; // @[Decoupled.scala 218:16]
    end
    if(ram_mask__T_5_en & ram_mask__T_5_mask) begin
      ram_mask[ram_mask__T_5_addr] <= ram_mask__T_5_data; // @[Decoupled.scala 218:16]
    end
    if (reset) begin
      _T <= 2'h0;
    end else if (do_enq) begin
      if (_T_6) begin
        _T <= 2'h0;
      end else begin
        _T <= _T_8;
      end
    end
    if (reset) begin
      _T_1 <= 2'h0;
    end else if (do_deq) begin
      if (_T_9) begin
        _T_1 <= 2'h0;
      end else begin
        _T_1 <= _T_11;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_12) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module FilterBM(
  input         clock,
  input         reset,
  input  [3:0]  io_filterin_idsrc,
  input  [31:0] io_filterin_iddest,
  input  [31:0] io_filterin_data,
  input         io_filterin_op,
  input         io_filterin_newtrans,
  input         io_filterin_finishtrans,
  output        io_filterout_op,
  output        io_filterout_newtrans,
  output        io_filterout_finishtrans,
  input  [31:0] io_dminput_dataref,
  input  [9:0]  io_dminput_analisys,
  input  [31:0] io_dminput_offset,
  input         io_dminput_refresh,
  input         io_dminput_fenable
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataref; // @[BusMonitor.scala 152:30]
  reg [9:0] analisys; // @[BusMonitor.scala 153:31]
  reg [31:0] offset; // @[BusMonitor.scala 154:29]
  reg  Fenable; // @[BusMonitor.scala 155:30]
  wire  _T_3 = analisys[3:0] == 4'h0; // @[BusMonitor.scala 186:28]
  wire  _T_5 = 6'h0 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_6 = io_filterin_data == dataref; // @[BusMonitor.scala 189:55]
  wire  _T_7 = 6'h1 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_8 = io_filterin_data > dataref; // @[BusMonitor.scala 193:55]
  wire  _T_9 = 6'h2 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_10 = io_filterin_data >= dataref; // @[BusMonitor.scala 197:55]
  wire  _T_11 = 6'h3 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_12 = io_filterin_data < dataref; // @[BusMonitor.scala 201:55]
  wire  _T_13 = 6'h4 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_14 = io_filterin_data <= dataref; // @[BusMonitor.scala 205:55]
  wire  _T_15 = 6'h5 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_16 = io_filterin_data != dataref; // @[BusMonitor.scala 209:55]
  wire  _T_17 = 6'h6 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_19 = io_filterin_data <= offset; // @[BusMonitor.scala 213:90]
  wire  _T_20 = _T_10 & _T_19; // @[BusMonitor.scala 213:69]
  wire  _T_21 = 6'h7 == analisys[9:4]; // @[Conditional.scala 37:30]
  wire  _T_23 = io_filterin_data >= offset; // @[BusMonitor.scala 217:90]
  wire  _T_24 = _T_14 & _T_23; // @[BusMonitor.scala 217:69]
  wire  _GEN_16 = _T_21 & _T_24; // @[Conditional.scala 39:67]
  wire  _GEN_17 = _T_17 ? _T_20 : _GEN_16; // @[Conditional.scala 39:67]
  wire  _GEN_18 = _T_15 ? _T_16 : _GEN_17; // @[Conditional.scala 39:67]
  wire  _GEN_19 = _T_13 ? _T_14 : _GEN_18; // @[Conditional.scala 39:67]
  wire  _GEN_20 = _T_11 ? _T_12 : _GEN_19; // @[Conditional.scala 39:67]
  wire  _GEN_21 = _T_9 ? _T_10 : _GEN_20; // @[Conditional.scala 39:67]
  wire  _GEN_22 = _T_7 ? _T_8 : _GEN_21; // @[Conditional.scala 39:67]
  wire  _GEN_23 = _T_5 ? _T_6 : _GEN_22; // @[Conditional.scala 40:58]
  wire  _T_26 = analisys[3:0] == 4'h1; // @[BusMonitor.scala 222:33]
  wire [31:0] _GEN_93 = {{28'd0}, io_filterin_idsrc}; // @[BusMonitor.scala 225:56]
  wire  _T_29 = _GEN_93 == dataref; // @[BusMonitor.scala 225:56]
  wire  _T_31 = _GEN_93 > dataref; // @[BusMonitor.scala 229:56]
  wire  _T_33 = _GEN_93 >= dataref; // @[BusMonitor.scala 233:56]
  wire  _T_35 = _GEN_93 < dataref; // @[BusMonitor.scala 237:56]
  wire  _T_37 = _GEN_93 <= dataref; // @[BusMonitor.scala 241:56]
  wire  _T_39 = _GEN_93 != dataref; // @[BusMonitor.scala 245:56]
  wire  _T_42 = _GEN_93 <= offset; // @[BusMonitor.scala 249:92]
  wire  _T_43 = _T_33 & _T_42; // @[BusMonitor.scala 249:70]
  wire  _T_46 = _GEN_93 >= offset; // @[BusMonitor.scala 253:92]
  wire  _T_47 = _T_37 & _T_46; // @[BusMonitor.scala 253:70]
  wire  _GEN_32 = _T_21 & _T_47; // @[Conditional.scala 39:67]
  wire  _GEN_33 = _T_17 ? _T_43 : _GEN_32; // @[Conditional.scala 39:67]
  wire  _GEN_34 = _T_15 ? _T_39 : _GEN_33; // @[Conditional.scala 39:67]
  wire  _GEN_35 = _T_13 ? _T_37 : _GEN_34; // @[Conditional.scala 39:67]
  wire  _GEN_36 = _T_11 ? _T_35 : _GEN_35; // @[Conditional.scala 39:67]
  wire  _GEN_37 = _T_9 ? _T_33 : _GEN_36; // @[Conditional.scala 39:67]
  wire  _GEN_38 = _T_7 ? _T_31 : _GEN_37; // @[Conditional.scala 39:67]
  wire  _GEN_39 = _T_5 ? _T_29 : _GEN_38; // @[Conditional.scala 40:58]
  wire  _T_49 = analisys[3:0] == 4'h2; // @[BusMonitor.scala 258:33]
  wire  _T_52 = io_filterin_iddest == dataref; // @[BusMonitor.scala 261:57]
  wire  _T_54 = io_filterin_iddest > dataref; // @[BusMonitor.scala 265:57]
  wire  _T_56 = io_filterin_iddest >= dataref; // @[BusMonitor.scala 269:57]
  wire  _T_58 = io_filterin_iddest < dataref; // @[BusMonitor.scala 273:57]
  wire  _T_60 = io_filterin_iddest <= dataref; // @[BusMonitor.scala 277:57]
  wire  _T_62 = io_filterin_iddest != dataref; // @[BusMonitor.scala 281:57]
  wire  _T_65 = io_filterin_iddest <= offset; // @[BusMonitor.scala 285:94]
  wire  _T_66 = _T_56 & _T_65; // @[BusMonitor.scala 285:71]
  wire  _T_69 = io_filterin_iddest >= offset; // @[BusMonitor.scala 289:94]
  wire  _T_70 = _T_60 & _T_69; // @[BusMonitor.scala 289:71]
  wire  _GEN_48 = _T_21 & _T_70; // @[Conditional.scala 39:67]
  wire  _GEN_49 = _T_17 ? _T_66 : _GEN_48; // @[Conditional.scala 39:67]
  wire  _GEN_50 = _T_15 ? _T_62 : _GEN_49; // @[Conditional.scala 39:67]
  wire  _GEN_51 = _T_13 ? _T_60 : _GEN_50; // @[Conditional.scala 39:67]
  wire  _GEN_52 = _T_11 ? _T_58 : _GEN_51; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_9 ? _T_56 : _GEN_52; // @[Conditional.scala 39:67]
  wire  _GEN_54 = _T_7 ? _T_54 : _GEN_53; // @[Conditional.scala 39:67]
  wire  _GEN_55 = _T_5 ? _T_52 : _GEN_54; // @[Conditional.scala 40:58]
  wire  _T_72 = analisys[3:0] == 4'h3; // @[BusMonitor.scala 294:33]
  wire  _T_74 = io_filterin_op == dataref[0]; // @[BusMonitor.scala 295:37]
  wire  _T_76 = analisys[3:0] == 4'h4; // @[BusMonitor.scala 298:33]
  wire  _T_80 = io_filterin_iddest == offset; // @[BusMonitor.scala 301:94]
  wire  _T_81 = _T_29 & _T_80; // @[BusMonitor.scala 301:71]
  wire  _T_84 = io_filterin_iddest > offset; // @[BusMonitor.scala 305:91]
  wire  _T_85 = _T_31 & _T_84; // @[BusMonitor.scala 305:68]
  wire  _T_89 = _T_33 & _T_69; // @[BusMonitor.scala 309:69]
  wire  _T_92 = io_filterin_iddest < offset; // @[BusMonitor.scala 313:91]
  wire  _T_93 = _T_35 & _T_92; // @[BusMonitor.scala 313:68]
  wire  _T_97 = _T_37 & _T_65; // @[BusMonitor.scala 317:69]
  wire  _T_100 = io_filterin_iddest != offset; // @[BusMonitor.scala 321:93]
  wire  _T_101 = _T_39 & _T_100; // @[BusMonitor.scala 321:70]
  wire  _GEN_63 = _T_15 & _T_101; // @[Conditional.scala 39:67]
  wire  _GEN_64 = _T_13 ? _T_97 : _GEN_63; // @[Conditional.scala 39:67]
  wire  _GEN_65 = _T_11 ? _T_93 : _GEN_64; // @[Conditional.scala 39:67]
  wire  _GEN_66 = _T_9 ? _T_89 : _GEN_65; // @[Conditional.scala 39:67]
  wire  _GEN_67 = _T_7 ? _T_85 : _GEN_66; // @[Conditional.scala 39:67]
  wire  _GEN_68 = _T_5 ? _T_81 : _GEN_67; // @[Conditional.scala 40:58]
  wire  _T_103 = analisys[3:0] == 4'h5; // @[BusMonitor.scala 326:33]
  wire  _T_108 = _T_6 & _T_80; // @[BusMonitor.scala 329:70]
  wire  _T_112 = _T_8 & _T_84; // @[BusMonitor.scala 333:67]
  wire  _T_116 = _T_10 & _T_69; // @[BusMonitor.scala 337:68]
  wire  _T_120 = _T_12 & _T_92; // @[BusMonitor.scala 341:67]
  wire  _T_124 = _T_14 & _T_65; // @[BusMonitor.scala 345:68]
  wire  _T_128 = _T_16 & _T_100; // @[BusMonitor.scala 349:69]
  wire  _GEN_75 = _T_15 & _T_128; // @[Conditional.scala 39:67]
  wire  _GEN_76 = _T_13 ? _T_124 : _GEN_75; // @[Conditional.scala 39:67]
  wire  _GEN_77 = _T_11 ? _T_120 : _GEN_76; // @[Conditional.scala 39:67]
  wire  _GEN_78 = _T_9 ? _T_116 : _GEN_77; // @[Conditional.scala 39:67]
  wire  _GEN_79 = _T_7 ? _T_112 : _GEN_78; // @[Conditional.scala 39:67]
  wire  _GEN_80 = _T_5 ? _T_108 : _GEN_79; // @[Conditional.scala 40:58]
  wire  _GEN_81 = _T_103 & _GEN_80; // @[BusMonitor.scala 326:41]
  wire  _GEN_82 = _T_76 ? _GEN_68 : _GEN_81; // @[BusMonitor.scala 298:41]
  wire  _GEN_83 = _T_72 ? _T_74 : _GEN_82; // @[BusMonitor.scala 294:41]
  wire  _GEN_84 = _T_49 ? _GEN_55 : _GEN_83; // @[BusMonitor.scala 258:41]
  wire  _GEN_85 = _T_26 ? _GEN_39 : _GEN_84; // @[BusMonitor.scala 222:41]
  wire  pass = _T_3 ? _GEN_23 : _GEN_85; // @[BusMonitor.scala 186:36]
  wire  pass2 = io_filterin_newtrans & pass; // @[BusMonitor.scala 176:39]
  reg  newtransout; // @[BusMonitor.scala 178:34]
  reg  finishtransout; // @[BusMonitor.scala 179:37]
  reg  outfilter_op; // @[Reg.scala 15:16]
  assign io_filterout_op = Fenable ? outfilter_op : io_filterin_op; // @[BusMonitor.scala 363:33 BusMonitor.scala 366:34]
  assign io_filterout_newtrans = Fenable ? newtransout : io_filterin_newtrans; // @[BusMonitor.scala 364:39 BusMonitor.scala 366:34]
  assign io_filterout_finishtrans = Fenable ? finishtransout : io_filterin_finishtrans; // @[BusMonitor.scala 365:42 BusMonitor.scala 366:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  dataref = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  analisys = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  offset = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  Fenable = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  newtransout = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  finishtransout = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  outfilter_op = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      dataref <= 32'h0;
    end else if (io_dminput_refresh) begin
      dataref <= io_dminput_dataref;
    end
    if (reset) begin
      analisys <= 10'h0;
    end else if (io_dminput_refresh) begin
      analisys <= io_dminput_analisys;
    end
    if (reset) begin
      offset <= 32'h0;
    end else if (io_dminput_refresh) begin
      offset <= io_dminput_offset;
    end
    if (reset) begin
      Fenable <= 1'h0;
    end else if (io_dminput_refresh) begin
      Fenable <= io_dminput_fenable;
    end
    newtransout <= io_filterin_newtrans & pass;
    finishtransout <= io_filterin_finishtrans & pass;
    if (pass2) begin
      outfilter_op <= io_filterin_op;
    end
  end
endmodule
module Performance_counter(
  input         clock,
  input         reset,
  input         io_pcinput_op,
  input         io_pcinput_newtrans,
  input         io_pcinput_finishtrans,
  input  [31:0] io_dmport_LatencyRangesW,
  input  [31:0] io_dmport_LatencyRangesR,
  input         io_dmport_Refresh,
  input  [3:0]  io_dmport_TagID_Reg,
  input         io_dmport_ReadRequest,
  input         io_dmport_Restart_Counters,
  output [31:0] io_dmport_Out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] Trans_counter_read; // @[BusMonitor.scala 58:41]
  reg [31:0] Trans_counter_write; // @[BusMonitor.scala 59:42]
  reg [15:0] LatCountersW_0; // @[BusMonitor.scala 63:35]
  reg [15:0] LatCountersW_1; // @[BusMonitor.scala 63:35]
  reg [15:0] LatCountersW_2; // @[BusMonitor.scala 63:35]
  reg [15:0] LatCountersW_3; // @[BusMonitor.scala 63:35]
  reg [15:0] LatCountersR_0; // @[BusMonitor.scala 64:35]
  reg [15:0] LatCountersR_1; // @[BusMonitor.scala 64:35]
  reg [15:0] LatCountersR_2; // @[BusMonitor.scala 64:35]
  reg [15:0] LatCountersR_3; // @[BusMonitor.scala 64:35]
  reg [19:0] validcounter; // @[BusMonitor.scala 65:35]
  reg [31:0] LatencyRangesW; // @[BusMonitor.scala 67:37]
  reg [31:0] LatencyRangesR; // @[BusMonitor.scala 68:37]
  reg [9:0] counter_for_latency; // @[BusMonitor.scala 71:42]
  reg  count_w; // @[BusMonitor.scala 72:30]
  reg  RegInputs; // @[Reg.scala 15:16]
  wire [31:0] _T_3 = Trans_counter_write + 32'h1; // @[BusMonitor.scala 87:93]
  wire [31:0] _T_5 = Trans_counter_read + 32'h1; // @[BusMonitor.scala 88:79]
  wire  counter_actived = io_pcinput_newtrans | io_pcinput_finishtrans; // @[BusMonitor.scala 92:48]
  wire  _T_7 = ~count_w; // @[BusMonitor.scala 94:42]
  wire [9:0] _T_9 = counter_for_latency + 10'h1; // @[BusMonitor.scala 96:66]
  wire [9:0] _GEN_68 = {{2'd0}, LatencyRangesW[7:0]}; // @[BusMonitor.scala 111:60]
  wire  _T_11 = counter_for_latency <= _GEN_68; // @[BusMonitor.scala 111:60]
  wire [15:0] _T_13 = LatCountersW_0 + 16'h1; // @[BusMonitor.scala 111:120]
  wire [9:0] _GEN_69 = {{2'd0}, LatencyRangesW[15:8]}; // @[BusMonitor.scala 112:65]
  wire  _T_15 = counter_for_latency <= _GEN_69; // @[BusMonitor.scala 112:65]
  wire  _T_17 = counter_for_latency > _GEN_68; // @[BusMonitor.scala 112:114]
  wire  _T_18 = _T_15 & _T_17; // @[BusMonitor.scala 112:90]
  wire [15:0] _T_20 = LatCountersW_1 + 16'h1; // @[BusMonitor.scala 112:173]
  wire [9:0] _GEN_71 = {{2'd0}, LatencyRangesW[23:16]}; // @[BusMonitor.scala 113:65]
  wire  _T_22 = counter_for_latency <= _GEN_71; // @[BusMonitor.scala 113:65]
  wire  _T_24 = counter_for_latency > _GEN_69; // @[BusMonitor.scala 113:115]
  wire  _T_25 = _T_22 & _T_24; // @[BusMonitor.scala 113:91]
  wire [15:0] _T_27 = LatCountersW_2 + 16'h1; // @[BusMonitor.scala 113:175]
  wire [9:0] _GEN_73 = {{2'd0}, LatencyRangesW[31:24]}; // @[BusMonitor.scala 114:65]
  wire  _T_29 = counter_for_latency <= _GEN_73; // @[BusMonitor.scala 114:65]
  wire  _T_31 = counter_for_latency > _GEN_71; // @[BusMonitor.scala 114:115]
  wire  _T_32 = _T_29 & _T_31; // @[BusMonitor.scala 114:91]
  wire [15:0] _T_34 = LatCountersW_3 + 16'h1; // @[BusMonitor.scala 114:176]
  wire [9:0] _GEN_75 = {{2'd0}, LatencyRangesR[7:0]}; // @[BusMonitor.scala 116:60]
  wire  _T_36 = counter_for_latency <= _GEN_75; // @[BusMonitor.scala 116:60]
  wire [15:0] _T_38 = LatCountersR_0 + 16'h1; // @[BusMonitor.scala 116:120]
  wire [9:0] _GEN_76 = {{2'd0}, LatencyRangesR[15:8]}; // @[BusMonitor.scala 117:65]
  wire  _T_40 = counter_for_latency <= _GEN_76; // @[BusMonitor.scala 117:65]
  wire  _T_42 = counter_for_latency > _GEN_75; // @[BusMonitor.scala 117:113]
  wire  _T_43 = _T_40 & _T_42; // @[BusMonitor.scala 117:89]
  wire [15:0] _T_45 = LatCountersR_1 + 16'h1; // @[BusMonitor.scala 117:172]
  wire [9:0] _GEN_78 = {{2'd0}, LatencyRangesR[23:16]}; // @[BusMonitor.scala 118:65]
  wire  _T_47 = counter_for_latency <= _GEN_78; // @[BusMonitor.scala 118:65]
  wire  _T_49 = counter_for_latency > _GEN_76; // @[BusMonitor.scala 118:114]
  wire  _T_50 = _T_47 & _T_49; // @[BusMonitor.scala 118:90]
  wire [15:0] _T_52 = LatCountersR_2 + 16'h1; // @[BusMonitor.scala 118:174]
  wire [9:0] _GEN_80 = {{2'd0}, LatencyRangesR[31:24]}; // @[BusMonitor.scala 119:65]
  wire  _T_54 = counter_for_latency <= _GEN_80; // @[BusMonitor.scala 119:65]
  wire  _T_56 = counter_for_latency > _GEN_78; // @[BusMonitor.scala 119:114]
  wire  _T_57 = _T_54 & _T_56; // @[BusMonitor.scala 119:90]
  wire [15:0] _T_59 = LatCountersR_3 + 16'h1; // @[BusMonitor.scala 119:175]
  wire [19:0] _T_61 = validcounter + 20'h1; // @[BusMonitor.scala 126:67]
  wire  _T_62 = io_dmport_TagID_Reg == 4'h1; // @[BusMonitor.scala 130:50]
  wire  _T_63 = io_dmport_TagID_Reg == 4'h2; // @[BusMonitor.scala 131:55]
  wire  _T_64 = io_dmport_TagID_Reg == 4'h3; // @[BusMonitor.scala 132:55]
  wire  _T_67 = io_dmport_TagID_Reg == 4'h4; // @[BusMonitor.scala 133:55]
  wire [31:0] _T_68 = {LatCountersW_1,LatCountersW_0}; // @[Cat.scala 29:58]
  wire  _T_69 = io_dmport_TagID_Reg == 4'h5; // @[BusMonitor.scala 134:55]
  wire [31:0] _T_70 = {LatCountersW_3,LatCountersW_2}; // @[Cat.scala 29:58]
  wire  _T_71 = io_dmport_TagID_Reg == 4'h6; // @[BusMonitor.scala 135:55]
  wire [31:0] _T_72 = {LatCountersR_1,LatCountersR_0}; // @[Cat.scala 29:58]
  wire  _T_73 = io_dmport_TagID_Reg == 4'h7; // @[BusMonitor.scala 136:55]
  wire [31:0] _T_74 = {LatCountersR_3,LatCountersR_2}; // @[Cat.scala 29:58]
  wire  _T_75 = io_dmport_TagID_Reg == 4'h8; // @[BusMonitor.scala 137:55]
  wire [31:0] _T_76 = {12'h0,validcounter}; // @[Cat.scala 29:58]
  wire  _T_77 = io_dmport_TagID_Reg == 4'h9; // @[BusMonitor.scala 138:55]
  wire  _T_78 = io_dmport_TagID_Reg == 4'ha; // @[BusMonitor.scala 139:55]
  wire [31:0] _GEN_57 = _T_78 ? LatencyRangesR : 32'h0; // @[BusMonitor.scala 139:64]
  wire [31:0] _GEN_58 = _T_77 ? LatencyRangesW : _GEN_57; // @[BusMonitor.scala 138:63]
  wire [31:0] _GEN_59 = _T_75 ? _T_76 : _GEN_58; // @[BusMonitor.scala 137:63]
  wire [31:0] _GEN_60 = _T_73 ? _T_74 : _GEN_59; // @[BusMonitor.scala 136:63]
  wire [31:0] _GEN_61 = _T_71 ? _T_72 : _GEN_60; // @[BusMonitor.scala 135:63]
  wire [31:0] _GEN_62 = _T_69 ? _T_70 : _GEN_61; // @[BusMonitor.scala 134:63]
  wire [31:0] _GEN_63 = _T_67 ? _T_68 : _GEN_62; // @[BusMonitor.scala 133:63]
  wire [31:0] _GEN_64 = _T_64 ? 32'h0 : _GEN_63; // @[BusMonitor.scala 132:63]
  wire [31:0] _GEN_65 = _T_63 ? Trans_counter_write : _GEN_64; // @[BusMonitor.scala 131:63]
  wire [31:0] _GEN_66 = _T_62 ? Trans_counter_read : _GEN_65; // @[BusMonitor.scala 130:58]
  assign io_dmport_Out = io_dmport_ReadRequest ? _GEN_66 : 32'h0; // @[BusMonitor.scala 130:73 BusMonitor.scala 131:78 BusMonitor.scala 132:78 BusMonitor.scala 133:78 BusMonitor.scala 134:78 BusMonitor.scala 135:78 BusMonitor.scala 136:78 BusMonitor.scala 137:78 BusMonitor.scala 138:78 BusMonitor.scala 139:79 BusMonitor.scala 140:50 BusMonitor.scala 141:43]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Trans_counter_read = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Trans_counter_write = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  LatCountersW_0 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  LatCountersW_1 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  LatCountersW_2 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  LatCountersW_3 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  LatCountersR_0 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  LatCountersR_1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  LatCountersR_2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  LatCountersR_3 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  validcounter = _RAND_10[19:0];
  _RAND_11 = {1{`RANDOM}};
  LatencyRangesW = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  LatencyRangesR = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  counter_for_latency = _RAND_13[9:0];
  _RAND_14 = {1{`RANDOM}};
  count_w = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  RegInputs = _RAND_15[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      Trans_counter_read <= 32'h0;
    end else if (io_dmport_Restart_Counters) begin
      Trans_counter_read <= 32'h0;
    end else if (io_pcinput_newtrans) begin
      if (!(io_pcinput_op)) begin
        Trans_counter_read <= _T_5;
      end
    end
    if (reset) begin
      Trans_counter_write <= 32'h0;
    end else if (io_dmport_Restart_Counters) begin
      Trans_counter_write <= 32'h0;
    end else if (io_pcinput_newtrans) begin
      if (io_pcinput_op) begin
        Trans_counter_write <= _T_3;
      end
    end
    if (reset) begin
      LatCountersW_0 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersW_0 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (RegInputs) begin
        if (_T_11) begin
          LatCountersW_0 <= _T_13;
        end
      end
    end
    if (reset) begin
      LatCountersW_1 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersW_1 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (RegInputs) begin
        if (!(_T_11)) begin
          if (_T_18) begin
            LatCountersW_1 <= _T_20;
          end
        end
      end
    end
    if (reset) begin
      LatCountersW_2 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersW_2 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (RegInputs) begin
        if (!(_T_11)) begin
          if (!(_T_18)) begin
            if (_T_25) begin
              LatCountersW_2 <= _T_27;
            end
          end
        end
      end
    end
    if (reset) begin
      LatCountersW_3 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersW_3 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (RegInputs) begin
        if (!(_T_11)) begin
          if (!(_T_18)) begin
            if (!(_T_25)) begin
              if (_T_32) begin
                LatCountersW_3 <= _T_34;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      LatCountersR_0 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersR_0 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (!(RegInputs)) begin
        if (_T_36) begin
          LatCountersR_0 <= _T_38;
        end
      end
    end
    if (reset) begin
      LatCountersR_1 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersR_1 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (!(RegInputs)) begin
        if (!(_T_36)) begin
          if (_T_43) begin
            LatCountersR_1 <= _T_45;
          end
        end
      end
    end
    if (reset) begin
      LatCountersR_2 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersR_2 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (!(RegInputs)) begin
        if (!(_T_36)) begin
          if (!(_T_43)) begin
            if (_T_50) begin
              LatCountersR_2 <= _T_52;
            end
          end
        end
      end
    end
    if (reset) begin
      LatCountersR_3 <= 16'h0;
    end else if (io_dmport_Restart_Counters) begin
      LatCountersR_3 <= 16'h0;
    end else if (io_pcinput_finishtrans) begin
      if (!(RegInputs)) begin
        if (!(_T_36)) begin
          if (!(_T_43)) begin
            if (!(_T_50)) begin
              if (_T_57) begin
                LatCountersR_3 <= _T_59;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      validcounter <= 20'h0;
    end else if (io_dmport_Restart_Counters) begin
      validcounter <= 20'h0;
    end else if (io_pcinput_finishtrans) begin
      validcounter <= _T_61;
    end
    if (reset) begin
      LatencyRangesW <= 32'hff0f0a05;
    end else if (io_dmport_Refresh) begin
      LatencyRangesW <= io_dmport_LatencyRangesW;
    end
    if (reset) begin
      LatencyRangesR <= 32'hff0f0a05;
    end else if (io_dmport_Refresh) begin
      LatencyRangesR <= io_dmport_LatencyRangesR;
    end
    if (reset) begin
      counter_for_latency <= 10'h0;
    end else if (count_w) begin
      counter_for_latency <= _T_9;
    end else begin
      counter_for_latency <= 10'h0;
    end
    if (reset) begin
      count_w <= 1'h0;
    end else if (counter_actived) begin
      count_w <= _T_7;
    end
    if (io_pcinput_newtrans) begin
      RegInputs <= io_pcinput_op;
    end
  end
endmodule
module Analysis_Lines(
  input         clock,
  input         reset,
  input  [3:0]  io_Busports_idsrc,
  input  [31:0] io_Busports_iddest,
  input  [31:0] io_Busports_data,
  input         io_Busports_op,
  input         io_Busports_newtrans,
  input         io_Busports_finishtrans,
  input  [31:0] io_Dm2flt_dataref,
  input  [9:0]  io_Dm2flt_analisys,
  input  [31:0] io_Dm2flt_offset,
  input         io_Dm2flt_refresh,
  input         io_Dm2flt_fenable,
  input  [31:0] io_DMport_LatencyRangesW,
  input  [31:0] io_DMport_LatencyRangesR,
  input         io_DMport_Refresh,
  input  [3:0]  io_DMport_TagID_Reg,
  input         io_DMport_ReadRequest,
  input         io_DMport_Restart_Counters,
  output [31:0] io_DMport_Out
);
  wire  FilterBM_clock; // @[BusMonitor.scala 378:58]
  wire  FilterBM_reset; // @[BusMonitor.scala 378:58]
  wire [3:0] FilterBM_io_filterin_idsrc; // @[BusMonitor.scala 378:58]
  wire [31:0] FilterBM_io_filterin_iddest; // @[BusMonitor.scala 378:58]
  wire [31:0] FilterBM_io_filterin_data; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_filterin_op; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_filterin_newtrans; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_filterin_finishtrans; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_filterout_op; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_filterout_newtrans; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_filterout_finishtrans; // @[BusMonitor.scala 378:58]
  wire [31:0] FilterBM_io_dminput_dataref; // @[BusMonitor.scala 378:58]
  wire [9:0] FilterBM_io_dminput_analisys; // @[BusMonitor.scala 378:58]
  wire [31:0] FilterBM_io_dminput_offset; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_dminput_refresh; // @[BusMonitor.scala 378:58]
  wire  FilterBM_io_dminput_fenable; // @[BusMonitor.scala 378:58]
  wire  Performance_counter_clock; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_reset; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_io_pcinput_op; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_io_pcinput_newtrans; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_io_pcinput_finishtrans; // @[BusMonitor.scala 379:53]
  wire [31:0] Performance_counter_io_dmport_LatencyRangesW; // @[BusMonitor.scala 379:53]
  wire [31:0] Performance_counter_io_dmport_LatencyRangesR; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_io_dmport_Refresh; // @[BusMonitor.scala 379:53]
  wire [3:0] Performance_counter_io_dmport_TagID_Reg; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_io_dmport_ReadRequest; // @[BusMonitor.scala 379:53]
  wire  Performance_counter_io_dmport_Restart_Counters; // @[BusMonitor.scala 379:53]
  wire [31:0] Performance_counter_io_dmport_Out; // @[BusMonitor.scala 379:53]
  FilterBM FilterBM ( // @[BusMonitor.scala 378:58]
    .clock(FilterBM_clock),
    .reset(FilterBM_reset),
    .io_filterin_idsrc(FilterBM_io_filterin_idsrc),
    .io_filterin_iddest(FilterBM_io_filterin_iddest),
    .io_filterin_data(FilterBM_io_filterin_data),
    .io_filterin_op(FilterBM_io_filterin_op),
    .io_filterin_newtrans(FilterBM_io_filterin_newtrans),
    .io_filterin_finishtrans(FilterBM_io_filterin_finishtrans),
    .io_filterout_op(FilterBM_io_filterout_op),
    .io_filterout_newtrans(FilterBM_io_filterout_newtrans),
    .io_filterout_finishtrans(FilterBM_io_filterout_finishtrans),
    .io_dminput_dataref(FilterBM_io_dminput_dataref),
    .io_dminput_analisys(FilterBM_io_dminput_analisys),
    .io_dminput_offset(FilterBM_io_dminput_offset),
    .io_dminput_refresh(FilterBM_io_dminput_refresh),
    .io_dminput_fenable(FilterBM_io_dminput_fenable)
  );
  Performance_counter Performance_counter ( // @[BusMonitor.scala 379:53]
    .clock(Performance_counter_clock),
    .reset(Performance_counter_reset),
    .io_pcinput_op(Performance_counter_io_pcinput_op),
    .io_pcinput_newtrans(Performance_counter_io_pcinput_newtrans),
    .io_pcinput_finishtrans(Performance_counter_io_pcinput_finishtrans),
    .io_dmport_LatencyRangesW(Performance_counter_io_dmport_LatencyRangesW),
    .io_dmport_LatencyRangesR(Performance_counter_io_dmport_LatencyRangesR),
    .io_dmport_Refresh(Performance_counter_io_dmport_Refresh),
    .io_dmport_TagID_Reg(Performance_counter_io_dmport_TagID_Reg),
    .io_dmport_ReadRequest(Performance_counter_io_dmport_ReadRequest),
    .io_dmport_Restart_Counters(Performance_counter_io_dmport_Restart_Counters),
    .io_dmport_Out(Performance_counter_io_dmport_Out)
  );
  assign io_DMport_Out = Performance_counter_io_dmport_Out; // @[BusMonitor.scala 417:39 BusMonitor.scala 425:39]
  assign FilterBM_clock = clock;
  assign FilterBM_reset = reset;
  assign FilterBM_io_filterin_idsrc = io_Busports_idsrc; // @[BusMonitor.scala 391:37]
  assign FilterBM_io_filterin_iddest = io_Busports_iddest; // @[BusMonitor.scala 391:37]
  assign FilterBM_io_filterin_data = io_Busports_data; // @[BusMonitor.scala 391:37]
  assign FilterBM_io_filterin_op = io_Busports_op; // @[BusMonitor.scala 391:37]
  assign FilterBM_io_filterin_newtrans = io_Busports_newtrans; // @[BusMonitor.scala 391:37]
  assign FilterBM_io_filterin_finishtrans = io_Busports_finishtrans; // @[BusMonitor.scala 391:37]
  assign FilterBM_io_dminput_dataref = io_Dm2flt_dataref; // @[BusMonitor.scala 395:52 BusMonitor.scala 401:52]
  assign FilterBM_io_dminput_analisys = io_Dm2flt_analisys; // @[BusMonitor.scala 396:53 BusMonitor.scala 402:53]
  assign FilterBM_io_dminput_offset = io_Dm2flt_offset; // @[BusMonitor.scala 397:51 BusMonitor.scala 403:51]
  assign FilterBM_io_dminput_refresh = io_Dm2flt_refresh; // @[BusMonitor.scala 398:52 BusMonitor.scala 404:52]
  assign FilterBM_io_dminput_fenable = io_Dm2flt_fenable; // @[BusMonitor.scala 399:52 BusMonitor.scala 405:52]
  assign Performance_counter_clock = clock;
  assign Performance_counter_reset = reset;
  assign Performance_counter_io_pcinput_op = FilterBM_io_filterout_op; // @[BusMonitor.scala 386:35]
  assign Performance_counter_io_pcinput_newtrans = FilterBM_io_filterout_newtrans; // @[BusMonitor.scala 387:41]
  assign Performance_counter_io_pcinput_finishtrans = FilterBM_io_filterout_finishtrans; // @[BusMonitor.scala 388:44]
  assign Performance_counter_io_dmport_LatencyRangesW = io_DMport_LatencyRangesW; // @[BusMonitor.scala 411:54 BusMonitor.scala 419:54]
  assign Performance_counter_io_dmport_LatencyRangesR = io_DMport_LatencyRangesR; // @[BusMonitor.scala 412:54 BusMonitor.scala 420:54]
  assign Performance_counter_io_dmport_Refresh = io_DMport_Refresh; // @[BusMonitor.scala 413:47 BusMonitor.scala 421:47]
  assign Performance_counter_io_dmport_TagID_Reg = io_DMport_TagID_Reg; // @[BusMonitor.scala 414:49 BusMonitor.scala 422:49]
  assign Performance_counter_io_dmport_ReadRequest = io_DMport_ReadRequest; // @[BusMonitor.scala 415:51 BusMonitor.scala 423:51]
  assign Performance_counter_io_dmport_Restart_Counters = io_DMport_Restart_Counters; // @[BusMonitor.scala 416:56 BusMonitor.scala 424:56]
endmodule
module BusMonitor(
  input         clock,
  input         reset,
  input  [31:0] io_BusPort_Data,
  input         io_BusPort_IdSource,
  input  [31:0] io_BusPort_IdDestiny,
  input         io_BusPort_Op,
  input         io_BusPort_Valid,
  input         io_BusPort_Ready,
  input  [31:0] io_Dm2flt_dataref,
  input  [9:0]  io_Dm2flt_analisys,
  input  [31:0] io_Dm2flt_offset,
  input         io_Dm2flt_refresh,
  input         io_Dm2flt_fenable,
  input  [31:0] io_DMport_LatencyRangesW,
  input  [31:0] io_DMport_LatencyRangesR,
  input         io_DMport_Refresh,
  input  [3:0]  io_DMport_TagID_Reg,
  input         io_DMport_ReadRequest,
  input         io_DMport_Restart_Counters,
  output [31:0] io_DMport_Out
);
  wire  AL_clock; // @[BusMonitor.scala 438:25]
  wire  AL_reset; // @[BusMonitor.scala 438:25]
  wire [3:0] AL_io_Busports_idsrc; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_Busports_iddest; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_Busports_data; // @[BusMonitor.scala 438:25]
  wire  AL_io_Busports_op; // @[BusMonitor.scala 438:25]
  wire  AL_io_Busports_newtrans; // @[BusMonitor.scala 438:25]
  wire  AL_io_Busports_finishtrans; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_Dm2flt_dataref; // @[BusMonitor.scala 438:25]
  wire [9:0] AL_io_Dm2flt_analisys; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_Dm2flt_offset; // @[BusMonitor.scala 438:25]
  wire  AL_io_Dm2flt_refresh; // @[BusMonitor.scala 438:25]
  wire  AL_io_Dm2flt_fenable; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_DMport_LatencyRangesW; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_DMport_LatencyRangesR; // @[BusMonitor.scala 438:25]
  wire  AL_io_DMport_Refresh; // @[BusMonitor.scala 438:25]
  wire [3:0] AL_io_DMport_TagID_Reg; // @[BusMonitor.scala 438:25]
  wire  AL_io_DMport_ReadRequest; // @[BusMonitor.scala 438:25]
  wire  AL_io_DMport_Restart_Counters; // @[BusMonitor.scala 438:25]
  wire [31:0] AL_io_DMport_Out; // @[BusMonitor.scala 438:25]
  Analysis_Lines AL ( // @[BusMonitor.scala 438:25]
    .clock(AL_clock),
    .reset(AL_reset),
    .io_Busports_idsrc(AL_io_Busports_idsrc),
    .io_Busports_iddest(AL_io_Busports_iddest),
    .io_Busports_data(AL_io_Busports_data),
    .io_Busports_op(AL_io_Busports_op),
    .io_Busports_newtrans(AL_io_Busports_newtrans),
    .io_Busports_finishtrans(AL_io_Busports_finishtrans),
    .io_Dm2flt_dataref(AL_io_Dm2flt_dataref),
    .io_Dm2flt_analisys(AL_io_Dm2flt_analisys),
    .io_Dm2flt_offset(AL_io_Dm2flt_offset),
    .io_Dm2flt_refresh(AL_io_Dm2flt_refresh),
    .io_Dm2flt_fenable(AL_io_Dm2flt_fenable),
    .io_DMport_LatencyRangesW(AL_io_DMport_LatencyRangesW),
    .io_DMport_LatencyRangesR(AL_io_DMport_LatencyRangesR),
    .io_DMport_Refresh(AL_io_DMport_Refresh),
    .io_DMport_TagID_Reg(AL_io_DMport_TagID_Reg),
    .io_DMport_ReadRequest(AL_io_DMport_ReadRequest),
    .io_DMport_Restart_Counters(AL_io_DMport_Restart_Counters),
    .io_DMport_Out(AL_io_DMport_Out)
  );
  assign io_DMport_Out = AL_io_DMport_Out; // @[BusMonitor.scala 449:22]
  assign AL_clock = clock;
  assign AL_reset = reset;
  assign AL_io_Busports_idsrc = {{3'd0}, io_BusPort_IdSource}; // @[BusMonitor.scala 440:30]
  assign AL_io_Busports_iddest = io_BusPort_IdDestiny; // @[BusMonitor.scala 441:31]
  assign AL_io_Busports_data = io_BusPort_Data; // @[BusMonitor.scala 442:29]
  assign AL_io_Busports_op = io_BusPort_Op; // @[BusMonitor.scala 443:27]
  assign AL_io_Busports_newtrans = io_BusPort_Ready; // @[BusMonitor.scala 445:33]
  assign AL_io_Busports_finishtrans = io_BusPort_Valid; // @[BusMonitor.scala 444:36]
  assign AL_io_Dm2flt_dataref = io_Dm2flt_dataref; // @[BusMonitor.scala 447:22]
  assign AL_io_Dm2flt_analisys = io_Dm2flt_analisys; // @[BusMonitor.scala 447:22]
  assign AL_io_Dm2flt_offset = io_Dm2flt_offset; // @[BusMonitor.scala 447:22]
  assign AL_io_Dm2flt_refresh = io_Dm2flt_refresh; // @[BusMonitor.scala 447:22]
  assign AL_io_Dm2flt_fenable = io_Dm2flt_fenable; // @[BusMonitor.scala 447:22]
  assign AL_io_DMport_LatencyRangesW = io_DMport_LatencyRangesW; // @[BusMonitor.scala 449:22]
  assign AL_io_DMport_LatencyRangesR = io_DMport_LatencyRangesR; // @[BusMonitor.scala 449:22]
  assign AL_io_DMport_Refresh = io_DMport_Refresh; // @[BusMonitor.scala 449:22]
  assign AL_io_DMport_TagID_Reg = io_DMport_TagID_Reg; // @[BusMonitor.scala 449:22]
  assign AL_io_DMport_ReadRequest = io_DMport_ReadRequest; // @[BusMonitor.scala 449:22]
  assign AL_io_DMport_Restart_Counters = io_DMport_Restart_Counters; // @[BusMonitor.scala 449:22]
endmodule
module DebugModule(
  input         clock,
  input         reset,
  input         io_Debugport_debug_progBuffAc_we,
  input  [31:0] io_Debugport_debug_progBuffAc_data_w,
  input  [31:0] io_Debugport_debug_progBuffAc_addr_wr,
  output [31:0] io_Debugport_debug_progBuffAc_data_r,
  input  [31:0] io_Debugport_debug_progBuffAc_IF_addr,
  output [31:0] io_Debugport_debug_progBuffAc_IF_data_r,
  output        io_Debugport_debug_nPB_rst,
  output        io_Debugport_debug_nPB_halt,
  output        io_Debugport_debug_nPB_RegsAc_we,
  output [31:0] io_Debugport_debug_nPB_RegsAc_reg_addr,
  output [31:0] io_Debugport_debug_nPB_RegsAc_data_w,
  input  [31:0] io_Debugport_debug_nPB_RegsAc_data_r,
  output        io_Debugport_debug_nPB_interruption,
  input         io_Debugport_debug_nPB_breakpoint,
  output [31:0] io_Debugport_SBA_AHB_caddr,
  output        io_Debugport_SBA_AHB_cwrite,
  output        io_Debugport_SBA_AHB_creq,
  output        io_Debugport_SBA_AHB_cvalid,
  output [2:0]  io_Debugport_SBA_AHB_csize,
  output [31:0] io_Debugport_SBA_AHB_cwdata,
  input  [31:0] io_Debugport_SBA_AHB_crdata,
  input         io_Debugport_SBA_AHB_cready,
  output        io_Debugport_dmi_req_ready,
  input         io_Debugport_dmi_req_valid,
  input  [1:0]  io_Debugport_dmi_req_bits_op,
  input  [9:0]  io_Debugport_dmi_req_bits_addr,
  input  [31:0] io_Debugport_dmi_req_bits_data,
  input         io_Debugport_dmi_resp_ready,
  output        io_Debugport_dmi_resp_valid,
  output [31:0] io_Debugport_dmi_resp_bits_data,
  output        io_DmStatusControl_DM_actived,
  output        io_DmStatusControl_Halted,
  output        io_DmStatusControl_Reseted,
  output        io_DmStatusControl_PcMode,
  output [4:0]  io_DmStatusControl_PBCellsProg,
  output [4:0]  io_DmStatusControl_AHBTrans,
  output [5:0]  io_DmStatusControl_DMTotalAcess,
  input         io_DmStatusControl_ResetDM,
  input         io_DmStatusControl_ClearProB,
  input         io_DmStatusControl_ClearAHBcells,
  input         io_DmStatusControl_ResetCounters,
  input  [31:0] io_MonitorPorts_Data,
  input         io_MonitorPorts_IdSource,
  input  [31:0] io_MonitorPorts_IdDestiny,
  input         io_MonitorPorts_Op,
  input         io_MonitorPorts_Valid,
  input         io_MonitorPorts_Ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
`endif // RANDOMIZE_REG_INIT
  wire  Queue_clock; // @[Decoupled.scala 296:21]
  wire  Queue_reset; // @[Decoupled.scala 296:21]
  wire  Queue_io_enq_ready; // @[Decoupled.scala 296:21]
  wire  Queue_io_enq_valid; // @[Decoupled.scala 296:21]
  wire  Queue_io_enq_bits_read; // @[Decoupled.scala 296:21]
  wire [5:0] Queue_io_enq_bits_index; // @[Decoupled.scala 296:21]
  wire [31:0] Queue_io_enq_bits_data; // @[Decoupled.scala 296:21]
  wire  Queue_io_deq_ready; // @[Decoupled.scala 296:21]
  wire  Queue_io_deq_valid; // @[Decoupled.scala 296:21]
  wire  Queue_io_deq_bits_read; // @[Decoupled.scala 296:21]
  wire [5:0] Queue_io_deq_bits_index; // @[Decoupled.scala 296:21]
  wire [31:0] Queue_io_deq_bits_data; // @[Decoupled.scala 296:21]
  wire [3:0] Queue_io_deq_bits_mask; // @[Decoupled.scala 296:21]
  wire  master_clock; // @[DebugModule.scala 260:22]
  wire  master_reset; // @[DebugModule.scala 260:22]
  wire [31:0] master_io_in_data; // @[DebugModule.scala 260:22]
  wire [31:0] master_io_in_addr; // @[DebugModule.scala 260:22]
  wire  master_io_in_wr; // @[DebugModule.scala 260:22]
  wire [1:0] master_io_in_wsize; // @[DebugModule.scala 260:22]
  wire  master_io_in_valid; // @[DebugModule.scala 260:22]
  wire [31:0] master_io_out_data; // @[DebugModule.scala 260:22]
  wire  master_io_out_valid; // @[DebugModule.scala 260:22]
  wire [31:0] master_io_condor_caddr; // @[DebugModule.scala 260:22]
  wire  master_io_condor_cwrite; // @[DebugModule.scala 260:22]
  wire  master_io_condor_creq; // @[DebugModule.scala 260:22]
  wire  master_io_condor_cvalid; // @[DebugModule.scala 260:22]
  wire [2:0] master_io_condor_csize; // @[DebugModule.scala 260:22]
  wire [31:0] master_io_condor_cwdata; // @[DebugModule.scala 260:22]
  wire [31:0] master_io_condor_crdata; // @[DebugModule.scala 260:22]
  wire  master_io_condor_cready; // @[DebugModule.scala 260:22]
  wire  BM_clock; // @[DebugModule.scala 366:19]
  wire  BM_reset; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_BusPort_Data; // @[DebugModule.scala 366:19]
  wire  BM_io_BusPort_IdSource; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_BusPort_IdDestiny; // @[DebugModule.scala 366:19]
  wire  BM_io_BusPort_Op; // @[DebugModule.scala 366:19]
  wire  BM_io_BusPort_Valid; // @[DebugModule.scala 366:19]
  wire  BM_io_BusPort_Ready; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_Dm2flt_dataref; // @[DebugModule.scala 366:19]
  wire [9:0] BM_io_Dm2flt_analisys; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_Dm2flt_offset; // @[DebugModule.scala 366:19]
  wire  BM_io_Dm2flt_refresh; // @[DebugModule.scala 366:19]
  wire  BM_io_Dm2flt_fenable; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_DMport_LatencyRangesW; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_DMport_LatencyRangesR; // @[DebugModule.scala 366:19]
  wire  BM_io_DMport_Refresh; // @[DebugModule.scala 366:19]
  wire [3:0] BM_io_DMport_TagID_Reg; // @[DebugModule.scala 366:19]
  wire  BM_io_DMport_ReadRequest; // @[DebugModule.scala 366:19]
  wire  BM_io_DMport_Restart_Counters; // @[DebugModule.scala 366:19]
  wire [31:0] BM_io_DMport_Out; // @[DebugModule.scala 366:19]
  reg [31:0] DebugInfo; // @[DebugModule.scala 117:26]
  reg [31:0] progbuff_0; // @[DebugModule.scala 121:25]
  reg [31:0] progbuff_1; // @[DebugModule.scala 121:25]
  reg [31:0] progbuff_2; // @[DebugModule.scala 121:25]
  reg [31:0] progbuff_3; // @[DebugModule.scala 121:25]
  reg  progbuff_actived; // @[DebugModule.scala 122:33]
  reg [31:0] data_r; // @[DebugModule.scala 123:29]
  reg [31:0] AHB_Access_0; // @[DebugModule.scala 126:27]
  reg [31:0] AHB_Access_1; // @[DebugModule.scala 126:27]
  reg [31:0] AHB_Access_2; // @[DebugModule.scala 126:27]
  reg  AHB_Connect2Bus; // @[DebugModule.scala 127:32]
  reg [31:0] hresponse; // @[DebugModule.scala 129:26]
  reg [31:0] Reference; // @[DebugModule.scala 135:26]
  reg [9:0] Analysis; // @[DebugModule.scala 136:25]
  reg [31:0] Offset; // @[DebugModule.scala 137:24]
  reg [31:0] Latency_W; // @[DebugModule.scala 138:26]
  reg [31:0] Latency_R; // @[DebugModule.scala 139:26]
  reg [31:0] PC_Read; // @[DebugModule.scala 141:24]
  reg [4:0] PC_Read_Req; // @[DebugModule.scala 142:28]
  reg [1:0] LA_Sel; // @[DebugModule.scala 143:23]
  reg [2:0] Fen_Refresh; // @[DebugModule.scala 144:28]
  reg [31:0] command; // @[DebugModule.scala 147:24]
  reg [31:0] data0; // @[DebugModule.scala 148:22]
  reg [31:0] Control_Core; // @[DebugModule.scala 152:29]
  wire  dbugm_ctrl_haltreq = Control_Core[31]; // @[DebugModule.scala 156:37]
  wire  dbugm_ctrl_hartreset = Control_Core[29]; // @[DebugModule.scala 158:39]
  wire  dbugm_ctrl_dmactive = Control_Core[0]; // @[DebugModule.scala 164:38]
  reg [31:0] if_out; // @[DebugModule.scala 168:29]
  wire [7:0] _T_51 = Queue_io_deq_bits_mask[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_53 = Queue_io_deq_bits_mask[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_55 = Queue_io_deq_bits_mask[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_57 = Queue_io_deq_bits_mask[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_60 = {_T_57,_T_55,_T_53,_T_51}; // @[Cat.scala 29:58]
  wire  _T_68 = &_T_60; // @[registerRouter.scala 219:44]
  wire  _T_1411 = Queue_io_deq_valid & io_Debugport_dmi_resp_ready; // @[registerRouter.scala 258:33]
  wire [5:0] _T_1265 = {Queue_io_deq_bits_index[5],Queue_io_deq_bits_index[4],Queue_io_deq_bits_index[3],Queue_io_deq_bits_index[2],Queue_io_deq_bits_index[1],Queue_io_deq_bits_index[0]}; // @[Cat.scala 29:58]
  wire [63:0] _T_1337 = 64'h1 << _T_1265; // @[OneHot.scala 58:35]
  wire  _T_1416 = ~Queue_io_deq_bits_read; // @[registerRouter.scala 259:49]
  wire  _T_1417 = _T_1411 & _T_1416; // @[registerRouter.scala 259:46]
  wire  _T_1419 = _T_1417 & _T_1337[0]; // @[registerRouter.scala 259:66]
  wire  _T_72 = _T_1419 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _T_73 = Queue_io_deq_bits_data; // @[registerRouter.scala 222:99]
  wire  _T_1509 = _T_1417 & _T_1337[5]; // @[registerRouter.scala 259:66]
  wire  _T_97 = _T_1509 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1851 = _T_1417 & _T_1337[24]; // @[registerRouter.scala 259:66]
  wire  _T_122 = _T_1851 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_2085 = _T_1417 & _T_1337[37]; // @[registerRouter.scala 259:66]
  wire  _T_147 = _T_2085 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_19 = _T_147 ? _T_73 : {{30'd0}, LA_Sel}; // @[registerRouter.scala 87:88]
  wire [31:0] _T_159 = {{30'd0}, LA_Sel}; // @[registerRouter.scala 231:55]
  wire  _T_1869 = _T_1417 & _T_1337[25]; // @[registerRouter.scala 259:66]
  wire  _T_172 = _T_1869 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1437 = _T_1417 & _T_1337[1]; // @[registerRouter.scala 259:66]
  wire  _T_222 = _T_1437 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_21 = _T_222 ? _T_73 : {{31'd0}, progbuff_actived}; // @[registerRouter.scala 87:88]
  wire [31:0] _T_234 = {{31'd0}, progbuff_actived}; // @[registerRouter.scala 231:55]
  wire  _T_1527 = _T_1417 & _T_1337[6]; // @[registerRouter.scala 259:66]
  wire  _T_247 = _T_1527 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_2103 = _T_1417 & _T_1337[38]; // @[registerRouter.scala 259:66]
  wire  _T_297 = _T_2103 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_23 = _T_297 ? _T_73 : {{29'd0}, Fen_Refresh}; // @[registerRouter.scala 87:88]
  wire [31:0] _T_309 = {{29'd0}, Fen_Refresh}; // @[registerRouter.scala 231:55]
  wire  _T_2013 = _T_1417 & _T_1337[33]; // @[registerRouter.scala 259:66]
  wire  _T_322 = _T_2013 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_2157 = _T_1417 & _T_1337[41]; // @[registerRouter.scala 259:66]
  wire  _T_347 = _T_2157 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1995 = _T_1417 & _T_1337[32]; // @[registerRouter.scala 259:66]
  wire  _T_372 = _T_1995 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_2031 = _T_1417 & _T_1337[34]; // @[registerRouter.scala 259:66]
  wire  _T_397 = _T_2031 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1815 = _T_1417 & _T_1337[22]; // @[registerRouter.scala 259:66]
  wire  _T_422 = _T_1815 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1545 = _T_1417 & _T_1337[7]; // @[registerRouter.scala 259:66]
  wire  _T_447 = _T_1545 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1977 = _T_1417 & _T_1337[31]; // @[registerRouter.scala 259:66]
  wire  _T_497 = _T_1977 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_30 = _T_497 ? _T_73 : {{22'd0}, Analysis}; // @[registerRouter.scala 87:88]
  wire [31:0] _T_509 = {{22'd0}, Analysis}; // @[registerRouter.scala 231:55]
  wire  _T_2139 = _T_1417 & _T_1337[40]; // @[registerRouter.scala 259:66]
  wire  _T_522 = _T_2139 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1887 = _T_1417 & _T_1337[26]; // @[registerRouter.scala 259:66]
  wire  _T_547 = _T_1887 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_32 = _T_547 ? _T_73 : {{31'd0}, AHB_Connect2Bus}; // @[registerRouter.scala 87:88]
  wire [31:0] _T_559 = {{31'd0}, AHB_Connect2Bus}; // @[registerRouter.scala 231:55]
  wire  _T_2067 = _T_1417 & _T_1337[36]; // @[registerRouter.scala 259:66]
  wire  _T_572 = _T_2067 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_33 = _T_572 ? _T_73 : {{27'd0}, PC_Read_Req}; // @[registerRouter.scala 87:88]
  wire [31:0] _T_584 = {{27'd0}, PC_Read_Req}; // @[registerRouter.scala 231:55]
  wire  _T_1959 = _T_1417 & _T_1337[30]; // @[registerRouter.scala 259:66]
  wire  _T_597 = _T_1959 & _T_68; // @[registerRouter.scala 222:84]
  wire  _T_1491 = _T_1417 & _T_1337[4]; // @[registerRouter.scala 259:66]
  wire  _T_622 = _T_1491 & _T_68; // @[registerRouter.scala 222:84]
  wire [31:0] _GEN_357 = 6'h1 == _T_1265 ? _T_234 : Control_Core; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_358 = 6'h2 == _T_1265 ? 32'h0 : _GEN_357; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_359 = 6'h3 == _T_1265 ? 32'h0 : _GEN_358; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_360 = 6'h4 == _T_1265 ? progbuff_0 : _GEN_359; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_361 = 6'h5 == _T_1265 ? progbuff_1 : _GEN_360; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_362 = 6'h6 == _T_1265 ? progbuff_2 : _GEN_361; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_363 = 6'h7 == _T_1265 ? progbuff_3 : _GEN_362; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_364 = 6'h8 == _T_1265 ? 32'h0 : _GEN_363; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_365 = 6'h9 == _T_1265 ? 32'h0 : _GEN_364; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_366 = 6'ha == _T_1265 ? 32'h0 : _GEN_365; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_367 = 6'hb == _T_1265 ? 32'h0 : _GEN_366; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_368 = 6'hc == _T_1265 ? 32'h0 : _GEN_367; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_369 = 6'hd == _T_1265 ? 32'h0 : _GEN_368; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_370 = 6'he == _T_1265 ? 32'h0 : _GEN_369; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_371 = 6'hf == _T_1265 ? 32'h0 : _GEN_370; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_372 = 6'h10 == _T_1265 ? 32'h0 : _GEN_371; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_373 = 6'h11 == _T_1265 ? 32'h0 : _GEN_372; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_374 = 6'h12 == _T_1265 ? 32'h0 : _GEN_373; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_375 = 6'h13 == _T_1265 ? 32'h0 : _GEN_374; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_376 = 6'h14 == _T_1265 ? 32'h0 : _GEN_375; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_377 = 6'h15 == _T_1265 ? 32'h0 : _GEN_376; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_378 = 6'h16 == _T_1265 ? AHB_Access_0 : _GEN_377; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_379 = 6'h17 == _T_1265 ? 32'h0 : _GEN_378; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_380 = 6'h18 == _T_1265 ? AHB_Access_1 : _GEN_379; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_381 = 6'h19 == _T_1265 ? AHB_Access_2 : _GEN_380; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_382 = 6'h1a == _T_1265 ? _T_559 : _GEN_381; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_383 = 6'h1b == _T_1265 ? 32'h0 : _GEN_382; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_384 = 6'h1c == _T_1265 ? hresponse : _GEN_383; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_385 = 6'h1d == _T_1265 ? DebugInfo : _GEN_384; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_386 = 6'h1e == _T_1265 ? Reference : _GEN_385; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_387 = 6'h1f == _T_1265 ? _T_509 : _GEN_386; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_388 = 6'h20 == _T_1265 ? Offset : _GEN_387; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_389 = 6'h21 == _T_1265 ? Latency_W : _GEN_388; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_390 = 6'h22 == _T_1265 ? Latency_R : _GEN_389; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_391 = 6'h23 == _T_1265 ? PC_Read : _GEN_390; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_392 = 6'h24 == _T_1265 ? _T_584 : _GEN_391; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_393 = 6'h25 == _T_1265 ? _T_159 : _GEN_392; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_394 = 6'h26 == _T_1265 ? _T_309 : _GEN_393; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_395 = 6'h27 == _T_1265 ? 32'h0 : _GEN_394; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_396 = 6'h28 == _T_1265 ? command : _GEN_395; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_397 = 6'h29 == _T_1265 ? data0 : _GEN_396; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_398 = 6'h2a == _T_1265 ? 32'h0 : _GEN_397; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_399 = 6'h2b == _T_1265 ? 32'h0 : _GEN_398; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_400 = 6'h2c == _T_1265 ? 32'h0 : _GEN_399; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_401 = 6'h2d == _T_1265 ? 32'h0 : _GEN_400; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_402 = 6'h2e == _T_1265 ? 32'h0 : _GEN_401; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_403 = 6'h2f == _T_1265 ? 32'h0 : _GEN_402; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_404 = 6'h30 == _T_1265 ? 32'h0 : _GEN_403; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_405 = 6'h31 == _T_1265 ? 32'h0 : _GEN_404; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_406 = 6'h32 == _T_1265 ? 32'h0 : _GEN_405; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_407 = 6'h33 == _T_1265 ? 32'h0 : _GEN_406; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_408 = 6'h34 == _T_1265 ? 32'h0 : _GEN_407; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_409 = 6'h35 == _T_1265 ? 32'h0 : _GEN_408; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_410 = 6'h36 == _T_1265 ? 32'h0 : _GEN_409; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_411 = 6'h37 == _T_1265 ? 32'h0 : _GEN_410; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_412 = 6'h38 == _T_1265 ? 32'h0 : _GEN_411; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_413 = 6'h39 == _T_1265 ? 32'h0 : _GEN_412; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_414 = 6'h3a == _T_1265 ? 32'h0 : _GEN_413; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_415 = 6'h3b == _T_1265 ? 32'h0 : _GEN_414; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_416 = 6'h3c == _T_1265 ? 32'h0 : _GEN_415; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_417 = 6'h3d == _T_1265 ? 32'h0 : _GEN_416; // @[registerRouter.scala 272:26]
  wire [31:0] _GEN_418 = 6'h3e == _T_1265 ? 32'h0 : _GEN_417; // @[registerRouter.scala 272:26]
  wire [15:0] ar_regno = command[15:0]; // @[DebugModule.scala 208:22]
  wire  ar_write = command[16]; // @[DebugModule.scala 209:22]
  wire  ar_transfer = command[17]; // @[DebugModule.scala 210:25]
  reg [1:0] NextstateCSRs; // @[DebugModule.scala 223:30]
  wire  _T_2658 = 2'h0 == NextstateCSRs; // @[Conditional.scala 37:30]
  wire  _T_2661 = ar_transfer & dbugm_ctrl_haltreq; // @[DebugModule.scala 227:36]
  wire  _T_2662 = 2'h1 == NextstateCSRs; // @[Conditional.scala 37:30]
  wire  _T_2663 = 2'h2 == NextstateCSRs; // @[Conditional.scala 37:30]
  wire  _T_2664 = NextstateCSRs == 2'h1; // @[DebugModule.scala 237:22]
  wire [31:0] _GEN_424 = ar_write ? data0 : 32'h0; // @[DebugModule.scala 238:38]
  wire  _T_2666 = ~ar_write; // @[DebugModule.scala 243:32]
  wire  _GEN_431 = _T_2664 & ar_write; // @[DebugModule.scala 237:38]
  wire  _T_2667 = NextstateCSRs == 2'h2; // @[DebugModule.scala 249:21]
  wire [31:0] _T_2671 = {command[31:18],1'h0,command[16:0]}; // @[Cat.scala 29:58]
  reg  late_valid; // @[DebugModule.scala 263:31]
  wire [31:0] _GEN_439 = master_io_out_valid ? 32'h0 : _GEN_32; // @[DebugModule.scala 273:19]
  wire  _T_2675 = dbugm_ctrl_haltreq | io_Debugport_debug_nPB_breakpoint; // @[DebugModule.scala 280:39]
  wire  halt_output = dbugm_ctrl_dmactive & _T_2675; // @[DebugModule.scala 279:29]
  wire  hartreset_output = dbugm_ctrl_dmactive & dbugm_ctrl_hartreset; // @[DebugModule.scala 279:29]
  wire [31:0] _T_2677 = {1'h1,Control_Core[30:0]}; // @[Cat.scala 29:58]
  reg [4:0] PBactived; // @[DebugModule.scala 302:26]
  wire  _T_2678 = progbuff_0 == 32'h0; // @[DebugModule.scala 305:34]
  wire  _GEN_445 = _T_2678 ? 1'h0 : 1'h1; // @[DebugModule.scala 305:42]
  wire  _T_2679 = progbuff_1 == 32'h0; // @[DebugModule.scala 305:34]
  wire  _GEN_446 = _T_2679 ? 1'h0 : 1'h1; // @[DebugModule.scala 305:42]
  wire  _T_2680 = progbuff_2 == 32'h0; // @[DebugModule.scala 305:34]
  wire  _GEN_447 = _T_2680 ? 1'h0 : 1'h1; // @[DebugModule.scala 305:42]
  wire  _T_2681 = progbuff_3 == 32'h0; // @[DebugModule.scala 305:34]
  wire  _GEN_448 = _T_2681 ? 1'h0 : 1'h1; // @[DebugModule.scala 305:42]
  wire [4:0] ProgBuffsload_0 = {{4'd0}, _GEN_445}; // @[DebugModule.scala 301:28 DebugModule.scala 305:60 DebugModule.scala 306:45]
  wire [4:0] ProgBuffsload_1 = {{4'd0}, _GEN_446}; // @[DebugModule.scala 301:28 DebugModule.scala 305:60 DebugModule.scala 306:45]
  wire [4:0] _T_2683 = ProgBuffsload_0 + ProgBuffsload_1; // @[DebugModule.scala 309:33]
  wire [4:0] ProgBuffsload_2 = {{4'd0}, _GEN_447}; // @[DebugModule.scala 301:28 DebugModule.scala 305:60 DebugModule.scala 306:45]
  wire [4:0] _T_2685 = _T_2683 + ProgBuffsload_2; // @[DebugModule.scala 309:52]
  wire [4:0] ProgBuffsload_3 = {{4'd0}, _GEN_448}; // @[DebugModule.scala 301:28 DebugModule.scala 305:60 DebugModule.scala 306:45]
  wire [4:0] _T_2687 = _T_2685 + ProgBuffsload_3; // @[DebugModule.scala 309:71]
  reg [4:0] AHBTrans; // @[DebugModule.scala 312:25]
  wire [4:0] _T_2690 = AHBTrans + 5'h1; // @[DebugModule.scala 313:53]
  reg [5:0] Totalaccess; // @[DebugModule.scala 316:28]
  wire [5:0] _T_2693 = Totalaccess + 6'h1; // @[DebugModule.scala 317:70]
  wire [31:0] _GEN_452 = io_DmStatusControl_ResetDM ? 32'h0 : _GEN_21; // @[DebugModule.scala 335:3]
  wire [31:0] _GEN_461 = io_DmStatusControl_ClearProB ? 32'h0 : _GEN_452; // @[DebugModule.scala 346:3]
  Queue Queue ( // @[Decoupled.scala 296:21]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits_read(Queue_io_enq_bits_read),
    .io_enq_bits_index(Queue_io_enq_bits_index),
    .io_enq_bits_data(Queue_io_enq_bits_data),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits_read(Queue_io_deq_bits_read),
    .io_deq_bits_index(Queue_io_deq_bits_index),
    .io_deq_bits_data(Queue_io_deq_bits_data),
    .io_deq_bits_mask(Queue_io_deq_bits_mask)
  );
  Condor_MI master ( // @[DebugModule.scala 260:22]
    .clock(master_clock),
    .reset(master_reset),
    .io_in_data(master_io_in_data),
    .io_in_addr(master_io_in_addr),
    .io_in_wr(master_io_in_wr),
    .io_in_wsize(master_io_in_wsize),
    .io_in_valid(master_io_in_valid),
    .io_out_data(master_io_out_data),
    .io_out_valid(master_io_out_valid),
    .io_condor_caddr(master_io_condor_caddr),
    .io_condor_cwrite(master_io_condor_cwrite),
    .io_condor_creq(master_io_condor_creq),
    .io_condor_cvalid(master_io_condor_cvalid),
    .io_condor_csize(master_io_condor_csize),
    .io_condor_cwdata(master_io_condor_cwdata),
    .io_condor_crdata(master_io_condor_crdata),
    .io_condor_cready(master_io_condor_cready)
  );
  BusMonitor BM ( // @[DebugModule.scala 366:19]
    .clock(BM_clock),
    .reset(BM_reset),
    .io_BusPort_Data(BM_io_BusPort_Data),
    .io_BusPort_IdSource(BM_io_BusPort_IdSource),
    .io_BusPort_IdDestiny(BM_io_BusPort_IdDestiny),
    .io_BusPort_Op(BM_io_BusPort_Op),
    .io_BusPort_Valid(BM_io_BusPort_Valid),
    .io_BusPort_Ready(BM_io_BusPort_Ready),
    .io_Dm2flt_dataref(BM_io_Dm2flt_dataref),
    .io_Dm2flt_analisys(BM_io_Dm2flt_analisys),
    .io_Dm2flt_offset(BM_io_Dm2flt_offset),
    .io_Dm2flt_refresh(BM_io_Dm2flt_refresh),
    .io_Dm2flt_fenable(BM_io_Dm2flt_fenable),
    .io_DMport_LatencyRangesW(BM_io_DMport_LatencyRangesW),
    .io_DMport_LatencyRangesR(BM_io_DMport_LatencyRangesR),
    .io_DMport_Refresh(BM_io_DMport_Refresh),
    .io_DMport_TagID_Reg(BM_io_DMport_TagID_Reg),
    .io_DMport_ReadRequest(BM_io_DMport_ReadRequest),
    .io_DMport_Restart_Counters(BM_io_DMport_Restart_Counters),
    .io_DMport_Out(BM_io_DMport_Out)
  );
  assign io_Debugport_debug_progBuffAc_data_r = data_r; // @[DebugModule.scala 124:40]
  assign io_Debugport_debug_progBuffAc_IF_data_r = if_out; // @[DebugModule.scala 169:49]
  assign io_Debugport_debug_nPB_rst = dbugm_ctrl_dmactive & hartreset_output; // @[DebugModule.scala 286:32 DebugModule.scala 289:32]
  assign io_Debugport_debug_nPB_halt = dbugm_ctrl_dmactive & halt_output; // @[DebugModule.scala 285:33 DebugModule.scala 288:33]
  assign io_Debugport_debug_nPB_RegsAc_we = _T_2667 ? 1'h0 : _GEN_431; // @[DebugModule.scala 218:36 DebugModule.scala 240:58 DebugModule.scala 245:58 DebugModule.scala 251:50]
  assign io_Debugport_debug_nPB_RegsAc_reg_addr = {{16'd0}, ar_regno}; // @[DebugModule.scala 217:41]
  assign io_Debugport_debug_nPB_RegsAc_data_w = _T_2664 ? _GEN_424 : 32'h0; // @[DebugModule.scala 219:39 DebugModule.scala 239:62]
  assign io_Debugport_debug_nPB_interruption = progbuff_actived; // @[DebugModule.scala 296:37]
  assign io_Debugport_SBA_AHB_caddr = master_io_condor_caddr; // @[DebugModule.scala 261:26]
  assign io_Debugport_SBA_AHB_cwrite = master_io_condor_cwrite; // @[DebugModule.scala 261:26]
  assign io_Debugport_SBA_AHB_creq = master_io_condor_creq; // @[DebugModule.scala 261:26]
  assign io_Debugport_SBA_AHB_cvalid = master_io_condor_cvalid; // @[DebugModule.scala 261:26]
  assign io_Debugport_SBA_AHB_csize = master_io_condor_csize; // @[DebugModule.scala 261:26]
  assign io_Debugport_SBA_AHB_cwdata = master_io_condor_cwdata; // @[DebugModule.scala 261:26]
  assign io_Debugport_dmi_req_ready = Queue_io_enq_ready; // @[RRouterDM.scala 26:25]
  assign io_Debugport_dmi_resp_valid = Queue_io_deq_valid; // @[RRouterDM.scala 34:26]
  assign io_Debugport_dmi_resp_bits_data = 6'h3f == _T_1265 ? 32'h0 : _GEN_418; // @[RRouterDM.scala 35:30]
  assign io_DmStatusControl_DM_actived = Control_Core[0]; // @[DebugModule.scala 323:33]
  assign io_DmStatusControl_Halted = dbugm_ctrl_dmactive & _T_2675; // @[DebugModule.scala 324:29]
  assign io_DmStatusControl_Reseted = dbugm_ctrl_dmactive & dbugm_ctrl_hartreset; // @[DebugModule.scala 325:30]
  assign io_DmStatusControl_PcMode = progbuff_actived; // @[DebugModule.scala 326:29]
  assign io_DmStatusControl_PBCellsProg = PBactived; // @[DebugModule.scala 327:34]
  assign io_DmStatusControl_AHBTrans = AHBTrans; // @[DebugModule.scala 328:31]
  assign io_DmStatusControl_DMTotalAcess = Totalaccess; // @[DebugModule.scala 329:35]
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = io_Debugport_dmi_req_valid; // @[Decoupled.scala 297:22]
  assign Queue_io_enq_bits_read = io_Debugport_dmi_req_bits_op == 2'h2; // @[Decoupled.scala 298:21]
  assign Queue_io_enq_bits_index = io_Debugport_dmi_req_bits_addr[7:2]; // @[Decoupled.scala 298:21]
  assign Queue_io_enq_bits_data = io_Debugport_dmi_req_bits_data; // @[Decoupled.scala 298:21]
  assign Queue_io_deq_ready = io_Debugport_dmi_resp_ready; // @[registerRouter.scala 247:17]
  assign master_clock = clock;
  assign master_reset = reset;
  assign master_io_in_data = AHB_Access_1; // @[DebugModule.scala 267:27]
  assign master_io_in_addr = AHB_Access_0; // @[DebugModule.scala 266:27]
  assign master_io_in_wr = AHB_Access_2[2]; // @[DebugModule.scala 268:24]
  assign master_io_in_wsize = AHB_Access_2[4:3]; // @[DebugModule.scala 269:27]
  assign master_io_in_valid = AHB_Connect2Bus; // @[DebugModule.scala 270:27]
  assign master_io_condor_crdata = io_Debugport_SBA_AHB_crdata; // @[DebugModule.scala 261:26]
  assign master_io_condor_cready = io_Debugport_SBA_AHB_cready; // @[DebugModule.scala 261:26]
  assign BM_clock = clock;
  assign BM_reset = reset;
  assign BM_io_BusPort_Data = io_MonitorPorts_Data; // @[DebugModule.scala 368:17]
  assign BM_io_BusPort_IdSource = io_MonitorPorts_IdSource; // @[DebugModule.scala 368:17]
  assign BM_io_BusPort_IdDestiny = io_MonitorPorts_IdDestiny; // @[DebugModule.scala 368:17]
  assign BM_io_BusPort_Op = io_MonitorPorts_Op; // @[DebugModule.scala 368:17]
  assign BM_io_BusPort_Valid = io_MonitorPorts_Valid; // @[DebugModule.scala 368:17]
  assign BM_io_BusPort_Ready = io_MonitorPorts_Ready; // @[DebugModule.scala 368:17]
  assign BM_io_Dm2flt_dataref = Reference; // @[DebugModule.scala 370:24]
  assign BM_io_Dm2flt_analisys = Analysis; // @[DebugModule.scala 371:25]
  assign BM_io_Dm2flt_offset = Offset; // @[DebugModule.scala 372:23]
  assign BM_io_Dm2flt_refresh = Fen_Refresh[0]; // @[DebugModule.scala 373:24]
  assign BM_io_Dm2flt_fenable = Fen_Refresh[1]; // @[DebugModule.scala 374:24]
  assign BM_io_DMport_LatencyRangesW = Latency_W; // @[DebugModule.scala 376:31]
  assign BM_io_DMport_LatencyRangesR = Latency_R; // @[DebugModule.scala 377:31]
  assign BM_io_DMport_Refresh = Fen_Refresh[0]; // @[DebugModule.scala 378:24]
  assign BM_io_DMport_TagID_Reg = PC_Read_Req[3:0]; // @[DebugModule.scala 379:26]
  assign BM_io_DMport_ReadRequest = PC_Read_Req[4]; // @[DebugModule.scala 380:28]
  assign BM_io_DMport_Restart_Counters = Fen_Refresh[2]; // @[DebugModule.scala 381:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  DebugInfo = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  progbuff_0 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  progbuff_1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  progbuff_2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  progbuff_3 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  progbuff_actived = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  data_r = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  AHB_Access_0 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  AHB_Access_1 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  AHB_Access_2 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  AHB_Connect2Bus = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  hresponse = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  Reference = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  Analysis = _RAND_13[9:0];
  _RAND_14 = {1{`RANDOM}};
  Offset = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  Latency_W = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  Latency_R = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  PC_Read = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  PC_Read_Req = _RAND_18[4:0];
  _RAND_19 = {1{`RANDOM}};
  LA_Sel = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  Fen_Refresh = _RAND_20[2:0];
  _RAND_21 = {1{`RANDOM}};
  command = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  data0 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  Control_Core = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  if_out = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  NextstateCSRs = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  late_valid = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  PBactived = _RAND_27[4:0];
  _RAND_28 = {1{`RANDOM}};
  AHBTrans = _RAND_28[4:0];
  _RAND_29 = {1{`RANDOM}};
  Totalaccess = _RAND_29[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      DebugInfo <= 32'h0;
    end else begin
      DebugInfo <= 32'h414f242;
    end
    if (reset) begin
      progbuff_0 <= 32'h0;
    end else if (io_DmStatusControl_ClearProB) begin
      progbuff_0 <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      progbuff_0 <= 32'h0;
    end else if (_T_622) begin
      progbuff_0 <= _T_73;
    end else if (io_Debugport_debug_progBuffAc_we) begin
      if (2'h0 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
        progbuff_0 <= io_Debugport_debug_progBuffAc_data_w;
      end
    end
    if (reset) begin
      progbuff_1 <= 32'h0;
    end else if (io_DmStatusControl_ClearProB) begin
      progbuff_1 <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      progbuff_1 <= 32'h0;
    end else if (_T_97) begin
      progbuff_1 <= _T_73;
    end else if (io_Debugport_debug_progBuffAc_we) begin
      if (2'h1 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
        progbuff_1 <= io_Debugport_debug_progBuffAc_data_w;
      end
    end
    if (reset) begin
      progbuff_2 <= 32'h0;
    end else if (io_DmStatusControl_ClearProB) begin
      progbuff_2 <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      progbuff_2 <= 32'h0;
    end else if (_T_247) begin
      progbuff_2 <= _T_73;
    end else if (io_Debugport_debug_progBuffAc_we) begin
      if (2'h2 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
        progbuff_2 <= io_Debugport_debug_progBuffAc_data_w;
      end
    end
    if (reset) begin
      progbuff_3 <= 32'h0;
    end else if (io_DmStatusControl_ClearProB) begin
      progbuff_3 <= 32'h0;
    end else if (_T_447) begin
      progbuff_3 <= _T_73;
    end else if (io_Debugport_debug_progBuffAc_we) begin
      if (2'h3 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
        progbuff_3 <= io_Debugport_debug_progBuffAc_data_w;
      end
    end
    if (reset) begin
      progbuff_actived <= 1'h0;
    end else begin
      progbuff_actived <= _GEN_461[0];
    end
    if (2'h3 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
      data_r <= progbuff_3;
    end else if (2'h2 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
      data_r <= progbuff_2;
    end else if (2'h1 == io_Debugport_debug_progBuffAc_addr_wr[1:0]) begin
      data_r <= progbuff_1;
    end else begin
      data_r <= progbuff_0;
    end
    if (reset) begin
      AHB_Access_0 <= 32'h0;
    end else if (io_DmStatusControl_ClearAHBcells) begin
      AHB_Access_0 <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      AHB_Access_0 <= 32'h0;
    end else if (_T_422) begin
      AHB_Access_0 <= _T_73;
    end
    if (reset) begin
      AHB_Access_1 <= 32'h0;
    end else if (io_DmStatusControl_ClearAHBcells) begin
      AHB_Access_1 <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      AHB_Access_1 <= 32'h0;
    end else if (_T_122) begin
      AHB_Access_1 <= _T_73;
    end
    if (reset) begin
      AHB_Access_2 <= 32'h0;
    end else if (io_DmStatusControl_ClearAHBcells) begin
      AHB_Access_2 <= 32'h0;
    end else if (_T_172) begin
      AHB_Access_2 <= _T_73;
    end
    if (reset) begin
      AHB_Connect2Bus <= 1'h0;
    end else begin
      AHB_Connect2Bus <= _GEN_439[0];
    end
    if (reset) begin
      hresponse <= 32'h0;
    end else if (io_DmStatusControl_ClearAHBcells) begin
      hresponse <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      hresponse <= 32'h0;
    end else if (late_valid) begin
      hresponse <= master_io_out_data;
    end
    if (reset) begin
      Reference <= 32'h0;
    end else if (_T_597) begin
      Reference <= _T_73;
    end
    if (reset) begin
      Analysis <= 10'h0;
    end else begin
      Analysis <= _GEN_30[9:0];
    end
    if (reset) begin
      Offset <= 32'h0;
    end else if (_T_372) begin
      Offset <= _T_73;
    end
    if (reset) begin
      Latency_W <= 32'h0;
    end else if (_T_322) begin
      Latency_W <= _T_73;
    end
    if (reset) begin
      Latency_R <= 32'h0;
    end else if (_T_397) begin
      Latency_R <= _T_73;
    end
    if (reset) begin
      PC_Read <= 32'h0;
    end else begin
      PC_Read <= BM_io_DMport_Out;
    end
    if (reset) begin
      PC_Read_Req <= 5'h0;
    end else begin
      PC_Read_Req <= _GEN_33[4:0];
    end
    if (reset) begin
      LA_Sel <= 2'h0;
    end else begin
      LA_Sel <= _GEN_19[1:0];
    end
    if (reset) begin
      Fen_Refresh <= 3'h0;
    end else begin
      Fen_Refresh <= _GEN_23[2:0];
    end
    if (reset) begin
      command <= 32'h0;
    end else if (_T_2667) begin
      command <= _T_2671;
    end else if (_T_522) begin
      command <= _T_73;
    end
    if (reset) begin
      data0 <= 32'h20;
    end else if (_T_2664) begin
      if (_T_2666) begin
        data0 <= io_Debugport_debug_nPB_RegsAc_data_r;
      end else if (_T_347) begin
        data0 <= _T_73;
      end
    end else if (_T_347) begin
      data0 <= _T_73;
    end
    if (reset) begin
      Control_Core <= 32'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      Control_Core <= 32'h0;
    end else if (io_Debugport_debug_nPB_breakpoint) begin
      Control_Core <= _T_2677;
    end else if (_T_72) begin
      Control_Core <= _T_73;
    end
    if (2'h3 == io_Debugport_debug_progBuffAc_IF_addr[1:0]) begin
      if_out <= progbuff_3;
    end else if (2'h2 == io_Debugport_debug_progBuffAc_IF_addr[1:0]) begin
      if_out <= progbuff_2;
    end else if (2'h1 == io_Debugport_debug_progBuffAc_IF_addr[1:0]) begin
      if_out <= progbuff_1;
    end else begin
      if_out <= progbuff_0;
    end
    if (reset) begin
      NextstateCSRs <= 2'h0;
    end else if (_T_2658) begin
      if (_T_2661) begin
        NextstateCSRs <= 2'h1;
      end
    end else if (_T_2662) begin
      NextstateCSRs <= 2'h2;
    end else if (_T_2663) begin
      NextstateCSRs <= 2'h0;
    end
    if (reset) begin
      late_valid <= 1'h0;
    end else begin
      late_valid <= master_io_out_valid;
    end
    if (reset) begin
      PBactived <= 5'h0;
    end else begin
      PBactived <= _T_2687;
    end
    if (reset) begin
      AHBTrans <= 5'h0;
    end else if (io_DmStatusControl_ResetCounters) begin
      AHBTrans <= 5'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      AHBTrans <= 5'h0;
    end else if (AHB_Connect2Bus) begin
      AHBTrans <= _T_2690;
    end
    if (reset) begin
      Totalaccess <= 6'h0;
    end else if (io_DmStatusControl_ResetCounters) begin
      Totalaccess <= 6'h0;
    end else if (io_DmStatusControl_ResetDM) begin
      Totalaccess <= 6'h0;
    end else if (io_Debugport_dmi_req_valid) begin
      Totalaccess <= _T_2693;
    end
  end
endmodule
module DebugSystem(
  input         clock,
  input         reset,
  input         io_pins_ext_TMS_C,
  input         io_pins_ext_TCK_C,
  input         io_pins_ext_TDI_C,
  input         io_pins_ext_TRSTn_C,
  output        io_pins_ext_TDO_I,
  input         io_pins_PinCTRL_CORE_0_PE,
  input         io_pins_PinCTRL_CORE_0_IE,
  input         io_pins_PinCTRL_CORE_0_DS,
  input         io_pins_PinCTRL_CORE_0_I,
  input         io_pins_PinCTRL_CORE_0_OEN,
  output        io_pins_PinCTRL_CORE_0_C,
  input         io_pins_PinCTRL_CORE_1_PE,
  input         io_pins_PinCTRL_CORE_1_IE,
  input         io_pins_PinCTRL_CORE_1_DS,
  input         io_pins_PinCTRL_CORE_1_I,
  input         io_pins_PinCTRL_CORE_1_OEN,
  output        io_pins_PinCTRL_CORE_1_C,
  output        io_pins_PinCTRL_IO_0_PE,
  output        io_pins_PinCTRL_IO_0_IE,
  output        io_pins_PinCTRL_IO_0_DS,
  output        io_pins_PinCTRL_IO_0_I,
  output        io_pins_PinCTRL_IO_0_OEN,
  input         io_pins_PinCTRL_IO_0_C,
  output        io_pins_PinCTRL_IO_1_PE,
  output        io_pins_PinCTRL_IO_1_IE,
  output        io_pins_PinCTRL_IO_1_DS,
  output        io_pins_PinCTRL_IO_1_I,
  output        io_pins_PinCTRL_IO_1_OEN,
  input         io_pins_PinCTRL_IO_1_C,
  input         io_Dm_Output_debug_progBuffAc_we,
  input  [31:0] io_Dm_Output_debug_progBuffAc_data_w,
  input  [31:0] io_Dm_Output_debug_progBuffAc_addr_wr,
  output [31:0] io_Dm_Output_debug_progBuffAc_data_r,
  input  [31:0] io_Dm_Output_debug_progBuffAc_IF_addr,
  output [31:0] io_Dm_Output_debug_progBuffAc_IF_data_r,
  output        io_Dm_Output_debug_nPB_rst,
  output        io_Dm_Output_debug_nPB_halt,
  output        io_Dm_Output_debug_nPB_RegsAc_we,
  output [31:0] io_Dm_Output_debug_nPB_RegsAc_reg_addr,
  output [31:0] io_Dm_Output_debug_nPB_RegsAc_data_w,
  input  [31:0] io_Dm_Output_debug_nPB_RegsAc_data_r,
  output        io_Dm_Output_debug_nPB_interruption,
  input         io_Dm_Output_debug_nPB_breakpoint,
  output [31:0] io_SBA_AHB_caddr,
  output        io_SBA_AHB_cwrite,
  output        io_SBA_AHB_creq,
  output        io_SBA_AHB_cvalid,
  output [2:0]  io_SBA_AHB_csize,
  output [31:0] io_SBA_AHB_cwdata,
  input  [31:0] io_SBA_AHB_crdata,
  input         io_SBA_AHB_cready,
  input  [31:0] io_MonitorPorts_Data,
  input         io_MonitorPorts_IdSource,
  input  [31:0] io_MonitorPorts_IdDestiny,
  input         io_MonitorPorts_Op,
  input         io_MonitorPorts_Valid,
  input         io_MonitorPorts_Ready
);
  wire  JTAG_TAP_BS_reset; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_TMS; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_TCK; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_TDI; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_TRSTn; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_TDO; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_0_PE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_0_IE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_0_DS; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_0_I; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_0_OEN; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_0_C; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_1_PE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_1_IE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_1_DS; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_1_I; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_1_OEN; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_CORE_1_C; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_0_PE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_0_IE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_0_DS; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_0_I; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_0_OEN; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_0_C; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_1_PE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_1_IE; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_1_DS; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_1_I; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_1_OEN; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_PinCTRL_IO_1_C; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmi_req_ready; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmi_req_valid; // @[DebugSystem.scala 57:33]
  wire [1:0] JTAG_TAP_BS_io_dmi_req_bits_op; // @[DebugSystem.scala 57:33]
  wire [9:0] JTAG_TAP_BS_io_dmi_req_bits_addr; // @[DebugSystem.scala 57:33]
  wire [31:0] JTAG_TAP_BS_io_dmi_req_bits_data; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmi_resp_valid; // @[DebugSystem.scala 57:33]
  wire [31:0] JTAG_TAP_BS_io_dmi_resp_bits_data; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_DM_actived; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_Halted; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_Reseted; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_PcMode; // @[DebugSystem.scala 57:33]
  wire [4:0] JTAG_TAP_BS_io_dmstatuscontrol_PBCellsProg; // @[DebugSystem.scala 57:33]
  wire [4:0] JTAG_TAP_BS_io_dmstatuscontrol_AHBTrans; // @[DebugSystem.scala 57:33]
  wire [5:0] JTAG_TAP_BS_io_dmstatuscontrol_DMTotalAcess; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_ResetDM; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_ClearProB; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_ClearAHBcells; // @[DebugSystem.scala 57:33]
  wire  JTAG_TAP_BS_io_dmstatuscontrol_ResetCounters; // @[DebugSystem.scala 57:33]
  wire  Synchronizer_io_Jtag_in_req_ready; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_Jtag_in_req_valid; // @[DebugSystem.scala 58:34]
  wire [1:0] Synchronizer_io_Jtag_in_req_bits_op; // @[DebugSystem.scala 58:34]
  wire [9:0] Synchronizer_io_Jtag_in_req_bits_addr; // @[DebugSystem.scala 58:34]
  wire [31:0] Synchronizer_io_Jtag_in_req_bits_data; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_DM_out_req_ready; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_DM_out_req_valid; // @[DebugSystem.scala 58:34]
  wire [1:0] Synchronizer_io_DM_out_req_bits_op; // @[DebugSystem.scala 58:34]
  wire [9:0] Synchronizer_io_DM_out_req_bits_addr; // @[DebugSystem.scala 58:34]
  wire [31:0] Synchronizer_io_DM_out_req_bits_data; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_DM_in_resp_ready; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_DM_in_resp_valid; // @[DebugSystem.scala 58:34]
  wire [31:0] Synchronizer_io_DM_in_resp_bits_data; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_Jtag_out_resp_valid; // @[DebugSystem.scala 58:34]
  wire [31:0] Synchronizer_io_Jtag_out_resp_bits_data; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_JtagReset; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_JtagClock; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_clock; // @[DebugSystem.scala 58:34]
  wire  Synchronizer_io_reset; // @[DebugSystem.scala 58:34]
  wire  DebugModule_clock; // @[DebugSystem.scala 59:33]
  wire  DebugModule_reset; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_debug_progBuffAc_we; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_progBuffAc_data_w; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_progBuffAc_addr_wr; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_progBuffAc_data_r; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_progBuffAc_IF_addr; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_progBuffAc_IF_data_r; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_debug_nPB_rst; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_debug_nPB_halt; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_debug_nPB_RegsAc_we; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_nPB_RegsAc_reg_addr; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_nPB_RegsAc_data_w; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_debug_nPB_RegsAc_data_r; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_debug_nPB_interruption; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_debug_nPB_breakpoint; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_SBA_AHB_caddr; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_SBA_AHB_cwrite; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_SBA_AHB_creq; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_SBA_AHB_cvalid; // @[DebugSystem.scala 59:33]
  wire [2:0] DebugModule_io_Debugport_SBA_AHB_csize; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_SBA_AHB_cwdata; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_SBA_AHB_crdata; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_SBA_AHB_cready; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_dmi_req_ready; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_dmi_req_valid; // @[DebugSystem.scala 59:33]
  wire [1:0] DebugModule_io_Debugport_dmi_req_bits_op; // @[DebugSystem.scala 59:33]
  wire [9:0] DebugModule_io_Debugport_dmi_req_bits_addr; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_dmi_req_bits_data; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_dmi_resp_ready; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_Debugport_dmi_resp_valid; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_Debugport_dmi_resp_bits_data; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_DM_actived; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_Halted; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_Reseted; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_PcMode; // @[DebugSystem.scala 59:33]
  wire [4:0] DebugModule_io_DmStatusControl_PBCellsProg; // @[DebugSystem.scala 59:33]
  wire [4:0] DebugModule_io_DmStatusControl_AHBTrans; // @[DebugSystem.scala 59:33]
  wire [5:0] DebugModule_io_DmStatusControl_DMTotalAcess; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_ResetDM; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_ClearProB; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_ClearAHBcells; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_DmStatusControl_ResetCounters; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_MonitorPorts_Data; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_MonitorPorts_IdSource; // @[DebugSystem.scala 59:33]
  wire [31:0] DebugModule_io_MonitorPorts_IdDestiny; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_MonitorPorts_Op; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_MonitorPorts_Valid; // @[DebugSystem.scala 59:33]
  wire  DebugModule_io_MonitorPorts_Ready; // @[DebugSystem.scala 59:33]
  JTag_TAP JTAG_TAP_BS ( // @[DebugSystem.scala 57:33]
    .reset(JTAG_TAP_BS_reset),
    .io_TMS(JTAG_TAP_BS_io_TMS),
    .io_TCK(JTAG_TAP_BS_io_TCK),
    .io_TDI(JTAG_TAP_BS_io_TDI),
    .io_TRSTn(JTAG_TAP_BS_io_TRSTn),
    .io_TDO(JTAG_TAP_BS_io_TDO),
    .io_PinCTRL_CORE_0_PE(JTAG_TAP_BS_io_PinCTRL_CORE_0_PE),
    .io_PinCTRL_CORE_0_IE(JTAG_TAP_BS_io_PinCTRL_CORE_0_IE),
    .io_PinCTRL_CORE_0_DS(JTAG_TAP_BS_io_PinCTRL_CORE_0_DS),
    .io_PinCTRL_CORE_0_I(JTAG_TAP_BS_io_PinCTRL_CORE_0_I),
    .io_PinCTRL_CORE_0_OEN(JTAG_TAP_BS_io_PinCTRL_CORE_0_OEN),
    .io_PinCTRL_CORE_0_C(JTAG_TAP_BS_io_PinCTRL_CORE_0_C),
    .io_PinCTRL_CORE_1_PE(JTAG_TAP_BS_io_PinCTRL_CORE_1_PE),
    .io_PinCTRL_CORE_1_IE(JTAG_TAP_BS_io_PinCTRL_CORE_1_IE),
    .io_PinCTRL_CORE_1_DS(JTAG_TAP_BS_io_PinCTRL_CORE_1_DS),
    .io_PinCTRL_CORE_1_I(JTAG_TAP_BS_io_PinCTRL_CORE_1_I),
    .io_PinCTRL_CORE_1_OEN(JTAG_TAP_BS_io_PinCTRL_CORE_1_OEN),
    .io_PinCTRL_CORE_1_C(JTAG_TAP_BS_io_PinCTRL_CORE_1_C),
    .io_PinCTRL_IO_0_PE(JTAG_TAP_BS_io_PinCTRL_IO_0_PE),
    .io_PinCTRL_IO_0_IE(JTAG_TAP_BS_io_PinCTRL_IO_0_IE),
    .io_PinCTRL_IO_0_DS(JTAG_TAP_BS_io_PinCTRL_IO_0_DS),
    .io_PinCTRL_IO_0_I(JTAG_TAP_BS_io_PinCTRL_IO_0_I),
    .io_PinCTRL_IO_0_OEN(JTAG_TAP_BS_io_PinCTRL_IO_0_OEN),
    .io_PinCTRL_IO_0_C(JTAG_TAP_BS_io_PinCTRL_IO_0_C),
    .io_PinCTRL_IO_1_PE(JTAG_TAP_BS_io_PinCTRL_IO_1_PE),
    .io_PinCTRL_IO_1_IE(JTAG_TAP_BS_io_PinCTRL_IO_1_IE),
    .io_PinCTRL_IO_1_DS(JTAG_TAP_BS_io_PinCTRL_IO_1_DS),
    .io_PinCTRL_IO_1_I(JTAG_TAP_BS_io_PinCTRL_IO_1_I),
    .io_PinCTRL_IO_1_OEN(JTAG_TAP_BS_io_PinCTRL_IO_1_OEN),
    .io_PinCTRL_IO_1_C(JTAG_TAP_BS_io_PinCTRL_IO_1_C),
    .io_dmi_req_ready(JTAG_TAP_BS_io_dmi_req_ready),
    .io_dmi_req_valid(JTAG_TAP_BS_io_dmi_req_valid),
    .io_dmi_req_bits_op(JTAG_TAP_BS_io_dmi_req_bits_op),
    .io_dmi_req_bits_addr(JTAG_TAP_BS_io_dmi_req_bits_addr),
    .io_dmi_req_bits_data(JTAG_TAP_BS_io_dmi_req_bits_data),
    .io_dmi_resp_valid(JTAG_TAP_BS_io_dmi_resp_valid),
    .io_dmi_resp_bits_data(JTAG_TAP_BS_io_dmi_resp_bits_data),
    .io_dmstatuscontrol_DM_actived(JTAG_TAP_BS_io_dmstatuscontrol_DM_actived),
    .io_dmstatuscontrol_Halted(JTAG_TAP_BS_io_dmstatuscontrol_Halted),
    .io_dmstatuscontrol_Reseted(JTAG_TAP_BS_io_dmstatuscontrol_Reseted),
    .io_dmstatuscontrol_PcMode(JTAG_TAP_BS_io_dmstatuscontrol_PcMode),
    .io_dmstatuscontrol_PBCellsProg(JTAG_TAP_BS_io_dmstatuscontrol_PBCellsProg),
    .io_dmstatuscontrol_AHBTrans(JTAG_TAP_BS_io_dmstatuscontrol_AHBTrans),
    .io_dmstatuscontrol_DMTotalAcess(JTAG_TAP_BS_io_dmstatuscontrol_DMTotalAcess),
    .io_dmstatuscontrol_ResetDM(JTAG_TAP_BS_io_dmstatuscontrol_ResetDM),
    .io_dmstatuscontrol_ClearProB(JTAG_TAP_BS_io_dmstatuscontrol_ClearProB),
    .io_dmstatuscontrol_ClearAHBcells(JTAG_TAP_BS_io_dmstatuscontrol_ClearAHBcells),
    .io_dmstatuscontrol_ResetCounters(JTAG_TAP_BS_io_dmstatuscontrol_ResetCounters)
  );
  JtagToDM Synchronizer ( // @[DebugSystem.scala 58:34]
    .io_Jtag_in_req_ready(Synchronizer_io_Jtag_in_req_ready),
    .io_Jtag_in_req_valid(Synchronizer_io_Jtag_in_req_valid),
    .io_Jtag_in_req_bits_op(Synchronizer_io_Jtag_in_req_bits_op),
    .io_Jtag_in_req_bits_addr(Synchronizer_io_Jtag_in_req_bits_addr),
    .io_Jtag_in_req_bits_data(Synchronizer_io_Jtag_in_req_bits_data),
    .io_DM_out_req_ready(Synchronizer_io_DM_out_req_ready),
    .io_DM_out_req_valid(Synchronizer_io_DM_out_req_valid),
    .io_DM_out_req_bits_op(Synchronizer_io_DM_out_req_bits_op),
    .io_DM_out_req_bits_addr(Synchronizer_io_DM_out_req_bits_addr),
    .io_DM_out_req_bits_data(Synchronizer_io_DM_out_req_bits_data),
    .io_DM_in_resp_ready(Synchronizer_io_DM_in_resp_ready),
    .io_DM_in_resp_valid(Synchronizer_io_DM_in_resp_valid),
    .io_DM_in_resp_bits_data(Synchronizer_io_DM_in_resp_bits_data),
    .io_Jtag_out_resp_valid(Synchronizer_io_Jtag_out_resp_valid),
    .io_Jtag_out_resp_bits_data(Synchronizer_io_Jtag_out_resp_bits_data),
    .io_JtagReset(Synchronizer_io_JtagReset),
    .io_JtagClock(Synchronizer_io_JtagClock),
    .io_clock(Synchronizer_io_clock),
    .io_reset(Synchronizer_io_reset)
  );
  DebugModule DebugModule ( // @[DebugSystem.scala 59:33]
    .clock(DebugModule_clock),
    .reset(DebugModule_reset),
    .io_Debugport_debug_progBuffAc_we(DebugModule_io_Debugport_debug_progBuffAc_we),
    .io_Debugport_debug_progBuffAc_data_w(DebugModule_io_Debugport_debug_progBuffAc_data_w),
    .io_Debugport_debug_progBuffAc_addr_wr(DebugModule_io_Debugport_debug_progBuffAc_addr_wr),
    .io_Debugport_debug_progBuffAc_data_r(DebugModule_io_Debugport_debug_progBuffAc_data_r),
    .io_Debugport_debug_progBuffAc_IF_addr(DebugModule_io_Debugport_debug_progBuffAc_IF_addr),
    .io_Debugport_debug_progBuffAc_IF_data_r(DebugModule_io_Debugport_debug_progBuffAc_IF_data_r),
    .io_Debugport_debug_nPB_rst(DebugModule_io_Debugport_debug_nPB_rst),
    .io_Debugport_debug_nPB_halt(DebugModule_io_Debugport_debug_nPB_halt),
    .io_Debugport_debug_nPB_RegsAc_we(DebugModule_io_Debugport_debug_nPB_RegsAc_we),
    .io_Debugport_debug_nPB_RegsAc_reg_addr(DebugModule_io_Debugport_debug_nPB_RegsAc_reg_addr),
    .io_Debugport_debug_nPB_RegsAc_data_w(DebugModule_io_Debugport_debug_nPB_RegsAc_data_w),
    .io_Debugport_debug_nPB_RegsAc_data_r(DebugModule_io_Debugport_debug_nPB_RegsAc_data_r),
    .io_Debugport_debug_nPB_interruption(DebugModule_io_Debugport_debug_nPB_interruption),
    .io_Debugport_debug_nPB_breakpoint(DebugModule_io_Debugport_debug_nPB_breakpoint),
    .io_Debugport_SBA_AHB_caddr(DebugModule_io_Debugport_SBA_AHB_caddr),
    .io_Debugport_SBA_AHB_cwrite(DebugModule_io_Debugport_SBA_AHB_cwrite),
    .io_Debugport_SBA_AHB_creq(DebugModule_io_Debugport_SBA_AHB_creq),
    .io_Debugport_SBA_AHB_cvalid(DebugModule_io_Debugport_SBA_AHB_cvalid),
    .io_Debugport_SBA_AHB_csize(DebugModule_io_Debugport_SBA_AHB_csize),
    .io_Debugport_SBA_AHB_cwdata(DebugModule_io_Debugport_SBA_AHB_cwdata),
    .io_Debugport_SBA_AHB_crdata(DebugModule_io_Debugport_SBA_AHB_crdata),
    .io_Debugport_SBA_AHB_cready(DebugModule_io_Debugport_SBA_AHB_cready),
    .io_Debugport_dmi_req_ready(DebugModule_io_Debugport_dmi_req_ready),
    .io_Debugport_dmi_req_valid(DebugModule_io_Debugport_dmi_req_valid),
    .io_Debugport_dmi_req_bits_op(DebugModule_io_Debugport_dmi_req_bits_op),
    .io_Debugport_dmi_req_bits_addr(DebugModule_io_Debugport_dmi_req_bits_addr),
    .io_Debugport_dmi_req_bits_data(DebugModule_io_Debugport_dmi_req_bits_data),
    .io_Debugport_dmi_resp_ready(DebugModule_io_Debugport_dmi_resp_ready),
    .io_Debugport_dmi_resp_valid(DebugModule_io_Debugport_dmi_resp_valid),
    .io_Debugport_dmi_resp_bits_data(DebugModule_io_Debugport_dmi_resp_bits_data),
    .io_DmStatusControl_DM_actived(DebugModule_io_DmStatusControl_DM_actived),
    .io_DmStatusControl_Halted(DebugModule_io_DmStatusControl_Halted),
    .io_DmStatusControl_Reseted(DebugModule_io_DmStatusControl_Reseted),
    .io_DmStatusControl_PcMode(DebugModule_io_DmStatusControl_PcMode),
    .io_DmStatusControl_PBCellsProg(DebugModule_io_DmStatusControl_PBCellsProg),
    .io_DmStatusControl_AHBTrans(DebugModule_io_DmStatusControl_AHBTrans),
    .io_DmStatusControl_DMTotalAcess(DebugModule_io_DmStatusControl_DMTotalAcess),
    .io_DmStatusControl_ResetDM(DebugModule_io_DmStatusControl_ResetDM),
    .io_DmStatusControl_ClearProB(DebugModule_io_DmStatusControl_ClearProB),
    .io_DmStatusControl_ClearAHBcells(DebugModule_io_DmStatusControl_ClearAHBcells),
    .io_DmStatusControl_ResetCounters(DebugModule_io_DmStatusControl_ResetCounters),
    .io_MonitorPorts_Data(DebugModule_io_MonitorPorts_Data),
    .io_MonitorPorts_IdSource(DebugModule_io_MonitorPorts_IdSource),
    .io_MonitorPorts_IdDestiny(DebugModule_io_MonitorPorts_IdDestiny),
    .io_MonitorPorts_Op(DebugModule_io_MonitorPorts_Op),
    .io_MonitorPorts_Valid(DebugModule_io_MonitorPorts_Valid),
    .io_MonitorPorts_Ready(DebugModule_io_MonitorPorts_Ready)
  );
  assign io_pins_ext_TDO_I = JTAG_TAP_BS_io_TDO; // @[gpio_pad.scala 36:17]
  assign io_pins_PinCTRL_CORE_0_C = JTAG_TAP_BS_io_PinCTRL_CORE_0_C; // @[DebugSystem.scala 71:11]
  assign io_pins_PinCTRL_CORE_1_C = JTAG_TAP_BS_io_PinCTRL_CORE_1_C; // @[DebugSystem.scala 71:11]
  assign io_pins_PinCTRL_IO_0_PE = JTAG_TAP_BS_io_PinCTRL_IO_0_PE; // @[DebugSystem.scala 77:29]
  assign io_pins_PinCTRL_IO_0_IE = JTAG_TAP_BS_io_PinCTRL_IO_0_IE; // @[DebugSystem.scala 78:29]
  assign io_pins_PinCTRL_IO_0_DS = JTAG_TAP_BS_io_PinCTRL_IO_0_DS; // @[DebugSystem.scala 76:30]
  assign io_pins_PinCTRL_IO_0_I = JTAG_TAP_BS_io_PinCTRL_IO_0_I; // @[DebugSystem.scala 79:29]
  assign io_pins_PinCTRL_IO_0_OEN = JTAG_TAP_BS_io_PinCTRL_IO_0_OEN; // @[DebugSystem.scala 75:31]
  assign io_pins_PinCTRL_IO_1_PE = JTAG_TAP_BS_io_PinCTRL_IO_1_PE; // @[DebugSystem.scala 77:29]
  assign io_pins_PinCTRL_IO_1_IE = JTAG_TAP_BS_io_PinCTRL_IO_1_IE; // @[DebugSystem.scala 78:29]
  assign io_pins_PinCTRL_IO_1_DS = JTAG_TAP_BS_io_PinCTRL_IO_1_DS; // @[DebugSystem.scala 76:30]
  assign io_pins_PinCTRL_IO_1_I = JTAG_TAP_BS_io_PinCTRL_IO_1_I; // @[DebugSystem.scala 79:29]
  assign io_pins_PinCTRL_IO_1_OEN = JTAG_TAP_BS_io_PinCTRL_IO_1_OEN; // @[DebugSystem.scala 75:31]
  assign io_Dm_Output_debug_progBuffAc_data_r = DebugModule_io_Debugport_debug_progBuffAc_data_r; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_progBuffAc_IF_data_r = DebugModule_io_Debugport_debug_progBuffAc_IF_data_r; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_nPB_rst = DebugModule_io_Debugport_debug_nPB_rst; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_nPB_halt = DebugModule_io_Debugport_debug_nPB_halt; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_nPB_RegsAc_we = DebugModule_io_Debugport_debug_nPB_RegsAc_we; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_nPB_RegsAc_reg_addr = DebugModule_io_Debugport_debug_nPB_RegsAc_reg_addr; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_nPB_RegsAc_data_w = DebugModule_io_Debugport_debug_nPB_RegsAc_data_w; // @[DebugSystem.scala 106:28]
  assign io_Dm_Output_debug_nPB_interruption = DebugModule_io_Debugport_debug_nPB_interruption; // @[DebugSystem.scala 106:28]
  assign io_SBA_AHB_caddr = DebugModule_io_Debugport_SBA_AHB_caddr; // @[DebugSystem.scala 108:20]
  assign io_SBA_AHB_cwrite = DebugModule_io_Debugport_SBA_AHB_cwrite; // @[DebugSystem.scala 108:20]
  assign io_SBA_AHB_creq = DebugModule_io_Debugport_SBA_AHB_creq; // @[DebugSystem.scala 108:20]
  assign io_SBA_AHB_cvalid = DebugModule_io_Debugport_SBA_AHB_cvalid; // @[DebugSystem.scala 108:20]
  assign io_SBA_AHB_csize = DebugModule_io_Debugport_SBA_AHB_csize; // @[DebugSystem.scala 108:20]
  assign io_SBA_AHB_cwdata = DebugModule_io_Debugport_SBA_AHB_cwdata; // @[DebugSystem.scala 108:20]
  assign JTAG_TAP_BS_reset = reset;
  assign JTAG_TAP_BS_io_TMS = io_pins_ext_TMS_C; // @[DebugSystem.scala 85:28]
  assign JTAG_TAP_BS_io_TCK = io_pins_ext_TCK_C; // @[DebugSystem.scala 86:28]
  assign JTAG_TAP_BS_io_TDI = io_pins_ext_TDI_C; // @[DebugSystem.scala 87:28]
  assign JTAG_TAP_BS_io_TRSTn = io_pins_ext_TRSTn_C; // @[DebugSystem.scala 88:30]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_0_PE = io_pins_PinCTRL_CORE_0_PE; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_0_IE = io_pins_PinCTRL_CORE_0_IE; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_0_DS = io_pins_PinCTRL_CORE_0_DS; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_0_I = io_pins_PinCTRL_CORE_0_I; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_0_OEN = io_pins_PinCTRL_CORE_0_OEN; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_1_PE = io_pins_PinCTRL_CORE_1_PE; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_1_IE = io_pins_PinCTRL_CORE_1_IE; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_1_DS = io_pins_PinCTRL_CORE_1_DS; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_1_I = io_pins_PinCTRL_CORE_1_I; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_CORE_1_OEN = io_pins_PinCTRL_CORE_1_OEN; // @[DebugSystem.scala 92:37]
  assign JTAG_TAP_BS_io_PinCTRL_IO_0_C = io_pins_PinCTRL_IO_0_C; // @[DebugSystem.scala 93:35]
  assign JTAG_TAP_BS_io_PinCTRL_IO_1_C = io_pins_PinCTRL_IO_1_C; // @[DebugSystem.scala 93:35]
  assign JTAG_TAP_BS_io_dmi_req_ready = Synchronizer_io_Jtag_in_req_ready; // @[DebugSystem.scala 101:32]
  assign JTAG_TAP_BS_io_dmi_resp_valid = Synchronizer_io_Jtag_out_resp_valid; // @[DebugSystem.scala 102:33]
  assign JTAG_TAP_BS_io_dmi_resp_bits_data = Synchronizer_io_Jtag_out_resp_bits_data; // @[DebugSystem.scala 102:33]
  assign JTAG_TAP_BS_io_dmstatuscontrol_DM_actived = DebugModule_io_DmStatusControl_DM_actived; // @[DebugSystem.scala 113:40]
  assign JTAG_TAP_BS_io_dmstatuscontrol_Halted = DebugModule_io_DmStatusControl_Halted; // @[DebugSystem.scala 113:40]
  assign JTAG_TAP_BS_io_dmstatuscontrol_Reseted = DebugModule_io_DmStatusControl_Reseted; // @[DebugSystem.scala 113:40]
  assign JTAG_TAP_BS_io_dmstatuscontrol_PcMode = DebugModule_io_DmStatusControl_PcMode; // @[DebugSystem.scala 113:40]
  assign JTAG_TAP_BS_io_dmstatuscontrol_PBCellsProg = DebugModule_io_DmStatusControl_PBCellsProg; // @[DebugSystem.scala 113:40]
  assign JTAG_TAP_BS_io_dmstatuscontrol_AHBTrans = DebugModule_io_DmStatusControl_AHBTrans; // @[DebugSystem.scala 113:40]
  assign JTAG_TAP_BS_io_dmstatuscontrol_DMTotalAcess = DebugModule_io_DmStatusControl_DMTotalAcess; // @[DebugSystem.scala 113:40]
  assign Synchronizer_io_Jtag_in_req_valid = JTAG_TAP_BS_io_dmi_req_valid; // @[DebugSystem.scala 101:32]
  assign Synchronizer_io_Jtag_in_req_bits_op = JTAG_TAP_BS_io_dmi_req_bits_op; // @[DebugSystem.scala 101:32]
  assign Synchronizer_io_Jtag_in_req_bits_addr = JTAG_TAP_BS_io_dmi_req_bits_addr; // @[DebugSystem.scala 101:32]
  assign Synchronizer_io_Jtag_in_req_bits_data = JTAG_TAP_BS_io_dmi_req_bits_data; // @[DebugSystem.scala 101:32]
  assign Synchronizer_io_DM_out_req_ready = DebugModule_io_Debugport_dmi_req_ready; // @[DebugSystem.scala 104:42]
  assign Synchronizer_io_DM_in_resp_valid = DebugModule_io_Debugport_dmi_resp_valid; // @[DebugSystem.scala 103:36]
  assign Synchronizer_io_DM_in_resp_bits_data = DebugModule_io_Debugport_dmi_resp_bits_data; // @[DebugSystem.scala 103:36]
  assign Synchronizer_io_JtagReset = JTAG_TAP_BS_io_TRSTn; // @[DebugSystem.scala 96:35]
  assign Synchronizer_io_JtagClock = JTAG_TAP_BS_io_TCK; // @[DebugSystem.scala 95:35]
  assign Synchronizer_io_clock = clock; // @[DebugSystem.scala 97:31]
  assign Synchronizer_io_reset = reset; // @[DebugSystem.scala 98:31]
  assign DebugModule_clock = clock;
  assign DebugModule_reset = reset;
  assign DebugModule_io_Debugport_debug_progBuffAc_we = io_Dm_Output_debug_progBuffAc_we; // @[DebugSystem.scala 106:28]
  assign DebugModule_io_Debugport_debug_progBuffAc_data_w = io_Dm_Output_debug_progBuffAc_data_w; // @[DebugSystem.scala 106:28]
  assign DebugModule_io_Debugport_debug_progBuffAc_addr_wr = io_Dm_Output_debug_progBuffAc_addr_wr; // @[DebugSystem.scala 106:28]
  assign DebugModule_io_Debugport_debug_progBuffAc_IF_addr = io_Dm_Output_debug_progBuffAc_IF_addr; // @[DebugSystem.scala 106:28]
  assign DebugModule_io_Debugport_debug_nPB_RegsAc_data_r = io_Dm_Output_debug_nPB_RegsAc_data_r; // @[DebugSystem.scala 106:28]
  assign DebugModule_io_Debugport_debug_nPB_breakpoint = io_Dm_Output_debug_nPB_breakpoint; // @[DebugSystem.scala 106:28]
  assign DebugModule_io_Debugport_SBA_AHB_crdata = io_SBA_AHB_crdata; // @[DebugSystem.scala 108:20]
  assign DebugModule_io_Debugport_SBA_AHB_cready = io_SBA_AHB_cready; // @[DebugSystem.scala 108:20]
  assign DebugModule_io_Debugport_dmi_req_valid = Synchronizer_io_DM_out_req_valid; // @[DebugSystem.scala 104:42]
  assign DebugModule_io_Debugport_dmi_req_bits_op = Synchronizer_io_DM_out_req_bits_op; // @[DebugSystem.scala 104:42]
  assign DebugModule_io_Debugport_dmi_req_bits_addr = Synchronizer_io_DM_out_req_bits_addr; // @[DebugSystem.scala 104:42]
  assign DebugModule_io_Debugport_dmi_req_bits_data = Synchronizer_io_DM_out_req_bits_data; // @[DebugSystem.scala 104:42]
  assign DebugModule_io_Debugport_dmi_resp_ready = Synchronizer_io_DM_in_resp_ready; // @[DebugSystem.scala 103:36]
  assign DebugModule_io_DmStatusControl_ResetDM = JTAG_TAP_BS_io_dmstatuscontrol_ResetDM; // @[DebugSystem.scala 113:40]
  assign DebugModule_io_DmStatusControl_ClearProB = JTAG_TAP_BS_io_dmstatuscontrol_ClearProB; // @[DebugSystem.scala 113:40]
  assign DebugModule_io_DmStatusControl_ClearAHBcells = JTAG_TAP_BS_io_dmstatuscontrol_ClearAHBcells; // @[DebugSystem.scala 113:40]
  assign DebugModule_io_DmStatusControl_ResetCounters = JTAG_TAP_BS_io_dmstatuscontrol_ResetCounters; // @[DebugSystem.scala 113:40]
  assign DebugModule_io_MonitorPorts_Data = io_MonitorPorts_Data; // @[DebugSystem.scala 110:37]
  assign DebugModule_io_MonitorPorts_IdSource = io_MonitorPorts_IdSource; // @[DebugSystem.scala 110:37]
  assign DebugModule_io_MonitorPorts_IdDestiny = io_MonitorPorts_IdDestiny; // @[DebugSystem.scala 110:37]
  assign DebugModule_io_MonitorPorts_Op = io_MonitorPorts_Op; // @[DebugSystem.scala 110:37]
  assign DebugModule_io_MonitorPorts_Valid = io_MonitorPorts_Valid; // @[DebugSystem.scala 110:37]
  assign DebugModule_io_MonitorPorts_Ready = io_MonitorPorts_Ready; // @[DebugSystem.scala 110:37]
endmodule
module Condor2ColibriBridge(
  output [31:0] io_colibriMaster_in_paddr,
  output [2:0]  io_colibriMaster_in_psize,
  output [31:0] io_colibriMaster_in_pwdata,
  output        io_colibriMaster_in_pwrite,
  output        io_colibriMaster_in_pvalid,
  input  [31:0] io_colibriMaster_in_prdata,
  input  [31:0] io_condorMaster_out_caddr,
  input         io_condorMaster_out_cwrite,
  input         io_condorMaster_out_cvalid,
  input  [2:0]  io_condorMaster_out_csize,
  input  [31:0] io_condorMaster_out_cwdata,
  output [31:0] io_condorMaster_out_crdata
);
  assign io_colibriMaster_in_paddr = io_condorMaster_out_caddr; // @[Condor2Colibri_Bridge.scala 17:29]
  assign io_colibriMaster_in_psize = io_condorMaster_out_csize; // @[Condor2Colibri_Bridge.scala 20:30]
  assign io_colibriMaster_in_pwdata = io_condorMaster_out_cwdata; // @[Condor2Colibri_Bridge.scala 21:30]
  assign io_colibriMaster_in_pwrite = io_condorMaster_out_cwrite; // @[Condor2Colibri_Bridge.scala 22:30]
  assign io_colibriMaster_in_pvalid = io_condorMaster_out_cvalid; // @[Condor2Colibri_Bridge.scala 23:30]
  assign io_condorMaster_out_crdata = io_colibriMaster_in_prdata; // @[Condor2Colibri_Bridge.scala 25:33]
endmodule
module microDMA(
  input         clock,
  input         reset,
  input  [7:0]  io_DataIn,
  input         io_DataInValid,
  input         io_enable,
  output [12:0] io_DataOutAddress,
  output [31:0] io_DataOut,
  output        io_pmode,
  output        io_DataOutValid,
  output        io_Finish
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] ByteCounter; // @[microDMA.scala 46:34]
  reg [12:0] AddressRegister; // @[microDMA.scala 48:38]
  reg [31:0] DataRegister; // @[microDMA.scala 49:35]
  reg  DataValid; // @[microDMA.scala 50:33]
  reg [31:0] MemoryCounter; // @[microDMA.scala 51:36]
  reg  StartProgramming; // @[microDMA.scala 52:39]
  reg  FinishProgramming; // @[microDMA.scala 53:40]
  reg  GetInstructionNumber; // @[microDMA.scala 66:43]
  reg [2:0] ActivateState; // @[microDMA.scala 67:36]
  wire  _T_2 = 3'h0 == ActivateState; // @[Conditional.scala 37:30]
  wire  _T_3 = io_DataIn == 8'h43; // @[microDMA.scala 76:49]
  wire  _T_4 = 3'h1 == ActivateState; // @[Conditional.scala 37:30]
  wire  _T_5 = io_DataIn == 8'h41; // @[microDMA.scala 95:49]
  wire  _T_6 = 3'h2 == ActivateState; // @[Conditional.scala 37:30]
  wire  _T_7 = io_DataIn == 8'h46; // @[microDMA.scala 114:49]
  wire  _T_8 = 3'h3 == ActivateState; // @[Conditional.scala 37:30]
  wire  _T_9 = io_DataIn == 8'h45; // @[microDMA.scala 133:49]
  wire  _GEN_8 = _T_9 | GetInstructionNumber; // @[microDMA.scala 134:33]
  wire  _T_10 = 3'h4 == ActivateState; // @[Conditional.scala 37:30]
  wire  _T_11 = ~GetInstructionNumber; // @[microDMA.scala 151:30]
  wire  _T_12 = MemoryCounter == 32'h0; // @[microDMA.scala 151:70]
  wire  _T_13 = _T_11 & _T_12; // @[microDMA.scala 151:52]
  wire  _T_14 = ActivateState == 3'h4; // @[microDMA.scala 164:44]
  wire  _T_15 = ByteCounter == 3'h4; // @[microDMA.scala 172:34]
  wire [2:0] _T_17 = ByteCounter + 3'h1; // @[microDMA.scala 187:60]
  wire [31:0] _T_19 = {MemoryCounter[23:0],io_DataIn}; // @[Cat.scala 29:58]
  wire [12:0] _T_21 = AddressRegister + 13'h1; // @[microDMA.scala 196:69]
  wire [31:0] _T_24 = MemoryCounter - 32'h1; // @[microDMA.scala 202:56]
  wire [31:0] _T_28 = {DataRegister[23:0],io_DataIn}; // @[Cat.scala 29:58]
  assign io_DataOutAddress = AddressRegister; // @[microDMA.scala 226:27]
  assign io_DataOut = DataRegister; // @[microDMA.scala 225:20]
  assign io_pmode = StartProgramming & io_enable; // @[microDMA.scala 224:18]
  assign io_DataOutValid = DataValid & io_enable; // @[microDMA.scala 227:25]
  assign io_Finish = FinishProgramming & io_enable; // @[microDMA.scala 228:19]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ByteCounter = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  AddressRegister = _RAND_1[12:0];
  _RAND_2 = {1{`RANDOM}};
  DataRegister = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  DataValid = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  MemoryCounter = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  StartProgramming = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  FinishProgramming = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  GetInstructionNumber = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  ActivateState = _RAND_8[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      ByteCounter <= 3'h0;
    end else if (GetInstructionNumber) begin
      if (StartProgramming) begin
        if (io_DataInValid) begin
          ByteCounter <= _T_17;
        end else if (_T_15) begin
          ByteCounter <= 3'h0;
        end
      end else if (_T_15) begin
        ByteCounter <= 3'h0;
      end
    end else if (StartProgramming) begin
      if (io_DataInValid) begin
        ByteCounter <= _T_17;
      end else if (_T_15) begin
        ByteCounter <= 3'h0;
      end
    end else if (_T_15) begin
      ByteCounter <= 3'h0;
    end
    if (reset) begin
      AddressRegister <= 13'h0;
    end else if (!(GetInstructionNumber)) begin
      if (DataValid) begin
        AddressRegister <= _T_21;
      end else if (!(_T_2)) begin
        if (!(_T_4)) begin
          if (!(_T_6)) begin
            if (_T_8) begin
              if (io_DataInValid) begin
                if (_T_9) begin
                  AddressRegister <= 13'h0;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      DataRegister <= 32'h0;
    end else if (!(GetInstructionNumber)) begin
      if (StartProgramming) begin
        if (io_DataInValid) begin
          DataRegister <= _T_28;
        end
      end
    end
    if (reset) begin
      DataValid <= 1'h0;
    end else if (GetInstructionNumber) begin
      DataValid <= 1'h0;
    end else if (StartProgramming) begin
      if (io_DataInValid) begin
        DataValid <= 1'h0;
      end else begin
        DataValid <= _T_15;
      end
    end else begin
      DataValid <= _T_15;
    end
    if (reset) begin
      MemoryCounter <= 32'h0;
    end else if (GetInstructionNumber) begin
      if (StartProgramming) begin
        if (io_DataInValid) begin
          MemoryCounter <= _T_19;
        end
      end
    end else if (_T_15) begin
      MemoryCounter <= _T_24;
    end
    if (reset) begin
      StartProgramming <= 1'h0;
    end else begin
      StartProgramming <= _T_14;
    end
    if (reset) begin
      FinishProgramming <= 1'h0;
    end else if (_T_2) begin
      FinishProgramming <= 1'h0;
    end else if (_T_4) begin
      FinishProgramming <= 1'h0;
    end else if (_T_6) begin
      FinishProgramming <= 1'h0;
    end else if (_T_8) begin
      FinishProgramming <= 1'h0;
    end else if (_T_10) begin
      FinishProgramming <= _T_13;
    end
    if (reset) begin
      GetInstructionNumber <= 1'h0;
    end else if (GetInstructionNumber) begin
      if (_T_15) begin
        GetInstructionNumber <= 1'h0;
      end else if (!(_T_2)) begin
        if (!(_T_4)) begin
          if (!(_T_6)) begin
            if (_T_8) begin
              if (io_DataInValid) begin
                GetInstructionNumber <= _GEN_8;
              end
            end
          end
        end
      end
    end else if (!(_T_2)) begin
      if (!(_T_4)) begin
        if (!(_T_6)) begin
          if (_T_8) begin
            if (io_DataInValid) begin
              GetInstructionNumber <= _GEN_8;
            end
          end
        end
      end
    end
    if (reset) begin
      ActivateState <= 3'h0;
    end else if (_T_2) begin
      if (io_DataInValid) begin
        if (_T_3) begin
          ActivateState <= 3'h1;
        end else begin
          ActivateState <= 3'h0;
        end
      end else begin
        ActivateState <= 3'h0;
      end
    end else if (_T_4) begin
      if (io_DataInValid) begin
        if (_T_5) begin
          ActivateState <= 3'h2;
        end else begin
          ActivateState <= 3'h0;
        end
      end else begin
        ActivateState <= 3'h1;
      end
    end else if (_T_6) begin
      if (io_DataInValid) begin
        if (_T_7) begin
          ActivateState <= 3'h3;
        end else begin
          ActivateState <= 3'h0;
        end
      end else begin
        ActivateState <= 3'h2;
      end
    end else if (_T_8) begin
      if (io_DataInValid) begin
        if (_T_9) begin
          ActivateState <= 3'h4;
        end else begin
          ActivateState <= 3'h0;
        end
      end else begin
        ActivateState <= 3'h3;
      end
    end else if (_T_10) begin
      if (_T_13) begin
        ActivateState <= 3'h0;
      end else begin
        ActivateState <= 3'h4;
      end
    end
  end
endmodule
module Condor_SI(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata,
  output [31:0] io_rego_0,
  output [31:0] io_rego_1,
  output [31:0] io_rego_2,
  output [31:0] io_rego_3,
  input  [31:0] io_regi_0,
  input  [31:0] io_regi_1,
  input  [31:0] io_regi_2,
  input  [31:0] io_regi_3
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rego_0; // @[condorSlave.scala 27:26]
  reg [31:0] rego_1; // @[condorSlave.scala 27:26]
  reg [31:0] rego_2; // @[condorSlave.scala 27:26]
  reg [31:0] rego_3; // @[condorSlave.scala 27:26]
  wire [255:0] _T_7 = {io_regi_3,io_regi_2,io_regi_1,io_regi_0,rego_3,rego_2,rego_1,rego_0}; // @[Cat.scala 29:58]
  wire [31:0] full_regs_0 = _T_7[31:0]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_1 = _T_7[63:32]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_2 = _T_7[95:64]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_3 = _T_7[127:96]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_4 = _T_7[159:128]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_5 = _T_7[191:160]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_6 = _T_7[223:192]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_7 = _T_7[255:224]; // @[condorSlave.scala 41:73]
  reg [2:0] wraddr; // @[condorSlave.scala 45:28]
  reg [1:0] bmask; // @[condorSlave.scala 46:28]
  reg  state; // @[condorSlave.scala 48:22]
  reg [2:0] csize; // @[condorSlave.scala 49:22]
  wire  _T_19 = io_condor_csel & io_condor_cvalid; // @[condorSlave.scala 51:30]
  wire  _T_20 = _T_19 & io_condor_creq; // @[condorSlave.scala 51:52]
  wire  _T_21 = _T_20 & io_condor_cwrite; // @[condorSlave.scala 51:73]
  wire  _T_22 = csize == 3'h0; // @[condorSlave.scala 58:19]
  wire [3:0] _GEN_49 = {{2'd0}, bmask}; // @[condorSlave.scala 59:83]
  wire [5:0] _T_27 = _GEN_49 * 4'h8; // @[condorSlave.scala 59:83]
  wire [70:0] _T_28 = 71'hff << _T_27; // @[condorSlave.scala 59:75]
  wire [70:0] _T_29 = ~_T_28; // @[condorSlave.scala 59:65]
  wire [31:0] _GEN_2 = 2'h1 == wraddr[1:0] ? rego_1 : rego_0; // @[condorSlave.scala 59:63]
  wire [31:0] _GEN_3 = 2'h2 == wraddr[1:0] ? rego_2 : _GEN_2; // @[condorSlave.scala 59:63]
  wire [31:0] _GEN_4 = 2'h3 == wraddr[1:0] ? rego_3 : _GEN_3; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_50 = {{39'd0}, _GEN_4}; // @[condorSlave.scala 59:63]
  wire [70:0] _T_30 = _GEN_50 & _T_29; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_51 = {{39'd0}, io_condor_cwdata}; // @[condorSlave.scala 59:91]
  wire [70:0] _T_31 = _T_30 | _GEN_51; // @[condorSlave.scala 59:91]
  wire  _T_32 = csize == 3'h1; // @[condorSlave.scala 61:32]
  wire [4:0] _GEN_52 = {{4'd0}, bmask[1]}; // @[condorSlave.scala 62:79]
  wire [5:0] _T_38 = _GEN_52 * 5'h10; // @[condorSlave.scala 62:79]
  wire [78:0] _T_39 = 79'hffff << _T_38; // @[condorSlave.scala 62:68]
  wire [78:0] _T_40 = ~_T_39; // @[condorSlave.scala 62:56]
  wire [78:0] _GEN_53 = {{47'd0}, _GEN_4}; // @[condorSlave.scala 62:54]
  wire [78:0] _T_41 = _GEN_53 & _T_40; // @[condorSlave.scala 62:54]
  wire [78:0] _GEN_54 = {{47'd0}, io_condor_cwdata}; // @[condorSlave.scala 62:88]
  wire [78:0] _T_42 = _T_41 | _GEN_54; // @[condorSlave.scala 62:88]
  wire  _T_43 = csize == 3'h2; // @[condorSlave.scala 64:32]
  wire [31:0] _T_49 = io_condor_caddr - 32'h20000000; // @[condorSlave.scala 74:33]
  reg [31:0] readed; // @[condorSlave.scala 75:29]
  wire [2:0] raddr = _T_49[4:2]; // @[condorSlave.scala 44:25 condorSlave.scala 74:14]
  assign io_condor_crdata = readed; // @[condorSlave.scala 76:29]
  assign io_rego_0 = rego_0; // @[condorSlave.scala 31:16]
  assign io_rego_1 = rego_1; // @[condorSlave.scala 31:16]
  assign io_rego_2 = rego_2; // @[condorSlave.scala 31:16]
  assign io_rego_3 = rego_3; // @[condorSlave.scala 31:16]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rego_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rego_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rego_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  rego_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  wraddr = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  bmask = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  state = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  csize = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  readed = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      rego_0 <= 32'h808;
    end else if (state) begin
      if (_T_22) begin
        if (2'h0 == wraddr[1:0]) begin
          rego_0 <= _T_31[31:0];
        end
      end else if (_T_32) begin
        if (2'h0 == wraddr[1:0]) begin
          rego_0 <= _T_42[31:0];
        end
      end else if (_T_43) begin
        if (2'h0 == wraddr[1:0]) begin
          rego_0 <= io_condor_cwdata;
        end
      end else if (2'h0 == wraddr[1:0]) begin
        rego_0 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_1 <= 32'h28b1;
    end else if (state) begin
      if (_T_22) begin
        if (2'h1 == wraddr[1:0]) begin
          rego_1 <= _T_31[31:0];
        end
      end else if (_T_32) begin
        if (2'h1 == wraddr[1:0]) begin
          rego_1 <= _T_42[31:0];
        end
      end else if (_T_43) begin
        if (2'h1 == wraddr[1:0]) begin
          rego_1 <= io_condor_cwdata;
        end
      end else if (2'h1 == wraddr[1:0]) begin
        rego_1 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_2 <= 32'h0;
    end else if (state) begin
      if (_T_22) begin
        if (2'h2 == wraddr[1:0]) begin
          rego_2 <= _T_31[31:0];
        end
      end else if (_T_32) begin
        if (2'h2 == wraddr[1:0]) begin
          rego_2 <= _T_42[31:0];
        end
      end else if (_T_43) begin
        if (2'h2 == wraddr[1:0]) begin
          rego_2 <= io_condor_cwdata;
        end
      end else if (2'h2 == wraddr[1:0]) begin
        rego_2 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_3 <= 32'h30;
    end else if (state) begin
      if (_T_22) begin
        if (2'h3 == wraddr[1:0]) begin
          rego_3 <= _T_31[31:0];
        end
      end else if (_T_32) begin
        if (2'h3 == wraddr[1:0]) begin
          rego_3 <= _T_42[31:0];
        end
      end else if (_T_43) begin
        if (2'h3 == wraddr[1:0]) begin
          rego_3 <= io_condor_cwdata;
        end
      end else if (2'h3 == wraddr[1:0]) begin
        rego_3 <= io_condor_cwdata;
      end
    end
    wraddr <= _T_49[4:2];
    bmask <= io_condor_caddr[1:0];
    if (reset) begin
      state <= 1'h0;
    end else begin
      state <= _T_21;
    end
    csize <= io_condor_csize;
    if (3'h7 == raddr) begin
      readed <= full_regs_7;
    end else if (3'h6 == raddr) begin
      readed <= full_regs_6;
    end else if (3'h5 == raddr) begin
      readed <= full_regs_5;
    end else if (3'h4 == raddr) begin
      readed <= full_regs_4;
    end else if (3'h3 == raddr) begin
      readed <= full_regs_3;
    end else if (3'h2 == raddr) begin
      readed <= full_regs_2;
    end else if (3'h1 == raddr) begin
      readed <= full_regs_1;
    end else begin
      readed <= full_regs_0;
    end
  end
endmodule
module FIFO(
  input        clock,
  input        reset,
  input  [7:0] io_FIFOin,
  input        io_FIFOwr,
  input        io_FIFOrd,
  input        io_reset,
  output [7:0] io_FIFOout,
  output       io_FIFOfull,
  output       io_FIFOempty,
  output       io_FIFOrdError,
  output       io_FIFOwrError
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] index; // @[FIFO.scala 41:22]
  reg [3:0] wrindex; // @[FIFO.scala 42:24]
  reg [3:0] rdindex; // @[FIFO.scala 43:24]
  reg [7:0] FIFO_0; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_1; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_2; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_3; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_4; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_5; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_6; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_7; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_8; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_9; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_10; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_11; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_12; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_13; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_14; // @[FIFO.scala 45:21]
  reg [7:0] FIFO_15; // @[FIFO.scala 45:21]
  reg [7:0] data; // @[FIFO.scala 47:21]
  wire  _T_1 = index == 5'h0; // @[FIFO.scala 58:20]
  wire [4:0] _T_3 = 5'h10 - 5'h1; // @[FIFO.scala 64:43]
  wire [4:0] _GEN_85 = {{1'd0}, rdindex}; // @[FIFO.scala 64:30]
  wire  _T_4 = _GEN_85 == _T_3; // @[FIFO.scala 64:30]
  wire [3:0] _T_6 = rdindex + 4'h1; // @[FIFO.scala 64:96]
  wire [4:0] _T_8 = index - 5'h1; // @[FIFO.scala 65:32]
  wire  _T_9 = index == 5'h10; // @[FIFO.scala 74:20]
  wire [4:0] _GEN_86 = {{1'd0}, wrindex}; // @[FIFO.scala 80:30]
  wire  _T_12 = _GEN_86 == _T_3; // @[FIFO.scala 80:30]
  wire [3:0] _T_14 = wrindex + 4'h1; // @[FIFO.scala 80:114]
  wire [4:0] _T_16 = index + 5'h1; // @[FIFO.scala 82:32]
  assign io_FIFOout = data; // @[FIFO.scala 93:20]
  assign io_FIFOfull = index == _T_3; // @[FIFO.scala 94:21]
  assign io_FIFOempty = index == 5'h0; // @[FIFO.scala 95:22]
  assign io_FIFOrdError = io_FIFOrd & _T_1; // @[FIFO.scala 91:18]
  assign io_FIFOwrError = io_FIFOwr & _T_9; // @[FIFO.scala 92:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  index = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  wrindex = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  rdindex = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  FIFO_0 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  FIFO_1 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  FIFO_2 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  FIFO_3 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  FIFO_4 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  FIFO_5 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  FIFO_6 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  FIFO_7 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  FIFO_8 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  FIFO_9 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  FIFO_10 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  FIFO_11 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  FIFO_12 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  FIFO_13 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  FIFO_14 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  FIFO_15 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  data = _RAND_19[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      index <= 5'h0;
    end else if (io_FIFOwr) begin
      if (_T_9) begin
        if (io_FIFOrd) begin
          if (_T_1) begin
            if (io_reset) begin
              index <= 5'h0;
            end
          end else begin
            index <= _T_8;
          end
        end else if (io_reset) begin
          index <= 5'h0;
        end
      end else begin
        index <= _T_16;
      end
    end else if (io_FIFOrd) begin
      if (_T_1) begin
        if (io_reset) begin
          index <= 5'h0;
        end
      end else begin
        index <= _T_8;
      end
    end else if (io_reset) begin
      index <= 5'h0;
    end
    if (reset) begin
      wrindex <= 4'h0;
    end else if (io_FIFOwr) begin
      if (_T_9) begin
        if (io_reset) begin
          wrindex <= 4'h0;
        end
      end else if (_T_12) begin
        wrindex <= 4'h0;
      end else begin
        wrindex <= _T_14;
      end
    end else if (io_reset) begin
      wrindex <= 4'h0;
    end
    if (reset) begin
      rdindex <= 4'h0;
    end else if (io_FIFOrd) begin
      if (_T_1) begin
        if (io_reset) begin
          rdindex <= 4'h0;
        end
      end else if (_T_4) begin
        rdindex <= 4'h0;
      end else begin
        rdindex <= _T_6;
      end
    end else if (io_reset) begin
      rdindex <= 4'h0;
    end
    if (reset) begin
      FIFO_0 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h0 == wrindex) begin
          FIFO_0 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_1 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h1 == wrindex) begin
          FIFO_1 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_2 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h2 == wrindex) begin
          FIFO_2 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_3 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h3 == wrindex) begin
          FIFO_3 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_4 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h4 == wrindex) begin
          FIFO_4 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_5 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h5 == wrindex) begin
          FIFO_5 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_6 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h6 == wrindex) begin
          FIFO_6 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_7 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h7 == wrindex) begin
          FIFO_7 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_8 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h8 == wrindex) begin
          FIFO_8 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_9 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'h9 == wrindex) begin
          FIFO_9 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_10 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'ha == wrindex) begin
          FIFO_10 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_11 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'hb == wrindex) begin
          FIFO_11 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_12 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'hc == wrindex) begin
          FIFO_12 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_13 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'hd == wrindex) begin
          FIFO_13 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_14 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'he == wrindex) begin
          FIFO_14 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      FIFO_15 <= 8'h0;
    end else if (io_FIFOwr) begin
      if (!(_T_9)) begin
        if (4'hf == wrindex) begin
          FIFO_15 <= io_FIFOin;
        end
      end
    end
    if (reset) begin
      data <= 8'h0;
    end else if (io_FIFOrd) begin
      if (!(_T_1)) begin
        if (4'hf == rdindex) begin
          data <= FIFO_15;
        end else if (4'he == rdindex) begin
          data <= FIFO_14;
        end else if (4'hd == rdindex) begin
          data <= FIFO_13;
        end else if (4'hc == rdindex) begin
          data <= FIFO_12;
        end else if (4'hb == rdindex) begin
          data <= FIFO_11;
        end else if (4'ha == rdindex) begin
          data <= FIFO_10;
        end else if (4'h9 == rdindex) begin
          data <= FIFO_9;
        end else if (4'h8 == rdindex) begin
          data <= FIFO_8;
        end else if (4'h7 == rdindex) begin
          data <= FIFO_7;
        end else if (4'h6 == rdindex) begin
          data <= FIFO_6;
        end else if (4'h5 == rdindex) begin
          data <= FIFO_5;
        end else if (4'h4 == rdindex) begin
          data <= FIFO_4;
        end else if (4'h3 == rdindex) begin
          data <= FIFO_3;
        end else if (4'h2 == rdindex) begin
          data <= FIFO_2;
        end else if (4'h1 == rdindex) begin
          data <= FIFO_1;
        end else begin
          data <= FIFO_0;
        end
      end
    end
  end
endmodule
module uartReceiver(
  input         clock,
  input         reset,
  input  [31:0] io_numberofClockPB,
  input  [15:0] io_lineControl,
  output [7:0]  io_rxLineStatus,
  output        io_PEFlag,
  input         io_read,
  input         io_resetFIFO,
  output [7:0]  io_ReceiverBuffer,
  output [7:0]  io_DMADataIn,
  output [7:0]  io_FIFOout,
  output        io_ReceivedDataValid,
  output [31:0] io_MeasuredBaudRate,
  input         io_rx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  wire  rxFIFO_clock; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_reset; // @[uartReceiver.scala 42:28]
  wire [7:0] rxFIFO_io_FIFOin; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_FIFOwr; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_FIFOrd; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_reset; // @[uartReceiver.scala 42:28]
  wire [7:0] rxFIFO_io_FIFOout; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_FIFOfull; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_FIFOempty; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_FIFOrdError; // @[uartReceiver.scala 42:28]
  wire  rxFIFO_io_FIFOwrError; // @[uartReceiver.scala 42:28]
  reg [10:0] rSR; // @[uartReceiver.scala 39:26]
  reg [7:0] receiverBuffer; // @[uartReceiver.scala 40:37]
  reg [7:0] DMADataIn; // @[uartReceiver.scala 41:32]
  reg [31:0] MeasuredBaudRate; // @[uartReceiver.scala 46:38]
  wire [7:0] rxLineControlRegister = io_lineControl[15:8]; // @[uartReceiver.scala 50:50]
  reg [2:0] rx_state; // @[uartReceiver.scala 53:25]
  reg [3:0] rx_index; // @[uartReceiver.scala 54:31]
  reg  sample; // @[uartReceiver.scala 56:29]
  reg  DataValid; // @[uartReceiver.scala 57:32]
  wire  enableFIFO = rxLineControlRegister[7]; // @[uartReceiver.scala 58:76]
  reg  FIFOwrite; // @[uartReceiver.scala 59:32]
  reg  readBuffer; // @[uartReceiver.scala 60:32]
  reg  parityError; // @[uartReceiver.scala 62:34]
  reg  rxBusy; // @[uartReceiver.scala 63:23]
  reg  dataReady; // @[uartReceiver.scala 64:26]
  reg  Ready; // @[uartReceiver.scala 65:22]
  reg  overWriteError; // @[uartReceiver.scala 66:37]
  reg  framingError; // @[uartReceiver.scala 67:35]
  wire  _T_4 = ~rxFIFO_io_FIFOempty; // @[uartReceiver.scala 80:47]
  wire  _T_5 = enableFIFO & _T_4; // @[uartReceiver.scala 80:33]
  wire  _T_6 = Ready | _T_5; // @[uartReceiver.scala 80:28]
  wire  _T_7 = rx_state != 3'h2; // @[uartReceiver.scala 81:29]
  reg [31:0] clockCounter; // @[uartReceiver.scala 85:35]
  wire  _T_10 = ~rxLineControlRegister[4]; // @[uartReceiver.scala 86:76]
  wire  twoStop = rxLineControlRegister[5] & _T_10; // @[uartReceiver.scala 86:73]
  wire  _T_13 = ~rxLineControlRegister[5]; // @[uartReceiver.scala 87:56]
  wire  parityStop = _T_13 & rxLineControlRegister[4]; // @[uartReceiver.scala 87:83]
  wire  parityTwoStop = rxLineControlRegister[5] & rxLineControlRegister[4]; // @[uartReceiver.scala 88:85]
  wire  oneStop = _T_13 & _T_10; // @[uartReceiver.scala 89:76]
  wire  _T_24 = 3'h0 == rx_state; // @[Conditional.scala 37:30]
  wire  _T_25 = ~io_rx; // @[uartReceiver.scala 93:78]
  wire [31:0] _T_27 = MeasuredBaudRate + 32'h1; // @[uartReceiver.scala 96:118]
  wire  _T_28 = 3'h1 == rx_state; // @[Conditional.scala 37:30]
  wire  _T_31 = 3'h2 == rx_state; // @[Conditional.scala 37:30]
  wire  _T_33 = 3'h3 == rx_state; // @[Conditional.scala 37:30]
  wire  _T_35 = rxLineControlRegister[3:0] == 4'h5; // @[uartReceiver.scala 117:74]
  wire  _T_36 = _T_35 & oneStop; // @[uartReceiver.scala 117:82]
  wire  _T_39 = _T_35 & twoStop; // @[uartReceiver.scala 118:86]
  wire  _T_42 = _T_35 & parityStop; // @[uartReceiver.scala 118:135]
  wire  _T_43 = _T_39 | _T_42; // @[uartReceiver.scala 118:97]
  wire  _T_45 = rxLineControlRegister[3:0] == 4'h6; // @[uartReceiver.scala 118:179]
  wire  _T_46 = _T_45 & oneStop; // @[uartReceiver.scala 118:187]
  wire  _T_47 = _T_43 | _T_46; // @[uartReceiver.scala 118:149]
  wire  _T_50 = _T_35 & parityTwoStop; // @[uartReceiver.scala 122:86]
  wire  _T_53 = _T_45 & twoStop; // @[uartReceiver.scala 122:141]
  wire  _T_54 = _T_50 | _T_53; // @[uartReceiver.scala 122:103]
  wire  _T_57 = _T_45 & parityStop; // @[uartReceiver.scala 122:190]
  wire  _T_58 = _T_54 | _T_57; // @[uartReceiver.scala 122:152]
  wire  _T_60 = rxLineControlRegister[3:0] == 4'h7; // @[uartReceiver.scala 122:234]
  wire  _T_61 = _T_60 & oneStop; // @[uartReceiver.scala 122:242]
  wire  _T_62 = _T_58 | _T_61; // @[uartReceiver.scala 122:204]
  wire  _T_65 = _T_45 & parityTwoStop; // @[uartReceiver.scala 126:86]
  wire  _T_68 = _T_60 & twoStop; // @[uartReceiver.scala 126:141]
  wire  _T_69 = _T_65 | _T_68; // @[uartReceiver.scala 126:103]
  wire  _T_72 = _T_60 & parityStop; // @[uartReceiver.scala 126:190]
  wire  _T_73 = _T_69 | _T_72; // @[uartReceiver.scala 126:152]
  wire  _T_75 = rxLineControlRegister[3:0] == 4'h8; // @[uartReceiver.scala 126:234]
  wire  _T_76 = _T_75 & oneStop; // @[uartReceiver.scala 126:242]
  wire  _T_77 = _T_73 | _T_76; // @[uartReceiver.scala 126:204]
  wire  _T_80 = _T_60 & parityTwoStop; // @[uartReceiver.scala 130:86]
  wire  _T_83 = _T_75 & twoStop; // @[uartReceiver.scala 130:141]
  wire  _T_84 = _T_80 | _T_83; // @[uartReceiver.scala 130:103]
  wire  _T_87 = _T_75 & parityStop; // @[uartReceiver.scala 130:190]
  wire  _T_88 = _T_84 | _T_87; // @[uartReceiver.scala 130:152]
  wire  _T_91 = _T_75 & parityTwoStop; // @[uartReceiver.scala 134:86]
  wire [31:0] _GEN_197 = {{1'd0}, io_numberofClockPB[31:1]}; // @[uartReceiver.scala 138:60]
  wire  _T_93 = clockCounter == _GEN_197; // @[uartReceiver.scala 138:60]
  wire [3:0] _T_96 = rx_index - 4'h1; // @[uartReceiver.scala 143:78]
  wire [31:0] _T_98 = clockCounter + 32'h1; // @[uartReceiver.scala 151:78]
  wire  _T_99 = 3'h4 == rx_state; // @[Conditional.scala 37:30]
  wire  _T_100 = clockCounter == io_numberofClockPB; // @[uartReceiver.scala 156:115]
  wire  _T_101 = 4'h0 == rx_index; // @[uartReceiver.scala 160:114]
  wire  _T_106 = 3'h5 == rx_state; // @[Conditional.scala 37:30]
  wire  _T_107 = receiverBuffer != 8'h0; // @[uartReceiver.scala 173:117]
  wire  _T_108 = ~sample; // @[uartReceiver.scala 182:102]
  wire [10:0] _GEN_24 = io_rx ? 11'h0 : rSR; // @[uartReceiver.scala 185:105]
  wire [10:0] _GEN_28 = _T_108 ? _GEN_24 : rSR; // @[uartReceiver.scala 183:97]
  wire [10:0] _GEN_34 = _T_106 ? _GEN_28 : rSR; // @[Conditional.scala 39:67]
  wire [10:0] _GEN_42 = _T_99 ? rSR : _GEN_34; // @[Conditional.scala 39:67]
  wire [10:0] _GEN_49 = _T_33 ? rSR : _GEN_42; // @[Conditional.scala 39:67]
  wire [10:0] _GEN_57 = _T_31 ? rSR : _GEN_49; // @[Conditional.scala 39:67]
  wire [10:0] _GEN_65 = _T_28 ? rSR : _GEN_57; // @[Conditional.scala 39:67]
  wire [10:0] _GEN_73 = _T_24 ? rSR : _GEN_65; // @[Conditional.scala 40:58]
  wire [7:0] data5oneStop = {2'h0,1'h0,rSR[1],rSR[2],rSR[3],rSR[4],rSR[5]}; // @[Cat.scala 29:58]
  wire [7:0] data5twoStop = {2'h0,1'h0,rSR[2],rSR[3],rSR[4],rSR[5],rSR[6]}; // @[Cat.scala 29:58]
  wire [7:0] data5parityTwoStop = {2'h0,1'h0,rSR[3],rSR[4],rSR[5],rSR[6],rSR[7]}; // @[Cat.scala 29:58]
  wire [7:0] data6oneStop = {2'h0,rSR[1],rSR[2],rSR[3],rSR[4],rSR[5],rSR[6]}; // @[Cat.scala 29:58]
  wire [7:0] data6twoStop = {2'h0,rSR[2],rSR[3],rSR[4],rSR[5],rSR[6],rSR[7]}; // @[Cat.scala 29:58]
  wire [7:0] data6parityTwoStop = {2'h0,rSR[3],rSR[4],rSR[5],rSR[6],rSR[7],rSR[8]}; // @[Cat.scala 29:58]
  wire [7:0] data7oneStop = {1'h0,rSR[1],rSR[2],rSR[3],rSR[4],rSR[5],rSR[6],rSR[7]}; // @[Cat.scala 29:58]
  wire [7:0] data7twoStop = {1'h0,rSR[2],rSR[3],rSR[4],rSR[5],rSR[6],rSR[7],rSR[8]}; // @[Cat.scala 29:58]
  wire [7:0] data7parityTwoStop = {1'h0,rSR[3],rSR[4],rSR[5],rSR[6],rSR[7],rSR[8],rSR[9]}; // @[Cat.scala 29:58]
  wire [7:0] data8oneStop = {rSR[1],rSR[2],rSR[3],rSR[4],rSR[5],rSR[6],rSR[7],rSR[8]}; // @[Cat.scala 29:58]
  wire [7:0] data8twoStop = {rSR[2],rSR[3],rSR[4],rSR[5],rSR[6],rSR[7],rSR[8],rSR[9]}; // @[Cat.scala 29:58]
  wire [7:0] data8parityTwoStop = {rSR[3],rSR[4],rSR[5],rSR[6],rSR[7],rSR[8],rSR[9],rSR[10]}; // @[Cat.scala 29:58]
  wire [11:0] _T_330 = {rSR,io_rx}; // @[Cat.scala 29:58]
  wire [11:0] _GEN_74 = sample ? _T_330 : {{1'd0}, rSR}; // @[uartReceiver.scala 231:113]
  wire  _GEN_75 = enableFIFO | FIFOwrite; // @[uartReceiver.scala 242:89]
  wire  _T_349 = oneStop | twoStop; // @[uartReceiver.scala 252:102]
  wire  _GEN_76 = _T_349 ? 1'h0 : parityError; // @[uartReceiver.scala 253:89]
  wire  _T_352 = ~enableFIFO; // @[uartReceiver.scala 260:110]
  wire  _T_357 = rSR[2] ^ rSR[3]; // @[uartReceiver.scala 281:127]
  wire  _T_359 = _T_357 ^ rSR[4]; // @[uartReceiver.scala 281:134]
  wire  _T_361 = _T_359 ^ rSR[5]; // @[uartReceiver.scala 281:141]
  wire  _T_363 = _T_361 ^ rSR[6]; // @[uartReceiver.scala 281:148]
  wire  _T_366 = ~rSR[1]; // @[uartReceiver.scala 281:188]
  wire  _T_368 = rxLineControlRegister[6] ? _T_366 : rSR[1]; // @[uartReceiver.scala 281:161]
  wire  _T_369 = _T_363 ^ _T_368; // @[uartReceiver.scala 281:156]
  wire  _T_373 = rSR[3] ^ rSR[4]; // @[uartReceiver.scala 290:126]
  wire  _T_375 = _T_373 ^ rSR[5]; // @[uartReceiver.scala 290:133]
  wire  _T_377 = _T_375 ^ rSR[6]; // @[uartReceiver.scala 290:140]
  wire  _T_379 = _T_377 ^ rSR[7]; // @[uartReceiver.scala 290:147]
  wire  _T_382 = ~rSR[2]; // @[uartReceiver.scala 290:186]
  wire  _T_384 = rxLineControlRegister[6] ? _T_382 : rSR[2]; // @[uartReceiver.scala 290:159]
  wire  _T_385 = _T_379 ^ _T_384; // @[uartReceiver.scala 290:154]
  wire [7:0] _GEN_82 = parityTwoStop ? data5parityTwoStop : rSR[7:0]; // @[uartReceiver.scala 284:97]
  wire [7:0] _GEN_85 = parityStop ? data5twoStop : _GEN_82; // @[uartReceiver.scala 275:97]
  wire [7:0] _GEN_88 = twoStop ? data5twoStop : _GEN_85; // @[uartReceiver.scala 267:97]
  wire [7:0] _GEN_91 = oneStop ? data5oneStop : _GEN_88; // @[uartReceiver.scala 259:97]
  wire  _T_401 = _T_363 ^ rSR[7]; // @[uartReceiver.scala 318:154]
  wire  _T_407 = _T_401 ^ _T_368; // @[uartReceiver.scala 318:161]
  wire  _T_419 = _T_379 ^ rSR[8]; // @[uartReceiver.scala 327:154]
  wire  _T_425 = _T_419 ^ _T_384; // @[uartReceiver.scala 327:161]
  wire [7:0] _GEN_98 = parityTwoStop ? data6parityTwoStop : rSR[7:0]; // @[uartReceiver.scala 321:97]
  wire [7:0] _GEN_101 = parityStop ? data6twoStop : _GEN_98; // @[uartReceiver.scala 312:97]
  wire [7:0] _GEN_104 = twoStop ? data6twoStop : _GEN_101; // @[uartReceiver.scala 304:97]
  wire [7:0] _GEN_107 = oneStop ? data6oneStop : _GEN_104; // @[uartReceiver.scala 296:97]
  wire  _T_443 = _T_401 ^ rSR[8]; // @[uartReceiver.scala 355:153]
  wire  _T_449 = _T_443 ^ _T_368; // @[uartReceiver.scala 355:160]
  wire  _T_463 = _T_419 ^ rSR[9]; // @[uartReceiver.scala 363:161]
  wire  _T_469 = _T_463 ^ _T_384; // @[uartReceiver.scala 363:168]
  wire [7:0] _GEN_114 = parityTwoStop ? data7parityTwoStop : rSR[7:0]; // @[uartReceiver.scala 357:97]
  wire [7:0] _GEN_117 = parityStop ? data7twoStop : _GEN_114; // @[uartReceiver.scala 349:97]
  wire [7:0] _GEN_120 = twoStop ? data7twoStop : _GEN_117; // @[uartReceiver.scala 341:97]
  wire [7:0] _GEN_123 = oneStop ? data7oneStop : _GEN_120; // @[uartReceiver.scala 333:97]
  wire  _T_489 = _T_443 ^ rSR[9]; // @[uartReceiver.scala 391:168]
  wire  _T_495 = _T_489 ^ _T_368; // @[uartReceiver.scala 391:175]
  wire  _T_511 = _T_463 ^ rSR[10]; // @[uartReceiver.scala 400:168]
  wire  _T_517 = _T_511 ^ _T_384; // @[uartReceiver.scala 400:176]
  wire [7:0] _GEN_130 = parityTwoStop ? data8parityTwoStop : rSR[7:0]; // @[uartReceiver.scala 394:97]
  wire [7:0] _GEN_133 = parityStop ? data8twoStop : _GEN_130; // @[uartReceiver.scala 385:97]
  wire [7:0] _GEN_136 = twoStop ? data8twoStop : _GEN_133; // @[uartReceiver.scala 377:97]
  wire [7:0] _GEN_139 = oneStop ? data8oneStop : _GEN_136; // @[uartReceiver.scala 369:97]
  wire [7:0] _GEN_142 = _T_75 ? _GEN_139 : rSR[7:0]; // @[uartReceiver.scala 367:89]
  wire [7:0] _GEN_145 = _T_60 ? _GEN_123 : _GEN_142; // @[uartReceiver.scala 331:89]
  wire [7:0] _GEN_148 = _T_45 ? _GEN_107 : _GEN_145; // @[uartReceiver.scala 294:89]
  wire [7:0] _GEN_151 = _T_35 ? _GEN_91 : _GEN_148; // @[uartReceiver.scala 257:89]
  wire [11:0] _GEN_153 = sample ? _T_330 : {{1'd0}, _GEN_73}; // @[uartReceiver.scala 239:81]
  wire  _GEN_154 = sample & _GEN_75; // @[uartReceiver.scala 239:81]
  wire  _GEN_156 = sample ? Ready : 1'h1; // @[uartReceiver.scala 239:81]
  wire [7:0] _GEN_160 = sample ? rSR[7:0] : _GEN_151; // @[uartReceiver.scala 239:81]
  wire [11:0] _GEN_161 = _T_106 ? _GEN_153 : {{1'd0}, _GEN_73}; // @[Conditional.scala 39:67]
  wire  _GEN_164 = _T_106 ? _GEN_156 : Ready; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_168 = _T_106 ? _GEN_160 : rSR[7:0]; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_171 = _T_99 ? _GEN_74 : _GEN_161; // @[Conditional.scala 39:67]
  wire  _GEN_173 = _T_99 ? Ready : _GEN_164; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_176 = _T_99 ? rSR[7:0] : _GEN_168; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_179 = _T_33 ? {{1'd0}, _GEN_73} : _GEN_171; // @[Conditional.scala 39:67]
  wire  _GEN_181 = _T_33 ? Ready : _GEN_173; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_184 = _T_33 ? rSR[7:0] : _GEN_176; // @[Conditional.scala 39:67]
  wire [11:0] _GEN_187 = _T_31 ? {{1'd0}, _GEN_73} : _GEN_179; // @[Conditional.scala 40:58]
  wire  _GEN_189 = _T_31 ? Ready : _GEN_181; // @[Conditional.scala 40:58]
  wire  _GEN_194 = _T_5 & _GEN_189; // @[uartReceiver.scala 411:17]
  wire [3:0] _T_522 = {framingError,overWriteError,rxBusy,dataReady}; // @[Cat.scala 29:58]
  wire [3:0] _T_525 = {rxFIFO_io_FIFOwrError,rxFIFO_io_FIFOrdError,rxFIFO_io_FIFOempty,rxFIFO_io_FIFOfull}; // @[Cat.scala 29:58]
  FIFO rxFIFO ( // @[uartReceiver.scala 42:28]
    .clock(rxFIFO_clock),
    .reset(rxFIFO_reset),
    .io_FIFOin(rxFIFO_io_FIFOin),
    .io_FIFOwr(rxFIFO_io_FIFOwr),
    .io_FIFOrd(rxFIFO_io_FIFOrd),
    .io_reset(rxFIFO_io_reset),
    .io_FIFOout(rxFIFO_io_FIFOout),
    .io_FIFOfull(rxFIFO_io_FIFOfull),
    .io_FIFOempty(rxFIFO_io_FIFOempty),
    .io_FIFOrdError(rxFIFO_io_FIFOrdError),
    .io_FIFOwrError(rxFIFO_io_FIFOwrError)
  );
  assign io_rxLineStatus = {_T_525,_T_522}; // @[uartReceiver.scala 425:25]
  assign io_PEFlag = parityError; // @[uartReceiver.scala 424:19]
  assign io_ReceiverBuffer = receiverBuffer; // @[uartReceiver.scala 427:27]
  assign io_DMADataIn = DMADataIn; // @[uartReceiver.scala 426:22]
  assign io_FIFOout = rxFIFO_io_FIFOout; // @[uartReceiver.scala 428:20]
  assign io_ReceivedDataValid = DataValid; // @[uartReceiver.scala 423:30]
  assign io_MeasuredBaudRate = MeasuredBaudRate; // @[uartReceiver.scala 429:29]
  assign rxFIFO_clock = clock;
  assign rxFIFO_reset = reset;
  assign rxFIFO_io_FIFOin = _T_31 ? rSR[7:0] : _GEN_184; // @[uartReceiver.scala 222:26 uartReceiver.scala 264:122 uartReceiver.scala 272:122 uartReceiver.scala 280:122 uartReceiver.scala 289:122 uartReceiver.scala 301:122 uartReceiver.scala 309:122 uartReceiver.scala 317:122 uartReceiver.scala 326:122 uartReceiver.scala 338:122 uartReceiver.scala 346:122 uartReceiver.scala 354:114 uartReceiver.scala 362:122 uartReceiver.scala 374:122 uartReceiver.scala 382:122 uartReceiver.scala 390:122 uartReceiver.scala 399:122]
  assign rxFIFO_io_FIFOwr = FIFOwrite; // @[uartReceiver.scala 78:26]
  assign rxFIFO_io_FIFOrd = enableFIFO & io_read; // @[uartReceiver.scala 77:26]
  assign rxFIFO_io_reset = io_resetFIFO; // @[uartReceiver.scala 76:25]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rSR = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  receiverBuffer = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  DMADataIn = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  MeasuredBaudRate = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  rx_state = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  rx_index = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  sample = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  DataValid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  FIFOwrite = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  readBuffer = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  parityError = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  rxBusy = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  dataReady = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  Ready = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  overWriteError = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  framingError = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  clockCounter = _RAND_16[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      rSR <= 11'h0;
    end else begin
      rSR <= _GEN_187[10:0];
    end
    if (reset) begin
      receiverBuffer <= 8'h0;
    end else if (readBuffer) begin
      if (_T_5) begin
        receiverBuffer <= rxFIFO_io_FIFOout;
      end else begin
        receiverBuffer <= 8'h0;
      end
    end else if (!(_T_31)) begin
      if (!(_T_33)) begin
        if (!(_T_99)) begin
          if (_T_106) begin
            if (!(sample)) begin
              if (_T_35) begin
                if (oneStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data5oneStop;
                  end
                end else if (twoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data5twoStop;
                  end
                end else if (parityStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data5twoStop;
                  end
                end else if (parityTwoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data5parityTwoStop;
                  end
                end
              end else if (_T_45) begin
                if (oneStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data6oneStop;
                  end
                end else if (twoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data6twoStop;
                  end
                end else if (parityStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data6twoStop;
                  end
                end else if (parityTwoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data6parityTwoStop;
                  end
                end
              end else if (_T_60) begin
                if (oneStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data7oneStop;
                  end
                end else if (twoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data7twoStop;
                  end
                end else if (parityStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data7twoStop;
                  end
                end else if (parityTwoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data7parityTwoStop;
                  end
                end
              end else if (_T_75) begin
                if (oneStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data8oneStop;
                  end
                end else if (twoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data8twoStop;
                  end
                end else if (parityStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data8twoStop;
                  end
                end else if (parityTwoStop) begin
                  if (_T_352) begin
                    receiverBuffer <= data8parityTwoStop;
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      DMADataIn <= 8'h0;
    end else if (!(_T_31)) begin
      if (!(_T_33)) begin
        if (!(_T_99)) begin
          if (_T_106) begin
            if (!(sample)) begin
              DMADataIn <= data8oneStop;
            end
          end
        end
      end
    end
    if (reset) begin
      MeasuredBaudRate <= 32'h0;
    end else if (_T_24) begin
      if (_T_25) begin
        MeasuredBaudRate <= _T_27;
      end
    end else if (_T_28) begin
      MeasuredBaudRate <= _T_27;
    end
    if (reset) begin
      rx_state <= 3'h0;
    end else if (_T_24) begin
      if (_T_25) begin
        rx_state <= 3'h1;
      end
    end else if (_T_28) begin
      if (io_rx) begin
        rx_state <= 3'h2;
      end
    end else if (_T_31) begin
      if (_T_25) begin
        rx_state <= 3'h3;
      end else begin
        rx_state <= 3'h2;
      end
    end else if (_T_33) begin
      if (_T_93) begin
        if (_T_25) begin
          rx_state <= 3'h4;
        end else begin
          rx_state <= 3'h2;
        end
      end else begin
        rx_state <= 3'h3;
      end
    end else if (_T_99) begin
      if (_T_100) begin
        if (_T_101) begin
          rx_state <= 3'h5;
        end else begin
          rx_state <= 3'h4;
        end
      end else begin
        rx_state <= 3'h4;
      end
    end else if (_T_106) begin
      if (_T_108) begin
        if (io_rx) begin
          rx_state <= 3'h2;
        end else begin
          rx_state <= 3'h5;
        end
      end else begin
        rx_state <= 3'h5;
      end
    end
    if (reset) begin
      rx_index <= 4'h0;
    end else if (!(_T_24)) begin
      if (!(_T_28)) begin
        if (!(_T_31)) begin
          if (_T_33) begin
            if (_T_93) begin
              if (_T_25) begin
                rx_index <= _T_96;
              end else if (_T_36) begin
                rx_index <= 4'h6;
              end else if (_T_47) begin
                rx_index <= 4'h7;
              end else if (_T_62) begin
                rx_index <= 4'h8;
              end else if (_T_77) begin
                rx_index <= 4'h9;
              end else if (_T_88) begin
                rx_index <= 4'ha;
              end else if (_T_91) begin
                rx_index <= 4'hb;
              end
            end else if (_T_36) begin
              rx_index <= 4'h6;
            end else if (_T_47) begin
              rx_index <= 4'h7;
            end else if (_T_62) begin
              rx_index <= 4'h8;
            end else if (_T_77) begin
              rx_index <= 4'h9;
            end else if (_T_88) begin
              rx_index <= 4'ha;
            end else if (_T_91) begin
              rx_index <= 4'hb;
            end
          end else if (_T_99) begin
            if (_T_100) begin
              rx_index <= _T_96;
            end
          end else if (_T_106) begin
            if (_T_108) begin
              if (io_rx) begin
                rx_index <= 4'h0;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      sample <= 1'h0;
    end else if (!(_T_24)) begin
      if (!(_T_28)) begin
        if (!(_T_31)) begin
          if (!(_T_33)) begin
            if (_T_99) begin
              sample <= _T_100;
            end else if (_T_106) begin
              sample <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      DataValid <= 1'h0;
    end else if (_T_31) begin
      DataValid <= 1'h0;
    end else if (_T_33) begin
      DataValid <= 1'h0;
    end else if (_T_99) begin
      DataValid <= 1'h0;
    end else if (_T_106) begin
      if (sample) begin
        DataValid <= 1'h0;
      end else begin
        DataValid <= 1'h1;
      end
    end
    if (reset) begin
      FIFOwrite <= 1'h0;
    end else if (!(_T_31)) begin
      if (!(_T_33)) begin
        if (!(_T_99)) begin
          if (_T_106) begin
            FIFOwrite <= _GEN_154;
          end
        end
      end
    end
    if (reset) begin
      readBuffer <= 1'h0;
    end else begin
      readBuffer <= io_read;
    end
    if (reset) begin
      parityError <= 1'h0;
    end else if (!(_T_31)) begin
      if (!(_T_33)) begin
        if (!(_T_99)) begin
          if (_T_106) begin
            if (!(sample)) begin
              if (_T_35) begin
                if (oneStop) begin
                  if (_T_349) begin
                    parityError <= 1'h0;
                  end
                end else if (twoStop) begin
                  if (_T_349) begin
                    parityError <= 1'h0;
                  end
                end else if (parityStop) begin
                  parityError <= _T_369;
                end else if (parityTwoStop) begin
                  parityError <= _T_385;
                end else if (_T_349) begin
                  parityError <= 1'h0;
                end
              end else if (_T_45) begin
                if (oneStop) begin
                  if (_T_349) begin
                    parityError <= 1'h0;
                  end
                end else if (twoStop) begin
                  parityError <= _GEN_76;
                end else if (parityStop) begin
                  parityError <= _T_407;
                end else if (parityTwoStop) begin
                  parityError <= _T_425;
                end else begin
                  parityError <= _GEN_76;
                end
              end else if (_T_60) begin
                if (oneStop) begin
                  parityError <= _GEN_76;
                end else if (twoStop) begin
                  parityError <= _GEN_76;
                end else if (parityStop) begin
                  parityError <= _T_449;
                end else if (parityTwoStop) begin
                  parityError <= _T_469;
                end else begin
                  parityError <= _GEN_76;
                end
              end else if (_T_75) begin
                if (oneStop) begin
                  parityError <= _GEN_76;
                end else if (twoStop) begin
                  parityError <= _GEN_76;
                end else if (parityStop) begin
                  parityError <= _T_495;
                end else if (parityTwoStop) begin
                  parityError <= _T_517;
                end else begin
                  parityError <= _GEN_76;
                end
              end else begin
                parityError <= _GEN_76;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      rxBusy <= 1'h0;
    end else begin
      rxBusy <= _T_7;
    end
    if (reset) begin
      dataReady <= 1'h0;
    end else begin
      dataReady <= _T_6;
    end
    if (reset) begin
      Ready <= 1'h0;
    end else if (readBuffer) begin
      Ready <= _GEN_194;
    end else if (!(_T_31)) begin
      if (!(_T_33)) begin
        if (!(_T_99)) begin
          if (_T_106) begin
            if (!(sample)) begin
              Ready <= 1'h1;
            end
          end
        end
      end
    end
    if (reset) begin
      overWriteError <= 1'h0;
    end else if (!(_T_24)) begin
      if (!(_T_28)) begin
        if (!(_T_31)) begin
          if (!(_T_33)) begin
            if (!(_T_99)) begin
              if (_T_106) begin
                overWriteError <= _T_107;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      framingError <= 1'h0;
    end else if (!(_T_24)) begin
      if (!(_T_28)) begin
        if (_T_31) begin
          if (_T_25) begin
            framingError <= 1'h0;
          end
        end else if (!(_T_33)) begin
          if (!(_T_99)) begin
            if (_T_106) begin
              if (_T_108) begin
                if (!(io_rx)) begin
                  framingError <= 1'h1;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      clockCounter <= 32'h0;
    end else if (!(_T_24)) begin
      if (!(_T_28)) begin
        if (_T_31) begin
          if (_T_25) begin
            clockCounter <= 32'h0;
          end
        end else if (_T_33) begin
          if (_T_93) begin
            clockCounter <= 32'h0;
          end else begin
            clockCounter <= _T_98;
          end
        end else if (_T_99) begin
          if (_T_100) begin
            clockCounter <= 32'h0;
          end else begin
            clockCounter <= _T_98;
          end
        end
      end
    end
  end
endmodule
module uartTransmitter(
  input         clock,
  input         reset,
  input  [15:0] io_lineControl,
  input  [31:0] io_numberofClockPB,
  input  [7:0]  io_txDataByte,
  input         io_wrData,
  input         io_resetFIFO,
  output [7:0]  io_txLineStatus,
  output        io_tx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  txFIFO_clock; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_reset; // @[uartTransmitter.scala 35:28]
  wire [7:0] txFIFO_io_FIFOin; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_FIFOwr; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_FIFOrd; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_reset; // @[uartTransmitter.scala 35:28]
  wire [7:0] txFIFO_io_FIFOout; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_FIFOfull; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_FIFOempty; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_FIFOrdError; // @[uartTransmitter.scala 35:28]
  wire  txFIFO_io_FIFOwrError; // @[uartTransmitter.scala 35:28]
  reg [11:0] tSR; // @[uartTransmitter.scala 30:26]
  reg [7:0] tHR; // @[uartTransmitter.scala 31:26]
  reg  tx_serial; // @[uartTransmitter.scala 33:32]
  reg [3:0] txBitCounter; // @[uartTransmitter.scala 34:35]
  wire [7:0] txLineControlRegister = io_lineControl[7:0]; // @[uartTransmitter.scala 42:50]
  reg [1:0] tx_state; // @[uartTransmitter.scala 46:25]
  reg  thrEmpty; // @[uartTransmitter.scala 47:25]
  reg  thrWriteEr; // @[uartTransmitter.scala 48:27]
  reg  txBusy; // @[uartTransmitter.scala 49:23]
  reg  txDone; // @[uartTransmitter.scala 50:23]
  reg  FIFOEnable; // @[uartTransmitter.scala 57:33]
  wire  _T_11 = txFIFO_io_FIFOout[1] ^ txFIFO_io_FIFOout[0]; // @[uartTransmitter.scala 62:198]
  wire  _T_12 = txFIFO_io_FIFOout[2] ^ _T_11; // @[uartTransmitter.scala 62:176]
  wire  _T_13 = txFIFO_io_FIFOout[3] ^ _T_12; // @[uartTransmitter.scala 62:154]
  wire  _T_14 = txFIFO_io_FIFOout[4] ^ _T_13; // @[uartTransmitter.scala 62:132]
  wire  _T_15 = txFIFO_io_FIFOout[5] ^ _T_14; // @[uartTransmitter.scala 62:110]
  wire  _T_16 = txFIFO_io_FIFOout[6] ^ _T_15; // @[uartTransmitter.scala 62:88]
  wire  _T_17 = txFIFO_io_FIFOout[7] ^ _T_16; // @[uartTransmitter.scala 62:66]
  wire  _T_26 = tHR[1] ^ tHR[0]; // @[uartTransmitter.scala 62:283]
  wire  _T_27 = tHR[2] ^ _T_26; // @[uartTransmitter.scala 62:275]
  wire  _T_28 = tHR[3] ^ _T_27; // @[uartTransmitter.scala 62:267]
  wire  _T_29 = tHR[4] ^ _T_28; // @[uartTransmitter.scala 62:259]
  wire  _T_30 = tHR[5] ^ _T_29; // @[uartTransmitter.scala 62:251]
  wire  _T_31 = tHR[6] ^ _T_30; // @[uartTransmitter.scala 62:243]
  wire  _T_32 = tHR[7] ^ _T_31; // @[uartTransmitter.scala 62:235]
  wire  oddParity = FIFOEnable ? _T_17 : _T_32; // @[uartTransmitter.scala 62:33]
  wire  evenParity = ~oddParity; // @[uartTransmitter.scala 63:30]
  wire  parity = txLineControlRegister[6] ? evenParity : oddParity; // @[uartTransmitter.scala 64:30]
  reg  start; // @[uartTransmitter.scala 67:28]
  reg  start_tx; // @[uartTransmitter.scala 68:31]
  reg  start_txBuf; // @[uartTransmitter.scala 69:34]
  reg  twoStopBits; // @[uartTransmitter.scala 70:34]
  reg [31:0] txClockCounter; // @[uartTransmitter.scala 71:37]
  wire  _T_37 = tHR == 8'h0; // @[uartTransmitter.scala 73:25]
  wire  _T_38 = ~txFIFO_io_FIFOempty; // @[uartTransmitter.scala 76:26]
  wire  _T_39 = _T_38 | io_wrData; // @[uartTransmitter.scala 76:47]
  wire  _GEN_0 = start | start_tx; // @[uartTransmitter.scala 77:28]
  wire  _T_40 = io_wrData & FIFOEnable; // @[uartTransmitter.scala 85:47]
  wire  _T_41 = ~FIFOEnable; // @[uartTransmitter.scala 87:18]
  wire  _T_42 = io_wrData & _T_41; // @[uartTransmitter.scala 87:16]
  wire  _T_43 = tHR != 8'h0; // @[uartTransmitter.scala 90:34]
  wire  _T_44 = tx_state == 2'h0; // @[uartTransmitter.scala 125:31]
  wire  _GEN_6 = txFIFO_io_FIFOempty & txDone; // @[uartTransmitter.scala 138:89]
  wire  _GEN_7 = txFIFO_io_FIFOempty ? txBusy : 1'h1; // @[uartTransmitter.scala 138:89]
  wire  _GEN_8 = txFIFO_io_FIFOempty ? 1'h0 : 1'h1; // @[uartTransmitter.scala 138:89]
  wire  _GEN_10 = FIFOEnable & _GEN_6; // @[uartTransmitter.scala 136:81]
  wire  _GEN_11 = FIFOEnable ? _GEN_7 : 1'h1; // @[uartTransmitter.scala 136:81]
  wire  _GEN_12 = FIFOEnable & _GEN_8; // @[uartTransmitter.scala 136:81]
  wire  _GEN_14 = start_txBuf & _GEN_12; // @[uartTransmitter.scala 128:73]
  wire  _GEN_18 = start_txBuf & _GEN_11; // @[uartTransmitter.scala 128:73]
  wire  _GEN_19 = _T_44 ? _GEN_18 : txBusy; // @[uartTransmitter.scala 125:44]
  wire  _T_45 = tx_state == 2'h1; // @[uartTransmitter.scala 158:31]
  wire  _T_48 = txLineControlRegister[3:0] == 4'h5; // @[uartTransmitter.scala 163:65]
  wire [11:0] _T_51 = {tSR[11:5],txFIFO_io_FIFOout[4:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_57 = {tSR[11:6],parity,txFIFO_io_FIFOout[4:0]}; // @[Cat.scala 29:58]
  wire [2:0] _GEN_26 = txLineControlRegister[4] ? 3'h6 : 3'h5; // @[uartTransmitter.scala 167:41]
  wire  _T_59 = txLineControlRegister[3:0] == 4'h6; // @[uartTransmitter.scala 171:77]
  wire [11:0] _T_62 = {tSR[11:6],txFIFO_io_FIFOout[5:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_68 = {tSR[11:7],parity,txFIFO_io_FIFOout[5:0]}; // @[Cat.scala 29:58]
  wire [2:0] _GEN_28 = txLineControlRegister[4] ? 3'h7 : 3'h6; // @[uartTransmitter.scala 175:41]
  wire  _T_70 = txLineControlRegister[3:0] == 4'h7; // @[uartTransmitter.scala 180:77]
  wire [11:0] _T_73 = {tSR[11:7],txFIFO_io_FIFOout[6:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_79 = {tSR[11:8],parity,txFIFO_io_FIFOout[6:0]}; // @[Cat.scala 29:58]
  wire  _T_81 = txLineControlRegister[3:0] == 4'h8; // @[uartTransmitter.scala 188:77]
  wire [7:0] _T_83 = txFIFO_io_FIFOout; // @[uartTransmitter.scala 190:81]
  wire [11:0] _T_84 = {tSR[11:8],_T_83}; // @[Cat.scala 29:58]
  wire [11:0] _T_90 = {tSR[11:9],parity,_T_83}; // @[Cat.scala 29:58]
  wire [11:0] _T_95 = {tSR[11:5],tHR[4:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_101 = {tSR[11:6],parity,tHR[4:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_106 = {tSR[11:6],tHR[5:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_112 = {tSR[11:7],parity,tHR[5:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_117 = {tSR[11:7],tHR[6:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_123 = {tSR[11:8],parity,tHR[6:0]}; // @[Cat.scala 29:58]
  wire [11:0] _T_128 = {tSR[11:8],tHR}; // @[Cat.scala 29:58]
  wire [11:0] _T_134 = {tSR[11:9],parity,tHR}; // @[Cat.scala 29:58]
  wire  _GEN_64 = _T_45 | _GEN_19; // @[uartTransmitter.scala 159:17]
  wire  _GEN_65 = _T_45 ? 1'h0 : tx_serial; // @[uartTransmitter.scala 159:17]
  wire  _T_135 = tx_state == 2'h2; // @[uartTransmitter.scala 244:31]
  wire  _T_136 = txClockCounter == io_numberofClockPB; // @[uartTransmitter.scala 247:46]
  wire [3:0] _T_138 = txBitCounter - 4'h1; // @[uartTransmitter.scala 249:62]
  wire  _T_139 = txBitCounter == 4'h0; // @[uartTransmitter.scala 250:51]
  wire [11:0] _T_142 = {1'h0,tSR[11:1]}; // @[Cat.scala 29:58]
  wire  _GEN_72 = _T_139 | tSR[0]; // @[uartTransmitter.scala 251:33]
  wire [31:0] _T_144 = txClockCounter + 32'h1; // @[uartTransmitter.scala 262:66]
  wire  _GEN_76 = _T_136 ? _GEN_72 : _GEN_65; // @[uartTransmitter.scala 248:25]
  wire  _GEN_80 = _T_135 | _GEN_64; // @[uartTransmitter.scala 245:17]
  wire  _GEN_83 = _T_135 ? _GEN_76 : _GEN_65; // @[uartTransmitter.scala 245:17]
  wire  _T_145 = tx_state == 2'h3; // @[uartTransmitter.scala 266:31]
  wire  _GEN_89 = twoStopBits ? 1'h0 : 1'h1; // @[uartTransmitter.scala 272:33]
  wire  _GEN_94 = _T_136 & _GEN_89; // @[uartTransmitter.scala 270:25]
  wire [3:0] _T_151 = {thrEmpty,thrWriteEr,txBusy,txDone}; // @[Cat.scala 29:58]
  wire [3:0] _T_154 = {txFIFO_io_FIFOwrError,txFIFO_io_FIFOrdError,txFIFO_io_FIFOempty,txFIFO_io_FIFOfull}; // @[Cat.scala 29:58]
  FIFO txFIFO ( // @[uartTransmitter.scala 35:28]
    .clock(txFIFO_clock),
    .reset(txFIFO_reset),
    .io_FIFOin(txFIFO_io_FIFOin),
    .io_FIFOwr(txFIFO_io_FIFOwr),
    .io_FIFOrd(txFIFO_io_FIFOrd),
    .io_reset(txFIFO_io_reset),
    .io_FIFOout(txFIFO_io_FIFOout),
    .io_FIFOfull(txFIFO_io_FIFOfull),
    .io_FIFOempty(txFIFO_io_FIFOempty),
    .io_FIFOrdError(txFIFO_io_FIFOrdError),
    .io_FIFOwrError(txFIFO_io_FIFOwrError)
  );
  assign io_txLineStatus = {_T_154,_T_151}; // @[uartTransmitter.scala 282:25]
  assign io_tx = tx_serial; // @[uartTransmitter.scala 283:15]
  assign txFIFO_clock = clock;
  assign txFIFO_reset = reset;
  assign txFIFO_io_FIFOin = io_txDataByte; // @[uartTransmitter.scala 82:34]
  assign txFIFO_io_FIFOwr = _T_42 ? 1'h0 : _T_40; // @[uartTransmitter.scala 85:34 uartTransmitter.scala 98:42]
  assign txFIFO_io_FIFOrd = _T_44 & _GEN_14; // @[uartTransmitter.scala 130:98 uartTransmitter.scala 145:114 uartTransmitter.scala 154:98 uartTransmitter.scala 156:94]
  assign txFIFO_io_reset = io_resetFIFO; // @[uartTransmitter.scala 86:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  tSR = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  tHR = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  tx_serial = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  txBitCounter = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  tx_state = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  thrEmpty = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  thrWriteEr = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  txBusy = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  txDone = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  FIFOEnable = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  start = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  start_tx = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  start_txBuf = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  twoStopBits = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  txClockCounter = _RAND_14[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      tSR <= 12'h0;
    end else if (_T_135) begin
      if (_T_136) begin
        if (_T_139) begin
          if (_T_45) begin
            if (FIFOEnable) begin
              if (_T_48) begin
                if (txLineControlRegister[4]) begin
                  tSR <= _T_57;
                end else begin
                  tSR <= _T_51;
                end
              end else if (_T_59) begin
                if (txLineControlRegister[4]) begin
                  tSR <= _T_68;
                end else begin
                  tSR <= _T_62;
                end
              end else if (_T_70) begin
                if (txLineControlRegister[4]) begin
                  tSR <= _T_79;
                end else begin
                  tSR <= _T_73;
                end
              end else if (_T_81) begin
                if (txLineControlRegister[4]) begin
                  tSR <= _T_90;
                end else begin
                  tSR <= _T_84;
                end
              end
            end else if (_T_48) begin
              if (txLineControlRegister[4]) begin
                tSR <= _T_101;
              end else begin
                tSR <= _T_95;
              end
            end else if (_T_59) begin
              if (txLineControlRegister[4]) begin
                tSR <= _T_112;
              end else begin
                tSR <= _T_106;
              end
            end else if (_T_70) begin
              if (txLineControlRegister[4]) begin
                tSR <= _T_123;
              end else begin
                tSR <= _T_117;
              end
            end else if (_T_81) begin
              if (txLineControlRegister[4]) begin
                tSR <= _T_134;
              end else begin
                tSR <= _T_128;
              end
            end
          end
        end else begin
          tSR <= _T_142;
        end
      end else if (_T_45) begin
        if (FIFOEnable) begin
          if (_T_48) begin
            if (txLineControlRegister[4]) begin
              tSR <= _T_57;
            end else begin
              tSR <= _T_51;
            end
          end else if (_T_59) begin
            if (txLineControlRegister[4]) begin
              tSR <= _T_68;
            end else begin
              tSR <= _T_62;
            end
          end else if (_T_70) begin
            if (txLineControlRegister[4]) begin
              tSR <= _T_79;
            end else begin
              tSR <= _T_73;
            end
          end else if (_T_81) begin
            if (txLineControlRegister[4]) begin
              tSR <= _T_90;
            end else begin
              tSR <= _T_84;
            end
          end
        end else if (_T_48) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_101;
          end else begin
            tSR <= _T_95;
          end
        end else if (_T_59) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_112;
          end else begin
            tSR <= _T_106;
          end
        end else if (_T_70) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_123;
          end else begin
            tSR <= _T_117;
          end
        end else if (_T_81) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_134;
          end else begin
            tSR <= _T_128;
          end
        end
      end
    end else if (_T_45) begin
      if (FIFOEnable) begin
        if (_T_48) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_57;
          end else begin
            tSR <= _T_51;
          end
        end else if (_T_59) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_68;
          end else begin
            tSR <= _T_62;
          end
        end else if (_T_70) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_79;
          end else begin
            tSR <= _T_73;
          end
        end else if (_T_81) begin
          if (txLineControlRegister[4]) begin
            tSR <= _T_90;
          end else begin
            tSR <= _T_84;
          end
        end
      end else if (_T_48) begin
        if (txLineControlRegister[4]) begin
          tSR <= _T_101;
        end else begin
          tSR <= _T_95;
        end
      end else if (_T_59) begin
        if (txLineControlRegister[4]) begin
          tSR <= _T_112;
        end else begin
          tSR <= _T_106;
        end
      end else if (_T_70) begin
        if (txLineControlRegister[4]) begin
          tSR <= _T_123;
        end else begin
          tSR <= _T_117;
        end
      end else if (_T_81) begin
        if (txLineControlRegister[4]) begin
          tSR <= _T_134;
        end else begin
          tSR <= _T_128;
        end
      end
    end
    if (reset) begin
      tHR <= 8'h0;
    end else if (_T_45) begin
      if (FIFOEnable) begin
        if (_T_42) begin
          tHR <= io_txDataByte;
        end
      end else begin
        tHR <= 8'h0;
      end
    end else if (_T_42) begin
      tHR <= io_txDataByte;
    end
    tx_serial <= reset | _GEN_83;
    if (reset) begin
      txBitCounter <= 4'h0;
    end else if (_T_135) begin
      if (_T_136) begin
        txBitCounter <= _T_138;
      end else if (_T_45) begin
        if (FIFOEnable) begin
          if (_T_48) begin
            txBitCounter <= {{1'd0}, _GEN_26};
          end else if (_T_59) begin
            txBitCounter <= {{1'd0}, _GEN_28};
          end else if (_T_70) begin
            if (txLineControlRegister[4]) begin
              txBitCounter <= 4'h8;
            end else begin
              txBitCounter <= 4'h7;
            end
          end else if (_T_81) begin
            if (txLineControlRegister[4]) begin
              txBitCounter <= 4'h9;
            end else begin
              txBitCounter <= 4'h8;
            end
          end
        end else if (_T_48) begin
          txBitCounter <= {{1'd0}, _GEN_26};
        end else if (_T_59) begin
          txBitCounter <= {{1'd0}, _GEN_28};
        end else if (_T_70) begin
          if (txLineControlRegister[4]) begin
            txBitCounter <= 4'h8;
          end else begin
            txBitCounter <= 4'h7;
          end
        end else if (_T_81) begin
          if (txLineControlRegister[4]) begin
            txBitCounter <= 4'h9;
          end else begin
            txBitCounter <= 4'h8;
          end
        end
      end
    end else if (_T_45) begin
      if (FIFOEnable) begin
        if (_T_48) begin
          txBitCounter <= {{1'd0}, _GEN_26};
        end else if (_T_59) begin
          txBitCounter <= {{1'd0}, _GEN_28};
        end else if (_T_70) begin
          if (txLineControlRegister[4]) begin
            txBitCounter <= 4'h8;
          end else begin
            txBitCounter <= 4'h7;
          end
        end else if (_T_81) begin
          if (txLineControlRegister[4]) begin
            txBitCounter <= 4'h9;
          end else begin
            txBitCounter <= 4'h8;
          end
        end
      end else if (_T_48) begin
        txBitCounter <= {{1'd0}, _GEN_26};
      end else if (_T_59) begin
        txBitCounter <= {{1'd0}, _GEN_28};
      end else if (_T_70) begin
        if (txLineControlRegister[4]) begin
          txBitCounter <= 4'h8;
        end else begin
          txBitCounter <= 4'h7;
        end
      end else if (_T_81) begin
        if (txLineControlRegister[4]) begin
          txBitCounter <= 4'h9;
        end else begin
          txBitCounter <= 4'h8;
        end
      end
    end
    if (reset) begin
      tx_state <= 2'h0;
    end else if (_T_145) begin
      if (_T_136) begin
        if (twoStopBits) begin
          tx_state <= 2'h3;
        end else begin
          tx_state <= 2'h0;
        end
      end else begin
        tx_state <= 2'h3;
      end
    end else if (_T_135) begin
      if (_T_136) begin
        if (_T_139) begin
          tx_state <= 2'h3;
        end
      end else begin
        tx_state <= 2'h2;
      end
    end else if (_T_45) begin
      tx_state <= 2'h2;
    end else if (_T_44) begin
      if (start_txBuf) begin
        if (FIFOEnable) begin
          if (txFIFO_io_FIFOempty) begin
            tx_state <= 2'h0;
          end else begin
            tx_state <= 2'h1;
          end
        end else begin
          tx_state <= 2'h1;
        end
      end
    end
    if (reset) begin
      thrEmpty <= 1'h0;
    end else begin
      thrEmpty <= _T_37;
    end
    if (reset) begin
      thrWriteEr <= 1'h0;
    end else if (_T_42) begin
      thrWriteEr <= _T_43;
    end
    if (reset) begin
      txBusy <= 1'h0;
    end else if (_T_145) begin
      if (_T_136) begin
        txBusy <= twoStopBits;
      end else begin
        txBusy <= 1'h1;
      end
    end else begin
      txBusy <= _GEN_80;
    end
    if (reset) begin
      txDone <= 1'h0;
    end else if (_T_145) begin
      txDone <= _GEN_94;
    end else if (_T_135) begin
      txDone <= 1'h0;
    end else if (_T_45) begin
      txDone <= 1'h0;
    end else if (_T_44) begin
      if (start_txBuf) begin
        txDone <= _GEN_10;
      end
    end
    if (reset) begin
      FIFOEnable <= 1'h0;
    end else begin
      FIFOEnable <= txLineControlRegister[7];
    end
    if (reset) begin
      start <= 1'h0;
    end else begin
      start <= _T_39;
    end
    if (reset) begin
      start_tx <= 1'h0;
    end else if (_T_44) begin
      if (start_txBuf) begin
        start_tx <= 1'h0;
      end else begin
        start_tx <= _GEN_0;
      end
    end else begin
      start_tx <= _GEN_0;
    end
    if (reset) begin
      start_txBuf <= 1'h0;
    end else begin
      start_txBuf <= start_tx;
    end
    if (reset) begin
      twoStopBits <= 1'h0;
    end else if (_T_145) begin
      if (_T_136) begin
        if (twoStopBits) begin
          twoStopBits <= 1'h0;
        end else if (_T_45) begin
          twoStopBits <= txLineControlRegister[5];
        end
      end else if (_T_45) begin
        twoStopBits <= txLineControlRegister[5];
      end
    end else if (_T_45) begin
      twoStopBits <= txLineControlRegister[5];
    end
    if (reset) begin
      txClockCounter <= 32'h0;
    end else if (_T_145) begin
      if (_T_136) begin
        txClockCounter <= 32'h0;
      end else begin
        txClockCounter <= _T_144;
      end
    end else if (_T_135) begin
      if (_T_136) begin
        txClockCounter <= 32'h0;
      end else begin
        txClockCounter <= _T_144;
      end
    end else if (_T_45) begin
      txClockCounter <= 32'h0;
    end else if (_T_44) begin
      if (start_txBuf) begin
        txClockCounter <= 32'h0;
      end
    end
  end
endmodule
module uart(
  input         clock,
  input         reset,
  input         io_rx,
  output        io_tx_I,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata,
  output        io_dma_pmode,
  output [31:0] io_dma_addr,
  output [31:0] io_dma_data,
  output        io_dma_we
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire  DMA_clock; // @[uart.scala 59:25]
  wire  DMA_reset; // @[uart.scala 59:25]
  wire [7:0] DMA_io_DataIn; // @[uart.scala 59:25]
  wire  DMA_io_DataInValid; // @[uart.scala 59:25]
  wire  DMA_io_enable; // @[uart.scala 59:25]
  wire [12:0] DMA_io_DataOutAddress; // @[uart.scala 59:25]
  wire [31:0] DMA_io_DataOut; // @[uart.scala 59:25]
  wire  DMA_io_pmode; // @[uart.scala 59:25]
  wire  DMA_io_DataOutValid; // @[uart.scala 59:25]
  wire  DMA_io_Finish; // @[uart.scala 59:25]
  wire  SI_clock; // @[uart.scala 63:23]
  wire  SI_reset; // @[uart.scala 63:23]
  wire [31:0] SI_io_condor_caddr; // @[uart.scala 63:23]
  wire  SI_io_condor_cwrite; // @[uart.scala 63:23]
  wire  SI_io_condor_creq; // @[uart.scala 63:23]
  wire  SI_io_condor_cvalid; // @[uart.scala 63:23]
  wire  SI_io_condor_csel; // @[uart.scala 63:23]
  wire [2:0] SI_io_condor_csize; // @[uart.scala 63:23]
  wire [31:0] SI_io_condor_cwdata; // @[uart.scala 63:23]
  wire [31:0] SI_io_condor_crdata; // @[uart.scala 63:23]
  wire [31:0] SI_io_rego_0; // @[uart.scala 63:23]
  wire [31:0] SI_io_rego_1; // @[uart.scala 63:23]
  wire [31:0] SI_io_rego_2; // @[uart.scala 63:23]
  wire [31:0] SI_io_rego_3; // @[uart.scala 63:23]
  wire [31:0] SI_io_regi_0; // @[uart.scala 63:23]
  wire [31:0] SI_io_regi_1; // @[uart.scala 63:23]
  wire [31:0] SI_io_regi_2; // @[uart.scala 63:23]
  wire [31:0] SI_io_regi_3; // @[uart.scala 63:23]
  wire  receiver_clock; // @[uart.scala 64:30]
  wire  receiver_reset; // @[uart.scala 64:30]
  wire [31:0] receiver_io_numberofClockPB; // @[uart.scala 64:30]
  wire [15:0] receiver_io_lineControl; // @[uart.scala 64:30]
  wire [7:0] receiver_io_rxLineStatus; // @[uart.scala 64:30]
  wire  receiver_io_PEFlag; // @[uart.scala 64:30]
  wire  receiver_io_read; // @[uart.scala 64:30]
  wire  receiver_io_resetFIFO; // @[uart.scala 64:30]
  wire [7:0] receiver_io_ReceiverBuffer; // @[uart.scala 64:30]
  wire [7:0] receiver_io_DMADataIn; // @[uart.scala 64:30]
  wire [7:0] receiver_io_FIFOout; // @[uart.scala 64:30]
  wire  receiver_io_ReceivedDataValid; // @[uart.scala 64:30]
  wire [31:0] receiver_io_MeasuredBaudRate; // @[uart.scala 64:30]
  wire  receiver_io_rx; // @[uart.scala 64:30]
  wire  transmitter_clock; // @[uart.scala 65:33]
  wire  transmitter_reset; // @[uart.scala 65:33]
  wire [15:0] transmitter_io_lineControl; // @[uart.scala 65:33]
  wire [31:0] transmitter_io_numberofClockPB; // @[uart.scala 65:33]
  wire [7:0] transmitter_io_txDataByte; // @[uart.scala 65:33]
  wire  transmitter_io_wrData; // @[uart.scala 65:33]
  wire  transmitter_io_resetFIFO; // @[uart.scala 65:33]
  wire [7:0] transmitter_io_txLineStatus; // @[uart.scala 65:33]
  wire  transmitter_io_tx; // @[uart.scala 65:33]
  reg [31:0] numberofClockPB; // @[uart.scala 69:38]
  reg [15:0] lineControl; // @[uart.scala 70:34]
  reg [7:0] regis_rxLineStatus; // @[uart.scala 72:24]
  reg  regis_PEFlag; // @[uart.scala 72:24]
  reg [7:0] regis_txLineStatus; // @[uart.scala 72:24]
  reg  readBuffer; // @[uart.scala 98:33]
  wire  _T = io_condor_caddr == 32'h2000001c; // @[uart.scala 99:37]
  wire  _T_1 = ~io_condor_cwrite; // @[uart.scala 99:72]
  wire  _T_2 = io_condor_csel & _T_1; // @[uart.scala 99:69]
  wire  read = _T & _T_2; // @[uart.scala 99:20]
  reg  write; // @[uart.scala 103:28]
  reg  writeBuffer; // @[uart.scala 104:34]
  wire  _T_4 = io_condor_caddr == 32'h20000008; // @[uart.scala 105:38]
  wire  _T_5 = io_condor_csel & io_condor_cwrite; // @[uart.scala 105:69]
  wire  _T_6 = _T_4 & _T_5; // @[uart.scala 105:21]
  wire  regos_BaudSelector = SI_io_rego_3[5]; // @[uart.scala 127:44]
  wire  _T_10 = ~readBuffer; // @[uart.scala 134:31]
  wire [7:0] _T_13 = lineControl[15] ? receiver_io_FIFOout : receiver_io_ReceiverBuffer; // @[uart.scala 145:32]
  wire [15:0] regos_lineControl = SI_io_rego_0[15:0]; // @[uart.scala 71:25 uart.scala 123:28]
  wire [31:0] regos_numberofClockPerBit = SI_io_rego_1; // @[uart.scala 71:25 uart.scala 124:35]
  microDMA DMA ( // @[uart.scala 59:25]
    .clock(DMA_clock),
    .reset(DMA_reset),
    .io_DataIn(DMA_io_DataIn),
    .io_DataInValid(DMA_io_DataInValid),
    .io_enable(DMA_io_enable),
    .io_DataOutAddress(DMA_io_DataOutAddress),
    .io_DataOut(DMA_io_DataOut),
    .io_pmode(DMA_io_pmode),
    .io_DataOutValid(DMA_io_DataOutValid),
    .io_Finish(DMA_io_Finish)
  );
  Condor_SI SI ( // @[uart.scala 63:23]
    .clock(SI_clock),
    .reset(SI_reset),
    .io_condor_caddr(SI_io_condor_caddr),
    .io_condor_cwrite(SI_io_condor_cwrite),
    .io_condor_creq(SI_io_condor_creq),
    .io_condor_cvalid(SI_io_condor_cvalid),
    .io_condor_csel(SI_io_condor_csel),
    .io_condor_csize(SI_io_condor_csize),
    .io_condor_cwdata(SI_io_condor_cwdata),
    .io_condor_crdata(SI_io_condor_crdata),
    .io_rego_0(SI_io_rego_0),
    .io_rego_1(SI_io_rego_1),
    .io_rego_2(SI_io_rego_2),
    .io_rego_3(SI_io_rego_3),
    .io_regi_0(SI_io_regi_0),
    .io_regi_1(SI_io_regi_1),
    .io_regi_2(SI_io_regi_2),
    .io_regi_3(SI_io_regi_3)
  );
  uartReceiver receiver ( // @[uart.scala 64:30]
    .clock(receiver_clock),
    .reset(receiver_reset),
    .io_numberofClockPB(receiver_io_numberofClockPB),
    .io_lineControl(receiver_io_lineControl),
    .io_rxLineStatus(receiver_io_rxLineStatus),
    .io_PEFlag(receiver_io_PEFlag),
    .io_read(receiver_io_read),
    .io_resetFIFO(receiver_io_resetFIFO),
    .io_ReceiverBuffer(receiver_io_ReceiverBuffer),
    .io_DMADataIn(receiver_io_DMADataIn),
    .io_FIFOout(receiver_io_FIFOout),
    .io_ReceivedDataValid(receiver_io_ReceivedDataValid),
    .io_MeasuredBaudRate(receiver_io_MeasuredBaudRate),
    .io_rx(receiver_io_rx)
  );
  uartTransmitter transmitter ( // @[uart.scala 65:33]
    .clock(transmitter_clock),
    .reset(transmitter_reset),
    .io_lineControl(transmitter_io_lineControl),
    .io_numberofClockPB(transmitter_io_numberofClockPB),
    .io_txDataByte(transmitter_io_txDataByte),
    .io_wrData(transmitter_io_wrData),
    .io_resetFIFO(transmitter_io_resetFIFO),
    .io_txLineStatus(transmitter_io_txLineStatus),
    .io_tx(transmitter_io_tx)
  );
  assign io_tx_I = transmitter_io_tx; // @[uart.scala 154:11]
  assign io_condor_crdata = SI_io_condor_crdata; // @[uart.scala 66:19]
  assign io_dma_pmode = DMA_io_pmode; // @[uart.scala 81:22]
  assign io_dma_addr = {{19'd0}, DMA_io_DataOutAddress}; // @[uart.scala 82:22]
  assign io_dma_data = DMA_io_DataOut; // @[uart.scala 83:22]
  assign io_dma_we = DMA_io_DataOutValid; // @[uart.scala 84:22]
  assign DMA_clock = clock;
  assign DMA_reset = reset;
  assign DMA_io_DataIn = receiver_io_DMADataIn; // @[uart.scala 75:23]
  assign DMA_io_DataInValid = receiver_io_ReceivedDataValid; // @[uart.scala 76:28]
  assign DMA_io_enable = SI_io_rego_3[4]; // @[uart.scala 78:23]
  assign SI_clock = clock;
  assign SI_reset = reset;
  assign SI_io_condor_caddr = io_condor_caddr; // @[uart.scala 66:19]
  assign SI_io_condor_cwrite = io_condor_cwrite; // @[uart.scala 66:19]
  assign SI_io_condor_creq = io_condor_creq; // @[uart.scala 66:19]
  assign SI_io_condor_cvalid = io_condor_cvalid; // @[uart.scala 66:19]
  assign SI_io_condor_csel = io_condor_csel; // @[uart.scala 66:19]
  assign SI_io_condor_csize = io_condor_csize; // @[uart.scala 66:19]
  assign SI_io_condor_cwdata = io_condor_cwdata; // @[uart.scala 66:19]
  assign SI_io_regi_0 = {{24'd0}, regis_rxLineStatus}; // @[uart.scala 148:23]
  assign SI_io_regi_1 = {{24'd0}, regis_txLineStatus}; // @[uart.scala 149:17]
  assign SI_io_regi_2 = {{31'd0}, regis_PEFlag}; // @[uart.scala 150:23]
  assign SI_io_regi_3 = {{24'd0}, _T_13}; // @[uart.scala 151:23]
  assign receiver_clock = clock;
  assign receiver_reset = reset;
  assign receiver_io_numberofClockPB = regos_BaudSelector ? receiver_io_MeasuredBaudRate : numberofClockPB; // @[uart.scala 133:37]
  assign receiver_io_lineControl = lineControl; // @[uart.scala 130:33]
  assign receiver_io_read = read & _T_10; // @[uart.scala 134:20]
  assign receiver_io_resetFIFO = DMA_io_Finish; // @[uart.scala 135:31]
  assign receiver_io_rx = io_rx; // @[uart.scala 88:24]
  assign transmitter_clock = clock;
  assign transmitter_reset = reset;
  assign transmitter_io_lineControl = lineControl; // @[uart.scala 130:124]
  assign transmitter_io_numberofClockPB = regos_BaudSelector ? receiver_io_MeasuredBaudRate : numberofClockPB; // @[uart.scala 133:120]
  assign transmitter_io_txDataByte = SI_io_rego_2[7:0]; // @[uart.scala 137:35]
  assign transmitter_io_wrData = writeBuffer; // @[uart.scala 138:31]
  assign transmitter_io_resetFIFO = DMA_io_Finish; // @[uart.scala 139:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  numberofClockPB = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  lineControl = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  regis_rxLineStatus = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  regis_PEFlag = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  regis_txLineStatus = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  readBuffer = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  write = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  writeBuffer = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      numberofClockPB <= 32'h28b1;
    end else begin
      numberofClockPB <= regos_numberofClockPerBit;
    end
    if (reset) begin
      lineControl <= 16'h808;
    end else begin
      lineControl <= regos_lineControl;
    end
    regis_rxLineStatus <= receiver_io_rxLineStatus;
    regis_PEFlag <= receiver_io_PEFlag;
    regis_txLineStatus <= transmitter_io_txLineStatus;
    if (reset) begin
      readBuffer <= 1'h0;
    end else begin
      readBuffer <= read;
    end
    if (reset) begin
      write <= 1'h0;
    end else begin
      write <= _T_6;
    end
    if (reset) begin
      writeBuffer <= 1'h0;
    end else begin
      writeBuffer <= write;
    end
  end
endmodule
module Condor_SI_1(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata,
  output [31:0] io_rego_0,
  output [31:0] io_rego_1,
  output [31:0] io_rego_2,
  output [31:0] io_rego_3,
  input  [31:0] io_regi_0,
  input  [31:0] io_regi_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] rego_0; // @[condorSlave.scala 27:26]
  reg [4:0] rego_1; // @[condorSlave.scala 27:26]
  reg [4:0] rego_2; // @[condorSlave.scala 27:26]
  reg [4:0] rego_3; // @[condorSlave.scala 27:26]
  wire [31:0] normregos_1 = {{27'd0}, rego_1}; // @[condorSlave.scala 29:29 condorSlave.scala 30:18]
  wire [31:0] normregos_0 = {{27'd0}, rego_0}; // @[condorSlave.scala 29:29 condorSlave.scala 30:18]
  wire [31:0] normregos_3 = {{27'd0}, rego_3}; // @[condorSlave.scala 29:29 condorSlave.scala 30:18]
  wire [31:0] normregos_2 = {{27'd0}, rego_2}; // @[condorSlave.scala 29:29 condorSlave.scala 30:18]
  wire [191:0] _T_5 = {io_regi_1,io_regi_0,normregos_3,normregos_2,normregos_1,normregos_0}; // @[Cat.scala 29:58]
  wire [31:0] full_regs_0 = _T_5[31:0]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_1 = _T_5[63:32]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_2 = _T_5[95:64]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_3 = _T_5[127:96]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_4 = _T_5[159:128]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_5 = _T_5[191:160]; // @[condorSlave.scala 41:73]
  reg [2:0] wraddr; // @[condorSlave.scala 45:28]
  reg [1:0] bmask; // @[condorSlave.scala 46:28]
  reg  state; // @[condorSlave.scala 48:22]
  reg [2:0] csize; // @[condorSlave.scala 49:22]
  wire  _T_15 = io_condor_csel & io_condor_cvalid; // @[condorSlave.scala 51:30]
  wire  _T_16 = _T_15 & io_condor_creq; // @[condorSlave.scala 51:52]
  wire  _T_17 = _T_16 & io_condor_cwrite; // @[condorSlave.scala 51:73]
  wire  _T_18 = csize == 3'h0; // @[condorSlave.scala 58:19]
  wire [3:0] _GEN_47 = {{2'd0}, bmask}; // @[condorSlave.scala 59:83]
  wire [5:0] _T_23 = _GEN_47 * 4'h8; // @[condorSlave.scala 59:83]
  wire [70:0] _T_24 = 71'hff << _T_23; // @[condorSlave.scala 59:75]
  wire [70:0] _T_25 = ~_T_24; // @[condorSlave.scala 59:65]
  wire [4:0] _GEN_2 = 2'h1 == wraddr[1:0] ? rego_1 : rego_0; // @[condorSlave.scala 59:63]
  wire [4:0] _GEN_3 = 2'h2 == wraddr[1:0] ? rego_2 : _GEN_2; // @[condorSlave.scala 59:63]
  wire [4:0] _GEN_4 = 2'h3 == wraddr[1:0] ? rego_3 : _GEN_3; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_48 = {{66'd0}, _GEN_4}; // @[condorSlave.scala 59:63]
  wire [70:0] _T_26 = _GEN_48 & _T_25; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_49 = {{39'd0}, io_condor_cwdata}; // @[condorSlave.scala 59:91]
  wire [70:0] _T_27 = _T_26 | _GEN_49; // @[condorSlave.scala 59:91]
  wire  _T_28 = csize == 3'h1; // @[condorSlave.scala 61:32]
  wire [4:0] _GEN_50 = {{4'd0}, bmask[1]}; // @[condorSlave.scala 62:79]
  wire [5:0] _T_34 = _GEN_50 * 5'h10; // @[condorSlave.scala 62:79]
  wire [78:0] _T_35 = 79'hffff << _T_34; // @[condorSlave.scala 62:68]
  wire [78:0] _T_36 = ~_T_35; // @[condorSlave.scala 62:56]
  wire [78:0] _GEN_51 = {{74'd0}, _GEN_4}; // @[condorSlave.scala 62:54]
  wire [78:0] _T_37 = _GEN_51 & _T_36; // @[condorSlave.scala 62:54]
  wire [78:0] _GEN_52 = {{47'd0}, io_condor_cwdata}; // @[condorSlave.scala 62:88]
  wire [78:0] _T_38 = _T_37 | _GEN_52; // @[condorSlave.scala 62:88]
  wire  _T_39 = csize == 3'h2; // @[condorSlave.scala 64:32]
  wire [31:0] _T_45 = io_condor_caddr - 32'h20000020; // @[condorSlave.scala 74:33]
  reg [31:0] readed; // @[condorSlave.scala 75:29]
  wire [2:0] raddr = _T_45[4:2]; // @[condorSlave.scala 44:25 condorSlave.scala 74:14]
  assign io_condor_crdata = readed; // @[condorSlave.scala 76:29]
  assign io_rego_0 = {{27'd0}, rego_0}; // @[condorSlave.scala 31:16]
  assign io_rego_1 = {{27'd0}, rego_1}; // @[condorSlave.scala 31:16]
  assign io_rego_2 = {{27'd0}, rego_2}; // @[condorSlave.scala 31:16]
  assign io_rego_3 = {{27'd0}, rego_3}; // @[condorSlave.scala 31:16]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rego_0 = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  rego_1 = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  rego_2 = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  rego_3 = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  wraddr = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  bmask = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  state = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  csize = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  readed = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      rego_0 <= 5'h0;
    end else if (state) begin
      if (_T_18) begin
        if (2'h0 == wraddr[1:0]) begin
          rego_0 <= _T_27[4:0];
        end
      end else if (_T_28) begin
        if (2'h0 == wraddr[1:0]) begin
          rego_0 <= _T_38[4:0];
        end
      end else if (_T_39) begin
        if (2'h0 == wraddr[1:0]) begin
          rego_0 <= io_condor_cwdata[4:0];
        end
      end else if (2'h0 == wraddr[1:0]) begin
        rego_0 <= io_condor_cwdata[4:0];
      end
    end
    if (reset) begin
      rego_1 <= 5'h1;
    end else if (state) begin
      if (_T_18) begin
        if (2'h1 == wraddr[1:0]) begin
          rego_1 <= _T_27[4:0];
        end
      end else if (_T_28) begin
        if (2'h1 == wraddr[1:0]) begin
          rego_1 <= _T_38[4:0];
        end
      end else if (_T_39) begin
        if (2'h1 == wraddr[1:0]) begin
          rego_1 <= io_condor_cwdata[4:0];
        end
      end else if (2'h1 == wraddr[1:0]) begin
        rego_1 <= io_condor_cwdata[4:0];
      end
    end
    if (reset) begin
      rego_2 <= 5'h0;
    end else if (state) begin
      if (_T_18) begin
        if (2'h2 == wraddr[1:0]) begin
          rego_2 <= _T_27[4:0];
        end
      end else if (_T_28) begin
        if (2'h2 == wraddr[1:0]) begin
          rego_2 <= _T_38[4:0];
        end
      end else if (_T_39) begin
        if (2'h2 == wraddr[1:0]) begin
          rego_2 <= io_condor_cwdata[4:0];
        end
      end else if (2'h2 == wraddr[1:0]) begin
        rego_2 <= io_condor_cwdata[4:0];
      end
    end
    if (reset) begin
      rego_3 <= 5'h1;
    end else if (state) begin
      if (_T_18) begin
        if (2'h3 == wraddr[1:0]) begin
          rego_3 <= _T_27[4:0];
        end
      end else if (_T_28) begin
        if (2'h3 == wraddr[1:0]) begin
          rego_3 <= _T_38[4:0];
        end
      end else if (_T_39) begin
        if (2'h3 == wraddr[1:0]) begin
          rego_3 <= io_condor_cwdata[4:0];
        end
      end else if (2'h3 == wraddr[1:0]) begin
        rego_3 <= io_condor_cwdata[4:0];
      end
    end
    wraddr <= _T_45[4:2];
    bmask <= io_condor_caddr[1:0];
    if (reset) begin
      state <= 1'h0;
    end else begin
      state <= _T_17;
    end
    csize <= io_condor_csize;
    if (3'h5 == raddr) begin
      readed <= full_regs_5;
    end else if (3'h4 == raddr) begin
      readed <= full_regs_4;
    end else if (3'h3 == raddr) begin
      readed <= full_regs_3;
    end else if (3'h2 == raddr) begin
      readed <= full_regs_2;
    end else if (3'h1 == raddr) begin
      readed <= full_regs_1;
    end else begin
      readed <= full_regs_0;
    end
  end
endmodule
module gpio(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata,
  output        io_pads_0_PE,
  output        io_pads_0_IE,
  output        io_pads_0_DS,
  output        io_pads_0_I,
  output        io_pads_0_OEN,
  input         io_pads_0_C,
  output        io_pads_1_PE,
  output        io_pads_1_IE,
  output        io_pads_1_DS,
  output        io_pads_1_I,
  output        io_pads_1_OEN,
  input         io_pads_1_C,
  input         io_gpio_0_funs_0_I,
  output        io_out_sync_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire  SI_clock; // @[gpio_condor.scala 76:23]
  wire  SI_reset; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_condor_caddr; // @[gpio_condor.scala 76:23]
  wire  SI_io_condor_cwrite; // @[gpio_condor.scala 76:23]
  wire  SI_io_condor_creq; // @[gpio_condor.scala 76:23]
  wire  SI_io_condor_cvalid; // @[gpio_condor.scala 76:23]
  wire  SI_io_condor_csel; // @[gpio_condor.scala 76:23]
  wire [2:0] SI_io_condor_csize; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_condor_cwdata; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_condor_crdata; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_rego_0; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_rego_1; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_rego_2; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_rego_3; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_regi_0; // @[gpio_condor.scala 76:23]
  wire [31:0] SI_io_regi_1; // @[gpio_condor.scala 76:23]
  wire  regos_0_funs_0_PE = SI_io_rego_0[0]; // @[gpio_condor.scala 82:55]
  wire  regos_0_funs_0_IE = SI_io_rego_0[1]; // @[gpio_condor.scala 83:55]
  wire  regos_0_funs_0_DS = SI_io_rego_0[2]; // @[gpio_condor.scala 84:55]
  wire  regos_0_funs_0_I = SI_io_rego_0[3]; // @[gpio_condor.scala 85:55]
  wire  regos_0_funs_0_OEN = SI_io_rego_0[4]; // @[gpio_condor.scala 86:55]
  wire  regos_1_funs_0_PE = SI_io_rego_2[0]; // @[gpio_condor.scala 82:55]
  wire  regos_1_funs_0_IE = SI_io_rego_2[1]; // @[gpio_condor.scala 83:55]
  wire  regos_1_funs_0_DS = SI_io_rego_2[2]; // @[gpio_condor.scala 84:55]
  wire  regos_1_funs_0_I = SI_io_rego_2[3]; // @[gpio_condor.scala 85:55]
  wire  regos_1_funs_0_OEN = SI_io_rego_2[4]; // @[gpio_condor.scala 86:55]
  reg  sync1_0; // @[gpio_condor.scala 98:22]
  reg  sync1_1; // @[gpio_condor.scala 98:22]
  reg  sync2_0; // @[gpio_condor.scala 99:22]
  reg  sync2_1; // @[gpio_condor.scala 99:22]
  reg  regis_0; // @[gpio_condor.scala 100:22]
  reg  regis_1; // @[gpio_condor.scala 100:22]
  wire  regos_0_IOF_sel = SI_io_rego_1[0]; // @[gpio_condor.scala 78:23 gpio_condor.scala 87:37]
  wire  regos_1_IOF_sel = SI_io_rego_3[0]; // @[gpio_condor.scala 78:23 gpio_condor.scala 87:37]
  Condor_SI_1 SI ( // @[gpio_condor.scala 76:23]
    .clock(SI_clock),
    .reset(SI_reset),
    .io_condor_caddr(SI_io_condor_caddr),
    .io_condor_cwrite(SI_io_condor_cwrite),
    .io_condor_creq(SI_io_condor_creq),
    .io_condor_cvalid(SI_io_condor_cvalid),
    .io_condor_csel(SI_io_condor_csel),
    .io_condor_csize(SI_io_condor_csize),
    .io_condor_cwdata(SI_io_condor_cwdata),
    .io_condor_crdata(SI_io_condor_crdata),
    .io_rego_0(SI_io_rego_0),
    .io_rego_1(SI_io_rego_1),
    .io_rego_2(SI_io_rego_2),
    .io_rego_3(SI_io_rego_3),
    .io_regi_0(SI_io_regi_0),
    .io_regi_1(SI_io_regi_1)
  );
  assign io_condor_crdata = SI_io_condor_crdata; // @[gpio_condor.scala 77:18]
  assign io_pads_0_PE = regos_0_IOF_sel ? 1'h0 : regos_0_funs_0_PE; // @[gpio_condor.scala 113:31]
  assign io_pads_0_IE = regos_0_IOF_sel ? 1'h0 : regos_0_funs_0_IE; // @[gpio_condor.scala 114:31]
  assign io_pads_0_DS = regos_0_IOF_sel ? 1'h0 : regos_0_funs_0_DS; // @[gpio_condor.scala 115:31]
  assign io_pads_0_I = regos_0_IOF_sel ? io_gpio_0_funs_0_I : regos_0_funs_0_I; // @[gpio_condor.scala 116:31]
  assign io_pads_0_OEN = regos_0_IOF_sel ? 1'h0 : regos_0_funs_0_OEN; // @[gpio_condor.scala 117:31]
  assign io_pads_1_PE = regos_1_IOF_sel ? 1'h0 : regos_1_funs_0_PE; // @[gpio_condor.scala 113:31]
  assign io_pads_1_IE = regos_1_IOF_sel | regos_1_funs_0_IE; // @[gpio_condor.scala 114:31]
  assign io_pads_1_DS = regos_1_IOF_sel ? 1'h0 : regos_1_funs_0_DS; // @[gpio_condor.scala 115:31]
  assign io_pads_1_I = regos_1_IOF_sel ? 1'h0 : regos_1_funs_0_I; // @[gpio_condor.scala 116:31]
  assign io_pads_1_OEN = regos_1_IOF_sel | regos_1_funs_0_OEN; // @[gpio_condor.scala 117:31]
  assign io_out_sync_1 = regis_1; // @[gpio_condor.scala 105:21]
  assign SI_clock = clock;
  assign SI_reset = reset;
  assign SI_io_condor_caddr = io_condor_caddr; // @[gpio_condor.scala 77:18]
  assign SI_io_condor_cwrite = io_condor_cwrite; // @[gpio_condor.scala 77:18]
  assign SI_io_condor_creq = io_condor_creq; // @[gpio_condor.scala 77:18]
  assign SI_io_condor_cvalid = io_condor_cvalid; // @[gpio_condor.scala 77:18]
  assign SI_io_condor_csel = io_condor_csel; // @[gpio_condor.scala 77:18]
  assign SI_io_condor_csize = io_condor_csize; // @[gpio_condor.scala 77:18]
  assign SI_io_condor_cwdata = io_condor_cwdata; // @[gpio_condor.scala 77:18]
  assign SI_io_regi_0 = {{31'd0}, regis_0}; // @[gpio_condor.scala 104:52]
  assign SI_io_regi_1 = {{31'd0}, regis_1}; // @[gpio_condor.scala 104:52]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sync1_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sync1_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sync2_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sync2_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  regis_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  regis_1 = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    sync1_0 <= io_pads_0_C;
    sync1_1 <= io_pads_1_C;
    sync2_0 <= sync1_0;
    sync2_1 <= sync1_1;
    regis_0 <= sync2_0;
    regis_1 <= sync2_1;
  end
endmodule
module Condor_SI_2(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata,
  output [31:0] io_rego_0,
  output [31:0] io_rego_1,
  input  [31:0] io_regi_0,
  input  [31:0] io_regi_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rego_0; // @[condorSlave.scala 27:26]
  reg [31:0] rego_1; // @[condorSlave.scala 27:26]
  wire [127:0] _T_3 = {io_regi_1,io_regi_0,rego_1,rego_0}; // @[Cat.scala 29:58]
  wire [31:0] full_regs_0 = _T_3[31:0]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_1 = _T_3[63:32]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_2 = _T_3[95:64]; // @[condorSlave.scala 41:73]
  wire [31:0] full_regs_3 = _T_3[127:96]; // @[condorSlave.scala 41:73]
  reg [1:0] wraddr; // @[condorSlave.scala 45:28]
  reg [1:0] bmask; // @[condorSlave.scala 46:28]
  reg  state; // @[condorSlave.scala 48:22]
  reg [2:0] csize; // @[condorSlave.scala 49:22]
  wire  _T_11 = io_condor_csel & io_condor_cvalid; // @[condorSlave.scala 51:30]
  wire  _T_12 = _T_11 & io_condor_creq; // @[condorSlave.scala 51:52]
  wire  _T_13 = _T_12 & io_condor_cwrite; // @[condorSlave.scala 51:73]
  wire  _T_14 = csize == 3'h0; // @[condorSlave.scala 58:19]
  wire [3:0] _GEN_25 = {{2'd0}, bmask}; // @[condorSlave.scala 59:83]
  wire [5:0] _T_19 = _GEN_25 * 4'h8; // @[condorSlave.scala 59:83]
  wire [70:0] _T_20 = 71'hff << _T_19; // @[condorSlave.scala 59:75]
  wire [70:0] _T_21 = ~_T_20; // @[condorSlave.scala 59:65]
  wire [31:0] _GEN_2 = wraddr[0] ? rego_1 : rego_0; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_26 = {{39'd0}, _GEN_2}; // @[condorSlave.scala 59:63]
  wire [70:0] _T_22 = _GEN_26 & _T_21; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_27 = {{39'd0}, io_condor_cwdata}; // @[condorSlave.scala 59:91]
  wire [70:0] _T_23 = _T_22 | _GEN_27; // @[condorSlave.scala 59:91]
  wire  _T_24 = csize == 3'h1; // @[condorSlave.scala 61:32]
  wire [4:0] _GEN_28 = {{4'd0}, bmask[1]}; // @[condorSlave.scala 62:79]
  wire [5:0] _T_30 = _GEN_28 * 5'h10; // @[condorSlave.scala 62:79]
  wire [78:0] _T_31 = 79'hffff << _T_30; // @[condorSlave.scala 62:68]
  wire [78:0] _T_32 = ~_T_31; // @[condorSlave.scala 62:56]
  wire [78:0] _GEN_29 = {{47'd0}, _GEN_2}; // @[condorSlave.scala 62:54]
  wire [78:0] _T_33 = _GEN_29 & _T_32; // @[condorSlave.scala 62:54]
  wire [78:0] _GEN_30 = {{47'd0}, io_condor_cwdata}; // @[condorSlave.scala 62:88]
  wire [78:0] _T_34 = _T_33 | _GEN_30; // @[condorSlave.scala 62:88]
  wire  _T_35 = csize == 3'h2; // @[condorSlave.scala 64:32]
  wire [31:0] _T_41 = io_condor_caddr - 32'h20000040; // @[condorSlave.scala 74:33]
  reg [31:0] readed; // @[condorSlave.scala 75:29]
  wire [1:0] raddr = _T_41[3:2]; // @[condorSlave.scala 44:25 condorSlave.scala 74:14]
  assign io_condor_crdata = readed; // @[condorSlave.scala 76:29]
  assign io_rego_0 = rego_0; // @[condorSlave.scala 31:16]
  assign io_rego_1 = rego_1; // @[condorSlave.scala 31:16]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rego_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rego_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  wraddr = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  bmask = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  state = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  csize = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  readed = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      rego_0 <= 32'h0;
    end else if (state) begin
      if (_T_14) begin
        if (~wraddr[0]) begin
          rego_0 <= _T_23[31:0];
        end
      end else if (_T_24) begin
        if (~wraddr[0]) begin
          rego_0 <= _T_34[31:0];
        end
      end else if (_T_35) begin
        if (~wraddr[0]) begin
          rego_0 <= io_condor_cwdata;
        end
      end else if (~wraddr[0]) begin
        rego_0 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_1 <= 32'h1;
    end else if (state) begin
      if (_T_14) begin
        if (wraddr[0]) begin
          rego_1 <= _T_23[31:0];
        end
      end else if (_T_24) begin
        if (wraddr[0]) begin
          rego_1 <= _T_34[31:0];
        end
      end else if (_T_35) begin
        if (wraddr[0]) begin
          rego_1 <= io_condor_cwdata;
        end
      end else if (wraddr[0]) begin
        rego_1 <= io_condor_cwdata;
      end
    end
    wraddr <= _T_41[3:2];
    bmask <= io_condor_caddr[1:0];
    if (reset) begin
      state <= 1'h0;
    end else begin
      state <= _T_13;
    end
    csize <= io_condor_csize;
    if (2'h3 == raddr) begin
      readed <= full_regs_3;
    end else if (2'h2 == raddr) begin
      readed <= full_regs_2;
    end else if (2'h1 == raddr) begin
      readed <= full_regs_1;
    end else begin
      readed <= full_regs_0;
    end
  end
endmodule
module timer(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  SI_clock; // @[timer.scala 50:23]
  wire  SI_reset; // @[timer.scala 50:23]
  wire [31:0] SI_io_condor_caddr; // @[timer.scala 50:23]
  wire  SI_io_condor_cwrite; // @[timer.scala 50:23]
  wire  SI_io_condor_creq; // @[timer.scala 50:23]
  wire  SI_io_condor_cvalid; // @[timer.scala 50:23]
  wire  SI_io_condor_csel; // @[timer.scala 50:23]
  wire [2:0] SI_io_condor_csize; // @[timer.scala 50:23]
  wire [31:0] SI_io_condor_cwdata; // @[timer.scala 50:23]
  wire [31:0] SI_io_condor_crdata; // @[timer.scala 50:23]
  wire [31:0] SI_io_rego_0; // @[timer.scala 50:23]
  wire [31:0] SI_io_rego_1; // @[timer.scala 50:23]
  wire [31:0] SI_io_regi_0; // @[timer.scala 50:23]
  wire [31:0] SI_io_regi_1; // @[timer.scala 50:23]
  reg [31:0] regis_count; // @[timer.scala 54:23]
  reg  regis_compOut; // @[timer.scala 54:23]
  wire  regos_en = SI_io_rego_1[0]; // @[timer.scala 58:62]
  wire  regos_reset = SI_io_rego_1[1]; // @[timer.scala 59:54]
  reg [31:0] counter; // @[timer.scala 64:28]
  wire  _T_2 = ~regis_compOut; // @[timer.scala 65:27]
  wire  _T_3 = regos_en & _T_2; // @[timer.scala 65:24]
  wire [31:0] _T_5 = counter + 32'h1; // @[timer.scala 66:34]
  wire [31:0] regos_compThresh = SI_io_rego_0; // @[timer.scala 53:23 timer.scala 57:25]
  Condor_SI_2 SI ( // @[timer.scala 50:23]
    .clock(SI_clock),
    .reset(SI_reset),
    .io_condor_caddr(SI_io_condor_caddr),
    .io_condor_cwrite(SI_io_condor_cwrite),
    .io_condor_creq(SI_io_condor_creq),
    .io_condor_cvalid(SI_io_condor_cvalid),
    .io_condor_csel(SI_io_condor_csel),
    .io_condor_csize(SI_io_condor_csize),
    .io_condor_cwdata(SI_io_condor_cwdata),
    .io_condor_crdata(SI_io_condor_crdata),
    .io_rego_0(SI_io_rego_0),
    .io_rego_1(SI_io_rego_1),
    .io_regi_0(SI_io_regi_0),
    .io_regi_1(SI_io_regi_1)
  );
  assign io_condor_crdata = SI_io_condor_crdata; // @[timer.scala 51:18]
  assign SI_clock = clock;
  assign SI_reset = reset;
  assign SI_io_condor_caddr = io_condor_caddr; // @[timer.scala 51:18]
  assign SI_io_condor_cwrite = io_condor_cwrite; // @[timer.scala 51:18]
  assign SI_io_condor_creq = io_condor_creq; // @[timer.scala 51:18]
  assign SI_io_condor_cvalid = io_condor_cvalid; // @[timer.scala 51:18]
  assign SI_io_condor_csel = io_condor_csel; // @[timer.scala 51:18]
  assign SI_io_condor_csize = io_condor_csize; // @[timer.scala 51:18]
  assign SI_io_condor_cwdata = io_condor_cwdata; // @[timer.scala 51:18]
  assign SI_io_regi_0 = {{31'd0}, regis_compOut}; // @[timer.scala 78:22]
  assign SI_io_regi_1 = regis_count; // @[timer.scala 79:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regis_count = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regis_compOut = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  counter = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    regis_count <= counter;
    regis_compOut <= counter > regos_compThresh;
    if (reset) begin
      counter <= 32'h0;
    end else if (_T_3) begin
      counter <= _T_5;
    end else if (regos_reset) begin
      counter <= 32'h0;
    end
  end
endmodule
module Condor_SI_3(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output [31:0] io_condor_crdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rego_0; // @[condorSlave.scala 27:26]
  reg [31:0] rego_1; // @[condorSlave.scala 27:26]
  reg [31:0] rego_2; // @[condorSlave.scala 27:26]
  reg [31:0] rego_3; // @[condorSlave.scala 27:26]
  reg [1:0] wraddr; // @[condorSlave.scala 45:28]
  reg [1:0] bmask; // @[condorSlave.scala 46:28]
  reg  state; // @[condorSlave.scala 48:22]
  reg [2:0] csize; // @[condorSlave.scala 49:22]
  wire  _T_2 = io_condor_csel & io_condor_cvalid; // @[condorSlave.scala 51:30]
  wire  _T_3 = _T_2 & io_condor_creq; // @[condorSlave.scala 51:52]
  wire  _T_4 = _T_3 & io_condor_cwrite; // @[condorSlave.scala 51:73]
  wire  _T_5 = csize == 3'h0; // @[condorSlave.scala 58:19]
  wire [3:0] _GEN_45 = {{2'd0}, bmask}; // @[condorSlave.scala 59:83]
  wire [5:0] _T_10 = _GEN_45 * 4'h8; // @[condorSlave.scala 59:83]
  wire [70:0] _T_11 = 71'hff << _T_10; // @[condorSlave.scala 59:75]
  wire [70:0] _T_12 = ~_T_11; // @[condorSlave.scala 59:65]
  wire [31:0] _GEN_2 = 2'h1 == wraddr ? rego_1 : rego_0; // @[condorSlave.scala 59:63]
  wire [31:0] _GEN_3 = 2'h2 == wraddr ? rego_2 : _GEN_2; // @[condorSlave.scala 59:63]
  wire [31:0] _GEN_4 = 2'h3 == wraddr ? rego_3 : _GEN_3; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_46 = {{39'd0}, _GEN_4}; // @[condorSlave.scala 59:63]
  wire [70:0] _T_13 = _GEN_46 & _T_12; // @[condorSlave.scala 59:63]
  wire [70:0] _GEN_47 = {{39'd0}, io_condor_cwdata}; // @[condorSlave.scala 59:91]
  wire [70:0] _T_14 = _T_13 | _GEN_47; // @[condorSlave.scala 59:91]
  wire  _T_15 = csize == 3'h1; // @[condorSlave.scala 61:32]
  wire [4:0] _GEN_48 = {{4'd0}, bmask[1]}; // @[condorSlave.scala 62:79]
  wire [5:0] _T_21 = _GEN_48 * 5'h10; // @[condorSlave.scala 62:79]
  wire [78:0] _T_22 = 79'hffff << _T_21; // @[condorSlave.scala 62:68]
  wire [78:0] _T_23 = ~_T_22; // @[condorSlave.scala 62:56]
  wire [78:0] _GEN_49 = {{47'd0}, _GEN_4}; // @[condorSlave.scala 62:54]
  wire [78:0] _T_24 = _GEN_49 & _T_23; // @[condorSlave.scala 62:54]
  wire [78:0] _GEN_50 = {{47'd0}, io_condor_cwdata}; // @[condorSlave.scala 62:88]
  wire [78:0] _T_25 = _T_24 | _GEN_50; // @[condorSlave.scala 62:88]
  wire  _T_26 = csize == 3'h2; // @[condorSlave.scala 64:32]
  wire [31:0] _T_32 = io_condor_caddr - 32'h20000060; // @[condorSlave.scala 74:33]
  reg [31:0] readed; // @[condorSlave.scala 75:29]
  wire [1:0] raddr = _T_32[3:2]; // @[condorSlave.scala 44:25 condorSlave.scala 74:14]
  assign io_condor_crdata = readed; // @[condorSlave.scala 76:29]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rego_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rego_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rego_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  rego_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  wraddr = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  bmask = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  state = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  csize = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  readed = _RAND_8[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      rego_0 <= 32'h110113;
    end else if (state) begin
      if (_T_5) begin
        if (2'h0 == wraddr) begin
          rego_0 <= _T_14[31:0];
        end
      end else if (_T_15) begin
        if (2'h0 == wraddr) begin
          rego_0 <= _T_25[31:0];
        end
      end else if (_T_26) begin
        if (2'h0 == wraddr) begin
          rego_0 <= io_condor_cwdata;
        end
      end else if (2'h0 == wraddr) begin
        rego_0 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_1 <= 32'h180e7;
    end else if (state) begin
      if (_T_5) begin
        if (2'h1 == wraddr) begin
          rego_1 <= _T_14[31:0];
        end
      end else if (_T_15) begin
        if (2'h1 == wraddr) begin
          rego_1 <= _T_25[31:0];
        end
      end else if (_T_26) begin
        if (2'h1 == wraddr) begin
          rego_1 <= io_condor_cwdata;
        end
      end else if (2'h1 == wraddr) begin
        rego_1 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_2 <= 32'h0;
    end else if (state) begin
      if (_T_5) begin
        if (2'h2 == wraddr) begin
          rego_2 <= _T_14[31:0];
        end
      end else if (_T_15) begin
        if (2'h2 == wraddr) begin
          rego_2 <= _T_25[31:0];
        end
      end else if (_T_26) begin
        if (2'h2 == wraddr) begin
          rego_2 <= io_condor_cwdata;
        end
      end else if (2'h2 == wraddr) begin
        rego_2 <= io_condor_cwdata;
      end
    end
    if (reset) begin
      rego_3 <= 32'h0;
    end else if (state) begin
      if (_T_5) begin
        if (2'h3 == wraddr) begin
          rego_3 <= _T_14[31:0];
        end
      end else if (_T_15) begin
        if (2'h3 == wraddr) begin
          rego_3 <= _T_25[31:0];
        end
      end else if (_T_26) begin
        if (2'h3 == wraddr) begin
          rego_3 <= io_condor_cwdata;
        end
      end else if (2'h3 == wraddr) begin
        rego_3 <= io_condor_cwdata;
      end
    end
    wraddr <= _T_32[3:2];
    bmask <= io_condor_caddr[1:0];
    if (reset) begin
      state <= 1'h0;
    end else begin
      state <= _T_4;
    end
    csize <= io_condor_csize;
    if (2'h3 == raddr) begin
      readed <= rego_3;
    end else if (2'h2 == raddr) begin
      readed <= rego_2;
    end else if (2'h1 == raddr) begin
      readed <= rego_1;
    end else begin
      readed <= rego_0;
    end
  end
endmodule
module Colibri_SI(
  input         clock,
  input         reset,
  input  [31:0] io_colibri_paddr,
  input         io_colibri_pwrite,
  input  [31:0] io_colibri_pwdata,
  input         io_colibri_psel,
  input  [2:0]  io_colibri_psize,
  output [31:0] io_colibri_prdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rego_0; // @[ColibriSlave.scala 28:26]
  reg [31:0] rego_1; // @[ColibriSlave.scala 28:26]
  reg  wraddr; // @[ColibriSlave.scala 46:29]
  reg [1:0] bmask; // @[ColibriSlave.scala 48:28]
  reg  state; // @[ColibriSlave.scala 50:22]
  reg [2:0] psize; // @[ColibriSlave.scala 52:22]
  wire  _T_2 = io_colibri_psel & io_colibri_pwrite; // @[ColibriSlave.scala 53:31]
  wire  _GEN_0 = _T_2 | state; // @[ColibriSlave.scala 53:55]
  wire  _T_3 = psize == 3'h0; // @[ColibriSlave.scala 58:27]
  wire [3:0] _GEN_24 = {{2'd0}, bmask}; // @[ColibriSlave.scala 59:89]
  wire [5:0] _T_8 = _GEN_24 * 4'h8; // @[ColibriSlave.scala 59:89]
  wire [70:0] _T_9 = 71'hff << _T_8; // @[ColibriSlave.scala 59:81]
  wire [70:0] _T_10 = ~_T_9; // @[ColibriSlave.scala 59:71]
  wire [31:0] _GEN_2 = wraddr ? rego_1 : rego_0; // @[ColibriSlave.scala 59:69]
  wire [70:0] _GEN_25 = {{39'd0}, _GEN_2}; // @[ColibriSlave.scala 59:69]
  wire [70:0] _T_11 = _GEN_25 & _T_10; // @[ColibriSlave.scala 59:69]
  wire [70:0] _GEN_26 = {{39'd0}, io_colibri_pwdata}; // @[ColibriSlave.scala 59:97]
  wire [70:0] _T_12 = _T_11 | _GEN_26; // @[ColibriSlave.scala 59:97]
  wire  _T_13 = psize == 3'h1; // @[ColibriSlave.scala 61:40]
  wire [4:0] _GEN_27 = {{4'd0}, bmask[1]}; // @[ColibriSlave.scala 62:87]
  wire [5:0] _T_19 = _GEN_27 * 5'h10; // @[ColibriSlave.scala 62:87]
  wire [78:0] _T_20 = 79'hffff << _T_19; // @[ColibriSlave.scala 62:76]
  wire [78:0] _T_21 = ~_T_20; // @[ColibriSlave.scala 62:64]
  wire [78:0] _GEN_28 = {{47'd0}, _GEN_2}; // @[ColibriSlave.scala 62:62]
  wire [78:0] _T_22 = _GEN_28 & _T_21; // @[ColibriSlave.scala 62:62]
  wire [78:0] _GEN_29 = {{47'd0}, io_colibri_pwdata}; // @[ColibriSlave.scala 62:96]
  wire [78:0] _T_23 = _T_22 | _GEN_29; // @[ColibriSlave.scala 62:96]
  wire  _T_24 = psize == 3'h2; // @[ColibriSlave.scala 64:40]
  wire [31:0] _T_30 = io_colibri_paddr - 32'h20002080; // @[ColibriSlave.scala 73:34]
  reg [31:0] readed; // @[ColibriSlave.scala 74:28]
  wire  raddr = _T_30[2]; // @[ColibriSlave.scala 45:25 ColibriSlave.scala 73:14]
  assign io_colibri_prdata = readed; // @[ColibriSlave.scala 75:30]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rego_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rego_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  wraddr = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bmask = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  state = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  psize = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  readed = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      rego_0 <= 32'h0;
    end else if (state) begin
      if (_T_3) begin
        if (~wraddr) begin
          rego_0 <= _T_12[31:0];
        end
      end else if (_T_13) begin
        if (~wraddr) begin
          rego_0 <= _T_23[31:0];
        end
      end else if (_T_24) begin
        if (~wraddr) begin
          rego_0 <= io_colibri_pwdata;
        end
      end else if (~wraddr) begin
        rego_0 <= io_colibri_pwdata;
      end
    end
    if (reset) begin
      rego_1 <= 32'h0;
    end else if (state) begin
      if (_T_3) begin
        if (wraddr) begin
          rego_1 <= _T_12[31:0];
        end
      end else if (_T_13) begin
        if (wraddr) begin
          rego_1 <= _T_23[31:0];
        end
      end else if (_T_24) begin
        if (wraddr) begin
          rego_1 <= io_colibri_pwdata;
        end
      end else if (wraddr) begin
        rego_1 <= io_colibri_pwdata;
      end
    end
    wraddr <= _T_30[2];
    bmask <= io_colibri_paddr[1:0];
    if (reset) begin
      state <= 1'h0;
    end else if (state) begin
      state <= 1'h0;
    end else begin
      state <= _GEN_0;
    end
    psize <= io_colibri_psize;
    if (raddr) begin
      readed <= rego_1;
    end else begin
      readed <= rego_0;
    end
  end
endmodule
module ram(
  input         clock,
  input         reset,
  input  [31:0] io_condor_caddr,
  input         io_condor_cwrite,
  input         io_condor_creq,
  input         io_condor_cvalid,
  input         io_condor_csel,
  input  [2:0]  io_condor_csize,
  input  [31:0] io_condor_cwdata,
  output        io_condor_creadyout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [10:0] mem_addr_A; // @[ram.scala 61:26]
  wire [31:0] mem_out_data_A; // @[ram.scala 61:26]
  wire [31:0] mem_data_A; // @[ram.scala 61:26]
  wire [3:0] mem_WE_A; // @[ram.scala 61:26]
  wire  mem_clock; // @[ram.scala 61:26]
  reg  wrinting; // @[ram.scala 71:31]
  reg [2:0] csize; // @[ram.scala 72:28]
  reg [12:0] wraddr; // @[ram.scala 73:28]
  wire  _T_1 = io_condor_csel & io_condor_cvalid; // @[ram.scala 75:30]
  wire  _T_2 = _T_1 & io_condor_creq; // @[ram.scala 75:52]
  wire  _T_3 = _T_2 & io_condor_cwrite; // @[ram.scala 75:73]
  wire  _GEN_0 = _T_3 | wrinting; // @[ram.scala 75:94]
  wire  _T_4 = csize == 3'h0; // @[ram.scala 93:19]
  wire  _T_5 = csize == 3'h1; // @[ram.scala 96:32]
  wire [3:0] _GEN_3 = _T_5 ? 4'h3 : 4'hf; // @[ram.scala 96:39]
  wire [3:0] _GEN_4 = _T_4 ? 4'h1 : _GEN_3; // @[ram.scala 93:26]
  wire [31:0] _T_8 = io_condor_caddr - 32'h20000080; // @[ram.scala 111:33]
  wire [12:0] raddr = _T_8[14:2]; // @[ram.scala 69:25 ram.scala 111:14]
  wire [12:0] _GEN_5 = wrinting ? wraddr : raddr; // @[ram.scala 90:3]
  wire [31:0] _GEN_10 = {{19'd0}, _GEN_5}; // @[ram.scala 80:27]
  SPSRAM_fpga #(.memory("ram.mem"), .nbits(32), .length(8192)) mem ( // @[ram.scala 61:26]
    .addr_A(mem_addr_A),
    .out_data_A(mem_out_data_A),
    .data_A(mem_data_A),
    .WE_A(mem_WE_A),
    .clock(mem_clock)
  );
  assign io_condor_creadyout = ~wrinting; // @[ram.scala 123:29]
  assign mem_addr_A = _GEN_10[10:0]; // @[ram.scala 86:30 ram.scala 91:31 ram.scala 108:31]
  assign mem_data_A = io_condor_cwdata; // @[ram.scala 87:30 ram.scala 92:30]
  assign mem_WE_A = wrinting ? _GEN_4 : 4'h0; // @[ram.scala 82:37 ram.scala 84:37 ram.scala 94:44 ram.scala 97:44 ram.scala 100:44 ram.scala 103:36 ram.scala 109:28]
  assign mem_clock = clock; // @[ram.scala 63:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  wrinting = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  csize = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  wraddr = _RAND_2[12:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      wrinting <= 1'h0;
    end else if (wrinting) begin
      wrinting <= 1'h0;
    end else begin
      wrinting <= _GEN_0;
    end
    csize <= io_condor_csize;
    wraddr <= _T_8[14:2];
  end
endmodule
module Arb(
  input         clock,
  input         reset,
  input  [31:0] io_M_0_caddr,
  input         io_M_0_cwrite,
  input         io_M_0_creq,
  input         io_M_0_cvalid,
  input  [2:0]  io_M_0_csize,
  input  [31:0] io_M_0_cwdata,
  output [31:0] io_M_0_crdata,
  output        io_M_0_cready,
  input  [31:0] io_M_1_caddr,
  input         io_M_1_cwrite,
  input         io_M_1_creq,
  input         io_M_1_cvalid,
  input  [2:0]  io_M_1_csize,
  input  [31:0] io_M_1_cwdata,
  output [31:0] io_M_1_crdata,
  output        io_M_1_cready,
  output [31:0] io_M_out_0_caddr,
  output        io_M_out_0_cwrite,
  output        io_M_out_0_creq,
  output        io_M_out_0_cvalid,
  output [2:0]  io_M_out_0_csize,
  output [31:0] io_M_out_0_cwdata,
  input  [31:0] io_M_out_0_crdata,
  input         io_M_out_0_cready,
  output [31:0] io_M_out_1_caddr,
  output        io_M_out_1_cwrite,
  output        io_M_out_1_creq,
  output        io_M_out_1_cvalid,
  output [2:0]  io_M_out_1_csize,
  output [31:0] io_M_out_1_cwdata,
  input  [31:0] io_M_out_1_crdata,
  input         io_M_out_1_cready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  ack_1; // @[Arb.scala 26:26]
  reg  ack_2; // @[Arb.scala 28:26]
  wire  _T = ~ack_1; // @[Arb.scala 32:48]
  wire  _T_2 = ~ack_2; // @[Arb.scala 33:48]
  assign io_M_0_crdata = io_M_out_0_crdata; // @[Arb.scala 38:25]
  assign io_M_0_cready = io_M_out_0_cready & _T; // @[Arb.scala 32:25]
  assign io_M_1_crdata = io_M_out_1_crdata; // @[Arb.scala 38:25]
  assign io_M_1_cready = io_M_out_1_cready & _T_2; // @[Arb.scala 33:25]
  assign io_M_out_0_caddr = io_M_0_caddr; // @[Arb.scala 46:27]
  assign io_M_out_0_cwrite = io_M_0_cwrite; // @[Arb.scala 45:27]
  assign io_M_out_0_creq = io_M_0_creq; // @[Arb.scala 42:27]
  assign io_M_out_0_cvalid = io_M_0_cvalid; // @[Arb.scala 41:27]
  assign io_M_out_0_csize = io_M_0_csize; // @[Arb.scala 44:27]
  assign io_M_out_0_cwdata = io_M_0_cwdata; // @[Arb.scala 43:27]
  assign io_M_out_1_caddr = io_M_1_caddr; // @[Arb.scala 46:27]
  assign io_M_out_1_cwrite = io_M_1_cwrite; // @[Arb.scala 45:27]
  assign io_M_out_1_creq = io_M_1_creq; // @[Arb.scala 42:27]
  assign io_M_out_1_cvalid = io_M_1_cvalid; // @[Arb.scala 41:27]
  assign io_M_out_1_csize = io_M_1_csize; // @[Arb.scala 44:27]
  assign io_M_out_1_cwdata = io_M_1_cwdata; // @[Arb.scala 43:27]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ack_1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ack_2 = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      ack_1 <= 1'h0;
    end else begin
      ack_1 <= io_M_0_cvalid;
    end
    if (reset) begin
      ack_2 <= 1'h0;
    end else begin
      ack_2 <= io_M_1_cvalid;
    end
  end
endmodule
module Condor_Bus(
  input         clock,
  input         reset,
  input  [31:0] io_Condor_Master_0_caddr,
  input         io_Condor_Master_0_cwrite,
  input         io_Condor_Master_0_creq,
  input         io_Condor_Master_0_cvalid,
  input  [2:0]  io_Condor_Master_0_csize,
  input  [31:0] io_Condor_Master_0_cwdata,
  output [31:0] io_Condor_Master_0_crdata,
  output        io_Condor_Master_0_cready,
  input  [31:0] io_Condor_Master_1_caddr,
  input         io_Condor_Master_1_cwrite,
  input         io_Condor_Master_1_creq,
  input         io_Condor_Master_1_cvalid,
  input  [2:0]  io_Condor_Master_1_csize,
  input  [31:0] io_Condor_Master_1_cwdata,
  output [31:0] io_Condor_Master_1_crdata,
  output        io_Condor_Master_1_cready,
  input  [31:0] io_Condor_Master_2_caddr,
  input         io_Condor_Master_2_cwrite,
  input         io_Condor_Master_2_creq,
  input         io_Condor_Master_2_cvalid,
  input  [2:0]  io_Condor_Master_2_csize,
  input  [31:0] io_Condor_Master_2_cwdata,
  output [31:0] io_Condor_Master_2_crdata,
  output        io_Condor_Master_2_cready,
  output [31:0] io_Condor_Slave_0_caddr,
  output        io_Condor_Slave_0_cwrite,
  output        io_Condor_Slave_0_creq,
  output        io_Condor_Slave_0_cvalid,
  output        io_Condor_Slave_0_csel,
  output [2:0]  io_Condor_Slave_0_csize,
  output [31:0] io_Condor_Slave_0_cwdata,
  input  [31:0] io_Condor_Slave_0_crdata,
  output [31:0] io_Condor_Slave_1_caddr,
  output        io_Condor_Slave_1_cwrite,
  output        io_Condor_Slave_1_creq,
  output        io_Condor_Slave_1_cvalid,
  output        io_Condor_Slave_1_csel,
  output [2:0]  io_Condor_Slave_1_csize,
  output [31:0] io_Condor_Slave_1_cwdata,
  input  [31:0] io_Condor_Slave_1_crdata,
  output [31:0] io_Condor_Slave_2_caddr,
  output        io_Condor_Slave_2_cwrite,
  output        io_Condor_Slave_2_creq,
  output        io_Condor_Slave_2_cvalid,
  output        io_Condor_Slave_2_csel,
  output [2:0]  io_Condor_Slave_2_csize,
  output [31:0] io_Condor_Slave_2_cwdata,
  input  [31:0] io_Condor_Slave_2_crdata,
  output [31:0] io_Condor_Slave_3_caddr,
  output        io_Condor_Slave_3_cwrite,
  output        io_Condor_Slave_3_creq,
  output        io_Condor_Slave_3_cvalid,
  output        io_Condor_Slave_3_csel,
  output [2:0]  io_Condor_Slave_3_csize,
  output [31:0] io_Condor_Slave_3_cwdata,
  input  [31:0] io_Condor_Slave_3_crdata,
  output [31:0] io_Condor_Slave_4_caddr,
  output        io_Condor_Slave_4_cwrite,
  output        io_Condor_Slave_4_creq,
  output        io_Condor_Slave_4_cvalid,
  output        io_Condor_Slave_4_csel,
  output [2:0]  io_Condor_Slave_4_csize,
  output [31:0] io_Condor_Slave_4_cwdata,
  input         io_Condor_Slave_4_creadyout,
  output [31:0] io_Condor_Slave_5_caddr,
  output        io_Condor_Slave_5_cwrite,
  output        io_Condor_Slave_5_cvalid,
  output [2:0]  io_Condor_Slave_5_csize,
  output [31:0] io_Condor_Slave_5_cwdata,
  input  [31:0] io_Condor_Slave_5_crdata,
  output [31:0] io_BusMonitor_Data,
  output [1:0]  io_BusMonitor_IdSource,
  output [31:0] io_BusMonitor_IdDestiny,
  output        io_BusMonitor_Op,
  output        io_BusMonitor_Valid,
  output        io_BusMonitor_Ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] Masters_0_caddr; // @[condor.scala 114:30]
  reg  Masters_0_cwrite; // @[condor.scala 114:30]
  reg  Masters_0_creq; // @[condor.scala 114:30]
  reg  Masters_0_cvalid; // @[condor.scala 114:30]
  reg [2:0] Masters_0_csize; // @[condor.scala 114:30]
  reg [31:0] Masters_0_cwdata; // @[condor.scala 114:30]
  reg [31:0] Masters_1_caddr; // @[condor.scala 114:30]
  reg  Masters_1_cwrite; // @[condor.scala 114:30]
  reg  Masters_1_creq; // @[condor.scala 114:30]
  reg  Masters_1_cvalid; // @[condor.scala 114:30]
  reg [2:0] Masters_1_csize; // @[condor.scala 114:30]
  reg [31:0] Masters_1_cwdata; // @[condor.scala 114:30]
  reg [31:0] Masters_2_caddr; // @[condor.scala 114:30]
  reg  Masters_2_cwrite; // @[condor.scala 114:30]
  reg  Masters_2_creq; // @[condor.scala 114:30]
  reg  Masters_2_cvalid; // @[condor.scala 114:30]
  reg [2:0] Masters_2_csize; // @[condor.scala 114:30]
  reg [31:0] Masters_2_cwdata; // @[condor.scala 114:30]
  reg [1:0] Rcurrent_master; // @[condor.scala 162:33]
  reg [5:0] Rslave_dec; // @[condor.scala 169:33]
  wire [1:0] _T_12 = Masters_0_creq + Masters_1_creq; // @[Bitwise.scala 47:55]
  wire [1:0] _T_14 = {{1'd0}, Masters_2_creq}; // @[Bitwise.scala 47:55]
  wire [2:0] _T_16 = _T_12 + _T_14; // @[Bitwise.scala 47:55]
  wire [1:0] num_req = _T_16[1:0]; // @[condor.scala 271:19]
  wire  _T_18 = num_req >= 2'h2; // @[condor.scala 193:22]
  wire [1:0] _T_23 = Masters_2_creq ? 2'h2 : 2'h3; // @[Mux.scala 47:69]
  wire [1:0] _T_24 = Masters_1_creq ? 2'h1 : _T_23; // @[Mux.scala 47:69]
  wire [1:0] _T_25 = Masters_0_creq ? 2'h0 : _T_24; // @[Mux.scala 47:69]
  wire [3:0] _T_115 = {1'h0,io_Condor_Master_2_creq,io_Condor_Master_1_creq,io_Condor_Master_0_creq}; // @[condor.scala 273:35]
  wire  request = |_T_115; // @[condor.scala 273:43]
  wire  _GEN_192 = 3'h4 == Rslave_dec[2:0] ? io_Condor_Slave_4_creadyout : 1'h1; // @[condor.scala 261:14]
  wire  _GEN_1355 = 3'h5 == Rslave_dec[2:0]; // @[condor.scala 261:14]
  wire  ReadySlave = _GEN_1355 | _GEN_192; // @[condor.scala 261:14]
  wire  _T_43 = request | ReadySlave; // @[condor.scala 239:16]
  wire  _T_127 = num_req == 2'h1; // @[condor.scala 300:34]
  wire [3:0] _T_111 = {1'h0,Masters_2_creq,Masters_1_creq,Masters_0_creq}; // @[condor.scala 272:36]
  wire  required = |_T_111; // @[condor.scala 272:44]
  wire [1:0] master_required = required ? _T_25 : 2'h0; // @[condor.scala 274:25]
  reg  State; // @[condor.scala 280:22]
  wire  _T_124 = ~State; // @[condor.scala 282:15]
  wire  _GEN_209 = _T_124 ? 1'h0 : 1'h1; // @[condor.scala 282:25]
  wire  Bus_busy = State | _GEN_209; // @[condor.scala 291:32]
  wire [1:0] _T_128 = Bus_busy ? Rcurrent_master : 2'h0; // @[condor.scala 300:65]
  wire [1:0] current_master = _T_127 ? master_required : _T_128; // @[condor.scala 300:25]
  wire  _T_47 = 2'h0 == current_master; // @[condor.scala 246:16]
  wire  _T_49 = 2'h1 == current_master; // @[condor.scala 246:16]
  wire  _T_51 = 2'h2 == current_master; // @[condor.scala 246:16]
  wire [31:0] _GEN_106 = 2'h1 == current_master ? Masters_1_caddr : Masters_0_caddr; // @[condor.scala 257:32]
  wire  _GEN_108 = 2'h1 == current_master ? Masters_1_cwrite : Masters_0_cwrite; // @[condor.scala 257:32]
  wire  _GEN_109 = 2'h1 == current_master ? Masters_1_creq : Masters_0_creq; // @[condor.scala 257:32]
  wire  _GEN_110 = 2'h1 == current_master ? Masters_1_cvalid : Masters_0_cvalid; // @[condor.scala 257:32]
  wire [2:0] _GEN_112 = 2'h1 == current_master ? Masters_1_csize : Masters_0_csize; // @[condor.scala 257:32]
  wire [31:0] _GEN_114 = 2'h1 == current_master ? Masters_1_cwdata : Masters_0_cwdata; // @[condor.scala 257:32]
  wire [31:0] _GEN_115 = 2'h2 == current_master ? Masters_2_caddr : _GEN_106; // @[condor.scala 257:32]
  wire  do_wr = 2'h2 == current_master ? Masters_2_cwrite : _GEN_108; // @[condor.scala 257:32]
  wire  _GEN_118 = 2'h2 == current_master ? Masters_2_creq : _GEN_109; // @[condor.scala 257:32]
  wire  _GEN_119 = 2'h2 == current_master ? Masters_2_cvalid : _GEN_110; // @[condor.scala 257:32]
  wire [2:0] _GEN_121 = 2'h2 == current_master ? Masters_2_csize : _GEN_112; // @[condor.scala 257:32]
  wire [31:0] _GEN_123 = 2'h2 == current_master ? Masters_2_cwdata : _GEN_114; // @[condor.scala 257:32]
  wire  _T_53 = 32'h20000000 <= _GEN_115; // @[condor.scala 257:32]
  wire  _T_56 = 32'h20000020 > _GEN_115; // @[condor.scala 257:104]
  wire  _T_57 = _T_53 & _T_56; // @[condor.scala 257:68]
  wire  sel_0 = _T_57 & required; // @[condor.scala 257:139]
  wire  _T_59 = 32'h20000020 <= _GEN_115; // @[condor.scala 257:32]
  wire  _T_62 = 32'h20000040 > _GEN_115; // @[condor.scala 257:104]
  wire  _T_63 = _T_59 & _T_62; // @[condor.scala 257:68]
  wire  sel_1 = _T_63 & required; // @[condor.scala 257:139]
  wire  _T_65 = 32'h20000040 <= _GEN_115; // @[condor.scala 257:32]
  wire  _T_68 = 32'h20000060 > _GEN_115; // @[condor.scala 257:104]
  wire  _T_69 = _T_65 & _T_68; // @[condor.scala 257:68]
  wire  sel_2 = _T_69 & required; // @[condor.scala 257:139]
  wire  _T_71 = 32'h20000060 <= _GEN_115; // @[condor.scala 257:32]
  wire  _T_74 = 32'h20000080 > _GEN_115; // @[condor.scala 257:104]
  wire  _T_75 = _T_71 & _T_74; // @[condor.scala 257:68]
  wire  sel_3 = _T_75 & required; // @[condor.scala 257:139]
  wire  _T_77 = 32'h20000080 <= _GEN_115; // @[condor.scala 257:32]
  wire  _T_80 = 32'h20002080 > _GEN_115; // @[condor.scala 257:104]
  wire  _T_81 = _T_77 & _T_80; // @[condor.scala 257:68]
  wire  sel_4 = _T_81 & required; // @[condor.scala 257:139]
  wire  _T_83 = 32'h20002080 <= _GEN_115; // @[condor.scala 257:32]
  wire  _T_86 = 32'h200020a0 > _GEN_115; // @[condor.scala 257:104]
  wire  _T_87 = _T_83 & _T_86; // @[condor.scala 257:68]
  wire  sel_5 = _T_87 & required; // @[condor.scala 257:139]
  wire [31:0] _GEN_149 = 3'h1 == Rslave_dec[2:0] ? io_Condor_Slave_1_crdata : io_Condor_Slave_0_crdata; // @[condor.scala 261:14]
  wire [31:0] _GEN_163 = 3'h2 == Rslave_dec[2:0] ? io_Condor_Slave_2_crdata : _GEN_149; // @[condor.scala 261:14]
  wire [31:0] _GEN_177 = 3'h3 == Rslave_dec[2:0] ? io_Condor_Slave_3_crdata : _GEN_163; // @[condor.scala 261:14]
  wire [31:0] _GEN_191 = 3'h4 == Rslave_dec[2:0] ? 32'hffffffff : _GEN_177; // @[condor.scala 261:14]
  wire [31:0] _GEN_205 = 3'h5 == Rslave_dec[2:0] ? io_Condor_Slave_5_crdata : _GEN_191; // @[condor.scala 261:14]
  wire [5:0] _T_94 = {sel_5,sel_4,sel_3,sel_2,sel_1,sel_0}; // @[condor.scala 262:24]
  wire  _T_95 = |_T_94; // @[condor.scala 262:32]
  wire  nonsel = ~_T_95; // @[condor.scala 262:17]
  wire [2:0] _T_97 = sel_4 ? 3'h4 : 3'h5; // @[Mux.scala 47:69]
  wire [2:0] _T_98 = sel_3 ? 3'h3 : _T_97; // @[Mux.scala 47:69]
  wire [2:0] _T_99 = sel_2 ? 3'h2 : _T_98; // @[Mux.scala 47:69]
  wire [2:0] _T_100 = sel_1 ? 3'h1 : _T_99; // @[Mux.scala 47:69]
  wire [2:0] _T_101 = sel_0 ? 3'h0 : _T_100; // @[Mux.scala 47:69]
  wire [2:0] _T_102 = nonsel ? 3'h7 : _T_101; // @[condor.scala 263:20]
  wire  _T_121 = ~nonsel; // @[condor.scala 276:22]
  wire  _T_122 = _GEN_118 & _GEN_119; // @[condor.scala 276:63]
  wire  do_transaction = _T_121 & _T_122; // @[condor.scala 276:30]
  reg [1:0] state; // @[condor.scala 305:28]
  wire  _T_130 = state == 2'h0; // @[condor.scala 307:20]
  wire  _T_131 = do_transaction & do_wr; // @[condor.scala 308:37]
  wire  _T_132 = ~do_wr; // @[condor.scala 311:47]
  wire  _T_133 = do_transaction & _T_132; // @[condor.scala 311:44]
  wire  _T_134 = state == 2'h1; // @[condor.scala 315:20]
  wire  _GEN_304 = 2'h3 == current_master ? 1'h0 : _GEN_118; // @[condor.scala 317:64]
  wire  _T_136 = ~_GEN_304; // @[condor.scala 317:64]
  wire  _T_137 = _T_136 | nonsel; // @[condor.scala 317:96]
  wire  _T_138 = ReadySlave & _T_137; // @[condor.scala 317:60]
  wire  _T_140 = ReadySlave & _GEN_304; // @[condor.scala 320:65]
  wire  _T_142 = _T_140 & _T_132; // @[condor.scala 320:99]
  wire  _T_144 = _T_142 & _T_121; // @[condor.scala 320:134]
  wire  _T_145 = state == 2'h2; // @[condor.scala 327:20]
  wire  _T_148 = _T_140 & do_wr; // @[condor.scala 329:82]
  wire  _T_150 = _T_148 & _T_121; // @[condor.scala 329:115]
  wire [5:0] slave_dec = {{3'd0}, _T_102}; // @[condor.scala 263:14]
  wire  _T_155 = slave_dec == 6'h0; // @[condor.scala 347:21]
  wire  _T_156 = slave_dec == 6'h1; // @[condor.scala 347:21]
  wire  _T_157 = slave_dec == 6'h2; // @[condor.scala 347:21]
  wire  _T_158 = slave_dec == 6'h3; // @[condor.scala 347:21]
  wire  _T_159 = slave_dec == 6'h4; // @[condor.scala 347:21]
  wire  _T_160 = slave_dec == 6'h5; // @[condor.scala 347:21]
  wire  _T_161 = 6'h0 == Rslave_dec; // @[condor.scala 374:16]
  wire  _T_163 = _T_161 & _T_134; // @[condor.scala 374:34]
  wire [31:0] _GEN_718 = 2'h1 == Rcurrent_master ? Masters_1_cwdata : Masters_0_cwdata; // @[condor.scala 375:40]
  wire [31:0] _GEN_727 = 2'h2 == Rcurrent_master ? Masters_2_cwdata : _GEN_718; // @[condor.scala 375:40]
  wire  _T_164 = 6'h1 == Rslave_dec; // @[condor.scala 374:16]
  wire  _T_166 = _T_164 & _T_134; // @[condor.scala 374:34]
  wire  _T_167 = 6'h2 == Rslave_dec; // @[condor.scala 374:16]
  wire  _T_169 = _T_167 & _T_134; // @[condor.scala 374:34]
  wire  _T_170 = 6'h3 == Rslave_dec; // @[condor.scala 374:16]
  wire  _T_172 = _T_170 & _T_134; // @[condor.scala 374:34]
  wire  _T_173 = 6'h4 == Rslave_dec; // @[condor.scala 374:16]
  wire  _T_175 = _T_173 & _T_134; // @[condor.scala 374:34]
  wire  _T_176 = 6'h5 == Rslave_dec; // @[condor.scala 374:16]
  wire  _T_178 = _T_176 & _T_134; // @[condor.scala 374:34]
  wire  _T_179 = 2'h0 == Rcurrent_master; // @[condor.scala 385:15]
  wire  _T_180 = Rslave_dec != 6'h7; // @[condor.scala 385:52]
  wire  _T_181 = _T_179 & _T_180; // @[condor.scala 385:38]
  wire  _T_183 = _T_181 & _T_145; // @[condor.scala 385:65]
  wire  _T_190 = _T_181 & _T_134; // @[condor.scala 390:70]
  wire  _T_192 = Rslave_dec == 6'h7; // @[condor.scala 396:57]
  wire  _T_193 = _T_179 & _T_192; // @[condor.scala 396:43]
  wire  _T_194 = _T_193 & required; // @[condor.scala 396:70]
  wire  _T_195 = 2'h0 != current_master; // @[condor.scala 401:20]
  wire  _T_197 = state != 2'h0; // @[condor.scala 401:73]
  wire  _T_198 = _T_18 | _T_197; // @[condor.scala 401:63]
  wire  _T_199 = _T_195 & _T_198; // @[condor.scala 401:42]
  wire  _GEN_903 = _T_199 ? 1'h0 : 1'h1; // @[condor.scala 401:84]
  wire  _GEN_905 = _T_194 | _GEN_903; // @[condor.scala 396:81]
  wire  _GEN_908 = _T_190 ? ReadySlave : _GEN_905; // @[condor.scala 390:90]
  wire  _T_200 = 2'h1 == Rcurrent_master; // @[condor.scala 385:15]
  wire  _T_202 = _T_200 & _T_180; // @[condor.scala 385:38]
  wire  _T_204 = _T_202 & _T_145; // @[condor.scala 385:65]
  wire  _T_211 = _T_202 & _T_134; // @[condor.scala 390:70]
  wire  _T_214 = _T_200 & _T_192; // @[condor.scala 396:43]
  wire  _T_215 = _T_214 & required; // @[condor.scala 396:70]
  wire  _T_216 = 2'h1 != current_master; // @[condor.scala 401:20]
  wire  _T_220 = _T_216 & _T_198; // @[condor.scala 401:42]
  wire  _GEN_1082 = _T_220 ? 1'h0 : 1'h1; // @[condor.scala 401:84]
  wire  _GEN_1084 = _T_215 | _GEN_1082; // @[condor.scala 396:81]
  wire  _GEN_1087 = _T_211 ? ReadySlave : _GEN_1084; // @[condor.scala 390:90]
  wire  _T_221 = 2'h2 == Rcurrent_master; // @[condor.scala 385:15]
  wire  _T_223 = _T_221 & _T_180; // @[condor.scala 385:38]
  wire  _T_225 = _T_223 & _T_145; // @[condor.scala 385:65]
  wire  _T_232 = _T_223 & _T_134; // @[condor.scala 390:70]
  wire  _T_235 = _T_221 & _T_192; // @[condor.scala 396:43]
  wire  _T_236 = _T_235 & required; // @[condor.scala 396:70]
  wire  _T_237 = 2'h2 != current_master; // @[condor.scala 401:20]
  wire  _T_241 = _T_237 & _T_198; // @[condor.scala 401:42]
  wire  _GEN_1261 = _T_241 ? 1'h0 : 1'h1; // @[condor.scala 401:84]
  wire  _GEN_1263 = _T_236 | _GEN_1261; // @[condor.scala 396:81]
  wire  _GEN_1266 = _T_232 ? ReadySlave : _GEN_1263; // @[condor.scala 390:90]
  wire  _GEN_1289 = 2'h1 == current_master ? io_Condor_Slave_1_cvalid : io_Condor_Slave_0_cvalid; // @[condor.scala 424:38]
  wire [31:0] _GEN_1296 = 2'h1 == current_master ? io_Condor_Slave_1_crdata : io_Condor_Slave_0_crdata; // @[condor.scala 424:38]
  wire  _GEN_1303 = 2'h2 == current_master ? io_Condor_Slave_2_cvalid : _GEN_1289; // @[condor.scala 424:38]
  wire [31:0] _GEN_1310 = 2'h2 == current_master ? io_Condor_Slave_2_crdata : _GEN_1296; // @[condor.scala 424:38]
  wire  _GEN_1317 = 2'h3 == current_master ? io_Condor_Slave_3_cvalid : _GEN_1303; // @[condor.scala 424:38]
  wire [31:0] _GEN_1324 = 2'h3 == current_master ? io_Condor_Slave_3_crdata : _GEN_1310; // @[condor.scala 424:38]
  wire [2:0] _GEN_1379 = {{1'd0}, current_master}; // @[condor.scala 424:38]
  wire  _GEN_1331 = 3'h4 == _GEN_1379 ? io_Condor_Slave_4_cvalid : _GEN_1317; // @[condor.scala 424:38]
  wire [31:0] _GEN_1338 = 3'h4 == _GEN_1379 ? 32'hffffffff : _GEN_1324; // @[condor.scala 424:38]
  wire [31:0] _GEN_1352 = 3'h5 == _GEN_1379 ? io_Condor_Slave_5_crdata : _GEN_1338; // @[condor.scala 424:38]
  assign io_Condor_Master_0_crdata = _T_183 ? _GEN_205 : 32'h0; // @[condor.scala 386:39 condor.scala 391:39 condor.scala 397:39 condor.scala 402:39 condor.scala 407:38]
  assign io_Condor_Master_0_cready = _T_183 ? ReadySlave : _GEN_908; // @[condor.scala 384:39]
  assign io_Condor_Master_1_crdata = _T_204 ? _GEN_205 : 32'h0; // @[condor.scala 386:39 condor.scala 391:39 condor.scala 397:39 condor.scala 402:39 condor.scala 407:38]
  assign io_Condor_Master_1_cready = _T_204 ? ReadySlave : _GEN_1087; // @[condor.scala 384:39]
  assign io_Condor_Master_2_crdata = _T_225 ? _GEN_205 : 32'h0; // @[condor.scala 386:39 condor.scala 391:39 condor.scala 397:39 condor.scala 402:39 condor.scala 407:38]
  assign io_Condor_Master_2_cready = _T_225 ? ReadySlave : _GEN_1266; // @[condor.scala 384:39]
  assign io_Condor_Slave_0_caddr = _T_155 ? _GEN_115 : 32'h0; // @[condor.scala 348:38 condor.scala 360:38]
  assign io_Condor_Slave_0_cwrite = _T_155 & do_wr; // @[condor.scala 355:38 condor.scala 367:38]
  assign io_Condor_Slave_0_creq = _T_155 & _GEN_118; // @[condor.scala 353:38 condor.scala 365:38]
  assign io_Condor_Slave_0_cvalid = _T_155 & _GEN_119; // @[condor.scala 356:38 condor.scala 368:38]
  assign io_Condor_Slave_0_csel = _T_57 & required; // @[condor.scala 258:29]
  assign io_Condor_Slave_0_csize = _T_155 ? _GEN_121 : 3'h0; // @[condor.scala 354:38 condor.scala 366:38]
  assign io_Condor_Slave_0_cwdata = _T_163 ? _GEN_727 : 32'h0; // @[condor.scala 375:40 condor.scala 378:40]
  assign io_Condor_Slave_1_caddr = _T_156 ? _GEN_115 : 32'h0; // @[condor.scala 348:38 condor.scala 360:38]
  assign io_Condor_Slave_1_cwrite = _T_156 & do_wr; // @[condor.scala 355:38 condor.scala 367:38]
  assign io_Condor_Slave_1_creq = _T_156 & _GEN_118; // @[condor.scala 353:38 condor.scala 365:38]
  assign io_Condor_Slave_1_cvalid = _T_156 & _GEN_119; // @[condor.scala 356:38 condor.scala 368:38]
  assign io_Condor_Slave_1_csel = _T_63 & required; // @[condor.scala 258:29]
  assign io_Condor_Slave_1_csize = _T_156 ? _GEN_121 : 3'h0; // @[condor.scala 354:38 condor.scala 366:38]
  assign io_Condor_Slave_1_cwdata = _T_166 ? _GEN_727 : 32'h0; // @[condor.scala 375:40 condor.scala 378:40]
  assign io_Condor_Slave_2_caddr = _T_157 ? _GEN_115 : 32'h0; // @[condor.scala 348:38 condor.scala 360:38]
  assign io_Condor_Slave_2_cwrite = _T_157 & do_wr; // @[condor.scala 355:38 condor.scala 367:38]
  assign io_Condor_Slave_2_creq = _T_157 & _GEN_118; // @[condor.scala 353:38 condor.scala 365:38]
  assign io_Condor_Slave_2_cvalid = _T_157 & _GEN_119; // @[condor.scala 356:38 condor.scala 368:38]
  assign io_Condor_Slave_2_csel = _T_69 & required; // @[condor.scala 258:29]
  assign io_Condor_Slave_2_csize = _T_157 ? _GEN_121 : 3'h0; // @[condor.scala 354:38 condor.scala 366:38]
  assign io_Condor_Slave_2_cwdata = _T_169 ? _GEN_727 : 32'h0; // @[condor.scala 375:40 condor.scala 378:40]
  assign io_Condor_Slave_3_caddr = _T_158 ? _GEN_115 : 32'h0; // @[condor.scala 348:38 condor.scala 360:38]
  assign io_Condor_Slave_3_cwrite = _T_158 & do_wr; // @[condor.scala 355:38 condor.scala 367:38]
  assign io_Condor_Slave_3_creq = _T_158 & _GEN_118; // @[condor.scala 353:38 condor.scala 365:38]
  assign io_Condor_Slave_3_cvalid = _T_158 & _GEN_119; // @[condor.scala 356:38 condor.scala 368:38]
  assign io_Condor_Slave_3_csel = _T_75 & required; // @[condor.scala 258:29]
  assign io_Condor_Slave_3_csize = _T_158 ? _GEN_121 : 3'h0; // @[condor.scala 354:38 condor.scala 366:38]
  assign io_Condor_Slave_3_cwdata = _T_172 ? _GEN_727 : 32'h0; // @[condor.scala 375:40 condor.scala 378:40]
  assign io_Condor_Slave_4_caddr = _T_159 ? _GEN_115 : 32'h0; // @[condor.scala 348:38 condor.scala 360:38]
  assign io_Condor_Slave_4_cwrite = _T_159 & do_wr; // @[condor.scala 355:38 condor.scala 367:38]
  assign io_Condor_Slave_4_creq = _T_159 & _GEN_118; // @[condor.scala 353:38 condor.scala 365:38]
  assign io_Condor_Slave_4_cvalid = _T_159 & _GEN_119; // @[condor.scala 356:38 condor.scala 368:38]
  assign io_Condor_Slave_4_csel = _T_81 & required; // @[condor.scala 258:29]
  assign io_Condor_Slave_4_csize = _T_159 ? _GEN_121 : 3'h0; // @[condor.scala 354:38 condor.scala 366:38]
  assign io_Condor_Slave_4_cwdata = _T_175 ? _GEN_727 : 32'h0; // @[condor.scala 375:40 condor.scala 378:40]
  assign io_Condor_Slave_5_caddr = _T_160 ? _GEN_115 : 32'h0; // @[condor.scala 348:38 condor.scala 360:38]
  assign io_Condor_Slave_5_cwrite = _T_160 & do_wr; // @[condor.scala 355:38 condor.scala 367:38]
  assign io_Condor_Slave_5_cvalid = _T_160 & _GEN_119; // @[condor.scala 356:38 condor.scala 368:38]
  assign io_Condor_Slave_5_csize = _T_160 ? _GEN_121 : 3'h0; // @[condor.scala 354:38 condor.scala 366:38]
  assign io_Condor_Slave_5_cwdata = _T_178 ? _GEN_727 : 32'h0; // @[condor.scala 375:40 condor.scala 378:40]
  assign io_BusMonitor_Data = do_wr ? _GEN_123 : _GEN_1352; // @[condor.scala 424:32]
  assign io_BusMonitor_IdSource = _T_127 ? master_required : _T_128; // @[condor.scala 425:32]
  assign io_BusMonitor_IdDestiny = 2'h2 == current_master ? Masters_2_caddr : _GEN_106; // @[condor.scala 426:32]
  assign io_BusMonitor_Op = 2'h2 == current_master ? Masters_2_cwrite : _GEN_108; // @[condor.scala 427:32]
  assign io_BusMonitor_Valid = 3'h5 == _GEN_1379 ? io_Condor_Slave_5_cvalid : _GEN_1331; // @[condor.scala 428:32]
  assign io_BusMonitor_Ready = _GEN_1355 | _GEN_192; // @[condor.scala 429:32]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Masters_0_caddr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Masters_0_cwrite = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  Masters_0_creq = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  Masters_0_cvalid = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  Masters_0_csize = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  Masters_0_cwdata = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  Masters_1_caddr = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  Masters_1_cwrite = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  Masters_1_creq = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  Masters_1_cvalid = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  Masters_1_csize = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  Masters_1_cwdata = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  Masters_2_caddr = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  Masters_2_cwrite = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  Masters_2_creq = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  Masters_2_cvalid = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  Masters_2_csize = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  Masters_2_cwdata = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  Rcurrent_master = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  Rslave_dec = _RAND_19[5:0];
  _RAND_20 = {1{`RANDOM}};
  State = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  state = _RAND_21[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      Masters_0_caddr <= 32'h0;
    end else if (_T_43) begin
      Masters_0_caddr <= io_Condor_Master_0_caddr;
    end else if (!(_T_47)) begin
      if (required) begin
        Masters_0_caddr <= io_Condor_Master_0_caddr;
      end
    end
    if (reset) begin
      Masters_0_cwrite <= 1'h0;
    end else if (_T_43) begin
      Masters_0_cwrite <= io_Condor_Master_0_cwrite;
    end else if (!(_T_47)) begin
      if (required) begin
        Masters_0_cwrite <= io_Condor_Master_0_cwrite;
      end
    end
    if (reset) begin
      Masters_0_creq <= 1'h0;
    end else if (_T_43) begin
      Masters_0_creq <= io_Condor_Master_0_creq;
    end else if (!(_T_47)) begin
      if (required) begin
        Masters_0_creq <= io_Condor_Master_0_creq;
      end
    end
    if (reset) begin
      Masters_0_cvalid <= 1'h0;
    end else if (_T_43) begin
      Masters_0_cvalid <= io_Condor_Master_0_cvalid;
    end else if (!(_T_47)) begin
      if (required) begin
        Masters_0_cvalid <= io_Condor_Master_0_cvalid;
      end
    end
    if (reset) begin
      Masters_0_csize <= 3'h0;
    end else if (_T_43) begin
      Masters_0_csize <= io_Condor_Master_0_csize;
    end else if (!(_T_47)) begin
      if (required) begin
        Masters_0_csize <= io_Condor_Master_0_csize;
      end
    end
    if (reset) begin
      Masters_0_cwdata <= 32'h0;
    end else if (_T_43) begin
      Masters_0_cwdata <= io_Condor_Master_0_cwdata;
    end else if (!(_T_47)) begin
      if (required) begin
        Masters_0_cwdata <= io_Condor_Master_0_cwdata;
      end
    end
    if (reset) begin
      Masters_1_caddr <= 32'h0;
    end else if (_T_43) begin
      Masters_1_caddr <= io_Condor_Master_1_caddr;
    end else if (!(_T_49)) begin
      if (required) begin
        Masters_1_caddr <= io_Condor_Master_1_caddr;
      end
    end
    if (reset) begin
      Masters_1_cwrite <= 1'h0;
    end else if (_T_43) begin
      Masters_1_cwrite <= io_Condor_Master_1_cwrite;
    end else if (!(_T_49)) begin
      if (required) begin
        Masters_1_cwrite <= io_Condor_Master_1_cwrite;
      end
    end
    if (reset) begin
      Masters_1_creq <= 1'h0;
    end else if (_T_43) begin
      Masters_1_creq <= io_Condor_Master_1_creq;
    end else if (!(_T_49)) begin
      if (required) begin
        Masters_1_creq <= io_Condor_Master_1_creq;
      end
    end
    if (reset) begin
      Masters_1_cvalid <= 1'h0;
    end else if (_T_43) begin
      Masters_1_cvalid <= io_Condor_Master_1_cvalid;
    end else if (!(_T_49)) begin
      if (required) begin
        Masters_1_cvalid <= io_Condor_Master_1_cvalid;
      end
    end
    if (reset) begin
      Masters_1_csize <= 3'h0;
    end else if (_T_43) begin
      Masters_1_csize <= io_Condor_Master_1_csize;
    end else if (!(_T_49)) begin
      if (required) begin
        Masters_1_csize <= io_Condor_Master_1_csize;
      end
    end
    if (reset) begin
      Masters_1_cwdata <= 32'h0;
    end else if (_T_43) begin
      Masters_1_cwdata <= io_Condor_Master_1_cwdata;
    end else if (!(_T_49)) begin
      if (required) begin
        Masters_1_cwdata <= io_Condor_Master_1_cwdata;
      end
    end
    if (reset) begin
      Masters_2_caddr <= 32'h0;
    end else if (_T_43) begin
      Masters_2_caddr <= io_Condor_Master_2_caddr;
    end else if (!(_T_51)) begin
      if (required) begin
        Masters_2_caddr <= io_Condor_Master_2_caddr;
      end
    end
    if (reset) begin
      Masters_2_cwrite <= 1'h0;
    end else if (_T_43) begin
      Masters_2_cwrite <= io_Condor_Master_2_cwrite;
    end else if (!(_T_51)) begin
      if (required) begin
        Masters_2_cwrite <= io_Condor_Master_2_cwrite;
      end
    end
    if (reset) begin
      Masters_2_creq <= 1'h0;
    end else if (_T_43) begin
      Masters_2_creq <= io_Condor_Master_2_creq;
    end else if (!(_T_51)) begin
      if (required) begin
        Masters_2_creq <= io_Condor_Master_2_creq;
      end
    end
    if (reset) begin
      Masters_2_cvalid <= 1'h0;
    end else if (_T_43) begin
      Masters_2_cvalid <= io_Condor_Master_2_cvalid;
    end else if (!(_T_51)) begin
      if (required) begin
        Masters_2_cvalid <= io_Condor_Master_2_cvalid;
      end
    end
    if (reset) begin
      Masters_2_csize <= 3'h0;
    end else if (_T_43) begin
      Masters_2_csize <= io_Condor_Master_2_csize;
    end else if (!(_T_51)) begin
      if (required) begin
        Masters_2_csize <= io_Condor_Master_2_csize;
      end
    end
    if (reset) begin
      Masters_2_cwdata <= 32'h0;
    end else if (_T_43) begin
      Masters_2_cwdata <= io_Condor_Master_2_cwdata;
    end else if (!(_T_51)) begin
      if (required) begin
        Masters_2_cwdata <= io_Condor_Master_2_cwdata;
      end
    end
    if (reset) begin
      Rcurrent_master <= 2'h0;
    end else if (_T_127) begin
      if (required) begin
        if (Masters_0_creq) begin
          Rcurrent_master <= 2'h0;
        end else if (Masters_1_creq) begin
          Rcurrent_master <= 2'h1;
        end else if (Masters_2_creq) begin
          Rcurrent_master <= 2'h2;
        end else begin
          Rcurrent_master <= 2'h3;
        end
      end else begin
        Rcurrent_master <= 2'h0;
      end
    end else if (!(Bus_busy)) begin
      Rcurrent_master <= 2'h0;
    end
    if (reset) begin
      Rslave_dec <= 6'h0;
    end else begin
      Rslave_dec <= slave_dec;
    end
    if (reset) begin
      State <= 1'h0;
    end else if (State) begin
      if (ReadySlave) begin
        State <= 1'h0;
      end else begin
        State <= 1'h1;
      end
    end else if (_T_124) begin
      State <= required;
    end
    if (reset) begin
      state <= 2'h0;
    end else if (_T_145) begin
      if (_T_150) begin
        state <= 2'h1;
      end else if (_T_138) begin
        state <= 2'h0;
      end else begin
        state <= 2'h2;
      end
    end else if (_T_134) begin
      if (_T_138) begin
        state <= 2'h0;
      end else if (_T_144) begin
        state <= 2'h2;
      end else begin
        state <= 2'h1;
      end
    end else if (_T_130) begin
      if (_T_131) begin
        state <= 2'h1;
      end else if (_T_133) begin
        state <= 2'h2;
      end
    end
  end
endmodule
module Colibri_Bus(
  input         clock,
  input         reset,
  input  [31:0] io_Colibri_Master_0_paddr,
  input  [2:0]  io_Colibri_Master_0_psize,
  input  [31:0] io_Colibri_Master_0_pwdata,
  input         io_Colibri_Master_0_pwrite,
  input         io_Colibri_Master_0_pvalid,
  output [31:0] io_Colibri_Master_0_prdata,
  output [31:0] io_Colibri_Slave_0_paddr,
  output        io_Colibri_Slave_0_pwrite,
  output [31:0] io_Colibri_Slave_0_pwdata,
  output        io_Colibri_Slave_0_psel,
  output [2:0]  io_Colibri_Slave_0_psize,
  input  [31:0] io_Colibri_Slave_0_prdata
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  Rcurrent_master; // @[colibri.scala 157:33]
  reg  Rslave_dec; // @[colibri.scala 164:33]
  reg  n_req; // @[colibri.scala 165:33]
  reg  State_fsm; // @[colibri.scala 181:26]
  wire  _T_6 = ~State_fsm; // @[colibri.scala 183:19]
  wire [1:0] _T_7 = {{1'd0}, io_Colibri_Master_0_pvalid}; // @[Bitwise.scala 47:55]
  wire  num_req = _T_7[0]; // @[colibri.scala 253:19]
  wire [1:0] _GEN_1 = _T_6 ? _T_7 : {{1'd0}, n_req}; // @[colibri.scala 183:28]
  wire  _T_11 = ~n_req; // @[colibri.scala 193:22]
  wire  _T_13 = n_req - 1'h1; // @[colibri.scala 198:34]
  wire [1:0] _GEN_4 = _T_11 ? _GEN_1 : {{1'd0}, _T_13}; // @[colibri.scala 193:31]
  wire [1:0] _GEN_6 = State_fsm ? _GEN_4 : _GEN_1; // @[colibri.scala 192:41]
  wire  next_req_m_0 = State_fsm ? 1'h0 : io_Colibri_Master_0_pvalid; // @[colibri.scala 208:35]
  wire  _T_22 = 32'h20002080 <= io_Colibri_Master_0_paddr; // @[colibri.scala 242:31]
  wire  _T_25 = 32'h200020a0 > io_Colibri_Master_0_paddr; // @[colibri.scala 242:113]
  wire  sel_0 = _T_22 & _T_25; // @[colibri.scala 242:77]
  wire  nonsel = ~sel_0; // @[colibri.scala 247:39]
  wire [1:0] _T_28 = nonsel ? 2'h2 : 2'h0; // @[colibri.scala 248:20]
  wire  _T_33 = io_Colibri_Master_0_pvalid ? 1'h0 : 1'h1; // @[Mux.scala 47:69]
  wire  master_required = io_Colibri_Master_0_pvalid & _T_33; // @[colibri.scala 255:25]
  wire  _T_35 = ~nonsel; // @[colibri.scala 257:22]
  wire  do_transaction = _T_35 & io_Colibri_Master_0_pvalid; // @[colibri.scala 257:30]
  reg  State; // @[colibri.scala 261:22]
  wire  _T_37 = ~State; // @[colibri.scala 263:15]
  wire  _GEN_18 = _T_37 ? 1'h0 : 1'h1; // @[colibri.scala 263:25]
  wire  Bus_busy = State | _GEN_18; // @[colibri.scala 272:32]
  reg [1:0] state; // @[colibri.scala 285:28]
  wire  _T_42 = state == 2'h0; // @[colibri.scala 287:20]
  wire  _T_43 = do_transaction & io_Colibri_Master_0_pwrite; // @[colibri.scala 288:37]
  wire  _T_44 = ~io_Colibri_Master_0_pwrite; // @[colibri.scala 291:47]
  wire  _T_45 = do_transaction & _T_44; // @[colibri.scala 291:44]
  wire  _T_46 = state == 2'h1; // @[colibri.scala 295:20]
  wire  slave_dec = _T_28[0]; // @[colibri.scala 248:14]
  wire  _GEN_27 = slave_dec ? 1'h0 : io_Colibri_Master_0_pvalid; // @[colibri.scala 297:62]
  wire  _T_47 = ~_GEN_27; // @[colibri.scala 297:62]
  wire  _T_48 = _T_47 | nonsel; // @[colibri.scala 297:89]
  wire  _T_52 = _GEN_27 & _T_44; // @[colibri.scala 300:92]
  wire  _T_54 = _T_52 & _T_35; // @[colibri.scala 300:132]
  wire  _T_55 = state == 2'h2; // @[colibri.scala 307:20]
  wire  _T_60 = _GEN_27 & io_Colibri_Master_0_pwrite; // @[colibri.scala 311:92]
  wire  _T_62 = _T_60 & _T_35; // @[colibri.scala 311:131]
  wire  _T_63 = ~slave_dec; // @[colibri.scala 326:21]
  wire  _T_64 = ~Rslave_dec; // @[colibri.scala 344:16]
  wire  _T_66 = _T_64 & _T_46; // @[colibri.scala 344:34]
  wire  _T_67 = ~Rcurrent_master; // @[colibri.scala 355:15]
  wire [1:0] _GEN_47 = {{1'd0}, Rslave_dec}; // @[colibri.scala 355:52]
  wire  _T_68 = _GEN_47 != 2'h2; // @[colibri.scala 355:52]
  wire  _T_69 = _T_67 & _T_68; // @[colibri.scala 355:38]
  wire  _T_71 = _T_69 & _T_55; // @[colibri.scala 355:65]
  assign io_Colibri_Master_0_prdata = _T_71 ? io_Colibri_Slave_0_prdata : 32'h0; // @[colibri.scala 356:41 colibri.scala 361:41 colibri.scala 367:41 colibri.scala 372:40]
  assign io_Colibri_Slave_0_paddr = _T_63 ? io_Colibri_Master_0_paddr : 32'h0; // @[colibri.scala 327:37 colibri.scala 335:37]
  assign io_Colibri_Slave_0_pwrite = _T_63 & io_Colibri_Master_0_pwrite; // @[colibri.scala 330:37 colibri.scala 338:37]
  assign io_Colibri_Slave_0_pwdata = _T_66 ? io_Colibri_Master_0_pwdata : 32'h0; // @[colibri.scala 328:37 colibri.scala 337:37 colibri.scala 345:41 colibri.scala 348:41]
  assign io_Colibri_Slave_0_psel = _T_22 & _T_25; // @[colibri.scala 243:30]
  assign io_Colibri_Slave_0_psize = _T_63 ? io_Colibri_Master_0_psize : 3'h0; // @[colibri.scala 329:37 colibri.scala 336:37]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Rcurrent_master = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  Rslave_dec = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  n_req = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  State_fsm = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  State = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  state = _RAND_5[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      Rcurrent_master <= 1'h0;
    end else if (num_req) begin
      Rcurrent_master <= master_required;
    end else if (!(Bus_busy)) begin
      if (next_req_m_0) begin
        Rcurrent_master <= 1'h0;
      end else begin
        Rcurrent_master <= 1'h1;
      end
    end
    if (reset) begin
      Rslave_dec <= 1'h0;
    end else begin
      Rslave_dec <= slave_dec;
    end
    if (reset) begin
      n_req <= 1'h0;
    end else begin
      n_req <= _GEN_6[0];
    end
    if (reset) begin
      State_fsm <= 1'h0;
    end else if (State_fsm) begin
      if (_T_11) begin
        State_fsm <= 1'h0;
      end else begin
        State_fsm <= 1'h1;
      end
    end else if (_T_6) begin
      State_fsm <= 1'h0;
    end
    if (reset) begin
      State <= 1'h0;
    end else if (State) begin
      State <= 1'h0;
    end else if (_T_37) begin
      State <= io_Colibri_Master_0_pvalid;
    end
    if (reset) begin
      state <= 2'h0;
    end else if (_T_55) begin
      if (_T_48) begin
        state <= 2'h0;
      end else if (_T_62) begin
        state <= 2'h1;
      end else begin
        state <= 2'h2;
      end
    end else if (_T_46) begin
      if (_T_48) begin
        state <= 2'h0;
      end else if (_T_54) begin
        state <= 2'h2;
      end else begin
        state <= 2'h1;
      end
    end else if (_T_42) begin
      if (_T_43) begin
        state <= 2'h1;
      end else if (_T_45) begin
        state <= 2'h2;
      end
    end
  end
endmodule
module Ottochip_nopads(
  input   clock,
  input   reset,
  output  io_pads_0_PE,
  output  io_pads_0_IE,
  output  io_pads_0_DS,
  output  io_pads_0_I,
  output  io_pads_0_OEN,
  input   io_pads_0_C,
  output  io_pads_1_PE,
  output  io_pads_1_IE,
  output  io_pads_1_DS,
  output  io_pads_1_I,
  output  io_pads_1_OEN,
  input   io_pads_1_C,
  input   io_pads_2_C,
  input   io_pads_3_C,
  input   io_pads_4_C,
  input   io_pads_5_C,
  output  io_pads_6_I
);
  wire  core_clock; // @[Ottochip.scala 54:26]
  wire  core_reset; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_condor_caddr; // @[Ottochip.scala 54:26]
  wire  core_io_condor_cwrite; // @[Ottochip.scala 54:26]
  wire  core_io_condor_creq; // @[Ottochip.scala 54:26]
  wire  core_io_condor_cvalid; // @[Ottochip.scala 54:26]
  wire [2:0] core_io_condor_csize; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_condor_cwdata; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_condor_crdata; // @[Ottochip.scala 54:26]
  wire  core_io_condor_cready; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_IF_condor_caddr; // @[Ottochip.scala 54:26]
  wire  core_io_IF_condor_cwrite; // @[Ottochip.scala 54:26]
  wire  core_io_IF_condor_creq; // @[Ottochip.scala 54:26]
  wire  core_io_IF_condor_cvalid; // @[Ottochip.scala 54:26]
  wire [2:0] core_io_IF_condor_csize; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_IF_condor_cwdata; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_IF_condor_crdata; // @[Ottochip.scala 54:26]
  wire  core_io_IF_condor_cready; // @[Ottochip.scala 54:26]
  wire  core_io_dma_pmode; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_dma_addr; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_dma_data; // @[Ottochip.scala 54:26]
  wire  core_io_dma_we; // @[Ottochip.scala 54:26]
  wire  core_io_debug_progBuffAc_we; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_progBuffAc_data_w; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_progBuffAc_addr_wr; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_progBuffAc_data_r; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_progBuffAc_IF_addr; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_progBuffAc_IF_data_r; // @[Ottochip.scala 54:26]
  wire  core_io_debug_nPB_rst; // @[Ottochip.scala 54:26]
  wire  core_io_debug_nPB_halt; // @[Ottochip.scala 54:26]
  wire  core_io_debug_nPB_RegsAc_we; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_nPB_RegsAc_reg_addr; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_nPB_RegsAc_data_w; // @[Ottochip.scala 54:26]
  wire [31:0] core_io_debug_nPB_RegsAc_data_r; // @[Ottochip.scala 54:26]
  wire  core_io_debug_nPB_interruption; // @[Ottochip.scala 54:26]
  wire  core_io_debug_nPB_breakpoint; // @[Ottochip.scala 54:26]
  wire  debug_clock; // @[Ottochip.scala 61:27]
  wire  debug_reset; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_ext_TMS_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_ext_TCK_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_ext_TDI_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_ext_TRSTn_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_ext_TDO_I; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_0_PE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_0_IE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_0_DS; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_0_I; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_0_OEN; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_0_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_1_PE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_1_IE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_1_DS; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_1_I; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_1_OEN; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_CORE_1_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_0_PE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_0_IE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_0_DS; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_0_I; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_0_OEN; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_0_C; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_1_PE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_1_IE; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_1_DS; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_1_I; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_1_OEN; // @[Ottochip.scala 61:27]
  wire  debug_io_pins_PinCTRL_IO_1_C; // @[Ottochip.scala 61:27]
  wire  debug_io_Dm_Output_debug_progBuffAc_we; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_progBuffAc_data_w; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_progBuffAc_addr_wr; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_progBuffAc_data_r; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_progBuffAc_IF_addr; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_progBuffAc_IF_data_r; // @[Ottochip.scala 61:27]
  wire  debug_io_Dm_Output_debug_nPB_rst; // @[Ottochip.scala 61:27]
  wire  debug_io_Dm_Output_debug_nPB_halt; // @[Ottochip.scala 61:27]
  wire  debug_io_Dm_Output_debug_nPB_RegsAc_we; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_nPB_RegsAc_reg_addr; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_nPB_RegsAc_data_w; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_Dm_Output_debug_nPB_RegsAc_data_r; // @[Ottochip.scala 61:27]
  wire  debug_io_Dm_Output_debug_nPB_interruption; // @[Ottochip.scala 61:27]
  wire  debug_io_Dm_Output_debug_nPB_breakpoint; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_SBA_AHB_caddr; // @[Ottochip.scala 61:27]
  wire  debug_io_SBA_AHB_cwrite; // @[Ottochip.scala 61:27]
  wire  debug_io_SBA_AHB_creq; // @[Ottochip.scala 61:27]
  wire  debug_io_SBA_AHB_cvalid; // @[Ottochip.scala 61:27]
  wire [2:0] debug_io_SBA_AHB_csize; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_SBA_AHB_cwdata; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_SBA_AHB_crdata; // @[Ottochip.scala 61:27]
  wire  debug_io_SBA_AHB_cready; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_MonitorPorts_Data; // @[Ottochip.scala 61:27]
  wire  debug_io_MonitorPorts_IdSource; // @[Ottochip.scala 61:27]
  wire [31:0] debug_io_MonitorPorts_IdDestiny; // @[Ottochip.scala 61:27]
  wire  debug_io_MonitorPorts_Op; // @[Ottochip.scala 61:27]
  wire  debug_io_MonitorPorts_Valid; // @[Ottochip.scala 61:27]
  wire  debug_io_MonitorPorts_Ready; // @[Ottochip.scala 61:27]
  wire [31:0] bridge_io_colibriMaster_in_paddr; // @[Ottochip.scala 69:25]
  wire [2:0] bridge_io_colibriMaster_in_psize; // @[Ottochip.scala 69:25]
  wire [31:0] bridge_io_colibriMaster_in_pwdata; // @[Ottochip.scala 69:25]
  wire  bridge_io_colibriMaster_in_pwrite; // @[Ottochip.scala 69:25]
  wire  bridge_io_colibriMaster_in_pvalid; // @[Ottochip.scala 69:25]
  wire [31:0] bridge_io_colibriMaster_in_prdata; // @[Ottochip.scala 69:25]
  wire [31:0] bridge_io_condorMaster_out_caddr; // @[Ottochip.scala 69:25]
  wire  bridge_io_condorMaster_out_cwrite; // @[Ottochip.scala 69:25]
  wire  bridge_io_condorMaster_out_cvalid; // @[Ottochip.scala 69:25]
  wire [2:0] bridge_io_condorMaster_out_csize; // @[Ottochip.scala 69:25]
  wire [31:0] bridge_io_condorMaster_out_cwdata; // @[Ottochip.scala 69:25]
  wire [31:0] bridge_io_condorMaster_out_crdata; // @[Ottochip.scala 69:25]
  wire  uart_clock; // @[Ottochip.scala 73:49]
  wire  uart_reset; // @[Ottochip.scala 73:49]
  wire  uart_io_rx; // @[Ottochip.scala 73:49]
  wire  uart_io_tx_I; // @[Ottochip.scala 73:49]
  wire [31:0] uart_io_condor_caddr; // @[Ottochip.scala 73:49]
  wire  uart_io_condor_cwrite; // @[Ottochip.scala 73:49]
  wire  uart_io_condor_creq; // @[Ottochip.scala 73:49]
  wire  uart_io_condor_cvalid; // @[Ottochip.scala 73:49]
  wire  uart_io_condor_csel; // @[Ottochip.scala 73:49]
  wire [2:0] uart_io_condor_csize; // @[Ottochip.scala 73:49]
  wire [31:0] uart_io_condor_cwdata; // @[Ottochip.scala 73:49]
  wire [31:0] uart_io_condor_crdata; // @[Ottochip.scala 73:49]
  wire  uart_io_dma_pmode; // @[Ottochip.scala 73:49]
  wire [31:0] uart_io_dma_addr; // @[Ottochip.scala 73:49]
  wire [31:0] uart_io_dma_data; // @[Ottochip.scala 73:49]
  wire  uart_io_dma_we; // @[Ottochip.scala 73:49]
  wire  gpios_clock; // @[Ottochip.scala 74:49]
  wire  gpios_reset; // @[Ottochip.scala 74:49]
  wire [31:0] gpios_io_condor_caddr; // @[Ottochip.scala 74:49]
  wire  gpios_io_condor_cwrite; // @[Ottochip.scala 74:49]
  wire  gpios_io_condor_creq; // @[Ottochip.scala 74:49]
  wire  gpios_io_condor_cvalid; // @[Ottochip.scala 74:49]
  wire  gpios_io_condor_csel; // @[Ottochip.scala 74:49]
  wire [2:0] gpios_io_condor_csize; // @[Ottochip.scala 74:49]
  wire [31:0] gpios_io_condor_cwdata; // @[Ottochip.scala 74:49]
  wire [31:0] gpios_io_condor_crdata; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_0_PE; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_0_IE; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_0_DS; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_0_I; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_0_OEN; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_0_C; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_1_PE; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_1_IE; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_1_DS; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_1_I; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_1_OEN; // @[Ottochip.scala 74:49]
  wire  gpios_io_pads_1_C; // @[Ottochip.scala 74:49]
  wire  gpios_io_gpio_0_funs_0_I; // @[Ottochip.scala 74:49]
  wire  gpios_io_out_sync_1; // @[Ottochip.scala 74:49]
  wire  timer_clock; // @[Ottochip.scala 75:49]
  wire  timer_reset; // @[Ottochip.scala 75:49]
  wire [31:0] timer_io_condor_caddr; // @[Ottochip.scala 75:49]
  wire  timer_io_condor_cwrite; // @[Ottochip.scala 75:49]
  wire  timer_io_condor_creq; // @[Ottochip.scala 75:49]
  wire  timer_io_condor_cvalid; // @[Ottochip.scala 75:49]
  wire  timer_io_condor_csel; // @[Ottochip.scala 75:49]
  wire [2:0] timer_io_condor_csize; // @[Ottochip.scala 75:49]
  wire [31:0] timer_io_condor_cwdata; // @[Ottochip.scala 75:49]
  wire [31:0] timer_io_condor_crdata; // @[Ottochip.scala 75:49]
  wire  regtest1_clock; // @[Ottochip.scala 77:33]
  wire  regtest1_reset; // @[Ottochip.scala 77:33]
  wire [31:0] regtest1_io_condor_caddr; // @[Ottochip.scala 77:33]
  wire  regtest1_io_condor_cwrite; // @[Ottochip.scala 77:33]
  wire  regtest1_io_condor_creq; // @[Ottochip.scala 77:33]
  wire  regtest1_io_condor_cvalid; // @[Ottochip.scala 77:33]
  wire  regtest1_io_condor_csel; // @[Ottochip.scala 77:33]
  wire [2:0] regtest1_io_condor_csize; // @[Ottochip.scala 77:33]
  wire [31:0] regtest1_io_condor_cwdata; // @[Ottochip.scala 77:33]
  wire [31:0] regtest1_io_condor_crdata; // @[Ottochip.scala 77:33]
  wire  regtest2_clock; // @[Ottochip.scala 78:33]
  wire  regtest2_reset; // @[Ottochip.scala 78:33]
  wire [31:0] regtest2_io_colibri_paddr; // @[Ottochip.scala 78:33]
  wire  regtest2_io_colibri_pwrite; // @[Ottochip.scala 78:33]
  wire [31:0] regtest2_io_colibri_pwdata; // @[Ottochip.scala 78:33]
  wire  regtest2_io_colibri_psel; // @[Ottochip.scala 78:33]
  wire [2:0] regtest2_io_colibri_psize; // @[Ottochip.scala 78:33]
  wire [31:0] regtest2_io_colibri_prdata; // @[Ottochip.scala 78:33]
  wire  ram_clock; // @[Ottochip.scala 79:49]
  wire  ram_reset; // @[Ottochip.scala 79:49]
  wire [31:0] ram_io_condor_caddr; // @[Ottochip.scala 79:49]
  wire  ram_io_condor_cwrite; // @[Ottochip.scala 79:49]
  wire  ram_io_condor_creq; // @[Ottochip.scala 79:49]
  wire  ram_io_condor_cvalid; // @[Ottochip.scala 79:49]
  wire  ram_io_condor_csel; // @[Ottochip.scala 79:49]
  wire [2:0] ram_io_condor_csize; // @[Ottochip.scala 79:49]
  wire [31:0] ram_io_condor_cwdata; // @[Ottochip.scala 79:49]
  wire  ram_io_condor_creadyout; // @[Ottochip.scala 79:49]
  wire  arbi_clock; // @[Ottochip.scala 86:25]
  wire  arbi_reset; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_0_caddr; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_0_cwrite; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_0_creq; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_0_cvalid; // @[Ottochip.scala 86:25]
  wire [2:0] arbi_io_M_0_csize; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_0_cwdata; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_0_crdata; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_0_cready; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_1_caddr; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_1_cwrite; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_1_creq; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_1_cvalid; // @[Ottochip.scala 86:25]
  wire [2:0] arbi_io_M_1_csize; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_1_cwdata; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_1_crdata; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_1_cready; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_out_0_caddr; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_0_cwrite; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_0_creq; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_0_cvalid; // @[Ottochip.scala 86:25]
  wire [2:0] arbi_io_M_out_0_csize; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_out_0_cwdata; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_out_0_crdata; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_0_cready; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_out_1_caddr; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_1_cwrite; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_1_creq; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_1_cvalid; // @[Ottochip.scala 86:25]
  wire [2:0] arbi_io_M_out_1_csize; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_out_1_cwdata; // @[Ottochip.scala 86:25]
  wire [31:0] arbi_io_M_out_1_crdata; // @[Ottochip.scala 86:25]
  wire  arbi_io_M_out_1_cready; // @[Ottochip.scala 86:25]
  wire  Condor_Bus_clock; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_reset; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_0_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_0_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_0_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_0_cvalid; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Master_0_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_0_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_0_crdata; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_0_cready; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_1_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_1_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_1_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_1_cvalid; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Master_1_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_1_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_1_crdata; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_1_cready; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_2_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_2_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_2_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_2_cvalid; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Master_2_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_2_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Master_2_crdata; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Master_2_cready; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_0_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_0_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_0_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_0_cvalid; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_0_csel; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Slave_0_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_0_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_0_crdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_1_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_1_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_1_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_1_cvalid; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_1_csel; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Slave_1_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_1_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_1_crdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_2_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_2_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_2_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_2_cvalid; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_2_csel; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Slave_2_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_2_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_2_crdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_3_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_3_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_3_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_3_cvalid; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_3_csel; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Slave_3_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_3_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_3_crdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_4_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_4_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_4_creq; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_4_cvalid; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_4_csel; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Slave_4_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_4_cwdata; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_4_creadyout; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_5_caddr; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_5_cwrite; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_Condor_Slave_5_cvalid; // @[BusFunc_condor.scala 32:20]
  wire [2:0] Condor_Bus_io_Condor_Slave_5_csize; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_5_cwdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_Condor_Slave_5_crdata; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_BusMonitor_Data; // @[BusFunc_condor.scala 32:20]
  wire [1:0] Condor_Bus_io_BusMonitor_IdSource; // @[BusFunc_condor.scala 32:20]
  wire [31:0] Condor_Bus_io_BusMonitor_IdDestiny; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_BusMonitor_Op; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_BusMonitor_Valid; // @[BusFunc_condor.scala 32:20]
  wire  Condor_Bus_io_BusMonitor_Ready; // @[BusFunc_condor.scala 32:20]
  wire  Colibri_Bus_clock; // @[BusFunc_colibri.scala 27:20]
  wire  Colibri_Bus_reset; // @[BusFunc_colibri.scala 27:20]
  wire [31:0] Colibri_Bus_io_Colibri_Master_0_paddr; // @[BusFunc_colibri.scala 27:20]
  wire [2:0] Colibri_Bus_io_Colibri_Master_0_psize; // @[BusFunc_colibri.scala 27:20]
  wire [31:0] Colibri_Bus_io_Colibri_Master_0_pwdata; // @[BusFunc_colibri.scala 27:20]
  wire  Colibri_Bus_io_Colibri_Master_0_pwrite; // @[BusFunc_colibri.scala 27:20]
  wire  Colibri_Bus_io_Colibri_Master_0_pvalid; // @[BusFunc_colibri.scala 27:20]
  wire [31:0] Colibri_Bus_io_Colibri_Master_0_prdata; // @[BusFunc_colibri.scala 27:20]
  wire [31:0] Colibri_Bus_io_Colibri_Slave_0_paddr; // @[BusFunc_colibri.scala 27:20]
  wire  Colibri_Bus_io_Colibri_Slave_0_pwrite; // @[BusFunc_colibri.scala 27:20]
  wire [31:0] Colibri_Bus_io_Colibri_Slave_0_pwdata; // @[BusFunc_colibri.scala 27:20]
  wire  Colibri_Bus_io_Colibri_Slave_0_psel; // @[BusFunc_colibri.scala 27:20]
  wire [2:0] Colibri_Bus_io_Colibri_Slave_0_psize; // @[BusFunc_colibri.scala 27:20]
  wire [31:0] Colibri_Bus_io_Colibri_Slave_0_prdata; // @[BusFunc_colibri.scala 27:20]
  Ottocore core ( // @[Ottochip.scala 54:26]
    .clock(core_clock),
    .reset(core_reset),
    .io_condor_caddr(core_io_condor_caddr),
    .io_condor_cwrite(core_io_condor_cwrite),
    .io_condor_creq(core_io_condor_creq),
    .io_condor_cvalid(core_io_condor_cvalid),
    .io_condor_csize(core_io_condor_csize),
    .io_condor_cwdata(core_io_condor_cwdata),
    .io_condor_crdata(core_io_condor_crdata),
    .io_condor_cready(core_io_condor_cready),
    .io_IF_condor_caddr(core_io_IF_condor_caddr),
    .io_IF_condor_cwrite(core_io_IF_condor_cwrite),
    .io_IF_condor_creq(core_io_IF_condor_creq),
    .io_IF_condor_cvalid(core_io_IF_condor_cvalid),
    .io_IF_condor_csize(core_io_IF_condor_csize),
    .io_IF_condor_cwdata(core_io_IF_condor_cwdata),
    .io_IF_condor_crdata(core_io_IF_condor_crdata),
    .io_IF_condor_cready(core_io_IF_condor_cready),
    .io_dma_pmode(core_io_dma_pmode),
    .io_dma_addr(core_io_dma_addr),
    .io_dma_data(core_io_dma_data),
    .io_dma_we(core_io_dma_we),
    .io_debug_progBuffAc_we(core_io_debug_progBuffAc_we),
    .io_debug_progBuffAc_data_w(core_io_debug_progBuffAc_data_w),
    .io_debug_progBuffAc_addr_wr(core_io_debug_progBuffAc_addr_wr),
    .io_debug_progBuffAc_data_r(core_io_debug_progBuffAc_data_r),
    .io_debug_progBuffAc_IF_addr(core_io_debug_progBuffAc_IF_addr),
    .io_debug_progBuffAc_IF_data_r(core_io_debug_progBuffAc_IF_data_r),
    .io_debug_nPB_rst(core_io_debug_nPB_rst),
    .io_debug_nPB_halt(core_io_debug_nPB_halt),
    .io_debug_nPB_RegsAc_we(core_io_debug_nPB_RegsAc_we),
    .io_debug_nPB_RegsAc_reg_addr(core_io_debug_nPB_RegsAc_reg_addr),
    .io_debug_nPB_RegsAc_data_w(core_io_debug_nPB_RegsAc_data_w),
    .io_debug_nPB_RegsAc_data_r(core_io_debug_nPB_RegsAc_data_r),
    .io_debug_nPB_interruption(core_io_debug_nPB_interruption),
    .io_debug_nPB_breakpoint(core_io_debug_nPB_breakpoint)
  );
  DebugSystem debug ( // @[Ottochip.scala 61:27]
    .clock(debug_clock),
    .reset(debug_reset),
    .io_pins_ext_TMS_C(debug_io_pins_ext_TMS_C),
    .io_pins_ext_TCK_C(debug_io_pins_ext_TCK_C),
    .io_pins_ext_TDI_C(debug_io_pins_ext_TDI_C),
    .io_pins_ext_TRSTn_C(debug_io_pins_ext_TRSTn_C),
    .io_pins_ext_TDO_I(debug_io_pins_ext_TDO_I),
    .io_pins_PinCTRL_CORE_0_PE(debug_io_pins_PinCTRL_CORE_0_PE),
    .io_pins_PinCTRL_CORE_0_IE(debug_io_pins_PinCTRL_CORE_0_IE),
    .io_pins_PinCTRL_CORE_0_DS(debug_io_pins_PinCTRL_CORE_0_DS),
    .io_pins_PinCTRL_CORE_0_I(debug_io_pins_PinCTRL_CORE_0_I),
    .io_pins_PinCTRL_CORE_0_OEN(debug_io_pins_PinCTRL_CORE_0_OEN),
    .io_pins_PinCTRL_CORE_0_C(debug_io_pins_PinCTRL_CORE_0_C),
    .io_pins_PinCTRL_CORE_1_PE(debug_io_pins_PinCTRL_CORE_1_PE),
    .io_pins_PinCTRL_CORE_1_IE(debug_io_pins_PinCTRL_CORE_1_IE),
    .io_pins_PinCTRL_CORE_1_DS(debug_io_pins_PinCTRL_CORE_1_DS),
    .io_pins_PinCTRL_CORE_1_I(debug_io_pins_PinCTRL_CORE_1_I),
    .io_pins_PinCTRL_CORE_1_OEN(debug_io_pins_PinCTRL_CORE_1_OEN),
    .io_pins_PinCTRL_CORE_1_C(debug_io_pins_PinCTRL_CORE_1_C),
    .io_pins_PinCTRL_IO_0_PE(debug_io_pins_PinCTRL_IO_0_PE),
    .io_pins_PinCTRL_IO_0_IE(debug_io_pins_PinCTRL_IO_0_IE),
    .io_pins_PinCTRL_IO_0_DS(debug_io_pins_PinCTRL_IO_0_DS),
    .io_pins_PinCTRL_IO_0_I(debug_io_pins_PinCTRL_IO_0_I),
    .io_pins_PinCTRL_IO_0_OEN(debug_io_pins_PinCTRL_IO_0_OEN),
    .io_pins_PinCTRL_IO_0_C(debug_io_pins_PinCTRL_IO_0_C),
    .io_pins_PinCTRL_IO_1_PE(debug_io_pins_PinCTRL_IO_1_PE),
    .io_pins_PinCTRL_IO_1_IE(debug_io_pins_PinCTRL_IO_1_IE),
    .io_pins_PinCTRL_IO_1_DS(debug_io_pins_PinCTRL_IO_1_DS),
    .io_pins_PinCTRL_IO_1_I(debug_io_pins_PinCTRL_IO_1_I),
    .io_pins_PinCTRL_IO_1_OEN(debug_io_pins_PinCTRL_IO_1_OEN),
    .io_pins_PinCTRL_IO_1_C(debug_io_pins_PinCTRL_IO_1_C),
    .io_Dm_Output_debug_progBuffAc_we(debug_io_Dm_Output_debug_progBuffAc_we),
    .io_Dm_Output_debug_progBuffAc_data_w(debug_io_Dm_Output_debug_progBuffAc_data_w),
    .io_Dm_Output_debug_progBuffAc_addr_wr(debug_io_Dm_Output_debug_progBuffAc_addr_wr),
    .io_Dm_Output_debug_progBuffAc_data_r(debug_io_Dm_Output_debug_progBuffAc_data_r),
    .io_Dm_Output_debug_progBuffAc_IF_addr(debug_io_Dm_Output_debug_progBuffAc_IF_addr),
    .io_Dm_Output_debug_progBuffAc_IF_data_r(debug_io_Dm_Output_debug_progBuffAc_IF_data_r),
    .io_Dm_Output_debug_nPB_rst(debug_io_Dm_Output_debug_nPB_rst),
    .io_Dm_Output_debug_nPB_halt(debug_io_Dm_Output_debug_nPB_halt),
    .io_Dm_Output_debug_nPB_RegsAc_we(debug_io_Dm_Output_debug_nPB_RegsAc_we),
    .io_Dm_Output_debug_nPB_RegsAc_reg_addr(debug_io_Dm_Output_debug_nPB_RegsAc_reg_addr),
    .io_Dm_Output_debug_nPB_RegsAc_data_w(debug_io_Dm_Output_debug_nPB_RegsAc_data_w),
    .io_Dm_Output_debug_nPB_RegsAc_data_r(debug_io_Dm_Output_debug_nPB_RegsAc_data_r),
    .io_Dm_Output_debug_nPB_interruption(debug_io_Dm_Output_debug_nPB_interruption),
    .io_Dm_Output_debug_nPB_breakpoint(debug_io_Dm_Output_debug_nPB_breakpoint),
    .io_SBA_AHB_caddr(debug_io_SBA_AHB_caddr),
    .io_SBA_AHB_cwrite(debug_io_SBA_AHB_cwrite),
    .io_SBA_AHB_creq(debug_io_SBA_AHB_creq),
    .io_SBA_AHB_cvalid(debug_io_SBA_AHB_cvalid),
    .io_SBA_AHB_csize(debug_io_SBA_AHB_csize),
    .io_SBA_AHB_cwdata(debug_io_SBA_AHB_cwdata),
    .io_SBA_AHB_crdata(debug_io_SBA_AHB_crdata),
    .io_SBA_AHB_cready(debug_io_SBA_AHB_cready),
    .io_MonitorPorts_Data(debug_io_MonitorPorts_Data),
    .io_MonitorPorts_IdSource(debug_io_MonitorPorts_IdSource),
    .io_MonitorPorts_IdDestiny(debug_io_MonitorPorts_IdDestiny),
    .io_MonitorPorts_Op(debug_io_MonitorPorts_Op),
    .io_MonitorPorts_Valid(debug_io_MonitorPorts_Valid),
    .io_MonitorPorts_Ready(debug_io_MonitorPorts_Ready)
  );
  Condor2ColibriBridge bridge ( // @[Ottochip.scala 69:25]
    .io_colibriMaster_in_paddr(bridge_io_colibriMaster_in_paddr),
    .io_colibriMaster_in_psize(bridge_io_colibriMaster_in_psize),
    .io_colibriMaster_in_pwdata(bridge_io_colibriMaster_in_pwdata),
    .io_colibriMaster_in_pwrite(bridge_io_colibriMaster_in_pwrite),
    .io_colibriMaster_in_pvalid(bridge_io_colibriMaster_in_pvalid),
    .io_colibriMaster_in_prdata(bridge_io_colibriMaster_in_prdata),
    .io_condorMaster_out_caddr(bridge_io_condorMaster_out_caddr),
    .io_condorMaster_out_cwrite(bridge_io_condorMaster_out_cwrite),
    .io_condorMaster_out_cvalid(bridge_io_condorMaster_out_cvalid),
    .io_condorMaster_out_csize(bridge_io_condorMaster_out_csize),
    .io_condorMaster_out_cwdata(bridge_io_condorMaster_out_cwdata),
    .io_condorMaster_out_crdata(bridge_io_condorMaster_out_crdata)
  );
  uart uart ( // @[Ottochip.scala 73:49]
    .clock(uart_clock),
    .reset(uart_reset),
    .io_rx(uart_io_rx),
    .io_tx_I(uart_io_tx_I),
    .io_condor_caddr(uart_io_condor_caddr),
    .io_condor_cwrite(uart_io_condor_cwrite),
    .io_condor_creq(uart_io_condor_creq),
    .io_condor_cvalid(uart_io_condor_cvalid),
    .io_condor_csel(uart_io_condor_csel),
    .io_condor_csize(uart_io_condor_csize),
    .io_condor_cwdata(uart_io_condor_cwdata),
    .io_condor_crdata(uart_io_condor_crdata),
    .io_dma_pmode(uart_io_dma_pmode),
    .io_dma_addr(uart_io_dma_addr),
    .io_dma_data(uart_io_dma_data),
    .io_dma_we(uart_io_dma_we)
  );
  gpio gpios ( // @[Ottochip.scala 74:49]
    .clock(gpios_clock),
    .reset(gpios_reset),
    .io_condor_caddr(gpios_io_condor_caddr),
    .io_condor_cwrite(gpios_io_condor_cwrite),
    .io_condor_creq(gpios_io_condor_creq),
    .io_condor_cvalid(gpios_io_condor_cvalid),
    .io_condor_csel(gpios_io_condor_csel),
    .io_condor_csize(gpios_io_condor_csize),
    .io_condor_cwdata(gpios_io_condor_cwdata),
    .io_condor_crdata(gpios_io_condor_crdata),
    .io_pads_0_PE(gpios_io_pads_0_PE),
    .io_pads_0_IE(gpios_io_pads_0_IE),
    .io_pads_0_DS(gpios_io_pads_0_DS),
    .io_pads_0_I(gpios_io_pads_0_I),
    .io_pads_0_OEN(gpios_io_pads_0_OEN),
    .io_pads_0_C(gpios_io_pads_0_C),
    .io_pads_1_PE(gpios_io_pads_1_PE),
    .io_pads_1_IE(gpios_io_pads_1_IE),
    .io_pads_1_DS(gpios_io_pads_1_DS),
    .io_pads_1_I(gpios_io_pads_1_I),
    .io_pads_1_OEN(gpios_io_pads_1_OEN),
    .io_pads_1_C(gpios_io_pads_1_C),
    .io_gpio_0_funs_0_I(gpios_io_gpio_0_funs_0_I),
    .io_out_sync_1(gpios_io_out_sync_1)
  );
  timer timer ( // @[Ottochip.scala 75:49]
    .clock(timer_clock),
    .reset(timer_reset),
    .io_condor_caddr(timer_io_condor_caddr),
    .io_condor_cwrite(timer_io_condor_cwrite),
    .io_condor_creq(timer_io_condor_creq),
    .io_condor_cvalid(timer_io_condor_cvalid),
    .io_condor_csel(timer_io_condor_csel),
    .io_condor_csize(timer_io_condor_csize),
    .io_condor_cwdata(timer_io_condor_cwdata),
    .io_condor_crdata(timer_io_condor_crdata)
  );
  Condor_SI_3 regtest1 ( // @[Ottochip.scala 77:33]
    .clock(regtest1_clock),
    .reset(regtest1_reset),
    .io_condor_caddr(regtest1_io_condor_caddr),
    .io_condor_cwrite(regtest1_io_condor_cwrite),
    .io_condor_creq(regtest1_io_condor_creq),
    .io_condor_cvalid(regtest1_io_condor_cvalid),
    .io_condor_csel(regtest1_io_condor_csel),
    .io_condor_csize(regtest1_io_condor_csize),
    .io_condor_cwdata(regtest1_io_condor_cwdata),
    .io_condor_crdata(regtest1_io_condor_crdata)
  );
  Colibri_SI regtest2 ( // @[Ottochip.scala 78:33]
    .clock(regtest2_clock),
    .reset(regtest2_reset),
    .io_colibri_paddr(regtest2_io_colibri_paddr),
    .io_colibri_pwrite(regtest2_io_colibri_pwrite),
    .io_colibri_pwdata(regtest2_io_colibri_pwdata),
    .io_colibri_psel(regtest2_io_colibri_psel),
    .io_colibri_psize(regtest2_io_colibri_psize),
    .io_colibri_prdata(regtest2_io_colibri_prdata)
  );
  ram ram ( // @[Ottochip.scala 79:49]
    .clock(ram_clock),
    .reset(ram_reset),
    .io_condor_caddr(ram_io_condor_caddr),
    .io_condor_cwrite(ram_io_condor_cwrite),
    .io_condor_creq(ram_io_condor_creq),
    .io_condor_cvalid(ram_io_condor_cvalid),
    .io_condor_csel(ram_io_condor_csel),
    .io_condor_csize(ram_io_condor_csize),
    .io_condor_cwdata(ram_io_condor_cwdata),
    .io_condor_creadyout(ram_io_condor_creadyout)
  );
  Arb arbi ( // @[Ottochip.scala 86:25]
    .clock(arbi_clock),
    .reset(arbi_reset),
    .io_M_0_caddr(arbi_io_M_0_caddr),
    .io_M_0_cwrite(arbi_io_M_0_cwrite),
    .io_M_0_creq(arbi_io_M_0_creq),
    .io_M_0_cvalid(arbi_io_M_0_cvalid),
    .io_M_0_csize(arbi_io_M_0_csize),
    .io_M_0_cwdata(arbi_io_M_0_cwdata),
    .io_M_0_crdata(arbi_io_M_0_crdata),
    .io_M_0_cready(arbi_io_M_0_cready),
    .io_M_1_caddr(arbi_io_M_1_caddr),
    .io_M_1_cwrite(arbi_io_M_1_cwrite),
    .io_M_1_creq(arbi_io_M_1_creq),
    .io_M_1_cvalid(arbi_io_M_1_cvalid),
    .io_M_1_csize(arbi_io_M_1_csize),
    .io_M_1_cwdata(arbi_io_M_1_cwdata),
    .io_M_1_crdata(arbi_io_M_1_crdata),
    .io_M_1_cready(arbi_io_M_1_cready),
    .io_M_out_0_caddr(arbi_io_M_out_0_caddr),
    .io_M_out_0_cwrite(arbi_io_M_out_0_cwrite),
    .io_M_out_0_creq(arbi_io_M_out_0_creq),
    .io_M_out_0_cvalid(arbi_io_M_out_0_cvalid),
    .io_M_out_0_csize(arbi_io_M_out_0_csize),
    .io_M_out_0_cwdata(arbi_io_M_out_0_cwdata),
    .io_M_out_0_crdata(arbi_io_M_out_0_crdata),
    .io_M_out_0_cready(arbi_io_M_out_0_cready),
    .io_M_out_1_caddr(arbi_io_M_out_1_caddr),
    .io_M_out_1_cwrite(arbi_io_M_out_1_cwrite),
    .io_M_out_1_creq(arbi_io_M_out_1_creq),
    .io_M_out_1_cvalid(arbi_io_M_out_1_cvalid),
    .io_M_out_1_csize(arbi_io_M_out_1_csize),
    .io_M_out_1_cwdata(arbi_io_M_out_1_cwdata),
    .io_M_out_1_crdata(arbi_io_M_out_1_crdata),
    .io_M_out_1_cready(arbi_io_M_out_1_cready)
  );
  Condor_Bus Condor_Bus ( // @[BusFunc_condor.scala 32:20]
    .clock(Condor_Bus_clock),
    .reset(Condor_Bus_reset),
    .io_Condor_Master_0_caddr(Condor_Bus_io_Condor_Master_0_caddr),
    .io_Condor_Master_0_cwrite(Condor_Bus_io_Condor_Master_0_cwrite),
    .io_Condor_Master_0_creq(Condor_Bus_io_Condor_Master_0_creq),
    .io_Condor_Master_0_cvalid(Condor_Bus_io_Condor_Master_0_cvalid),
    .io_Condor_Master_0_csize(Condor_Bus_io_Condor_Master_0_csize),
    .io_Condor_Master_0_cwdata(Condor_Bus_io_Condor_Master_0_cwdata),
    .io_Condor_Master_0_crdata(Condor_Bus_io_Condor_Master_0_crdata),
    .io_Condor_Master_0_cready(Condor_Bus_io_Condor_Master_0_cready),
    .io_Condor_Master_1_caddr(Condor_Bus_io_Condor_Master_1_caddr),
    .io_Condor_Master_1_cwrite(Condor_Bus_io_Condor_Master_1_cwrite),
    .io_Condor_Master_1_creq(Condor_Bus_io_Condor_Master_1_creq),
    .io_Condor_Master_1_cvalid(Condor_Bus_io_Condor_Master_1_cvalid),
    .io_Condor_Master_1_csize(Condor_Bus_io_Condor_Master_1_csize),
    .io_Condor_Master_1_cwdata(Condor_Bus_io_Condor_Master_1_cwdata),
    .io_Condor_Master_1_crdata(Condor_Bus_io_Condor_Master_1_crdata),
    .io_Condor_Master_1_cready(Condor_Bus_io_Condor_Master_1_cready),
    .io_Condor_Master_2_caddr(Condor_Bus_io_Condor_Master_2_caddr),
    .io_Condor_Master_2_cwrite(Condor_Bus_io_Condor_Master_2_cwrite),
    .io_Condor_Master_2_creq(Condor_Bus_io_Condor_Master_2_creq),
    .io_Condor_Master_2_cvalid(Condor_Bus_io_Condor_Master_2_cvalid),
    .io_Condor_Master_2_csize(Condor_Bus_io_Condor_Master_2_csize),
    .io_Condor_Master_2_cwdata(Condor_Bus_io_Condor_Master_2_cwdata),
    .io_Condor_Master_2_crdata(Condor_Bus_io_Condor_Master_2_crdata),
    .io_Condor_Master_2_cready(Condor_Bus_io_Condor_Master_2_cready),
    .io_Condor_Slave_0_caddr(Condor_Bus_io_Condor_Slave_0_caddr),
    .io_Condor_Slave_0_cwrite(Condor_Bus_io_Condor_Slave_0_cwrite),
    .io_Condor_Slave_0_creq(Condor_Bus_io_Condor_Slave_0_creq),
    .io_Condor_Slave_0_cvalid(Condor_Bus_io_Condor_Slave_0_cvalid),
    .io_Condor_Slave_0_csel(Condor_Bus_io_Condor_Slave_0_csel),
    .io_Condor_Slave_0_csize(Condor_Bus_io_Condor_Slave_0_csize),
    .io_Condor_Slave_0_cwdata(Condor_Bus_io_Condor_Slave_0_cwdata),
    .io_Condor_Slave_0_crdata(Condor_Bus_io_Condor_Slave_0_crdata),
    .io_Condor_Slave_1_caddr(Condor_Bus_io_Condor_Slave_1_caddr),
    .io_Condor_Slave_1_cwrite(Condor_Bus_io_Condor_Slave_1_cwrite),
    .io_Condor_Slave_1_creq(Condor_Bus_io_Condor_Slave_1_creq),
    .io_Condor_Slave_1_cvalid(Condor_Bus_io_Condor_Slave_1_cvalid),
    .io_Condor_Slave_1_csel(Condor_Bus_io_Condor_Slave_1_csel),
    .io_Condor_Slave_1_csize(Condor_Bus_io_Condor_Slave_1_csize),
    .io_Condor_Slave_1_cwdata(Condor_Bus_io_Condor_Slave_1_cwdata),
    .io_Condor_Slave_1_crdata(Condor_Bus_io_Condor_Slave_1_crdata),
    .io_Condor_Slave_2_caddr(Condor_Bus_io_Condor_Slave_2_caddr),
    .io_Condor_Slave_2_cwrite(Condor_Bus_io_Condor_Slave_2_cwrite),
    .io_Condor_Slave_2_creq(Condor_Bus_io_Condor_Slave_2_creq),
    .io_Condor_Slave_2_cvalid(Condor_Bus_io_Condor_Slave_2_cvalid),
    .io_Condor_Slave_2_csel(Condor_Bus_io_Condor_Slave_2_csel),
    .io_Condor_Slave_2_csize(Condor_Bus_io_Condor_Slave_2_csize),
    .io_Condor_Slave_2_cwdata(Condor_Bus_io_Condor_Slave_2_cwdata),
    .io_Condor_Slave_2_crdata(Condor_Bus_io_Condor_Slave_2_crdata),
    .io_Condor_Slave_3_caddr(Condor_Bus_io_Condor_Slave_3_caddr),
    .io_Condor_Slave_3_cwrite(Condor_Bus_io_Condor_Slave_3_cwrite),
    .io_Condor_Slave_3_creq(Condor_Bus_io_Condor_Slave_3_creq),
    .io_Condor_Slave_3_cvalid(Condor_Bus_io_Condor_Slave_3_cvalid),
    .io_Condor_Slave_3_csel(Condor_Bus_io_Condor_Slave_3_csel),
    .io_Condor_Slave_3_csize(Condor_Bus_io_Condor_Slave_3_csize),
    .io_Condor_Slave_3_cwdata(Condor_Bus_io_Condor_Slave_3_cwdata),
    .io_Condor_Slave_3_crdata(Condor_Bus_io_Condor_Slave_3_crdata),
    .io_Condor_Slave_4_caddr(Condor_Bus_io_Condor_Slave_4_caddr),
    .io_Condor_Slave_4_cwrite(Condor_Bus_io_Condor_Slave_4_cwrite),
    .io_Condor_Slave_4_creq(Condor_Bus_io_Condor_Slave_4_creq),
    .io_Condor_Slave_4_cvalid(Condor_Bus_io_Condor_Slave_4_cvalid),
    .io_Condor_Slave_4_csel(Condor_Bus_io_Condor_Slave_4_csel),
    .io_Condor_Slave_4_csize(Condor_Bus_io_Condor_Slave_4_csize),
    .io_Condor_Slave_4_cwdata(Condor_Bus_io_Condor_Slave_4_cwdata),
    .io_Condor_Slave_4_creadyout(Condor_Bus_io_Condor_Slave_4_creadyout),
    .io_Condor_Slave_5_caddr(Condor_Bus_io_Condor_Slave_5_caddr),
    .io_Condor_Slave_5_cwrite(Condor_Bus_io_Condor_Slave_5_cwrite),
    .io_Condor_Slave_5_cvalid(Condor_Bus_io_Condor_Slave_5_cvalid),
    .io_Condor_Slave_5_csize(Condor_Bus_io_Condor_Slave_5_csize),
    .io_Condor_Slave_5_cwdata(Condor_Bus_io_Condor_Slave_5_cwdata),
    .io_Condor_Slave_5_crdata(Condor_Bus_io_Condor_Slave_5_crdata),
    .io_BusMonitor_Data(Condor_Bus_io_BusMonitor_Data),
    .io_BusMonitor_IdSource(Condor_Bus_io_BusMonitor_IdSource),
    .io_BusMonitor_IdDestiny(Condor_Bus_io_BusMonitor_IdDestiny),
    .io_BusMonitor_Op(Condor_Bus_io_BusMonitor_Op),
    .io_BusMonitor_Valid(Condor_Bus_io_BusMonitor_Valid),
    .io_BusMonitor_Ready(Condor_Bus_io_BusMonitor_Ready)
  );
  Colibri_Bus Colibri_Bus ( // @[BusFunc_colibri.scala 27:20]
    .clock(Colibri_Bus_clock),
    .reset(Colibri_Bus_reset),
    .io_Colibri_Master_0_paddr(Colibri_Bus_io_Colibri_Master_0_paddr),
    .io_Colibri_Master_0_psize(Colibri_Bus_io_Colibri_Master_0_psize),
    .io_Colibri_Master_0_pwdata(Colibri_Bus_io_Colibri_Master_0_pwdata),
    .io_Colibri_Master_0_pwrite(Colibri_Bus_io_Colibri_Master_0_pwrite),
    .io_Colibri_Master_0_pvalid(Colibri_Bus_io_Colibri_Master_0_pvalid),
    .io_Colibri_Master_0_prdata(Colibri_Bus_io_Colibri_Master_0_prdata),
    .io_Colibri_Slave_0_paddr(Colibri_Bus_io_Colibri_Slave_0_paddr),
    .io_Colibri_Slave_0_pwrite(Colibri_Bus_io_Colibri_Slave_0_pwrite),
    .io_Colibri_Slave_0_pwdata(Colibri_Bus_io_Colibri_Slave_0_pwdata),
    .io_Colibri_Slave_0_psel(Colibri_Bus_io_Colibri_Slave_0_psel),
    .io_Colibri_Slave_0_psize(Colibri_Bus_io_Colibri_Slave_0_psize),
    .io_Colibri_Slave_0_prdata(Colibri_Bus_io_Colibri_Slave_0_prdata)
  );
  assign io_pads_0_PE = debug_io_pins_PinCTRL_IO_0_PE; // @[Ottochip.scala 132:28]
  assign io_pads_0_IE = debug_io_pins_PinCTRL_IO_0_IE; // @[Ottochip.scala 132:28]
  assign io_pads_0_DS = debug_io_pins_PinCTRL_IO_0_DS; // @[Ottochip.scala 132:28]
  assign io_pads_0_I = debug_io_pins_PinCTRL_IO_0_I; // @[Ottochip.scala 132:28]
  assign io_pads_0_OEN = debug_io_pins_PinCTRL_IO_0_OEN; // @[Ottochip.scala 132:28]
  assign io_pads_1_PE = debug_io_pins_PinCTRL_IO_1_PE; // @[Ottochip.scala 132:28]
  assign io_pads_1_IE = debug_io_pins_PinCTRL_IO_1_IE; // @[Ottochip.scala 132:28]
  assign io_pads_1_DS = debug_io_pins_PinCTRL_IO_1_DS; // @[Ottochip.scala 132:28]
  assign io_pads_1_I = debug_io_pins_PinCTRL_IO_1_I; // @[Ottochip.scala 132:28]
  assign io_pads_1_OEN = debug_io_pins_PinCTRL_IO_1_OEN; // @[Ottochip.scala 132:28]
  assign io_pads_6_I = debug_io_pins_ext_TDO_I; // @[Ottochip.scala 143:31]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_condor_crdata = arbi_io_M_1_crdata; // @[Ottochip.scala 88:22]
  assign core_io_condor_cready = arbi_io_M_1_cready; // @[Ottochip.scala 88:22]
  assign core_io_IF_condor_crdata = arbi_io_M_0_crdata; // @[Ottochip.scala 87:22]
  assign core_io_IF_condor_cready = arbi_io_M_0_cready; // @[Ottochip.scala 87:22]
  assign core_io_dma_pmode = uart_io_dma_pmode; // @[Ottochip.scala 117:21]
  assign core_io_dma_addr = uart_io_dma_addr; // @[Ottochip.scala 117:21]
  assign core_io_dma_data = uart_io_dma_data; // @[Ottochip.scala 117:21]
  assign core_io_dma_we = uart_io_dma_we; // @[Ottochip.scala 117:21]
  assign core_io_debug_progBuffAc_data_r = debug_io_Dm_Output_debug_progBuffAc_data_r; // @[Ottochip.scala 62:23]
  assign core_io_debug_progBuffAc_IF_data_r = debug_io_Dm_Output_debug_progBuffAc_IF_data_r; // @[Ottochip.scala 62:23]
  assign core_io_debug_nPB_rst = debug_io_Dm_Output_debug_nPB_rst; // @[Ottochip.scala 62:23]
  assign core_io_debug_nPB_halt = debug_io_Dm_Output_debug_nPB_halt; // @[Ottochip.scala 62:23]
  assign core_io_debug_nPB_RegsAc_we = debug_io_Dm_Output_debug_nPB_RegsAc_we; // @[Ottochip.scala 62:23]
  assign core_io_debug_nPB_RegsAc_reg_addr = debug_io_Dm_Output_debug_nPB_RegsAc_reg_addr; // @[Ottochip.scala 62:23]
  assign core_io_debug_nPB_RegsAc_data_w = debug_io_Dm_Output_debug_nPB_RegsAc_data_w; // @[Ottochip.scala 62:23]
  assign core_io_debug_nPB_interruption = debug_io_Dm_Output_debug_nPB_interruption; // @[Ottochip.scala 62:23]
  assign debug_clock = clock;
  assign debug_reset = reset;
  assign debug_io_pins_ext_TMS_C = io_pads_3_C; // @[Ottochip.scala 140:31]
  assign debug_io_pins_ext_TCK_C = io_pads_2_C; // @[Ottochip.scala 139:28]
  assign debug_io_pins_ext_TDI_C = io_pads_4_C; // @[Ottochip.scala 141:31]
  assign debug_io_pins_ext_TRSTn_C = io_pads_5_C; // @[Ottochip.scala 142:31]
  assign debug_io_pins_PinCTRL_CORE_0_PE = gpios_io_pads_0_PE; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_0_IE = gpios_io_pads_0_IE; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_0_DS = gpios_io_pads_0_DS; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_0_I = gpios_io_pads_0_I; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_0_OEN = gpios_io_pads_0_OEN; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_1_PE = gpios_io_pads_1_PE; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_1_IE = gpios_io_pads_1_IE; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_1_DS = gpios_io_pads_1_DS; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_1_I = gpios_io_pads_1_I; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_CORE_1_OEN = gpios_io_pads_1_OEN; // @[Ottochip.scala 131:47]
  assign debug_io_pins_PinCTRL_IO_0_C = io_pads_0_C; // @[Ottochip.scala 132:28]
  assign debug_io_pins_PinCTRL_IO_1_C = io_pads_1_C; // @[Ottochip.scala 132:28]
  assign debug_io_Dm_Output_debug_progBuffAc_we = core_io_debug_progBuffAc_we; // @[Ottochip.scala 62:23]
  assign debug_io_Dm_Output_debug_progBuffAc_data_w = core_io_debug_progBuffAc_data_w; // @[Ottochip.scala 62:23]
  assign debug_io_Dm_Output_debug_progBuffAc_addr_wr = core_io_debug_progBuffAc_addr_wr; // @[Ottochip.scala 62:23]
  assign debug_io_Dm_Output_debug_progBuffAc_IF_addr = core_io_debug_progBuffAc_IF_addr; // @[Ottochip.scala 62:23]
  assign debug_io_Dm_Output_debug_nPB_RegsAc_data_r = core_io_debug_nPB_RegsAc_data_r; // @[Ottochip.scala 62:23]
  assign debug_io_Dm_Output_debug_nPB_breakpoint = core_io_debug_nPB_breakpoint; // @[Ottochip.scala 62:23]
  assign debug_io_SBA_AHB_crdata = Condor_Bus_io_Condor_Master_2_crdata; // @[BusFunc_condor.scala 45:22]
  assign debug_io_SBA_AHB_cready = Condor_Bus_io_Condor_Master_2_cready; // @[BusFunc_condor.scala 46:22]
  assign debug_io_MonitorPorts_Data = Condor_Bus_io_BusMonitor_Data; // @[BusFunc_condor.scala 69:21]
  assign debug_io_MonitorPorts_IdSource = Condor_Bus_io_BusMonitor_IdSource[0]; // @[BusFunc_condor.scala 70:21]
  assign debug_io_MonitorPorts_IdDestiny = Condor_Bus_io_BusMonitor_IdDestiny; // @[BusFunc_condor.scala 71:21]
  assign debug_io_MonitorPorts_Op = Condor_Bus_io_BusMonitor_Op; // @[BusFunc_condor.scala 72:21]
  assign debug_io_MonitorPorts_Valid = Condor_Bus_io_BusMonitor_Valid; // @[BusFunc_condor.scala 73:21]
  assign debug_io_MonitorPorts_Ready = Condor_Bus_io_BusMonitor_Ready; // @[BusFunc_condor.scala 74:21]
  assign bridge_io_colibriMaster_in_prdata = Colibri_Bus_io_Colibri_Master_0_prdata; // @[BusFunc_colibri.scala 38:19]
  assign bridge_io_condorMaster_out_caddr = Condor_Bus_io_Condor_Slave_5_caddr; // @[BusFunc_condor.scala 50:22]
  assign bridge_io_condorMaster_out_cwrite = Condor_Bus_io_Condor_Slave_5_cwrite; // @[BusFunc_condor.scala 59:22]
  assign bridge_io_condorMaster_out_cvalid = Condor_Bus_io_Condor_Slave_5_cvalid; // @[BusFunc_condor.scala 60:22]
  assign bridge_io_condorMaster_out_csize = Condor_Bus_io_Condor_Slave_5_csize; // @[BusFunc_condor.scala 55:22]
  assign bridge_io_condorMaster_out_cwdata = Condor_Bus_io_Condor_Slave_5_cwdata; // @[BusFunc_condor.scala 58:22]
  assign uart_clock = clock;
  assign uart_reset = reset;
  assign uart_io_rx = gpios_io_out_sync_1; // @[Ottochip.scala 125:19]
  assign uart_io_condor_caddr = Condor_Bus_io_Condor_Slave_0_caddr; // @[BusFunc_condor.scala 50:22]
  assign uart_io_condor_cwrite = Condor_Bus_io_Condor_Slave_0_cwrite; // @[BusFunc_condor.scala 59:22]
  assign uart_io_condor_creq = Condor_Bus_io_Condor_Slave_0_creq; // @[BusFunc_condor.scala 52:22]
  assign uart_io_condor_cvalid = Condor_Bus_io_Condor_Slave_0_cvalid; // @[BusFunc_condor.scala 60:22]
  assign uart_io_condor_csel = Condor_Bus_io_Condor_Slave_0_csel; // @[BusFunc_condor.scala 56:22]
  assign uart_io_condor_csize = Condor_Bus_io_Condor_Slave_0_csize; // @[BusFunc_condor.scala 55:22]
  assign uart_io_condor_cwdata = Condor_Bus_io_Condor_Slave_0_cwdata; // @[BusFunc_condor.scala 58:22]
  assign gpios_clock = clock;
  assign gpios_reset = reset;
  assign gpios_io_condor_caddr = Condor_Bus_io_Condor_Slave_1_caddr; // @[BusFunc_condor.scala 50:22]
  assign gpios_io_condor_cwrite = Condor_Bus_io_Condor_Slave_1_cwrite; // @[BusFunc_condor.scala 59:22]
  assign gpios_io_condor_creq = Condor_Bus_io_Condor_Slave_1_creq; // @[BusFunc_condor.scala 52:22]
  assign gpios_io_condor_cvalid = Condor_Bus_io_Condor_Slave_1_cvalid; // @[BusFunc_condor.scala 60:22]
  assign gpios_io_condor_csel = Condor_Bus_io_Condor_Slave_1_csel; // @[BusFunc_condor.scala 56:22]
  assign gpios_io_condor_csize = Condor_Bus_io_Condor_Slave_1_csize; // @[BusFunc_condor.scala 55:22]
  assign gpios_io_condor_cwdata = Condor_Bus_io_Condor_Slave_1_cwdata; // @[BusFunc_condor.scala 58:22]
  assign gpios_io_pads_0_C = debug_io_pins_PinCTRL_CORE_0_C; // @[Ottochip.scala 131:47]
  assign gpios_io_pads_1_C = debug_io_pins_PinCTRL_CORE_1_C; // @[Ottochip.scala 131:47]
  assign gpios_io_gpio_0_funs_0_I = uart_io_tx_I; // @[Ottochip.scala 122:34]
  assign timer_clock = clock;
  assign timer_reset = reset;
  assign timer_io_condor_caddr = Condor_Bus_io_Condor_Slave_2_caddr; // @[BusFunc_condor.scala 50:22]
  assign timer_io_condor_cwrite = Condor_Bus_io_Condor_Slave_2_cwrite; // @[BusFunc_condor.scala 59:22]
  assign timer_io_condor_creq = Condor_Bus_io_Condor_Slave_2_creq; // @[BusFunc_condor.scala 52:22]
  assign timer_io_condor_cvalid = Condor_Bus_io_Condor_Slave_2_cvalid; // @[BusFunc_condor.scala 60:22]
  assign timer_io_condor_csel = Condor_Bus_io_Condor_Slave_2_csel; // @[BusFunc_condor.scala 56:22]
  assign timer_io_condor_csize = Condor_Bus_io_Condor_Slave_2_csize; // @[BusFunc_condor.scala 55:22]
  assign timer_io_condor_cwdata = Condor_Bus_io_Condor_Slave_2_cwdata; // @[BusFunc_condor.scala 58:22]
  assign regtest1_clock = clock;
  assign regtest1_reset = reset;
  assign regtest1_io_condor_caddr = Condor_Bus_io_Condor_Slave_3_caddr; // @[BusFunc_condor.scala 50:22]
  assign regtest1_io_condor_cwrite = Condor_Bus_io_Condor_Slave_3_cwrite; // @[BusFunc_condor.scala 59:22]
  assign regtest1_io_condor_creq = Condor_Bus_io_Condor_Slave_3_creq; // @[BusFunc_condor.scala 52:22]
  assign regtest1_io_condor_cvalid = Condor_Bus_io_Condor_Slave_3_cvalid; // @[BusFunc_condor.scala 60:22]
  assign regtest1_io_condor_csel = Condor_Bus_io_Condor_Slave_3_csel; // @[BusFunc_condor.scala 56:22]
  assign regtest1_io_condor_csize = Condor_Bus_io_Condor_Slave_3_csize; // @[BusFunc_condor.scala 55:22]
  assign regtest1_io_condor_cwdata = Condor_Bus_io_Condor_Slave_3_cwdata; // @[BusFunc_condor.scala 58:22]
  assign regtest2_clock = clock;
  assign regtest2_reset = reset;
  assign regtest2_io_colibri_paddr = Colibri_Bus_io_Colibri_Slave_0_paddr; // @[BusFunc_colibri.scala 43:21]
  assign regtest2_io_colibri_pwrite = Colibri_Bus_io_Colibri_Slave_0_pwrite; // @[BusFunc_colibri.scala 44:21]
  assign regtest2_io_colibri_pwdata = Colibri_Bus_io_Colibri_Slave_0_pwdata; // @[BusFunc_colibri.scala 46:21]
  assign regtest2_io_colibri_psel = Colibri_Bus_io_Colibri_Slave_0_psel; // @[BusFunc_colibri.scala 45:21]
  assign regtest2_io_colibri_psize = Colibri_Bus_io_Colibri_Slave_0_psize; // @[BusFunc_colibri.scala 47:21]
  assign ram_clock = clock;
  assign ram_reset = reset;
  assign ram_io_condor_caddr = Condor_Bus_io_Condor_Slave_4_caddr; // @[BusFunc_condor.scala 50:22]
  assign ram_io_condor_cwrite = Condor_Bus_io_Condor_Slave_4_cwrite; // @[BusFunc_condor.scala 59:22]
  assign ram_io_condor_creq = Condor_Bus_io_Condor_Slave_4_creq; // @[BusFunc_condor.scala 52:22]
  assign ram_io_condor_cvalid = Condor_Bus_io_Condor_Slave_4_cvalid; // @[BusFunc_condor.scala 60:22]
  assign ram_io_condor_csel = Condor_Bus_io_Condor_Slave_4_csel; // @[BusFunc_condor.scala 56:22]
  assign ram_io_condor_csize = Condor_Bus_io_Condor_Slave_4_csize; // @[BusFunc_condor.scala 55:22]
  assign ram_io_condor_cwdata = Condor_Bus_io_Condor_Slave_4_cwdata; // @[BusFunc_condor.scala 58:22]
  assign arbi_clock = clock;
  assign arbi_reset = reset;
  assign arbi_io_M_0_caddr = core_io_IF_condor_caddr; // @[Ottochip.scala 87:22]
  assign arbi_io_M_0_cwrite = core_io_IF_condor_cwrite; // @[Ottochip.scala 87:22]
  assign arbi_io_M_0_creq = core_io_IF_condor_creq; // @[Ottochip.scala 87:22]
  assign arbi_io_M_0_cvalid = core_io_IF_condor_cvalid; // @[Ottochip.scala 87:22]
  assign arbi_io_M_0_csize = core_io_IF_condor_csize; // @[Ottochip.scala 87:22]
  assign arbi_io_M_0_cwdata = core_io_IF_condor_cwdata; // @[Ottochip.scala 87:22]
  assign arbi_io_M_1_caddr = core_io_condor_caddr; // @[Ottochip.scala 88:22]
  assign arbi_io_M_1_cwrite = core_io_condor_cwrite; // @[Ottochip.scala 88:22]
  assign arbi_io_M_1_creq = core_io_condor_creq; // @[Ottochip.scala 88:22]
  assign arbi_io_M_1_cvalid = core_io_condor_cvalid; // @[Ottochip.scala 88:22]
  assign arbi_io_M_1_csize = core_io_condor_csize; // @[Ottochip.scala 88:22]
  assign arbi_io_M_1_cwdata = core_io_condor_cwdata; // @[Ottochip.scala 88:22]
  assign arbi_io_M_out_0_crdata = Condor_Bus_io_Condor_Master_0_crdata; // @[BusFunc_condor.scala 45:22]
  assign arbi_io_M_out_0_cready = Condor_Bus_io_Condor_Master_0_cready; // @[BusFunc_condor.scala 46:22]
  assign arbi_io_M_out_1_crdata = Condor_Bus_io_Condor_Master_1_crdata; // @[BusFunc_condor.scala 45:22]
  assign arbi_io_M_out_1_cready = Condor_Bus_io_Condor_Master_1_cready; // @[BusFunc_condor.scala 46:22]
  assign Condor_Bus_clock = clock;
  assign Condor_Bus_reset = reset;
  assign Condor_Bus_io_Condor_Master_0_caddr = arbi_io_M_out_0_caddr; // @[BusFunc_condor.scala 35:19]
  assign Condor_Bus_io_Condor_Master_0_cwrite = arbi_io_M_out_0_cwrite; // @[BusFunc_condor.scala 42:19]
  assign Condor_Bus_io_Condor_Master_0_creq = arbi_io_M_out_0_creq; // @[BusFunc_condor.scala 37:19]
  assign Condor_Bus_io_Condor_Master_0_cvalid = arbi_io_M_out_0_cvalid; // @[BusFunc_condor.scala 43:19]
  assign Condor_Bus_io_Condor_Master_0_csize = arbi_io_M_out_0_csize; // @[BusFunc_condor.scala 39:19]
  assign Condor_Bus_io_Condor_Master_0_cwdata = arbi_io_M_out_0_cwdata; // @[BusFunc_condor.scala 41:19]
  assign Condor_Bus_io_Condor_Master_1_caddr = arbi_io_M_out_1_caddr; // @[BusFunc_condor.scala 35:19]
  assign Condor_Bus_io_Condor_Master_1_cwrite = arbi_io_M_out_1_cwrite; // @[BusFunc_condor.scala 42:19]
  assign Condor_Bus_io_Condor_Master_1_creq = arbi_io_M_out_1_creq; // @[BusFunc_condor.scala 37:19]
  assign Condor_Bus_io_Condor_Master_1_cvalid = arbi_io_M_out_1_cvalid; // @[BusFunc_condor.scala 43:19]
  assign Condor_Bus_io_Condor_Master_1_csize = arbi_io_M_out_1_csize; // @[BusFunc_condor.scala 39:19]
  assign Condor_Bus_io_Condor_Master_1_cwdata = arbi_io_M_out_1_cwdata; // @[BusFunc_condor.scala 41:19]
  assign Condor_Bus_io_Condor_Master_2_caddr = debug_io_SBA_AHB_caddr; // @[BusFunc_condor.scala 35:19]
  assign Condor_Bus_io_Condor_Master_2_cwrite = debug_io_SBA_AHB_cwrite; // @[BusFunc_condor.scala 42:19]
  assign Condor_Bus_io_Condor_Master_2_creq = debug_io_SBA_AHB_creq; // @[BusFunc_condor.scala 37:19]
  assign Condor_Bus_io_Condor_Master_2_cvalid = debug_io_SBA_AHB_cvalid; // @[BusFunc_condor.scala 43:19]
  assign Condor_Bus_io_Condor_Master_2_csize = debug_io_SBA_AHB_csize; // @[BusFunc_condor.scala 39:19]
  assign Condor_Bus_io_Condor_Master_2_cwdata = debug_io_SBA_AHB_cwdata; // @[BusFunc_condor.scala 41:19]
  assign Condor_Bus_io_Condor_Slave_0_crdata = uart_io_condor_crdata; // @[BusFunc_condor.scala 62:22]
  assign Condor_Bus_io_Condor_Slave_1_crdata = gpios_io_condor_crdata; // @[BusFunc_condor.scala 62:22]
  assign Condor_Bus_io_Condor_Slave_2_crdata = timer_io_condor_crdata; // @[BusFunc_condor.scala 62:22]
  assign Condor_Bus_io_Condor_Slave_3_crdata = regtest1_io_condor_crdata; // @[BusFunc_condor.scala 62:22]
  assign Condor_Bus_io_Condor_Slave_4_creadyout = ram_io_condor_creadyout; // @[BusFunc_condor.scala 63:22]
  assign Condor_Bus_io_Condor_Slave_5_crdata = bridge_io_condorMaster_out_crdata; // @[BusFunc_condor.scala 62:22]
  assign Colibri_Bus_clock = clock;
  assign Colibri_Bus_reset = reset;
  assign Colibri_Bus_io_Colibri_Master_0_paddr = bridge_io_colibriMaster_in_paddr; // @[BusFunc_colibri.scala 30:19]
  assign Colibri_Bus_io_Colibri_Master_0_psize = bridge_io_colibriMaster_in_psize; // @[BusFunc_colibri.scala 35:19]
  assign Colibri_Bus_io_Colibri_Master_0_pwdata = bridge_io_colibriMaster_in_pwdata; // @[BusFunc_colibri.scala 36:19]
  assign Colibri_Bus_io_Colibri_Master_0_pwrite = bridge_io_colibriMaster_in_pwrite; // @[BusFunc_colibri.scala 32:19]
  assign Colibri_Bus_io_Colibri_Master_0_pvalid = bridge_io_colibriMaster_in_pvalid; // @[BusFunc_colibri.scala 33:19]
  assign Colibri_Bus_io_Colibri_Slave_0_prdata = regtest2_io_colibri_prdata; // @[BusFunc_colibri.scala 49:19]
endmodule
module Ottochip(
  input   clock,
  input   reset,
  inout   io_pad_0,
  inout   io_pad_1,
  inout   io_pad_2,
  inout   io_pad_3,
  inout   io_pad_4,
  inout   io_pad_5,
  inout   io_pad_6
);
  wire  Ottochip_nopads_clock; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_reset; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_0_PE; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_0_IE; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_0_DS; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_0_I; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_0_OEN; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_0_C; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_1_PE; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_1_IE; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_1_DS; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_1_I; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_1_OEN; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_1_C; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_2_C; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_3_C; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_4_C; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_5_C; // @[Ottochip.scala 153:37]
  wire  Ottochip_nopads_io_pads_6_I; // @[Ottochip.scala 153:37]
  wire  gpio_pad_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_gpio_port_C; // @[Ottochip.scala 158:50]
  wire  gpio_pad_1_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_1_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_1_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_1_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_1_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_1_gpio_port_C; // @[Ottochip.scala 158:50]
  wire  gpio_pad_2_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_2_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_2_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_2_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_2_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_2_gpio_port_C; // @[Ottochip.scala 158:50]
  wire  gpio_pad_3_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_3_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_3_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_3_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_3_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_3_gpio_port_C; // @[Ottochip.scala 158:50]
  wire  gpio_pad_4_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_4_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_4_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_4_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_4_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_4_gpio_port_C; // @[Ottochip.scala 158:50]
  wire  gpio_pad_5_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_5_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_5_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_5_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_5_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_5_gpio_port_C; // @[Ottochip.scala 158:50]
  wire  gpio_pad_6_gpio_port_PE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_6_gpio_port_IE; // @[Ottochip.scala 158:50]
  wire  gpio_pad_6_gpio_port_DS; // @[Ottochip.scala 158:50]
  wire  gpio_pad_6_gpio_port_I; // @[Ottochip.scala 158:50]
  wire  gpio_pad_6_gpio_port_OEN; // @[Ottochip.scala 158:50]
  wire  gpio_pad_6_gpio_port_C; // @[Ottochip.scala 158:50]
  Ottochip_nopads Ottochip_nopads ( // @[Ottochip.scala 153:37]
    .clock(Ottochip_nopads_clock),
    .reset(Ottochip_nopads_reset),
    .io_pads_0_PE(Ottochip_nopads_io_pads_0_PE),
    .io_pads_0_IE(Ottochip_nopads_io_pads_0_IE),
    .io_pads_0_DS(Ottochip_nopads_io_pads_0_DS),
    .io_pads_0_I(Ottochip_nopads_io_pads_0_I),
    .io_pads_0_OEN(Ottochip_nopads_io_pads_0_OEN),
    .io_pads_0_C(Ottochip_nopads_io_pads_0_C),
    .io_pads_1_PE(Ottochip_nopads_io_pads_1_PE),
    .io_pads_1_IE(Ottochip_nopads_io_pads_1_IE),
    .io_pads_1_DS(Ottochip_nopads_io_pads_1_DS),
    .io_pads_1_I(Ottochip_nopads_io_pads_1_I),
    .io_pads_1_OEN(Ottochip_nopads_io_pads_1_OEN),
    .io_pads_1_C(Ottochip_nopads_io_pads_1_C),
    .io_pads_2_C(Ottochip_nopads_io_pads_2_C),
    .io_pads_3_C(Ottochip_nopads_io_pads_3_C),
    .io_pads_4_C(Ottochip_nopads_io_pads_4_C),
    .io_pads_5_C(Ottochip_nopads_io_pads_5_C),
    .io_pads_6_I(Ottochip_nopads_io_pads_6_I)
  );
  gpio_pad gpio_pad ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_gpio_port_PE),
    .gpio_port_IE(gpio_pad_gpio_port_IE),
    .gpio_port_DS(gpio_pad_gpio_port_DS),
    .gpio_port_I(gpio_pad_gpio_port_I),
    .gpio_port_OEN(gpio_pad_gpio_port_OEN),
    .gpio_port_C(gpio_pad_gpio_port_C),
    .PAD(io_pad_0)
  );
  gpio_pad gpio_pad_1 ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_1_gpio_port_PE),
    .gpio_port_IE(gpio_pad_1_gpio_port_IE),
    .gpio_port_DS(gpio_pad_1_gpio_port_DS),
    .gpio_port_I(gpio_pad_1_gpio_port_I),
    .gpio_port_OEN(gpio_pad_1_gpio_port_OEN),
    .gpio_port_C(gpio_pad_1_gpio_port_C),
    .PAD(io_pad_1)
  );
  gpio_pad gpio_pad_2 ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_2_gpio_port_PE),
    .gpio_port_IE(gpio_pad_2_gpio_port_IE),
    .gpio_port_DS(gpio_pad_2_gpio_port_DS),
    .gpio_port_I(gpio_pad_2_gpio_port_I),
    .gpio_port_OEN(gpio_pad_2_gpio_port_OEN),
    .gpio_port_C(gpio_pad_2_gpio_port_C),
    .PAD(io_pad_2)
  );
  gpio_pad gpio_pad_3 ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_3_gpio_port_PE),
    .gpio_port_IE(gpio_pad_3_gpio_port_IE),
    .gpio_port_DS(gpio_pad_3_gpio_port_DS),
    .gpio_port_I(gpio_pad_3_gpio_port_I),
    .gpio_port_OEN(gpio_pad_3_gpio_port_OEN),
    .gpio_port_C(gpio_pad_3_gpio_port_C),
    .PAD(io_pad_3)
  );
  gpio_pad gpio_pad_4 ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_4_gpio_port_PE),
    .gpio_port_IE(gpio_pad_4_gpio_port_IE),
    .gpio_port_DS(gpio_pad_4_gpio_port_DS),
    .gpio_port_I(gpio_pad_4_gpio_port_I),
    .gpio_port_OEN(gpio_pad_4_gpio_port_OEN),
    .gpio_port_C(gpio_pad_4_gpio_port_C),
    .PAD(io_pad_4)
  );
  gpio_pad gpio_pad_5 ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_5_gpio_port_PE),
    .gpio_port_IE(gpio_pad_5_gpio_port_IE),
    .gpio_port_DS(gpio_pad_5_gpio_port_DS),
    .gpio_port_I(gpio_pad_5_gpio_port_I),
    .gpio_port_OEN(gpio_pad_5_gpio_port_OEN),
    .gpio_port_C(gpio_pad_5_gpio_port_C),
    .PAD(io_pad_5)
  );
  gpio_pad gpio_pad_6 ( // @[Ottochip.scala 158:50]
    .gpio_port_PE(gpio_pad_6_gpio_port_PE),
    .gpio_port_IE(gpio_pad_6_gpio_port_IE),
    .gpio_port_DS(gpio_pad_6_gpio_port_DS),
    .gpio_port_I(gpio_pad_6_gpio_port_I),
    .gpio_port_OEN(gpio_pad_6_gpio_port_OEN),
    .gpio_port_C(gpio_pad_6_gpio_port_C),
    .PAD(io_pad_6)
  );
  assign Ottochip_nopads_clock = clock;
  assign Ottochip_nopads_reset = reset;
  assign Ottochip_nopads_io_pads_0_C = gpio_pad_gpio_port_C; // @[Ottochip.scala 163:35]
  assign Ottochip_nopads_io_pads_1_C = gpio_pad_1_gpio_port_C; // @[Ottochip.scala 163:35]
  assign Ottochip_nopads_io_pads_2_C = gpio_pad_2_gpio_port_C; // @[Ottochip.scala 163:35]
  assign Ottochip_nopads_io_pads_3_C = gpio_pad_3_gpio_port_C; // @[Ottochip.scala 163:35]
  assign Ottochip_nopads_io_pads_4_C = gpio_pad_4_gpio_port_C; // @[Ottochip.scala 163:35]
  assign Ottochip_nopads_io_pads_5_C = gpio_pad_5_gpio_port_C; // @[Ottochip.scala 163:35]
  assign gpio_pad_gpio_port_PE = Ottochip_nopads_io_pads_0_PE; // @[Ottochip.scala 163:35]
  assign gpio_pad_gpio_port_IE = Ottochip_nopads_io_pads_0_IE; // @[Ottochip.scala 163:35]
  assign gpio_pad_gpio_port_DS = Ottochip_nopads_io_pads_0_DS; // @[Ottochip.scala 163:35]
  assign gpio_pad_gpio_port_I = Ottochip_nopads_io_pads_0_I; // @[Ottochip.scala 163:35]
  assign gpio_pad_gpio_port_OEN = Ottochip_nopads_io_pads_0_OEN; // @[Ottochip.scala 163:35]
  assign gpio_pad_1_gpio_port_PE = Ottochip_nopads_io_pads_1_PE; // @[Ottochip.scala 163:35]
  assign gpio_pad_1_gpio_port_IE = Ottochip_nopads_io_pads_1_IE; // @[Ottochip.scala 163:35]
  assign gpio_pad_1_gpio_port_DS = Ottochip_nopads_io_pads_1_DS; // @[Ottochip.scala 163:35]
  assign gpio_pad_1_gpio_port_I = Ottochip_nopads_io_pads_1_I; // @[Ottochip.scala 163:35]
  assign gpio_pad_1_gpio_port_OEN = Ottochip_nopads_io_pads_1_OEN; // @[Ottochip.scala 163:35]
  assign gpio_pad_2_gpio_port_PE = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_2_gpio_port_IE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_2_gpio_port_DS = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_2_gpio_port_I = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_2_gpio_port_OEN = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_3_gpio_port_PE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_3_gpio_port_IE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_3_gpio_port_DS = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_3_gpio_port_I = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_3_gpio_port_OEN = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_4_gpio_port_PE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_4_gpio_port_IE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_4_gpio_port_DS = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_4_gpio_port_I = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_4_gpio_port_OEN = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_5_gpio_port_PE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_5_gpio_port_IE = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_5_gpio_port_DS = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_5_gpio_port_I = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_5_gpio_port_OEN = 1'h1; // @[Ottochip.scala 163:35]
  assign gpio_pad_6_gpio_port_PE = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_6_gpio_port_IE = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_6_gpio_port_DS = 1'h0; // @[Ottochip.scala 163:35]
  assign gpio_pad_6_gpio_port_I = Ottochip_nopads_io_pads_6_I; // @[Ottochip.scala 163:35]
  assign gpio_pad_6_gpio_port_OEN = 1'h0; // @[Ottochip.scala 163:35]
endmodule
