# FSM Design

## FSM Role

The FSM supervises the PID controller by monitoring instability indicators
and switching control modes when early signs of instability are detected.

The FSM operates outside the PID loop.

## FSM States

- NORMAL  
  Nominal PID operation.

- DEGRADED  
  Conservative control mode (reduced gains, limited integral action).

- SAFE  
  Safety-oriented mode (output limiting, ramp-down, or hold).

## Instability Indicators

Typical indicators include:
- Growth of tracking error (moving average or rate)
- Frequent sign changes in error (oscillation)
- Control input saturation
- Excessive control input variation

Indicators are evaluated continuously.

## State Transitions

- NORMAL → DEGRADED  
  Triggered when instability indicators exceed predefined thresholds.

- DEGRADED → SAFE  
  Triggered when degradation persists or worsens.

- DEGRADED → NORMAL  
  Allowed only after indicators remain within safe bounds
  for a sufficient duration (hysteresis applied).

FSM transitions are based on **early indicators**, not complete instability.

