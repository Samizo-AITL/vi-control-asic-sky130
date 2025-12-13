# intersample-supervisory-control

Supervisory FSM design for discrete-time control instability caused by intersample disturbances and sampling-period variations.

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


-```--

## Instability Indicators (Examples)

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


