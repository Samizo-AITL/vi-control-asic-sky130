---
layout: default
title: "Control Model Overview"
nav_order: 2
parent: "Documentation"
permalink: /docs/01_control_model/
---

## 🧮 Control Model (Overview)

The discrete-time PID control law implemented in this project is:

$$
u[n] = K_p e[n] + K_i \sum_{k=0}^{n} e[k] + K_d \left(e[n] - e[n-1]\right)
$$

where:

- $e[n]$ : control error at sample $n$
- $u[n]$ : control output (PWM duty or timing command)
- $K_p$  : proportional gain
- $K_i$  : integral gain
- $K_d$  : derivative gain

This equation is mapped **directly and explicitly** to fixed-point hardware.

---

## ⚡ Error Definition Using V–I Feedback

The control error $e[n]$ is defined using **Voltage–Current (V–I) feedback**.

Typical examples:

$$
e[n] = V_{\text{ref}}[n] - V[n]
$$

or

$$
e[n] = f\big(V[n], I[n]\big)
$$

where:

- $V[n]$ : measured voltage (digital sample)
- $I[n]$ : measured current (digital sample)

All voltage and current values are assumed to be digitized  
by **external ADCs** and provided to the ASIC synchronously.

---

## 🧠 Digital Control Architecture (Conceptual)

The digital control system is conceptually composed of
three deterministic processing stages.

```
e[n]
 │
 ▼
+----------------+
| PID Controller |  (fixed-point)
+----------------+
 │ u[n]
 ▼
+----------------+
| FSM Supervisor |  (INIT / RUN / FAULT)
+----------------+
 │
 ▼
+----------------+
| PWM Generator  |
+----------------+
```

This conceptual structure is **independent of implementation details**
and serves as the basis for fixed-point design and RTL mapping.

> RTL waveforms and implementation-level verification results
> are provided separately in **Appendix A**.

---

## 🔢 Fixed-Point Arithmetic Policy

All control computations are implemented using **fixed-point arithmetic**
to guarantee deterministic timing and hardware efficiency.

### Design Policy

- Deterministic latency
- Saturation instead of wrap-around
- Explicit bit-width definition
- Fully synchronous implementation

Example Q-format definitions:

- Voltage $V[n]$ : Qm.n
- Current $I[n]$ : Qm.n
- Control output $u[n]$ : Qp.q

This makes numerical behavior **fully analyzable before RTL coding**.

---

## ⏱ Deterministic Timing (Why Not MCU?)

Unlike MCU-based control systems, this design features:

- No interrupts
- No task scheduling
- No execution jitter

Each control cycle completes in a **fixed number of clock cycles**.

| Aspect | MCU | This ASIC |
|------|-----|-----------|
| Timing | Variable | Deterministic |
| Latency | Interrupt dependent | Fixed |
| Control flow | Software | Hardware FSM |
| Analysis | Difficult | Exact |

This property is essential for **industrial and safety-oriented control**.

---

## 🛠 Technology Stack

- **Process**: SkyWater SKY130 (130 nm)
- **EDA Flow**: OpenLane
- **HDL**: Verilog
- **Clocking**: Single-clock synchronous design
- **Scope**: Digital-only ASIC

---

## 📘 Educational Focus

This project prioritizes:

- Transparency
- Explainability
- Reproducibility

Every control equation can be traced directly to RTL,  
and every RTL block can be traced to the final layout.

---

## ➡️ Next

Proceed to numerical implementation details:

➡️ **[Fixed-Point Design](02_fixed_point.md)**  

The next chapter explains fixed-point representation,
scaling, saturation, and overflow handling.

---

## ⬅️ Navigation

- 🔙 **[Documentation Index](index.md)**  
- 🏠 **[Project Top](../index.md)**
