//========================================================================
// Standard Cells
//========================================================================
// We use ifndef SYNTHESIS so that when we push the design through the
// flow the synthesis tool will use the real standard cells from the
// standard cell library instead of these behavior models.

`ifndef TUT3_VERILOG_REGINCR_STDCELLS_V
`define TUT3_VERILOG_REGINCR_STDCELLS_V

`ifndef SYNTHESIS

//------------------------------------------------------------------------
// LOGIC0_X1
//------------------------------------------------------------------------

module LOGIC0_X1
(
  output logic Z
);

  assign Z = 0;

endmodule

//------------------------------------------------------------------------
// LOGIC1_X1
//------------------------------------------------------------------------

module LOGIC1_X1
(
  output logic Z
);

  assign Z = 1;

endmodule

//------------------------------------------------------------------------
// INV_X1
//------------------------------------------------------------------------

module INV_X1
(
  input  logic A,
  output logic ZN
);

  assign ZN = ~A;

endmodule

//------------------------------------------------------------------------
// DFFR_X1
//------------------------------------------------------------------------

module DFFR_X1
(
  input  logic D,
  input  logic RN,
  input  logic CK,
  output logic Q,
  output logic QN
);

  always @(posedge CK) begin
    if ( ~RN ) begin
      Q  <= 0;
      QN <= 1;
    end
    else begin
      Q  <= D;
      QN <= ~D;
    end
  end

endmodule

//------------------------------------------------------------------------
// FA_X1
//------------------------------------------------------------------------

module FA_X1
(
  input  logic A,
  input  logic B,
  input  logic CI,
  output logic CO,
  output logic S
);

  assign S  = A ^ B ^ CI;
  assign CO = (A & B) | (B & CI) | (A & CI);

endmodule

`endif

`endif /* TUT3_VERILOG_REGINCR_STDCELLS_V */

