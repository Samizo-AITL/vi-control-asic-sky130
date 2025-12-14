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
| 🇺🇸 English | https://samizo-aitl.github.io/vi-control-asic-sky130/docs/ | https://github.com/Samizo-AITL/vi-control-asic-sky130/tree/main |

---

This repository provides a **complete, reproducible, and tapeout-ready example**
of a **digital control ASIC** based on **Voltage–Current (V–I) feedback**,
implemented with **PID control, FSM supervision, and PWM generation**
using **OpenLane** and **SkyWater SKY130**.

This is **not a partial experiment** or a tool demonstration.  
It documents a **finished and verified RTL-to-GDS ASIC design**.

---

## 📚 Documentation Roadmap

1. Overview  
   - docs/00_overview.md

2. Control Model  
   - docs/01_control_model.md

3. Fixed-Point Design  
   - docs/02_fixed_point.md

4. RTL: PID Core  
   - docs/03_rtl_pid.md

5. RTL: FSM & PWM  
   - docs/04_fsm_pwm.md

6. OpenLane Flow  
   - docs/05_openlane_flow.md

7. Gate-level Simulation (Functional)  
   - docs/06_gate_sim_functional.md

8. Appendix A: Figure List  
   - docs/appendix_figures.md

---

## 🎯 Project Goal

Provide a full ASIC design reference:

Control Theory  
→ Fixed-Point Design  
→ RTL  
→ FSM & PWM  
→ OpenLane  
→ GDS

---

## 📁 Repository Structure

vi-control-asic-sky130/
├─ README.md  
├─ docs/  
│  ├─ index.md  
│  ├─ 00_overview.md  
│  ├─ 01_control_model.md  
│  ├─ 02_fixed_point.md  
│  ├─ 03_rtl_pid.md  
│  ├─ 04_fsm_pwm.md  
│  ├─ 05_openlane_flow.md  
│  ├─ 06_gate_sim_functional.md  
│  └─ appendix_figures.md  
│  
├─ rtl/  
├─ sim/  
├─ openlane/  
└─ scripts/  

---

## ✅ Verification Status

- RTL functional simulation: COMPLETED  
- PID step response (P / PI): VERIFIED  
- FSM state transitions: VERIFIED  
- PWM timing: VERIFIED  
- STA timing closure: PASSED  
- DRC / LVS: CLEAN  

Gate-level timing simulation was intentionally omitted.
Timing correctness is guaranteed by STA.

---

## 👤 Author

Shinichi Samizo  
M.S. Electrical and Electronic Engineering  
Former Engineer, Seiko Epson Corporation

---

## 📄 License

Source Code: MIT  
Documentation: CC BY 4.0 / CC BY-SA 4.0  
Figures: CC BY-NC 4.0  

---

END OF DOCUMENT
