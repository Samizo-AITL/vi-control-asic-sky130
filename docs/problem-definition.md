# Problem Definition

## Discrete-Time Control Limitation

In discrete-time control systems, control inputs are updated only at sampling instants.
Between samples, the plant evolves continuously without feedback updates.

## Intersample Disturbances

Disturbances and state changes may occur between sampling instants, including:
- Load changes
- External impulses
- Nonlinear effects (saturation, friction)

These effects are invisible to the controller until the next sample.

## Sampling-Period Variations

In real systems, the sampling period may vary due to:
- CPU load
- Communication delays
- Integrated supervisory control

Sampling-period variations effectively increase phase delay
and reduce closed-loop robustness.

## Resulting Issue

Even if the discrete-time closed-loop system is theoretically stable,
the actual implementation may exhibit:
- Oscillations
- Integral windup
- Limit cycles
- Apparent instability

This gap between theory and implementation is the core problem addressed here.

