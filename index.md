---
layout: default
title: Documentation Index
nav_order: 1
---

# V–I Control ASIC on SKY130  
**PID + FSM + PWM using OpenLane (Educational & Practical)**

---

## 🔗 Official Links

| Language | GitHub Pages 🌐 | GitHub 💻 |
|----------|----------------|-----------|
| 🇺🇸 English | [![GitHub Pages EN](https://img.shields.io/badge/GitHub%20Pages-English-brightgreen?logo=github)](https://samizo-aitl.github.io/vi-control-asic-sky130/) | [![GitHub Repo EN](https://img.shields.io/badge/GitHub-English-blue?logo=github)](https://github.com/Samizo-AITL/vi-control-asic-sky130/tree/main) |

---

This repository provides a **clear, minimal, and tapeout-ready example**
of a **digital control ASIC** based on **Voltage–Current (V–I) feedback**,
implemented with **PID control, FSM supervision, and PWM generation**
using **OpenLane** and **SkyWater SKY130**.

The project is designed as both:

- 📘 **Educational material** (control theory → RTL → GDS)
- 🧩 **Practical ASIC prototype** (MCU offloading / deterministic control)

---

## 📚 Documentation Roadmap

Read the documents in the following order:

1. **Overview**  
   👉 [Overview](00_overview.md)  
   System concept, motivation, and design philosophy.

2. **Control Model**  
   👉 [Control Model](01_control_model.md)  
   Discrete-time PID control using V–I feedback.

3. **Fixed-Point Design**  
   👉 [Fixed-Point Design](02_fixed_point.md)  
   Signal normalization, Q-format selection, saturation.

4. **RTL PID Core**  
   👉 [RTL PID Core](03_rtl_pid.md)  
   Mapping equations directly into Verilog RTL.

5. **FSM Supervisor & PWM Generator**  
   👉 [FSM Supervisor & PWM Generator](04_fsm_pwm.md)  
   Safety supervision and pulse generation.

6. **OpenLane Flow**  
   👉 [OpenLane Flow](05_openlane_flow.md)  
   RTL → GDS implementation using OpenLane.

---

## 🔑 Key Concepts

### Inputs
- Voltage: `V[n]` (digital samples from external ADC)
- Current: `I[n]` (digital samples from external ADC)

### Outputs
- Control signal: `u[n]` → PWM duty or timing
- Protection & status flags (OV / OC / FAULT)

### Architecture
- PID controller (fixed-point, deterministic latency)
- FSM-based supervision (INIT / RUN / FAULT)
- PWM generator
- Register interface (SPI / GPIO)

All analog V–I conversion is intentionally kept **off-chip**.
This repository focuses on **pure digital ASIC design**.

---

## 🎯 Project Goals

Provide a **step-by-step ASIC design example**:

```
Control Theory
 → Fixed-Point Design
   → RTL
     → FSM & PWM
       → OpenLane
         → GDS
```

Demonstrate why **ASIC-based control** is superior to MCU-based control:

- Deterministic timing (no interrupts)
- Stable control period
- Reproducible behavior
- Explicit and provable safety logic

---

## 📁 Repository Structure

```text
vi-control-asic-sky130/
├─ README.md
├─ docs/
│  ├─ index.md
│  ├─ 00_overview.md
│  ├─ 01_control_model.md
│  ├─ 02_fixed_point.md
│  ├─ 03_rtl_pid.md
│  ├─ 04_fsm_pwm.md
│  └─ 05_openlane_flow.md
│
├─ rtl/
├─ sim/
├─ openlane/
└─ scripts/
```

---

## 🖼 GDS Layout (OpenLane + SKY130)

<img
  src="https://samizo-aitl.github.io/vi-control-asic-sky130/docs/layout/vi_control_top_gds_overview.png"
  alt="GDS layout overview"
  style="width:80%;"
/>

- Tool: OpenLane
- PDK: SKY130A
- Status: DRC / LVS clean, GDS generated

---

## 🚀 Intended Audience

This project is suitable for:

- Students learning digital control and VLSI
- Engineers migrating from MCU-based control to ASICs
- Educators building semiconductor teaching materials
- Developers evaluating OpenLane + SKY130 workflows

---

## 👤 Author

**Shinichi Samizo**  
M.S. in Electrical and Electronic Engineering, Shinshu University  
Former Engineer at Seiko Epson Corporation  

GitHub: [https://github.com/Samizo-AITL](https://github.com/Samizo-AITL)

---

## 📄 License

| Item | License |
|------|---------|
| Source Code | MIT |
| Documentation Text | CC BY 4.0 / CC BY-SA 4.0 |
| Figures & Diagrams | CC BY-NC 4.0 |

---

**Start with the control model.  
Understand the equations.  
Then build the silicon.**
