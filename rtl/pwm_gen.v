// pwm_gen.v : glitch-free PWM (update duty only at period boundary)
// duty_in: Q1.15 signed, expected in [0, +1). Negative -> 0, >1 -> max.
module pwm_gen #(
    parameter int W = 16,
    parameter int PWM_BITS = 12  // PWM period = 2^PWM_BITS clocks
)(
    input  wire               clk,
    input  wire               rst_n,     // active-low synchronous reset
    input  wire               enable,

    input  wire signed [W-1:0] duty_in,  // u[n] Q1.15
    output reg                pwm_out
);
    reg [PWM_BITS-1:0] ctr;
    reg [PWM_BITS-1:0] duty_latched;

    // Convert Q1.15 duty to PWM_BITS (0..2^PWM_BITS-1)
    wire signed [W-1:0] duty_clamped =
        (duty_in < 0) ? '0 :
        (duty_in > 16'sh7FFF) ? 16'sh7FFF :
        duty_in;

    // scale: duty_latched = duty_clamped * (2^PWM_BITS - 1) / 2^15
    wire [31:0] scaled = $signed(duty_clamped) * ( (1<<PWM_BITS) - 1 );
    wire [PWM_BITS-1:0] duty_next = scaled >>> 15;

    always @(posedge clk) begin
        if (!rst_n) begin
            ctr <= '0;
            duty_latched <= '0;
            pwm_out <= 1'b0;
        end else begin
            ctr <= ctr + 1'b1;

            // Latch duty at the start of each PWM period
            if (ctr == {PWM_BITS{1'b0}}) begin
                duty_latched <= duty_next;
            end

            if (!enable) begin
                pwm_out <= 1'b0;
            end else begin
                pwm_out <= (ctr < duty_latched) ? 1'b1 : 1'b0;
            end
        end
    end
endmodule
