---
layout: default
title: "Fixed-Point Design"
nav_order: 3
parent: "Documentation"
---

# 🔢 Fixed-Point Design for V–I Control

This chapter explains how **continuous-valued control equations**
are mapped into **fixed-point arithmetic** suitable for a
**deterministic digital ASIC implementation**.

All voltage **V** and current **I** signals are treated explicitly
as fixed-point numbers, with **bounded range and known precision**.

---

## 🎯 Why Fixed-Point?

Floating-point arithmetic is avoided in this design because:

- Hardware cost is high
- Latency is variable
- Verification becomes complex

Fixed-point arithmetic provides:

- Deterministic execution time
- Predictable overflow behavior
- Efficient hardware implementation

These properties are essential for **control and safety-critical systems**,
where timing and numerical behavior must be provable.

---

## 📐 Signal Normalization (V–I)

Before entering the control core, all physical signals are normalized.

### Voltage

Let the physical voltage range be:

$$
0 \le V_{\text{phys}} \le V_{\text{max}}
$$

The normalized digital voltage is defined as:

$$
V[n] = \frac{V_{\text{phys}}}{V_{\text{max}}}
$$

### Current

Similarly, for current:

$$
0 \le I_{\text{phys}} \le I_{\text{max}}
$$

$$
I[n] = \frac{I_{\text{phys}}}{I_{\text{max}}}
$$

After normalization:

- $V[n] \in [0, 1]$
- $I[n] \in [0, 1]$

This ensures that **all subsequent fixed-point computations**
operate on bounded, dimensionless quantities.

---

## 🧩 Fixed-Point Data Path (Conceptual)

The following figure shows how normalized V–I signals
are processed through fixed-point arithmetic blocks
before being converted into PWM timing.

<img
  src="https://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_github_rtl_01.png"
  alt="Fixed-point datapath overview"
  style="width:80%;"
/>

This structure clarifies where:

- bit growth occurs
- saturation must be applied
- state variables are stored

---

## 🧮 Q-Format Representation

A fixed-point number is represented as:

$$
x = \text{integer} \times 2^{-f}
$$

where:

- $f$ : number of fractional bits

### Example: Q1.15 Format

- Total bits: 16
- Integer bits: 1
- Fractional bits: 15

Range:

$$
-1.0 \le x < +1.0
$$

Resolution:

$$
\Delta = 2^{-15}
$$

This format is well suited for **normalized V and I signals**.

---

## ⚙️ Fixed-Point PID Computation

The discrete-time PID equation:

$$
u[n] = K_p e[n] + K_i \sum e[n] + K_d (e[n] - e[n-1])
$$

is implemented using fixed-point multipliers and adders.

### Gain Representation

- $K_p$, $K_i$, $K_d$ are stored as fixed-point values
- Gains are programmable via registers (SPI)
- Gain changes do not affect control timing

Care must be taken to allocate sufficient bit width
for **intermediate multiplication results**.

---

## 🚨 Saturation and Overflow Handling

Unlike software, hardware must explicitly define behavior
when numerical limits are exceeded.

### Saturation Policy

If a computed value exceeds the allowed range:

- Positive overflow → clamp to maximum
- Negative overflow → clamp to minimum

This avoids wrap-around behavior, which can cause
**catastrophic instability in control systems**.

All saturation points are explicitly coded in RTL.

---

## 📊 Bit-Width Planning (Example)

| Signal | Format | Notes |
|------|-------|------|
| $V[n]$, $I[n]$ | Q1.15 | Normalized input |
| $e[n]$ | Q2.15 | Signed error |
| $\sum e[n]$ | Q4.15 | Accumulated integral |
| $u[n]$ | Q2.15 | Control output |

These values are **design examples**, chosen to illustrate:

- headroom for accumulation
- bounded control output
- safe saturation margins

Actual formats may be adjusted based on system requirements.

---

## ⏱ Deterministic Latency

Each fixed-point operation:

- Uses a known number of clock cycles
- Has no data-dependent timing

Therefore, the total control latency is:

$$
T_{\text{latency}} = N_{\text{cycles}} \times T_{\text{clk}}
$$

This makes worst-case timing **trivial to compute and verify**.

---

## 🧪 Verification Strategy

Fixed-point behavior is verified by:

- Comparing against floating-point reference models
- Explicitly testing saturation and overflow cases
- Inspecting waveforms for bit growth and truncation

This ensures numerical correctness **before synthesis**.

---

## ➡️ Next

Proceed to:

➡️ **[`RTL PID Core`](03_rtl_pid.md)**

Once the number system is fixed,
the RTL implementation becomes straightforward and mechanical.
