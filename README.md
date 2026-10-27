# Elevator-Controller-using-Verilog.
Four-floor elevator controller using Verilog HDL and finite state machine (FSM), with a simulation testbench.

## Overview
This project implements a four-floor elevator controller using Verilog HDL and a Finite State Machine (FSM). It controls elevator movement based on floor requests and supports an emergency stop feature.

## State Diagram

The elevator controller uses a Finite State Machine (FSM) with four states: Idle, Move Up, Move Down, and Emergency.

![Elevator Controller State Diagram](Elevator Controller State Diagram.png)


## Features
- Four-floor operation (Floor 0 to Floor 3)
- FSM-based control with Idle, Move Up, Move Down, and Emergency states
- Floor request selection using priority logic
- Upward and downward movement control
- Emergency stop functionality
- Verilog testbench for simulation and verification

## Inputs
| Signal | Description |
|---|---|
| `clk` | Clock input |
| `rst` | Active-high reset |
| `floor_req[3:0]` | Floor request inputs |
| `emergency_stop` | Emergency stop input |

## Outputs
| Signal | Description |
|---|---|
| `move_up` | Activates upward movement |
| `move_down` | Activates downward movement |
| `motor_stop` | Indicates that the motor should stop |
| `current_floor[1:0]` | Indicates the current floor |

## Files
- `lift_controller.v` — Main elevator controller design
- `tb_lift_controller.v` — Testbench for simulation

## Simulation
1. Add both Verilog files to your simulator.
2. Set `tb_lift_controller` as the simulation top module.
3. Run the simulation.
4. Observe the console output and signal waveforms.

The testbench checks floor requests and emergency stopping.

## Tools and Technologies
- Verilog HDL
- Finite State Machine (FSM)
- Digital Logic Design
- RTL Simulation

## Note
This is an educational simulation project. It does not include the safety systems required for a real elevator.
