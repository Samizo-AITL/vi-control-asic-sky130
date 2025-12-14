`timescale 1ns/1ps

module tb_top;
    logic clk = 0;
    always #5 clk = ~clk; // 100 MHz

    logic rst_n = 0;

    logic signed [15:0] v_in, i_in;

    // SPI (kept idle in this minimal TB; regs default)
    logic spi_sclk = 0, spi_csn = 1, spi_mosi = 0;
    wire  spi_miso;

    wire pwm_out;
    wire fault;

    top dut (
        .clk(clk), .rst_n(rst_n),
        .v_in(v_in), .i_in(i_in),
        .spi_sclk(spi_sclk), .spi_csn(spi_csn),
        .spi_mosi(spi_mosi), .spi_miso(spi_miso),
        .pwm_out(pwm_out),
        .fault(fault)
    );

    // helper: Q1.15 from real (for TB only)
    function automatic signed [15:0] q15(input real x);
        real y;
        begin
            y = x;
            if (y > 0.999969) y = 0.999969;
            if (y < -1.0)     y = -1.0;
            q15 = $rtoi(y * 32768.0);
        end
    endfunction

    initial begin
        // init
        v_in = q15(0.0);
        i_in = q15(0.0);

        // reset
        repeat (5) @(posedge clk);
        rst_n <= 1;
        repeat (5) @(posedge clk);

        // NOTE: reg_start default is 0; this TB doesn't drive SPI.
        // For quick smoke: force start (educational shortcut).
        force dut.reg_start = 1'b1;
        @(posedge clk);
        force dut.reg_start = 1'b0;

        // Step response on V[n] with I[n]=0
        // v_ref default 0.5 (0x4000). We step v_in from 0.1 -> 0.6
        v_in = q15(0.1);
        repeat (2000) @(posedge clk);

        v_in = q15(0.6);
        repeat (4000) @(posedge clk);

        // Over-current fault test: I[n] > I_MAX -> FAULT
        i_in = q15(0.95);
        repeat (200) @(posedge clk);

        // Clear and recover (force clear_fault for smoke)
        force dut.reg_clear_fault = 1'b1;
        @(posedge clk);
        force dut.reg_clear_fault = 1'b0;

        i_in = q15(0.0);
        repeat (1000) @(posedge clk);

        $finish;
    end
endmodule
