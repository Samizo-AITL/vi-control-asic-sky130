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

## 🔑 Key Concepts

- **Inputs**  
  - Voltage: `V[n]` (digital samples from external ADC)  
  - Current: `I[n]` (digital samples from external ADC)

- **Outputs**  
  - Control signal: `u[n]` → PWM duty / timing  
  - Protection & status flags (OV / OC / FAULT)

- **Architecture**  
  - PID controller (fixed-point, deterministic latency)  
  - FSM-based supervision (INIT / RUN / FAULT)  
  - PWM generator  
  - Register interface (SPI / GPIO)

> All analog V–I conversion is intentionally kept **off-chip**.  
> This repository focuses on **pure digital design**, fully compatible with
> OpenLane and SKY130 standard cells.

---

## 🎯 Project Goals

- Provide a **step-by-step ASIC design example**:

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

[![Hybrid License](https://img.shields.io/badge/license-Hybrid-blueviolet)](https://samizo-aitl.github.io/intersample-supervisory-control/#-license)

| Item | License | Description |
|------|---------|-------------|
| **Source Code** | MIT | Free to use, modify, redistribute |
| **Text Materials** | CC BY 4.0 / CC BY-SA 4.0 | Attribution & share-alike rules |
| **Figures & Diagrams** | CC BY-NC 4.0 | Non-commercial use |
| **External References** | Original license applies | Cite properly |

---

# 💬 Feedback

> Feedback, ideas, and discussions are welcome.

[![💬 GitHub Discussions](https://img.shields.io/badge/💬%20GitHub-Discussions-brightgreen?logo=github)](https://github.com/Samizo-AITL/intersample-supervisory-control/discussions)





