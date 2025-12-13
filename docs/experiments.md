# Experiments

## Objective

The experiments demonstrate how intersample disturbances
and sampling-period variations affect discrete-time control behavior,
and how the supervisory FSM intervenes.

## Scenarios

Typical scenarios include:
- Gradual increase of sampling period Ts
- Injection of disturbances between sampling instants
- Combination of Ts variation and actuator saturation

## Observations

The following signals are observed:
- Plant output
- Tracking error
- Control input
- FSM state transitions

The focus is on **when and why the FSM intervenes**, not on waveform aesthetics.

## Expected Outcome

- PID-only control shows oscillatory or unstable behavior
- FSM detects early degradation
- Control mode is switched before complete instability occurs

These experiments illustrate architectural robustness rather than controller optimality.

