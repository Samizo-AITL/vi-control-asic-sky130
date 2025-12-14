// fsm_controller.v : INIT / RUN / FAULT supervisor (V–I safety)
module fsm_controller #(
    parameter int W = 16,
    parameter signed [W-1:0] V_MAX = 16'sh7FFF, // Q1.15 (≈ +0.999)
    parameter signed [W-1:0] I_MAX = 16'sh7FFF
)(
    input  wire                clk,
    input  wire                rst_n,     // active-low synchronous reset

    input  wire                start,    // request RUN
    input  wire                clear_fault,

    input  wire signed [W-1:0] v_in,     // V[n]
    input  wire signed [W-1:0] i_in,     // I[n]

    output reg                 pid_en,
    output reg                 fault,
    output reg  [1:0]          state
);
    localparam [1:0] S_INIT  = 2'd0;
    localparam [1:0] S_RUN   = 2'd1;
    localparam [1:0] S_FAULT = 2'd2;

    wire ov = (v_in > V_MAX);
    wire oc = (i_in > I_MAX);
    wire fault_cond = ov | oc;

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= S_INIT;
            pid_en <= 1'b0;
            fault <= 1'b0;
        end else begin
            case (state)
                S_INIT: begin
                    pid_en <= 1'b0;
                    fault <= 1'b0;
                    if (start) state <= S_RUN;
                end
                S_RUN: begin
                    pid_en <= 1'b1;
                    fault <= 1'b0;
                    if (fault_cond) state <= S_FAULT;
                end
                S_FAULT: begin
                    pid_en <= 1'b0;
                    fault <= 1'b1;
                    if (clear_fault && !fault_cond) state <= S_INIT;
                end
                default: begin
                    state <= S_INIT;
                    pid_en <= 1'b0;
                    fault <= 1'b0;
                end
            endcase
        end
    end
endmodule
