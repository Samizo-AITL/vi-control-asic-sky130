---
layout: default
title: "OpenLane Flow"
nav_order: 6
parent: "Documentation"
---

# 🏭 OpenLane Flow (RTL → GDS)

This chapter explains how the RTL developed in previous chapters
is transformed into a **manufacturable ASIC layout (GDS)**
using **OpenLane** and **SkyWater SKY130**.

The focus is on **understanding the flow**, not just running commands.

---

## 🎯 Goal of This Chapter

By the end of this chapter, you will understand:

- What happens at each stage of the OpenLane flow
- Why each step is required
- How to interpret basic PPA results
- How digital control logic maps onto silicon

---

## 🧰 Toolchain Overview

The OpenLane flow uses the following main components:

- **Yosys** – RTL synthesis
- **OpenROAD** – Floorplan, placement, CTS, routing
- **Magic / KLayout** – Layout and DRC
- **Netgen** – LVS

All steps target the **SKY130 open PDK**.

---

## 📂 OpenLane Directory Structure

A typical OpenLane design directory looks like this:

```text
openlane/
└─ vi_control_core/
   ├─ config.tcl
   ├─ pin_order.cfg
   └─ runs/
```

The config.tcl file defines
clock, utilization, and design constraints.

---

## ⚙️ Key Configuration Parameters

Important parameters in config.tcl include:

DESIGN_NAME
VERILOG_FILES
CLOCK_PORT
CLOCK_PERIOD
FP_CORE_UTIL

Example (conceptual):

```
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "20.0"
set ::env(FP_CORE_UTIL) 50
```

These values directly affect
timing, area, and routability.

---

## 🧠 Step 1: Synthesis

During synthesis:

RTL is translated into a gate-level netlist
Flip-flops, adders, and multipliers are mapped to standard cells

Key outputs:
Gate count
Estimated timing
Area estimate
This is the first point where silicon cost becomes visible.

---

## 🧱 Step 2: Floorplanning

Floorplanning defines:
Core area size
Aspect ratio

IO pin placement
Power grid strategy

For control ASICs:
Moderate utilization (40–60%) is recommended
Simple rectangular layouts are sufficient

---

## 🧭 Step 3: Placement

During placement:
Standard cells are placed inside the core area
Timing-driven optimization is applied

At this stage, you can observe:
Cell density
Early timing slack
Congested regions

---

## ⏱ Step 4: Clock Tree Synthesis (CTS)

CTS inserts clock buffers to ensure:
Low skew
Balanced clock distribution

For this design:
Single clock domain
No gated clocks
This simplicity greatly improves robustness.

---

## 🛣 Step 5: Routing

Routing connects all placed cells:
Global routing
Detailed routing

Key checks:
No open nets
Acceptable congestion
Reasonable wire lengths

---

## 🔍 Step 6: DRC and LVS

Final sign-off checks:

DRC (Design Rule Check):
Ensures layout follows manufacturing rules

LVS (Layout vs. Schematic):
Ensures layout matches the netlist

Passing both checks is mandatory
for tapeout readiness.

---

## 📊 PPA Analysis

After completion, evaluate:
Performance: Maximum clock frequency
Power: Estimated dynamic and leakage power
Area: Core and die size

For educational control ASICs:
Performance margins are usually generous
Area is dominated by arithmetic units
Power is modest due to low frequency

## 🧠 Educational Insight

Seeing RTL transformed into geometry
is a critical learning moment.

At this point, you should be able to:
Point to where the PID logic lives on silicon
Relate control complexity to chip area
Understand timing as a physical property

---

## 🏁 Completion

```
You have now completed the full journey:
Control Theory
 → Fixed-Point Arithmetic
   → RTL Design
     → FSM & PWM
       → OpenLane
         → GDS
```

This is the essence of practical digital ASIC design.

---

## 📌 Next Steps (Optional)

Possible extensions include:
Adding SPI register interfaces
Integrating test features
Exploring alternative clock periods
Tapeout via MPW services

---

## 🎉 Congratulations

You have reached the end of the core documentation.

If you understand every chapter in this project,
you understand how to build a real control ASIC.






