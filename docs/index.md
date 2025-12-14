---
layout: default
title: "Documentation"
nav_order: 1
has_children: true
---

# 📘 V–I Control ASIC Documentation

Welcome to the documentation for **V–I Control ASIC on SKY130**.

This documentation provides a **reproducible, end-to-end guide** covering:

> **Control theory → Fixed-point design → RTL → Verification → OpenLane → GDS**

The goal is not only to explain *how* to design a control ASIC,  
but also *why* each architectural and implementation decision is made.

This material is written as **design documentation + educational reference**.

---

## 🔗 Official Links

| Language | GitHub Pages 🌐 | GitHub 💻 |
|----------|----------------|-----------|
| 🇺🇸 English | [![GitHub Pages EN](https://img.shields.io/badge/GitHub%20Pages-English-brightgreen?logo=github)](https://samizo-aitl.github.io/vi-control-asic-sky130/docs/) | [![GitHub Repo EN](https://img.shields.io/badge/GitHub-English-blue?logo=github)](https://github.com/Samizo-AITL/vi-control-asic-sky130/tree/main/docs) |

---

## 🎯 What You Will Learn

By following this documentation, you will understand:

- How **Voltage (V)** and **Current (I)** signals are represented in digital control
- How a **discrete-time PID controller** is implemented in fixed-point hardware
- How an **FSM supervisor** enforces safe and deterministic operation
- How **PWM signals** are generated from digital control outputs
- How functional correctness is verified using **RTL simulation**
- How to run a full **RTL-to-GDS flow** using OpenLane and SKY130

This is a **digital-only ASIC design**.  
All analog blocks (ADC / DAC) are assumed to be external.

---

## 🧩 Target Architecture (Conceptual View)

```
V[n], I[n]
│
▼
+-----------+
| PID Core | ← Fixed-point arithmetic
+-----------+
│ u[n]
▼
+-----------+
| FSM Ctrl | ← INIT / RUN / FAULT
+-----------+
│
▼
+-----------+
| PWM Gen | ← Duty / timing output
+-----------+
```

---

## 📚 Documentation Structure

Each chapter corresponds to one markdown file under `docs/`.

### 0️⃣ Overview
➡️ **[00_overview.md](00_overview.md)**  
System concept, motivation, and overall design philosophy.

### 1️⃣ Control Model
➡️ **[01_control_model.md](01_control_model.md)**  
Discrete-time PID control using V–I feedback.

### 2️⃣ Fixed-Point Design
➡️ **[02_fixed_point.md](02_fixed_point.md)**  
Q-format selection, scaling, saturation, and overflow handling.

### 3️⃣ RTL: PID Core
➡️ **[03_rtl_pid.md](03_rtl_pid.md)**  
PID datapath, registers, and fixed-point arithmetic in Verilog.

### 4️⃣ RTL: FSM & PWM
➡️ **[04_fsm_pwm.md](04_fsm_pwm.md)**  
FSM supervisor, PWM generator, and safety behavior.

### 5️⃣ OpenLane Flow
➡️ **[05_openlane_flow.md](05_openlane_flow.md)**  
Synthesis, place & route, STA, and layout inspection.

### 6️⃣ Gate-level Simulation (Functional)
➡️ **[06_gate_sim_functional.md](06_gate_sim_functional.md)**  
Gate-level simulation **investigation and technical assessment**  
(post-layout, functional intent).

---

## 📎 Appendix

For a complete index of all figures used in this documentation  
(including verification waveforms, layout images, and GDS views), see:

➡️ **[Appendix A: Figure List](appendix_figures.md)**

This appendix clarifies:
- What each figure represents
- Which verification phase it belongs to
- Why similar-looking figures exist (comparison / stepwise validation)

---

## ✅ Verification Strategy

This project focuses on **functional correctness at RTL level**:

- RTL simulation with Icarus Verilog
- Step-response verification (P / PI control)
- FSM state transition checking
- PWM duty and timing validation using GTKWave

> **Note on Gate-Level Simulation**  
> Gate-level **functional simulation was investigated but not completed**.
>
> The SKY130 standard cell libraries rely on
> **UDP (User Defined Primitive)** constructs  
> (e.g. `sky130_fd_sc_hd__udp_*`),
> which are not fully supported by Icarus Verilog.
>
> As a result, reliable gate-level functional simulation
> using Icarus Verilog was not feasible.
>
> Timing correctness is instead ensured by:
> - Static Timing Analysis (STA) in OpenLane
> - Post-layout inspection (Magic / GDS)

This reflects a **realistic and widely accepted ASIC development trade-off**
when using open-source tools.

---

## ✅ Verification Status (Completed)

The verification phase for this project is **complete**
within the intended scope of this educational ASIC design.

### Verification Coverage

- ✅ RTL functional simulation
- ✅ PID step-response verification (P / PI)
- ✅ FSM state transition verification
- ✅ PWM duty and timing verification
- ⚠ Gate-level functional simulation  
  (investigated, not completed due to tool limitations)
- ✅ Static Timing Analysis (STA) closure
- ✅ DRC / LVS clean (OpenLane)

### Not Performed

- ⏭ Gate-level timing-aware simulation  
  (intentionally omitted; STA used instead)

### Conclusion

Based on the completed verification steps and documented tool limitations,
the V–I Control ASIC design is considered:

> **Functionally correct at RTL level, timing-clean by STA,
> and complete as an educational RTL-to-GDS reference implementation
> using OpenLane and SKY130.**

This concludes the verification phase of the project.

---

## 🛠 Prerequisites

You should have basic knowledge of:

- Digital logic and Verilog HDL
- Control fundamentals (PID)
- Linux command-line environment

No prior ASIC tapeout experience is required.

---

## 🚀 How to Start

Start here:

➡️ **[00_overview.md](00_overview.md)**

Then proceed sequentially through the chapters.  
Each section builds directly on the previous one.

---

## 📌 Design Philosophy

This project follows three core principles:

1. **Make timing explicit**
2. **Make arithmetic visible**
3. **Make behavior explainable**

If you understand every block in this design,  
you understand the essence of a **practical control ASIC**.

---

Happy learning, and enjoy building silicon.

