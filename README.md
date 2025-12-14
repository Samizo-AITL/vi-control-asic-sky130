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
```
Control Theory → Fixed-Point Design → RTL → OpenLane → GDS
```
- Demonstrate why **ASIC-based control** is superior to MCU-based control:
- Deterministic timing (no interrupts)
- Stable control period
- Reproducible behavior
- Clear safety logic

- Serve as a **foundation教材** for:
- Digital control engineers
- ASIC / VLSI beginners
- Industrial control applications

---

## 📁 Repository Structure

```text
vi-control-asic-sky130/
├─ README.md                # This file
├─ docs/                    # Educational documents (Markdown)
│  ├─ 00_overview.md
│  ├─ 01_control_model.md
│  ├─ 02_fixed_point.md
│  ├─ 03_rtl_pid.md
│  ├─ 04_fsm_pwm.md
│  └─ 05_openlane_flow.md
│
├─ rtl/                     # Verilog RTL
│  ├─ pid_core.v
│  ├─ fsm_controller.v
│  ├─ pwm_gen.v
│  ├─ reg_if_spi.v
│  └─ top.v
│
├─ sim/                     # Testbenches
│
├─ openlane/                # OpenLane configuration
│
└─ scripts/                 # Utility scripts (fixed-point, etc.)
```

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

### Error Definition (V–I Based)

The error $e[n]$ is defined using **Voltage–Current (V–I) feedback**.
The exact definition depends on the target system, but a typical form is:

$$
e[n] = V_{\text{ref}}[n] - V[n]
$$

or, when current feedback is required:

$$
e[n] = f\big(V[n], I[n]\big)
$$

where:

- $V[n]$ : measured voltage (digital sample)
- $I[n]$ : measured current (digital sample)

All voltage and current values are assumed to be converted
to digital form by **external ADCs**.

---

## 🔢 Fixed-Point Arithmetic

All control computations are implemented using **fixed-point arithmetic**.

### Design Principles

- Deterministic latency
- Saturation instead of wrap-around
- Explicit bit-width control
- Hardware-friendly implementation

A typical Q-format is:

- Voltage $V[n]$ : Qm.n
- Current $I[n]$ : Qm.n
- Control output $u[n]$ : Qp.q

Overflow and underflow are handled using **saturation logic**.

---

## 🧠 Control Architecture

The control core consists of the following digital blocks:

- **PID Core**  
  Computes $u[n]$ from $e[n]$ using fixed-point arithmetic.

- **FSM Supervisor**  
  Controls operating modes:
  - `INIT`
  - `RUN`
  - `FAULT`

- **PWM Generator**  
  Converts $u[n]$ into duty-cycle or timing signals.

- **Register Interface**  
  Allows gain parameters and status to be accessed via SPI or GPIO.

All blocks operate on a **single deterministic control clock**.

---

## ⏱ Deterministic Timing

Unlike MCU-based control systems:

- No interrupts
- No task scheduling
- No jitter caused by software execution

Each control cycle executes in a **fixed number of clock cycles**,
making the system suitable for safety-critical and industrial applications.

---

## 🛠 Technology Stack

- **Process**: SkyWater SKY130 (130 nm)
- **EDA Flow**: OpenLane (RTL → GDS)
- **HDL**: Verilog
- **Design Style**: Fully synchronous, single-clock
- **Target**: Digital-only ASIC (no on-chip ADC/DAC)

---

## 📘 Educational Philosophy

This project intentionally avoids:

- High-performance AI accelerators
- Complex mixed-signal integration
- Black-box IP dependencies

Instead, it focuses on:

- Transparency
- Explainability
- Reproducibility
- One-to-one mapping between equations and RTL

Every register, multiplier, and FSM transition
can be traced directly back to the control equations.

---

## 🚀 Intended Audience

This repository is suitable for:

- Students learning digital control and VLSI
- Engineers moving from MCU-based control to ASICs
- Educators building hands-on semiconductor教材
- Developers evaluating OpenLane + SKY130 workflows

---

## 📌 Project Status

- [ ] Control model definition
- [ ] Fixed-point format selection
- [ ] RTL implementation
- [ ] OpenLane synthesis
- [ ] Place & Route
- [ ] GDS generation

---

**Start with the control model.  
Understand the equations.  
Then build the silicon.**

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


