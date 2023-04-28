//========================================================================
// Registered Incrementer
//========================================================================
// This is a simple example of a module for a registered incrementer
// which combines a positive edge triggered register with a combinational
// +2 incrementer. We use flat register-transfer-level modeling.

`ifndef TUT3_VERILOG_REGINCR_REG_INCR_V
`define TUT3_VERILOG_REGINCR_REG_INCR_V

`include "vc/trace.v"
`include "tut3_verilog/regincr/stdcells.v"

//------------------------------------------------------------------------
// RegIncrGL
//------------------------------------------------------------------------

module tut3_verilog_regincr_RegIncrGL
(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] in_,
  output logic [7:0] out
);

  // Invert reset signal

  logic reset_bar;

  INV_X1 inv
  (
    .A  (reset),
    .ZN (reset_bar)
  );

  // Gate-level bit-sliced implementation

  logic [7:0] reg_out;
  logic [7:0] reg_out_bar;
  logic [7:0] const_1;
  logic [8:0] carry;

  LOGIC0_X1 cin0( .Z (carry[0]) );

  genvar i;
  generate
  for ( i = 0; i < 8; i = i + 1 ) begin: gen

    DFFR_X1 dffr
    (
      .D  (in_[i]),
      .RN (reset_bar),
      .CK (clk),
      .Q  (reg_out[i]),
      .QN (reg_out_bar[i])
    );

    if ( i == 0 )
      LOGIC1_X1 logic_( .Z (const_1[i]) );
    else
      LOGIC0_X1 logic_( .Z (const_1[i]) );

    FA_X1 fa
    (
      .A  (reg_out[i]),
      .B  (const_1[i]),
      .CI (carry[i]),
      .CO (carry[i+1]),
      .S  (out[i])
    );

  end
  endgenerate

  `ifndef SYNTHESIS

  logic [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin
    $sformat( str, "%x (%x) %x", in_, reg_out, out );
    vc_trace.append_str( trace_str, str );
  end
  `VC_TRACE_END

  `endif /* SYNTHESIS */

  // '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''/\

endmodule

`endif /* TUT3_VERILOG_REGINCR_REG_INCR_V */
