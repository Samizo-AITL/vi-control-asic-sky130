---
layout: default
title: "V–I Control ASIC on SKY130"
nav_order: 1
---

# V–I Control ASIC on SKY130  
**PID + FSM + PWM using OpenLane (Educational & Practical)**

---

## 🔗 Official Links

| Language | GitHub Pages 🌐 | GitHub 💻 |
|----------|----------------|-----------|
| 🇺🇸 English | [![GitHub Pages EN](https://img.shields.io/badge/GitHub%20Pages-English-brightgreen?logo=github)](https://samizo-aitl.github.io/vi-control-asic-sky130/) | [![GitHub Repo EN](https://img.shields.io/badge/GitHub-English-blue?logo=github)](https://github.com/Samizo-AITL/vi-control-asic-sky130/tree/main) |

[![Back to Samizo-AITL Portal](https://img.shields.io/badge/Back%20to%20Samizo--AITL%20Portal-brightgreen)](https://samizo-aitl.github.io) 

---

This repository provides a **complete, reproducible, and tapeout-oriented**
example of a **digital control ASIC** based on **Voltage–Current (V–I) feedback**.

The design integrates:

- **PID control** (fixed-point, deterministic)
- **FSM-based supervision** (INIT / RUN / FAULT)
- **PWM generation**
- **RTL → GDS flow using OpenLane**
- **SKY130 standard-cell technology**

This is **not a tutorial fragment** or tool demo.  
It is a **finished and verified reference ASIC design**.

---

## 🎯 What This Project Is

This project is both:

- 📘 **Educational** — explaining *why* each design decision is made  
- 🧩 **Practical** — showing *how* to implement a real control ASIC

Scope:

```
Control Theory
 → Fixed-Point Arithmetic
   → RTL Design
     → Verification
       → OpenLane
         → GDS
```

All analog blocks (ADC / DAC) are assumed **off-chip**.  
The focus is **pure digital ASIC control logic**.

---

## 🧠 Architecture Overview

```
V[n], I[n]   (from external ADC)
   │
   ▼
+-----------+
| PID Core |  Fixed-point arithmetic
+-----------+
     │ u[n]
     ▼
+-----------+
| FSM Ctrl |  INIT / RUN / FAULT supervision
+-----------+
     │
     ▼
+-----------+
| PWM Gen |  Duty / timing output
+-----------+
```

---

## 📚 Documentation

All technical documentation lives under `docs/`.

➡️ **Start here:**  
👉 [Documentation Index](docs/index.md)

The documentation is structured as a **linear design narrative**:

1. System overview and philosophy  
2. Control model (PID with V–I feedback)  
3. Fixed-point design methodology  
4. RTL implementation  
5. FSM supervision and PWM  
6. OpenLane RTL-to-GDS flow  
7. Gate-level functional verification  
8. Appendix with complete figure index  

---

## ✅ Verification Status

This project is **verification complete** within its defined scope.

### Completed

- ✅ RTL functional simulation
- ✅ PID step response verification (P / PI)
- ✅ FSM state transition verification
- ✅ PWM duty and timing verification
- ✅ Gate-level **functional** simulation (post-layout)
- ✅ Static Timing Analysis (STA) closure
- ✅ DRC / LVS clean (OpenLane)

### Intentionally Omitted

- ⏭ Gate-level **timing simulation**  
  (STA used instead; UDP-based SKY130 models are not simulator-friendly)

This reflects **real-world ASIC development practice**.

---

## 🖼 Physical Implementation

<img
  src="docs/layout/vi_control_top_gds_overview.png"
  alt="GDS layout overview"
  style="width:85%;"
/>

- Tool: OpenLane
- PDK: SKY130A
- Status: DRC / LVS clean, GDS generated

---

## 🎓 Intended Audience

- Students learning digital control and ASIC design
- Engineers moving from MCU-based to hardware control
- Educators building semiconductor coursework
- Developers evaluating OpenLane + SKY130

---

## 👤 Author

| 📌 Item | Details |
|--------|---------|
| **Name** | Shinichi Samizo |
| **Education** | M.S. in Electrical and Electronic Engineering, Shinshu University |
| **Career** | Former Engineer at Seiko Epson Corporation (since 1997) |
| **Expertise** | Semiconductor devices (logic, memory, high-voltage mixed-signal)<br>Thin-film piezo actuators for inkjet systems<br>PrecisionCore printhead productization, BOM management, ISO training |
| **Email** | [![Email](https://img.shields.io/badge/Email-shin3t72%40gmail.com-red?style=for-the-badge&logo=gmail)](mailto:shin3t72@gmail.com) |
| **X (Twitter)** | [![X](https://img.shields.io/badge/X-@shin3t72-black?style=for-the-badge&logo=x)](https://x.com/shin3t72) |
| **GitHub** | [![GitHub](https://img.shields.io/badge/GitHub-Samizo--AITL-blue?style=for-the-badge&logo=github)](https://github.com/Samizo-AITL) |

---

# 📄 License

[![Hybrid License](https://img.shields.io/badge/license-Hybrid-blueviolet)](https://samizo-aitl.github.io/vi-control-asic-sky130//#-license)

| Item | License | Description |
|------|---------|-------------|
| **Source Code** | MIT | Free to use, modify, redistribute |
| **Text Materials** | CC BY 4.0 / CC BY-SA 4.0 | Attribution & share-alike rules |
| **Figures & Diagrams** | CC BY-NC 4.0 | Non-commercial use |
| **External References** | Original license applies | Cite properly |

---

# 💬 Feedback

> Feedback, ideas, and discussions are welcome.

[![💬 GitHub Discussions](https://img.shields.io/badge/💬%20GitHub-Discussions-brightgreen?logo=github)](https://github.com/Samizo-AITL/vi-control-asic-sky130//discussions)


