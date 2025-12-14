// fixed_sat.v : signed saturation helpers
module sat_signed #(
    parameter int IN_W  = 32,
    parameter int OUT_W = 16
)(
    input  wire signed [IN_W-1:0]  in_val,
    output wire signed [OUT_W-1:0] out_val
);
    localparam signed [OUT_W-1:0] OUT_MAX = {1'b0, {OUT_W-1{1'b1}}};
    localparam signed [OUT_W-1:0] OUT_MIN = {1'b1, {OUT_W-1{1'b0}}};

    // Compare against OUT_W range extended to IN_W
    wire signed [IN_W-1:0] max_ext = {{(IN_W-OUT_W){OUT_MAX[OUT_W-1]}}, OUT_MAX};
    wire signed [IN_W-1:0] min_ext = {{(IN_W-OUT_W){OUT_MIN[OUT_W-1]}}, OUT_MIN};

    assign out_val = (in_val > max_ext) ? OUT_MAX :
                     (in_val < min_ext) ? OUT_MIN :
                     in_val[OUT_W-1:0];
endmodule
