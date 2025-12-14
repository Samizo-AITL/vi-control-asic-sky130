---
layout: default
title: "Overview"
nav_order: 1
parent: "Documentation"
---

# 🧭 Overview  
**V–I Control ASIC on SKY130**

This project demonstrates how a **Voltage–Current (V–I) based control system**
can be implemented as a **fully digital ASIC**, using  
**OpenLane** and **SkyWater SKY130**.

The emphasis is on:

- clarity of design intent
- deterministic timing
- educational transparency

This is not just a result-oriented project,  
but a **process-oriented design record**.

---

## 🎯 What This Project Is

This repository serves as:

- 📘 A **step-by-step educational guide**
- 🧩 A **practical digital control ASIC reference**
- 🛠 A **complete RTL-to-GDS implementation example** using open-source tools

You will see, end to end, how:

> **Control theory becomes fixed-point math,**  
> **fixed-point math becomes RTL,**  
> **and RTL becomes silicon.**

Every abstraction layer is explicitly connected to the next.

---

## ❌ What This Project Is NOT

To keep the scope focused and realistic, this project is **not**:

- A high-performance AI or DSP accelerator
- A mixed-signal SoC with on-chip ADC/DAC
- A vendor-specific MCU or firmware example

All **analog functions** (ADC, DAC, current sensing) are intentionally
kept **off-chip**.

The ASIC focuses purely on **deterministic digital control logic**.

---

## ⚡ Core Idea: V–I Based Digital Control

The control system operates on two physical quantities:

- **Voltage (V)**
- **Current (I)**

These are sampled by external ADCs and provided to the ASIC
as **digital fixed-point values**:

- $V[n]$ : voltage sample  
- $I[n]$ : current sample  

The ASIC computes a discrete-time control output:

- $u[n]$ : control command  
  → used as PWM duty or timing information

This makes the control loop:

- synchronous
- cycle-accurate
- fully analyzable in hardware terms

---

## 🧩 Target Architecture (Conceptual)

```
V[n], I[n]
│
▼
+----------------+
| PID Controller | ← Fixed-point arithmetic
+----------------+
│ u[n]
▼
+----------------+
| FSM Supervisor | ← INIT / RUN / FAULT
+----------------+
│
▼
+----------------+
| PWM Generator | ← Digital pulse output
+----------------+
```


This separation ensures:

- Deterministic timing
- Explicit safety handling
- Clear responsibility per block

---

## ⏱ Why ASIC-Based Control?

Compared with MCU-based control approaches:

| MCU-based Control | ASIC-based Control (This Project) |
|---|---|
| Interrupt-driven | Fully synchronous |
| Variable latency | Deterministic latency |
| Software-hidden states | Explicit FSM states |
| Hard to prove timing | Exact cycle count |

For **industrial and safety-oriented control**,  
*determinism and explainability matter more than raw flexibility*.

---

## 🛠 Technology Stack

- **Process**: SkyWater SKY130 (130 nm)
- **EDA Flow**: OpenLane
- **Design Style**: Digital-only, single clock
- **Language**: Verilog HDL
- **Arithmetic**: Fixed-point (Q-format)

All RTL and flows are compatible with the open-source SKY130 PDK.

---

## 📚 Documentation Roadmap

The documentation progresses in the following order:

1. **Overview**  
   System concept and motivation (this chapter)

2. **Control Model**  
   Discrete-time PID equations using V–I feedback

3. **Fixed-Point Design**  
   Scaling, Q-format selection, saturation

4. **RTL PID Core**  
   Verilog implementation of the control law

5. **FSM & PWM**  
   Supervision, safety logic, pulse generation

6. **OpenLane Flow**  
   RTL → GDS implementation and layout analysis

Each chapter builds directly on the previous one.  
Skipping ahead is discouraged.

---

## 🧠 Educational Philosophy

This project follows three principles:

1. **Make timing explicit**
2. **Make arithmetic visible**
3. **Make behavior explainable**

If you understand every block in this design,
you understand the essence of a **practical control ASIC**.

---

## ➡️ Next

Proceed to the control equations:

➡️ **[01_control_model.md](01_control_model.md)**

Start from the math.  
Everything else follows.
