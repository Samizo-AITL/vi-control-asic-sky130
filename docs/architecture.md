# Architecture

## Purpose
This document describes the control architecture used in this repository.
The goal is not to improve PID tuning, but to **supervise discrete-time control behavior when implementation assumptions are violated**.

## Layered Structure

- Inner loop: Discrete-time PID controller (ZOH-based)
- Supervisory layer: Finite State Machine (FSM)

The FSM does not replace the PID.
It supervises the PID when intersample events or sampling-period variations degrade stability.

## Design Principle

- PID: performance-oriented, assumes nominal sampling
- FSM: safety- and robustness-oriented, assumes reality deviates from design

This separation allows the system to remain controllable even when
the discrete-time assumptions no longer hold.

## Architectural View

PID failures are treated as **system-level events**, not tuning mistakes.
The FSM acts as a design-level safeguard against implementation-induced instability.

