---
layout: default
title: "RTL PID Core"
nav_order: 4
parent: "Documentation"
permalink: /docs/03_rtl_pid/
---

# 🧩 RTL PID Core Implementation

This chapter explains how the **fixed-point PID control equation**
is mapped directly into **Verilog RTL**.

The goal is to implement a **clear, minimal, and deterministic**
PID core suitable for **ASIC implementation on SKY130**.

This design prioritizes **explainability over optimization**.

---

## 🎯 Design Objectives

The PID core is designed to:

- Operate entirely with fixed-point arithmetic
- Execute in a deterministic number of clock cycles
- Avoid hidden states or implicit behavior
- Be easy to verify, modify, and extend

This is **not** a high-performance design,
but a **transparent educational reference**.

---

## 🧩 PID Core in System Context

The PID core operates as part of a larger control system,
supervised by an FSM and followed by a PWM generator.

In this chapter, the focus is intentionally limited to the
**PID core itself**, independent of supervision and output mapping.

> System-level integration and waveform-based verification results
> are documented in **Appendix A: Figure List**.

---

## 📥 Inputs and Outputs

### Inputs

| Signal | Description |
|------|-------------|
| `clk` | Control clock |
| `rst_n` | Active-low synchronous reset |
| `enable` | Control enable (from FSM) |
| `v_in` | Normalized voltage input $V[n]$ |
| `i_in` | Normalized current input $I[n]$ (optional) |
| `v_ref` | Voltage reference $V_{\text{ref}}[n]$ |
| `kp` | Proportional gain |
| `ki` | Integral gain |
| `kd` | Derivative gain |

All numeric signals are **fixed-point signed values**.

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

Current $I[n]$ is provided as an input and can be incorporated
into more advanced control laws, such as:

- current limiting
- feed-forward compensation
- multi-loop control

In this chapter, the **voltage error form** is used for clarity.

---

## 🧠 Internal State Registers

The PID core maintains explicit state registers:

- `e_prev` : previous error $e[n-1]$
- `i_acc`  : integral accumulator $\sum e[n]$

These states are:

- fully visible in RTL
- synchronously updated
- reset deterministically

There are **no implicit or hidden states**.

---

## 🏗 RTL Pipeline Structure

The PID core can be conceptually divided into four stages:

1. **Error computation**  
   $e[n] = V_{\text{ref}}[n] - V[n]$

2. **P / I / D term computation**  
   Fixed-point multiply operations

3. **Summation and scaling**  
   Alignment and right-shift

4. **Output register**  
   Registered control output

Each stage uses simple combinational logic
followed by registers.

No multi-cycle or variable-latency operations are used.

---

## 🧾 Reference Verilog Implementation

The following code illustrates a **minimal PID core**
intended for educational purposes.

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
    output reg               valid
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

This implementation maps directly from the equations
defined in the previous chapters.

---

## 🚨 Saturation and Safety Considerations

For clarity, saturation logic is omitted in the reference implementation above.

In a production-quality control ASIC,
explicit saturation logic is mandatory to guarantee safe operation.

### Why Saturation Is Required

Without saturation:

- Integral accumulation may overflow
- Output wrap-around can occur
- Control behavior becomes unpredictable

This is especially dangerous in V–I control systems,
where excessive voltage or current can damage hardware.

---

## 🧯 Integral Windup Protection

The integral accumulator `i_acc` must be protected
against excessive growth.

Typical strategies include:

- Clamping `i_acc` to a predefined range
- Conditional integration (integrate only when output is not saturated)
- Resetting the integrator in `FAULT` state

### Example (conceptual)

```verilog
if (i_acc > I_ACC_MAX)
    i_acc <= I_ACC_MAX;
else if (i_acc < I_ACC_MIN)
    i_acc <= I_ACC_MIN;
else
    i_acc <= i_acc + e_cur;
```

This logic prevents integrator windup
while preserving deterministic timing.

---

## 🔒 Output Clamping

The control output `u_out` must be limited
to a safe operating range.

### Example (conceptual)

```verilog
if (u_calc > U_MAX)
    u_out <= U_MAX;
else if (u_calc < U_MIN)
    u_out <= U_MIN;
else
    u_out <= u_calc;
```

This ensures the PWM generator never receives
invalid or dangerous commands.

---

## ⏱ Timing Impact

Adding saturation and clamping logic:

- Increases combinational logic slightly
- Adds **no additional clock cycles**

Deterministic timing is fully preserved.

---

## 🧪 Verification Considerations

RTL verification should include:

- Step response tests (P / PI)
- Forced saturation scenarios
- Integrator recovery after saturation
- Waveform inspection of internal states

All internal registers should be observable in simulation.

---

## 🧠 Educational Note

In software, saturation is often hidden in libraries.

In hardware, **every limit must be explicit**.

This visibility is one of the key educational benefits
of implementing control systems as an ASIC.

---

---

## ➡️ Next

Proceed to system-level supervision:

➡️ **[RTL: FSM & PWM](04_fsm_pwm.md)**  

The next chapter introduces the FSM supervisor,
safety handling, and PWM generation logic.

---

## ⬅️ Navigation

- 🔙 **[Documentation Index](index.md)**  
- 🏠 **[Project Top](../index.md)**
