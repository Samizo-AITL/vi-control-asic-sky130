// top.v : Top-level integration (V–I input + PID + FSM + PWM + SPI regs)

module top (
    input  wire clk,
    input  wire rst_n,

    // V–I samples (from external ADC / digital frontend)
    input  wire signed [15:0] v_in,   // V[n] Q1.15
    input  wire signed [15:0] i_in,   // I[n] Q1.15

    // SPI
    input  wire spi_sclk,
    input  wire spi_csn,
    input  wire spi_mosi,
    output wire spi_miso,

    // PWM output
    output wire pwm_out,

    // status
    output wire fault
);
    wire [15:0] reg_kp, reg_ki, reg_kd, reg_vref;
    wire reg_start, reg_clear_fault;

    reg_if_spi u_spi (
        .clk(clk), .rst_n(rst_n),
        .spi_sclk(spi_sclk), .spi_csn(spi_csn),
        .spi_mosi(spi_mosi), .spi_miso(spi_miso),
        .reg_kp(reg_kp), .reg_ki(reg_ki), .reg_kd(reg_kd),
        .reg_vref(reg_vref),
        .reg_start(reg_start),
        .reg_clear_fault(reg_clear_fault)
    );

    wire pid_en;
    wire [1:0] fsm_state;

    fsm_controller #(
        .V_MAX(16'sh7000), // example thresholds (adjust)
        .I_MAX(16'sh7000)
    ) u_fsm (
        .clk(clk), .rst_n(rst_n),
        .start(reg_start),
        .clear_fault(reg_clear_fault),
        .v_in(v_in),
        .i_in(i_in),
        .pid_en(pid_en),
        .fault(fault),
        .state(fsm_state)
    );

    wire signed [15:0] u_out;
    wire u_valid;

    pid_core u_pid (
        .clk(clk), .rst_n(rst_n),
        .enable(pid_en),
        .v_in(v_in), .i_in(i_in), .v_ref(reg_vref),
        .kp(reg_kp), .ki(reg_ki), .kd(reg_kd),
        .u_out(u_out),
        .valid(u_valid)
    );

    pwm_gen #(.PWM_BITS(12)) u_pwm (
        .clk(clk), .rst_n(rst_n),
        .enable(pid_en && u_valid && !fault),
        .duty_in(u_out),
        .pwm_out(pwm_out)
    );
endmodule
