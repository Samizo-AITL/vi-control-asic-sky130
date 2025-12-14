---
layout: default
title: "FSM Supervisor & PWM Generator"
nav_order: 5
parent: "Documentation"
---

# 🧠 FSM Supervisor & PWM Generator

This chapter describes the **supervisory FSM** and the **PWM generator**,
which together ensure **safe, deterministic, and controllable behavior**
of the V–I control ASIC.

While the PID core computes *how much* to control,
the FSM decides *whether* control is allowed,
and the PWM generator decides *how* that control is applied in time.

---

## 🎯 Role of the FSM

The FSM (Finite State Machine) supervises the control system by:

- Enabling or disabling the PID core
- Monitoring fault conditions
- Enforcing safe transitions between operating modes
- Forcing outputs into a known safe state when required

This explicit, hardware-defined control logic is one of the key advantages
of ASIC-based control systems.

---

## 🔄 FSM States

The reference design uses three explicit states:

| State | Description |
|------|-------------|
| `INIT`  | Initialization, reset, and stabilization |
| `RUN`   | Normal closed-loop control operation |
| `FAULT` | Control disabled, outputs forced safe |

There are no implicit states and no software-managed flags.

---

## 🧩 State Transition Diagram (Conceptual)

```
    +------+
    | INIT |
    +------+
        |
        | start
        ▼
    +------+
    | RUN  |
    +------+
      |  ▲
fault | | clear
      ▼ |
   +-------+
   | FAULT |
   +-------+
```

- All transitions are synchronous
- No asynchronous or combinational state changes are allowed
- Transition conditions are evaluated on clock edges only

---

## 🚨 Fault Conditions (V–I Based)

Fault detection is based on **explicit voltage and current limits**.

Typical fault conditions include:

- **Over-voltage (OV)**  
  $V[n] > V_{\text{max}}$
- **Over-current (OC)**  
  $I[n] > I_{\text{max}}$

Additional fault sources may include:

- Watchdog timeout
- Internal arithmetic overflow
- External emergency stop signal

All fault conditions are synchronized to the control clock
before being evaluated by the FSM.

---

## 🔒 Behavior in FAULT State

When the FSM enters the `FAULT` state:

- PID computation is disabled (`enable = 0`)
- PWM output is forced to a safe value (typically logic 0)
- Integral accumulator is reset or frozen
- The system remains latched until an explicit clear/reset

This ensures the system always fails **safe**, not **active**.

---

## ⚡ PWM Generator Overview

The PWM generator converts the normalized control output $u[n]$
into a digital pulse waveform suitable for driving external power stages.

Key characteristics:

- Fixed PWM period
- Programmable duty cycle
- Synchronous update only at period boundaries
- No combinational glitches

---

## 🧮 PWM Operation

Let:

- $u[n] \in [0, 1]$ : normalized control output
- $T_{\text{PWM}}$ : PWM period
- $N$ : PWM counter maximum

The duty count is computed as:

$$
D_{\text{cnt}} = u[n] \times N
$$

The PWM output is asserted when:

$$
\text{counter} < D_{\text{cnt}}
$$

This structure guarantees cycle-accurate pulse widths.

---

## 🏗 PWM RTL Structure (Conceptual)

```
       u[n]
        │
        ▼
 +-------------+
 |  Duty Calc  |
 +-------------+
        │
        ▼
 +-------------+
 |  Counter    | ← fixed PWM period
 +-------------+
        │
        ▼
     PWM_OUT
```

The duty register is updated **only when the counter wraps**,
preventing mid-period glitches.

---

## ⏱ Deterministic System Behavior

Because:

- FSM transitions occur only on clock edges
- PWM period is fixed and known
- No asynchronous gating is used

The entire control system exhibits:

- Fixed latency
- Repeatable timing
- Fully analyzable worst-case behavior

This determinism is essential for industrial and safety-oriented control.

---

## 🧪 Verification Strategy

Recommended verification steps include:

- Exhaustive FSM state transition testing
- Forced OV / OC fault injection
- Verification that PWM output is disabled in `FAULT`
- Duty-cycle accuracy checks across the full range
- Reset and recovery behavior validation

Waveform inspection is strongly recommended.

---

## 📘 Educational Insight

In software systems, safety logic is often distributed and implicit.

In hardware systems, **safety is structural**:

- You can point to the exact gate that disables the output
- You can trace fault propagation cycle-by-cycle
- You can prove system behavior formally

This transparency is a major advantage of ASIC-based control design.

---

## ➡️ Next

Proceed to the final implementation stage:

➡️ **[OpenLane Flow](05_openlane_flow.md)**

The next chapter turns RTL into placed, routed,
and verified silicon.
