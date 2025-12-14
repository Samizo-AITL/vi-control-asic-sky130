---
layout: default
title: "FSM Supervisor & PWM Generator"
nav_order: 5
parent: "Documentation"
---

# 🧠 FSM Supervisor & PWM Generator

This chapter introduces the **supervisory FSM** and the **PWM generator**,
which together ensure **safe, deterministic, and controllable behavior**
of the V–I control ASIC.

While the PID core computes *how much* to control,
the FSM decides *whether* control is allowed.

---

## 🎯 Role of the FSM

The FSM (Finite State Machine) supervises the control system by:

- Enabling or disabling the PID core
- Monitoring fault conditions
- Enforcing safe transitions between modes

This explicit control logic is one of the key advantages
of hardware-based control systems.

---

## 🔄 FSM States

The reference design uses three states:

| State | Description |
|------|-------------|
| `INIT`  | Initialization and reset |
| `RUN`   | Normal control operation |
| `FAULT` | Control disabled, safe state |

---

## 🧩 State Transition Diagram

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
+------+
|FAULT |
+------+
```


- Transitions are synchronous
- No asynchronous behavior is allowed

---

## 🚨 Fault Conditions (V–I Based)

Faults are detected using voltage and current limits:

- Over-voltage (OV):  
  $V[n] > V_{\text{max}}$
- Over-current (OC):  
  $I[n] > I_{\text{max}}$

Additional fault sources may include:

- Watchdog timeout
- Internal arithmetic overflow
- External emergency stop

---

## 🔒 Behavior in FAULT State

When the FSM enters `FAULT`:

- PID computation is disabled
- PWM output is forced to a safe value (typically 0)
- Integral accumulator is reset or frozen

This guarantees that the system fails **safe**, not **active**.

---

## ⚡ PWM Generator Overview

The PWM generator converts the control output $u[n]$
into a digital pulse train.

Key characteristics:

- Fixed PWM period
- Programmable duty cycle
- Synchronous update

---

## 🧮 PWM Operation

Let:

- $u[n] \in [0, 1]$ (normalized control output)
- $T_{\text{PWM}}$ : PWM period

The duty cycle is:

$$
D = u[n] \times 100\%
$$

The PWM output is high for:

$$
T_{\text{ON}} = D \times T_{\text{PWM}}
$$

---

## 🏗 RTL Structure (Concept)

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
 |  Counter    | ← PWM period
 +-------------+
        │
        ▼
    PWM_OUT
```


The duty value is updated **only at PWM period boundaries**
to avoid glitches.

---

## ⏱ Deterministic Behavior

- FSM transitions occur only on clock edges
- PWM period is fixed
- No asynchronous gating

As a result, the system behavior is fully deterministic
and easy to analyze.

---

## 🧪 Verification Strategy

Recommended checks:

- Verify all FSM transitions
- Force OV / OC conditions and observe FAULT entry
- Confirm PWM output is disabled in FAULT
- Check duty-cycle correctness

Simulation waveforms are especially useful here.

---

## 📘 Educational Insight

In software, safety logic is often scattered across code.

In hardware, **safety is structural**:
- You can point to the exact gate that disables output
- You can prove behavior cycle-by-cycle

This clarity is a major advantage of ASIC-based control.

---

## ➡️ Next

Proceed to:

➡️ **[OpenLane Flow](05_openlane_flow.md)**

The final chapter turns RTL into silicon.




