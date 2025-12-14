// pid_core.v : Fixed-point PID core (educational reference)
// Assumptions:
// - v_in, i_in, v_ref are Q1.15 signed (normalized V–I samples)
// - kp, ki, kd are Q1.15 signed
// - u_out is Q1.15 signed (normalized control output, typically mapped to PWM)
// Notes:
// - Includes integral clamp and output clamp
// - Deterministic: 1-cycle output update when enable=1

module pid_core #(
    parameter int W      = 16,
    parameter int FRAC   = 15,
    parameter int IACC_W = 32,  // integral accumulator width
    // Integral accumulator clamp in IACC_W domain
    parameter signed [IACC_W-1:0] I_ACC_MAX = 32'sh0FFFFFFF,
    parameter signed [IACC_W-1:0] I_ACC_MIN = -32'sh10000000
)(
    input  wire                 clk,
    input  wire                 rst_n,   // active-low synchronous reset
    input  wire                 enable,

    input  wire signed [W-1:0]  v_in,   // V[n] Q1.15
    input  wire signed [W-1:0]  i_in,   // I[n] Q1.15 (optional, not used in base error)
    input  wire signed [W-1:0]  v_ref,  // Vref[n] Q1.15

    input  wire signed [W-1:0]  kp,
    input  wire signed [W-1:0]  ki,
    input  wire signed [W-1:0]  kd,

    output reg  signed [W-1:0]  u_out,  // u[n] Q1.15
    output reg                  valid
);
    // Error e[n] in a slightly wider format to avoid overflow on subtract
    wire signed [W:0] e_cur_w = {v_ref[W-1], v_ref} - {v_in[W-1], v_in};

    reg  signed [W:0]  e_prev;          // e[n-1]
    reg  signed [IACC_W-1:0] i_acc;     // Σe

    // Multiply terms (wide)
    wire signed [31:0] p_mul = $signed(e_cur_w) * $signed(kp);             // (W+1)*W -> up to 32
    wire signed [47:0] i_mul = $signed(i_acc)   * $signed(ki);             // IACC_W*W -> 48 (enough for 32x16)
    wire signed [31:0] d_mul = ($signed(e_cur_w) - $signed(e_prev)) * $signed(kd);

    // Align back to Q1.15 by shifting FRAC
    wire signed [31:0] p_q = p_mul >>> FRAC;
    wire signed [31:0] d_q = d_mul >>> FRAC;
    wire signed [47:0] i_q = i_mul >>> FRAC;

    // Sum in wide domain
    wire signed [47:0] sum_w = $signed({{16{p_q[31]}}, p_q}) +
                              $signed(i_q) +
                              $signed({{16{d_q[31]}}, d_q});

    // Clamp output to Q1.15 range
    wire signed [15:0] u_sat;
    sat_signed #(.IN_W(48), .OUT_W(16)) u_saturator (.in_val(sum_w), .out_val(u_sat));

    // Integral update with clamp
    wire signed [IACC_W-1:0] i_next = i_acc + $signed({{(IACC_W-(W+1)){e_cur_w[W]}}, e_cur_w});

    wire signed [IACC_W-1:0] i_clamped =
        (i_next > I_ACC_MAX) ? I_ACC_MAX :
        (i_next < I_ACC_MIN) ? I_ACC_MIN :
        i_next;

    // Optional usage of I[n] for advanced error definitions (placeholder)
    // wire signed [W:0] e_cur_alt = e_cur_w - {i_in[W-1], i_in};

    always @(posedge clk) begin
        if (!rst_n) begin
            e_prev <= '0;
            i_acc  <= '0;
            u_out  <= '0;
            valid  <= 1'b0;
        end else if (enable) begin
            e_prev <= e_cur_w;
            i_acc  <= i_clamped;
            u_out  <= u_sat;
            valid  <= 1'b1;
        end else begin
            valid <= 1'b0;
        end
    end
endmodule
