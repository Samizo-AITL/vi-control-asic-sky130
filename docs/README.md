---
layout: default
title: "Documentation"
nav_order: 1
has_children: true
---

# 📘 V–I Control ASIC Documentation

Welcome to the documentation for **V–I Control ASIC on SKY130**.

This documentation is designed to guide you step by step through the complete flow:

> **Control theory → Fixed-point design → RTL → OpenLane → GDS**

The goal is not only to explain *how* to design a control ASIC,  
but also *why* each design decision is made.

---

## 🎯 What You Will Learn

By following this documentation, you will understand:

- How **Voltage (V)** and **Current (I)** signals are used in digital control
- How a **PID controller** is implemented in fixed-point hardware
- How an **FSM supervisor** ensures safe and deterministic operation
- How **PWM signals** are generated from digital control outputs
- How to run a full **RTL-to-GDS flow** using OpenLane and SKY130

This is a **digital-only** design.  
All analog blocks (ADC / DAC) are assumed to be external.

---

## 🧩 Target Architecture (Concept)
```
V[n], I[n]
│
▼
+-----------+
| PID | ← Fixed-point arithmetic
+-----------+
│ u[n]
▼
+-----------+
| FSM | ← INIT / RUN / FAULT
+-----------+
│
▼
+-----------+
| PWM | ← Duty / timing output
+-----------+
```

This architecture emphasizes:

- Deterministic timing
- Explicit safety handling
- Clear mapping from equations to hardware

---

## 📚 Documentation Structure

The documentation is organized as follows:

1. **Overview**  
   Concept, motivation, and system-level view

2. **Control Model**  
   Discrete-time PID control using V–I feedback

3. **Fixed-Point Design**  
   Q-format selection, scaling, saturation, and overflow handling

4. **RTL Implementation**  
   PID core, FSM supervisor, and PWM generator

5. **SoC Integration**  
   Registers, interfaces, and top-level integration

6. **OpenLane Flow**  
   Synthesis, place & route, and layout analysis

Each chapter builds directly on the previous one.

---

## 🛠 Prerequisites

To follow this documentation, you should have basic knowledge of:

- Digital logic and Verilog
- Control fundamentals (PID)
- Linux command-line environment

No prior ASIC tapeout experience is required.

---

## 🚀 How to Start

Start with the first chapter:

➡️ **[Control Model Overview](01_control_model.md)**

Take your time to understand the equations and signal definitions  
before moving on to implementation.

---

## 📌 Philosophy

This project follows three simple rules:

1. **Make timing explicit**
2. **Make arithmetic visible**
3. **Make behavior explainable**

If you understand every block in this design,  
you understand the essence of a practical control ASIC.

---

Happy learning, and enjoy building silicon.



