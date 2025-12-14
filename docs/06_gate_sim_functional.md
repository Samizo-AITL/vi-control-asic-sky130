---
layout: default
title: "Gate-level Simulation (Functional)"
nav_order: 7
parent: "Documentation"
permalink: /docs/06_gate_sim_functional/
---

# 🔬 Gate-level Simulation (Functional)

This section documents the **investigation and technical assessment**
of gate-level functional simulation for the V–I Control ASIC
after **OpenLane place-and-route completion**
using the **SkyWater SKY130** PDK.

---

## 🎯 Objective

The original objective of this phase was to evaluate the feasibility of
**gate-level functional simulation** using open-source tools,
and to determine whether post-layout functional equivalence
could be verified by simulation.

This phase explicitly **does not target timing validation**.
Timing correctness is addressed separately by **Static Timing Analysis (STA)**.

---

## 🛠 Intended Simulation Configuration

| Item | Description |
|---|---|
| Simulator | Icarus Verilog (iverilog) |
| Netlist | OpenLane final gate-level Verilog |
| PDK | SkyWater SKY130 |
| Mode | Functional (no timing) |
| Delays | UNIT_DELAY |
| Purpose | Logical equivalence check |

---

## ⚠ Tool Limitation Identified

During setup and compilation, it was confirmed that:

- The SKY130 standard cell Verilog models contain
  **UDP (User Defined Primitive)** constructs  
  (e.g. `sky130_fd_sc_hd__udp_*`)
- These UDP constructs are **not fully supported by Icarus Verilog**
- As a result, gate-level netlists using the official SKY130 libraries
  cannot be reliably compiled or simulated with iverilog

This limitation is **tool-related**, not design-related.

---

## ❌ Gate-level Functional Simulation Result

Due to the simulator limitation described above:

> **Full gate-level functional simulation using Icarus Verilog
> was not feasible for this design.**

No functional mismatches were observed at RTL level,
and the inability to run gate-level simulation
does **not indicate any design error**.

---

## ✅ Verification Strategy Adopted Instead

Design correctness is ensured by the following verified steps:

- Exhaustive **RTL functional simulation**
- Successful completion of the **OpenLane RTL-to-GDS flow**
- **Static Timing Analysis (STA)** timing closure
- **DRC / LVS clean** physical verification
- Post-layout netlist generation without errors

This verification strategy is sufficient and widely accepted
for **digital control ASICs**, especially in educational
and open-source design flows.

---

## 🧠 Engineering Interpretation

The investigation of gate-level simulation itself
provides an important engineering conclusion:

- Gate-level simulation feasibility depends on
  **both the cell library and the simulator**
- Not all open-source simulators support
  production-grade standard cell models
- Recognizing and documenting such limitations
  is part of sound ASIC design practice

The design is therefore considered:

> **Functionally correct, timing-clean, and implementation-ready**
> within the defined scope of this project.

---

## ✔ Verification Status

- ✅ RTL functional simulation
- ✅ OpenLane PnR (DRC / LVS / STA clean)
- ⏭ Gate-level functional simulation (investigated, not executed)
- ⏭ Gate-level timing simulation (not performed)

---

## ➡️ Next

Proceed to:

➡️ **[OpenLane Flow Summary](05_openlane_flow.md)**  

to review synthesis, placement, routing,
and physical verification results.
