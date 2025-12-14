---
layout: default
title: "Gate-level Simulation (Functional)"
nav_order: 7
parent: "Documentation"
permalink: /docs/06_gate_sim_functional/
---

# 🔬 Gate-level Simulation (Functional)

This section documents the **gate-level functional simulation**
of the V–I Control ASIC after **OpenLane place-and-route completion**
using the **SkyWater SKY130** PDK.

The objective is to confirm that the **post-layout gate netlist**
is **logically equivalent** to the RTL design.

---

## 🎯 Purpose of Gate-level Simulation

The purpose of this simulation is **not timing validation**.

Instead, it verifies:

- Logical equivalence between RTL and gate netlist
- Correct reset and initialization behavior
- Deterministic FSM operation after synthesis and PnR
- Absence of functional mismatches or unknown (X) states

This corresponds to a **functional LEC-style check**
performed using simulation.

---

## 🛠 Simulation Configuration

| Item | Description |
|---|---|
| Simulator | iverilog |
| Netlist | OpenLane final gate-level Verilog |
| PDK | SkyWater SKY130 |
| Mode | Functional (no timing) |
| Delays | UNIT_DELAY |
| UDP | Not used |

Timing-aware gate-level simulation is intentionally omitted.
Timing correctness is verified separately by **static timing analysis (STA)**.

---

## 🧪 Testbench Strategy

The **same testbench** used for RTL simulation
is reused for gate-level simulation.

This ensures:

- Identical stimulus
- Cycle-by-cycle output comparison
- Direct functional equivalence checking

No gate-specific testbench modifications are required.

---

## ✅ Simulation Results Summary

The following conditions were verified:

- Reset sequence executes correctly
- FSM transitions match RTL behavior
- Control output (V–I based) matches RTL cycle-by-cycle
- No mismatches or X-propagation observed

Overall result:

> **Gate-level functional behavior is identical to RTL.**

---

## 📈 Waveform Inspection

### Reset and Initialization Sequence

<img
  src="https://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/gate_sim/reset_seq.png"
  alt="Gate-level reset sequence"
  style="width:60%;"
/>

This waveform confirms correct synchronous reset release
and FSM initialization.

---

### Normal Control Operation

<img
  src="https://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/gate_sim/waveform_ok.png"
  alt="Gate-level functional waveform"
  style="width:60%;"
/>

The control output and FSM state evolution
match the RTL simulation exactly.

---

## 🧠 Interpretation

This gate-level functional simulation confirms that:

- Logic synthesis preserved RTL intent
- Place-and-route did not introduce functional errors
- The control algorithm is robust against structural transformations

Combined with:

- RTL simulation
- DRC / LVS clean layout
- STA timing closure

the design is considered **functionally and structurally correct**.

---

## 🚫 Why Gate-level Timing Simulation Is Not Performed

Gate-level timing simulation is not performed for the following reasons:

- Timing correctness is already guaranteed by STA
- UDP-based SKY130 cell models are not simulator-friendly
- Functional correctness is the primary educational objective

This approach reflects **common industry practice**
for digital ASIC control designs.

---

## ✔ Verification Status

- ✅ RTL simulation
- ✅ Gate-level functional simulation
- ✅ OpenLane PnR (DRC / LVS / STA clean)
- ⏭ Gate-level timing simulation (not performed)

---

## ➡️ Next

Proceed to:

➡️ **[OpenLane Flow Summary](05_openlane_flow.md)**  

to review synthesis, placement, routing,
and layout verification results.
