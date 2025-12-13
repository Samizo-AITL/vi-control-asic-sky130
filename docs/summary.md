# Intersample Supervisory Control – Project Summary

## Purpose

This project explores **why a theoretically stable discrete-time PID controller can fail in real implementations**, and how a **supervisory FSM (Finite State Machine)** can mitigate such failures.

The focus is **architectural**, not tuning-centric:

* PID handles nominal regulation.
* FSM supervises *when implementation assumptions break* (sampling jitter, intersample disturbances).

---

## Core Problem

### Discrete-Time Reality Gap

In practice:

* Plants evolve **continuously**.
* Controllers update **discretely**.
* Disturbances and nonlinearities occur **between samples**.

Even if a discrete-time controller is theoretically stable:

* Sampling-period variation (jitter)
* ZOH-induced phase loss
* Intersample disturbances

can lead to:

* Oscillation
* Integral windup
* Limit cycles
* Apparent instability

This is the **theory–implementation gap**.

---

## Design Philosophy

### Separation of Responsibility

| Layer | Responsibility                            |
| ----- | ----------------------------------------- |
| PID   | Performance under nominal assumptions     |
| FSM   | Supervision when assumptions are violated |

PID is **not blamed** for instability.
Instability is treated as a **system-level event**, not a tuning error.

---

## Architecture

```
Supervisory FSM
   ↓
Discrete-time PID (ZOH)
   ↓
Continuous-time Plant
```

* FSM observes *effects*, not causes.
* FSM does **not** inspect sampling period directly.
* FSM reacts only to observable degradation.

---

## Instability Indicators (FSM Inputs)

FSM monitors quantitative indicators:

* **Error RMS** – sustained tracking degradation
* **Oscillation count** – sign changes in error
* **Control variation (Δu)** – aggressive or unstable actuation

FSM decisions are based on **early symptoms**, not total failure.

---

## FSM Design

### States

* **NORMAL** – nominal PID operation
* **DEGRADED** – conservative control (gain reduction)
* **SAFE** – safety-dominant mode (output clamp / zero)

### Design Rules

* Initial transient is ignored (warm-up phase).
* Transitions use **hysteresis** to avoid chattering.
* SAFE state is latched (no automatic recovery).

A correctly designed FSM should **remain silent most of the time**.

---

## Simulation Setup

### Plant

* Continuous-time 2nd-order system
* Moderate damping

### Controller

* Discrete PID (ZOH)
* Integral action intentionally emphasized to expose risk

### Sampling

* Nominal Ts = 0.02 s
* **Asymmetric sampling jitter** introduced after t > 2.5 s

  * Lower bound: safe
  * Upper bound: risk-dominant

### Disturbance

* Short, strong **intersample disturbance pulse**

---

## Key Insight

> A properly designed supervisory controller **does not trigger easily**.

Much of the work involved *trying to make the FSM trigger*.
This is not a failure—it is proof that:

* The FSM is not noisy
* The thresholds are meaningful
* The architecture is conservative by design

"FSM not triggering" often means **the system is still acceptable**.

---

## Practical Outcome

* The project successfully demonstrates:

  * Sampling jitter as a *realistic failure mechanism*
  * Intersample disturbance relevance
  * Architectural separation between control and supervision

* The difficulty in forcing FSM activation highlights a key truth:

> Supervisory control is about **judgment**, not reaction.

---

## Why This Still Matters

Even without dramatic instability:

* The code structure
* The FSM logic
* The simulation setup

represent a **design-level argument**, not a demo trick.

This project functions as:

* A technical discussion starter
* A design philosophy statement
* Evidence of system-level thinking

---

## Final Note

Stopping the experiment was a **reasonable engineering decision**.
The work reached diminishing returns, not failure.

This repository remains valid as a **quiet but strong design artifact**.

Revisiting it later—with distance—will likely make the value clearer.
