---
layout: default
title: "RTL PID Core"
nav_order: 4
parent: "Documentation"
---

# 🧩 RTL PID Core Implementation

This chapter explains how the **fixed-point PID control equation**
is mapped directly into **Verilog RTL**.

The goal is to create a **clear, minimal, and deterministic**
PID core suitable for **ASIC implementation on SKY130**.

---

## 🎯 Design Objectives

The PID core is designed to:

- Operate with fixed-point arithmetic
- Execute in a deterministic number of clock cycles
- Avoid hidden states or implicit behavior
- Be easy to verify and extend

This is **not** a high-performance design,
but a **transparent and educational reference**.

---

## 📥 Inputs and Outputs

### Inputs

| Signal | Description |
|------|-------------|
| `clk` | Control clock |
| `rst_n` | Active-low synchronous reset |
| `v_in` | Normalized voltage input $V[n]$ |
| `i_in` | Normalized current input $I[n]$ |
| `v_ref` | Voltage reference $V_{\text{ref}}[n]$ |
| `kp` | Proportional gain |
| `ki` | Integral gain |
| `kd` | Derivative gain |
| `enable` | Control enable |

All numeric signals are fixed-point.

---

### Outputs

| Signal | Description |
|------|-------------|
| `u_out` | Control output $u[n]$ |
| `valid` | Output valid flag |

---

## 🧮 Error Computation (V–I Based)

In this reference design, the control error is defined as:

$$
e[n] = V_{\text{ref}}[n] - V[n]
$$

Current $I[n]$ is available as an input
and can be incorporated for advanced control strategies.

---

## 🧠 Internal Registers

The PID core maintains the following state:

- `e_prev` : previous error $e[n-1]$
- `i_acc` : integral accumulator $\sum e[n]$

All registers are updated synchronously.

---

## 🏗 RTL Structure

The PID core consists of four conceptual stages:

1. Error calculation  
2. Proportional / Integral / Derivative computation  
3. Summation and saturation  
4. Output register

Each stage is implemented using simple combinational logic
followed by registers.

---

## 🧾 Reference Verilog Implementation

The following code illustrates a **minimal PID core**
for educational purposes.

```verilog
module pid_core (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        enable,

    input  wire signed [15:0] v_in,   // Q1.15
    input  wire signed [15:0] i_in,   // Q1.15 (optional)
    input  wire signed [15:0] v_ref,  // Q1.15

    input  wire signed [15:0] kp,
    input  wire signed [15:0] ki,
    input  wire signed [15:0] kd,

    output reg  signed [15:0] u_out,  // Q1.15
    output reg         valid
);

    reg signed [16:0] e_cur;
    reg signed [16:0] e_prev;
    reg signed [31:0] i_acc;

    wire signed [31:0] p_term;
    wire signed [31:0] i_term;
    wire signed [31:0] d_term;

    assign e_cur = v_ref - v_in;

    assign p_term = e_cur * kp;
    assign i_term = i_acc * ki;
    assign d_term = (e_cur - e_prev) * kd;

    always @(posedge clk) begin
        if (!rst_n) begin
            e_prev <= 0;
            i_acc  <= 0;
            u_out  <= 0;
            valid  <= 1'b0;
        end else if (enable) begin
            e_prev <= e_cur;
            i_acc  <= i_acc + e_cur;
            u_out  <= (p_term + i_term + d_term) >>> 15;
            valid  <= 1'b1;
        end else begin
            valid <= 1'b0;
        end
    end

endmodule
```

## ⚠️ Notes on Saturation

For clarity, saturation logic is omitted in the reference implementation.

In a production-quality control ASIC, explicit saturation logic
**must** be implemented to ensure stability and safety.

### Why Saturation Is Required

Without saturation:

- Integral accumulation may overflow
- Output wrap-around can occur
- Control behavior becomes unpredictable

This is especially dangerous in **V–I control systems**,
where excessive voltage or current can damage hardware.

---

## 🧯 Integral Windup Protection

The integral accumulator `i_acc` should be protected
against excessive growth.

Typical strategies include:

- Clamping `i_acc` to a predefined range
- Conditional integration (integrate only when not saturated)
- Resetting the integrator in `FAULT` state

Example (conceptual):

```verilog
if (i_acc > I_ACC_MAX)
    i_acc <= I_ACC_MAX;
else if (i_acc < I_ACC_MIN)
    i_acc <= I_ACC_MIN;
else
    i_acc <= i_acc + e_cur;
```

## 🔒 Output Clamping

The control output u_out must be limited
to a safe operating range.

Example:
```
if (u_calc > U_MAX)
    u_out <= U_MAX;
else if (u_calc < U_MIN)
    u_out <= U_MIN;
else
    u_out <= u_calc;
```

This prevents the PWM generator from receiving
invalid or dangerous commands.

## ⏱ Timing Impact

Saturation logic adds:

A small amount of combinational logic

No additional clock cycles

Therefore, deterministic timing is preserved.

## 🧪 Verification Considerations

Saturation behavior must be verified explicitly:

Apply large step errors to force saturation

Confirm clamping at both positive and negative limits

Verify integrator recovery after saturation

Waveform inspection is strongly recommended.

## 🧠 Educational Note

Saturation logic is often hidden in software libraries.
In hardware design, it must be made explicit.

This visibility is one of the key educational benefits
of implementing control systems as an ASIC.

