// reg_if_spi.v : very small SPI slave (Mode 0) for register access (educational)
// - 8-bit address, 16-bit data
// - Transaction format (MSB first):
//   [RW(1)][ADDR(7)][DATA(16)]  total 24 bits
//   RW=0 write, RW=1 read (read returns DATA of ADDR on next transaction for simplicity)
//
// NOTE: This is a minimal educational block; production designs require stronger SPI spec handling.

module reg_if_spi (
    input  wire        clk,
    input  wire        rst_n,

    // SPI signals (external clock sampled by clk; assumes sclk not faster than clk/2)
    input  wire        spi_sclk,
    input  wire        spi_csn,
    input  wire        spi_mosi,
    output reg         spi_miso,

    // Registers
    output reg  [15:0] reg_kp,
    output reg  [15:0] reg_ki,
    output reg  [15:0] reg_kd,
    output reg  [15:0] reg_vref,
    output reg         reg_start,
    output reg         reg_clear_fault
);
    // sync SPI lines
    reg sclk_d, csn_d, mosi_d;
    always @(posedge clk) begin
        sclk_d <= spi_sclk;
        csn_d  <= spi_csn;
        mosi_d <= spi_mosi;
    end

    wire csn = csn_d;
    wire sclk = sclk_d;
    wire sclk_rise = (sclk_d && !sclk); // (intentionally simple; if needed, refine with 2FF sync)

    reg [4:0] bit_cnt;
    reg [23:0] shreg;
    reg [15:0] read_data_shadow;

    wire rw   = shreg[23];
    wire [7:0] addr = shreg[22:16];
    wire [15:0] data = shreg[15:0];

    // Address map
    localparam [7:0] A_KP    = 8'h00;
    localparam [7:0] A_KI    = 8'h01;
    localparam [7:0] A_KD    = 8'h02;
    localparam [7:0] A_VREF  = 8'h03;
    localparam [7:0] A_CTRL  = 8'h10; // [0]=start, [1]=clear_fault

    // SPI shift in/out
    always @(posedge clk) begin
        if (!rst_n) begin
            bit_cnt <= 5'd0;
            shreg <= 24'd0;
            spi_miso <= 1'b0;

            reg_kp <= 16'sh2000; // default gains
            reg_ki <= 16'sh0100;
            reg_kd <= 16'sh0000;
            reg_vref <= 16'sh4000;

            reg_start <= 1'b0;
            reg_clear_fault <= 1'b0;

            read_data_shadow <= 16'd0;
        end else begin
            reg_start <= 1'b0;
            reg_clear_fault <= 1'b0;

            if (csn) begin
                bit_cnt <= 5'd0;
            end else begin
                // sample MOSI on sclk rising (Mode 0)
                if (sclk_rise) begin
                    shreg <= {shreg[22:0], mosi_d};
                    bit_cnt <= bit_cnt + 1'b1;

                    // shift out on MISO (simple: output shadow MSB-first)
                    spi_miso <= read_data_shadow[15 - bit_cnt[3:0]];
                end

                // commit when 24 bits received
                if (bit_cnt == 5'd24) begin
                    bit_cnt <= 5'd0;

                    if (!rw) begin
                        // WRITE
                        case (addr)
                            A_KP:   reg_kp   <= data;
                            A_KI:   reg_ki   <= data;
                            A_KD:   reg_kd   <= data;
                            A_VREF: reg_vref <= data;
                            A_CTRL: begin
                                reg_start       <= data[0];
                                reg_clear_fault <= data[1];
                            end
                            default: ;
                        endcase
                    end else begin
                        // READ: update shadow for next shift-out
                        case (addr)
                            A_KP:   read_data_shadow <= reg_kp;
                            A_KI:   read_data_shadow <= reg_ki;
                            A_KD:   read_data_shadow <= reg_kd;
                            A_VREF: read_data_shadow <= reg_vref;
                            A_CTRL: read_data_shadow <= {14'd0, reg_clear_fault, reg_start};
                            default: read_data_shadow <= 16'h0000;
                        endcase
                    end
                end
            end
        end
    end
endmodule
