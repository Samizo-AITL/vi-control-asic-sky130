---
layout: default
title: "Control Model Overview"
nav_order: 2
parent: "Documentation"
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

## 🧠 Digital Control Architecture

The control core is composed of **three deterministic hardware blocks**.

<img
  src="https://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_fsm_01.png"
  alt="V–I Control Digital Architecture"
  style="width:80%;"
/>

### Block Responsibilities

- **PID Core**  
  Fixed-point computation of the control law

- **FSM Supervisor**  
  Operating modes:
  - `INIT`
  - `RUN`
  - `FAULT`

- **PWM Generator**  
  Converts $u[n]$ to PWM duty or timing signals

All blocks share a **single deterministic control clock**.

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

Proceed to:

- [`Fixed-Point Design`](02_fixed_point.md)
- [`RTL PID Core`](03_rtl_pid.md)
