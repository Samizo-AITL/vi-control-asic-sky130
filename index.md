---
layout: default
title: Documentation Index
nav_order: 1
---

# intersample-supervisory-control

Supervisory FSM design for discrete-time control instability caused by intersample disturbances and sampling-period variations.

---

## 🔗 Official Links

| Language | GitHub Pages 🌐 | GitHub 💻 |
|----------|----------------|-----------|
| 🇺🇸 English | [![GitHub Pages EN](https://img.shields.io/badge/GitHub%20Pages-English-brightgreen?logo=github)](https://samizo-aitl.github.io/intersample-supervisory-control/) | [![GitHub Repo EN](https://img.shields.io/badge/GitHub-English-blue?logo=github)](https://github.com/Samizo-AITL/intersample-supervisory-control/tree/main) |

---

## Overview

This repository demonstrates **why a theoretically stable discrete-time PID controller can become unstable in real implementations**, and how a **supervisory finite state machine (FSM)** can mitigate such failures.

The focus is not on PID tuning itself, but on **architectural supervision**:
detecting early signs of instability caused by **intersample disturbances**, **sampling-period variations**, and **implementation-side delays**, and switching control modes accordingly.

This reflects real-world control failures observed in embedded systems, industrial automation, and manufacturing equipment.

---

## Problem Statement

In discrete-time control systems:

- Control inputs are updated only at sampling instants
- The plant evolves continuously between samples
- Disturbances and nonlinear effects may occur **between samples**

As a result:

- State deviations may grow unnoticed
- Effective phase margin degrades
- Integral windup, oscillations, or limit cycles may occur

These failures can arise **even when the discrete-time closed-loop system is theoretically stable**.

---

## Key Idea

This repository introduces a **supervisory FSM layer** placed outside the PID loop:

- **PID** handles continuous regulation under nominal conditions
- **FSM** monitors instability indicators and supervises control modes
- (Optional extension) **Higher-level reasoning** can be layered on top

The FSM does not replace the PID controller.
It **protects the system when assumptions behind the PID design are violated**.

---

## System Architecture

```
+----------------------------+
| Supervisory FSM Layer |
| - Instability detection |
| - Mode switching |
+-------------+---------------+
|
+-------------v---------------+
| PID Controller |
| (Discrete-time, ZOH) |
+-------------+---------------+
|
+-------------v---------------+
| Plant |
| (Continuous-time dynamics) |
+-----------------------------+
```
---

# Instability Indicators (Examples)

The FSM monitors observable signals such as:

- Tracking error growth (moving average or rate)
- Sign changes indicating oscillatory behavior
- Control input saturation or excessive variation
- Degradation of apparent damping

FSM transitions are triggered by **early instability indicators**, not by complete loss of stability.

---

## FSM Control Modes

A minimal configuration includes:

- **NORMAL**  
  Nominal PID control

- **DEGRADED**  
  Conservative gains, integral suppression, or reduced bandwidth

- **SAFE**  
  Output limiting, ramp-down, or hold behavior

Hysteresis is used to prevent mode chattering.

---

## Demonstration Scenario

Typical experiments include:

- Gradually increasing the sampling period \( T_s \)
- Injecting intersample disturbances
- Observing:
  - Output response
  - Control input behavior
  - FSM state transitions

The emphasis is on **how and when the supervisory layer intervenes**.

---

##　Scope and Non-Goals

This repository intentionally avoids:

- Advanced PID auto-tuning
- Optimal or adaptive control design
- Machine-learning-based controllers

The goal is **architectural clarity**, not algorithmic novelty.

---

## Intended Audience

This project is intended for:

- Control system designers
- Embedded and real-time control engineers
- Industrial automation and equipment developers
- Engineers who have experienced "the controller works on paper, but fails in practice"

---

## License

MIT License

---

## Author

Shinichi Samizo  
(Design philosophy: PID × FSM × Supervisory architectures)


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




