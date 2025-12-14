---
layout: default
title: Documentation
nav_order: 1
has_children: true
---

# 📘 V–I Control ASIC on SKY130  
**PID + FSM + PWM — RTL to GDS using OpenLane**

---

## 🎯 Overview

This documentation describes a **complete, verified digital control ASIC**
based on **Voltage–Current (V–I) feedback**, implemented using:

- Fixed-point **PID control**
- Deterministic **FSM supervision**
- Hardware **PWM generation**
- Full **RTL → GDS** flow with **OpenLane**
- **SkyWater SKY130** open PDK

This is **not** a partial tutorial or tool demo.

> It is a **finished ASIC design**, documented end-to-end,  
> intended as both **educational reference** and **practical baseline**.

---

## 🔗 Official Project Links

| Item | Link |
|----|----|
| 🌐 GitHub Pages (Docs) | https://samizo-aitl.github.io/vi-control-asic-sky130/docs/ |
| 💻 GitHub Repository | https://github.com/Samizo-AITL/vi-control-asic-sky130 |
| 💬 Discussions | https://github.com/Samizo-AITL/vi-control-asic-sky130/discussions |

---

## 🧠 What This Project Teaches

By reading this documentation sequentially, you will understand:

- How **V[n] / I[n] samples** are treated in digital control hardware
- How a **discrete-time PID controller** is mapped into fixed-point RTL
- How **FSM-based supervision** guarantees deterministic and safe behavior
- How **PWM timing** is generated directly from control output
- How functional correctness is verified at **RTL and gate level**
- How to run a full **OpenLane RTL-to-GDS flow** on SKY130

All **analog blocks (ADC/DAC)** are assumed **off-chip**.  
This project focuses on **pure digital ASIC design**.

---

## 🧩 Target Architecture (Conceptual)

```
V[n], I[n]   (from external ADC)
   │
   ▼
+-------------+
|  PID Core   |  ← Fixed-point arithmetic
+-------------+
       │ u[n]
       ▼
+-------------+
|   FSM Ctrl  |  ← INIT / RUN / FAULT
+-------------+
       │
       ▼
+-------------+
|  PWM Gen    |  ← Duty / timing output
+-------------+
```

---

## 📚 Documentation Structure

Each chapter is a standalone Markdown file under `docs/`.

### 0️⃣ Overview
➡️ **[00_overview.md](00_overview.md)**  
Project motivation, scope, and design philosophy.

### 1️⃣ Control Model
➡️ **[01_control_model.md](01_control_model.md)**  
Discrete-time PID control using V–I feedback.

### 2️⃣ Fixed-Point Design
➡️ **[02_fixed_point.md](02_fixed_point.md)**  
Q-format selection, scaling, saturation, and overflow handling.

### 3️⃣ RTL: PID Core
➡️ **[03_rtl_pid.md](03_rtl_pid.md)**  
Cycle-accurate PID datapath in Verilog.

### 4️⃣ RTL: FSM & PWM
➡️ **[04_fsm_pwm.md](04_fsm_pwm.md)**  
Supervisory FSM and PWM generation logic.

### 5️⃣ OpenLane Flow
➡️ **[05_openlane_flow.md](05_openlane_flow.md)**  
Synthesis, placement, routing, STA, and layout inspection.

### 6️⃣ Gate-level Simulation (Functional)
➡️ **[06_gate_sim_functional.md](06_gate_sim_functional.md)**  
Post-layout **functional** verification (logical equivalence, no timing).

---

## 📎 Appendix

➡️ **[Appendix A: Figure List](appendix_figures.md)**  

A complete index of **all waveforms, layouts, and verification figures**,  
clarifying:

- What each figure proves
- Which verification phase it belongs to
- Why similar-looking figures exist

Highly recommended for reviewers.

---

## ✅ Verification Strategy

This project emphasizes **functional correctness with explicit timing guarantees**.

### Performed

- ✅ RTL functional simulation (Icarus Verilog)
- ✅ PID step-response verification (P / PI)
- ✅ FSM state transition verification
- ✅ PWM duty and timing verification
- ✅ Gate-level **functional** simulation (post-layout)
- ✅ Static Timing Analysis (STA) closure
- ✅ DRC / LVS clean (OpenLane)

### Intentionally Omitted

- ⏭ Gate-level **timing-aware** simulation

**Reason:**  
Timing correctness is guaranteed by STA,  
and SKY130 UDP-based cell models are not simulator-friendly.

This reflects **realistic industry practice**.

---

## 🖼 Final GDS (Physical Deliverable)

<img
  src="https://samizo-aitl.github.io/vi-control-asic-sky130/docs/layout/vi_control_top_gds_overview.png"
  alt="GDS layout overview"
  style="width:85%;"
/>

- Tool: OpenLane
- PDK: SKY130A
- Status: DRC / LVS clean, STA closed

---

## 👤 Author

**Shinichi Samizo**  
M.S. Electrical & Electronic Engineering (Shinshu University)

- Former Engineer, **Seiko Epson Corporation**
- Semiconductor logic / memory / HV mixed-signal
- Inkjet MEMS & PrecisionCore productization
- Control hardware architecture & education

GitHub: https://github.com/Samizo-AITL  
Email: shin3t72@gmail.com

---

## 📄 License

| Item | License |
|----|----|
| Source Code | MIT |
| Text & Documentation | CC BY 4.0 / CC BY-SA 4.0 |
| Figures & Diagrams | CC BY-NC 4.0 |
| External References | Original license applies |

---

> **Conclusion**  
> This documentation represents a **complete, reproducible, and verified**
> digital control ASIC design on SKY130.
>
> If you understand every chapter,  
> you understand the essence of a **practical control ASIC**.
