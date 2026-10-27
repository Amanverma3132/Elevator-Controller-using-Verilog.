
# Elevator Controller Using Verilog HDL

## Project Overview

This project implements a **4-floor elevator controller** using Verilog HDL. The controller manages elevator movement based on floor requests and controls the motor signals to move the elevator up, down, or stop.

A Finite State Machine (FSM) is used to control the elevator's operation. An emergency stop input is also included to stop the elevator during an emergency condition.

## Features

- Supports four floors: Floor 0, Floor 1, Floor 2, and Floor 3.
- Moves the elevator upward or downward according to the requested floor.
- Uses an FSM with four states.
- Includes an emergency stop feature.
- Provides separate signals for upward movement, downward movement, and motor stopping.
- Includes a Verilog testbench for simulation and verification.

## State Diagram

The controller uses four states:

1. **IDLE** – The elevator remains stopped.
2. **MOVE UP** – The elevator moves to a higher floor.
3. **MOVE DOWN** – The elevator moves to a lower floor.
4. **EMERGENCY** – The elevator stops when the emergency signal is activated.

![Elevator Controller State Diagram](Elevator Controller State Diagram.png)

## FSM State Encoding

| State | Encoding |
|---|---|
| IDLE | `00` |
| MOVE UP | `01` |
| MOVE DOWN | `10` |
| EMERGENCY | `11` |

## Inputs and Outputs

### Inputs

| Signal | Width | Description |
|---|---:|---|
| `clk` | 1 bit | Clock signal |
| `rst` | 1 bit | Active-high asynchronous reset |
| `floor_req` | 4 bits | Floor request inputs for floors 0–3 |
| `emergency_stop` | 1 bit | Emergency stop input |

### Outputs

| Signal | Width | Description |
|---|---:|---|
| `move_up` | 1 bit | Enables upward movement |
| `move_down` | 1 bit | Enables downward movement |
| `motor_stop` | 1 bit | Indicates that the motor should stop |
| `current_floor` | 2 bits | Indicates the current floor (0–3) |

## Working Principle

1. After reset, the elevator starts at Floor 0 in the IDLE state.
2. The controller checks the requested floor and compares it with the current floor.
3. If the target floor is higher than the current floor, the controller enters MOVE UP.
4. If the target floor is lower than the current floor, the controller enters MOVE DOWN.
5. When the target floor is reached, the controller returns to IDLE.
6. If `emergency_stop` is activated, the controller enters the EMERGENCY state and asserts the motor stop signal.
7. After the emergency signal is removed, the controller returns to IDLE.

**Note:** When multiple floor requests are active simultaneously, the current implementation selects the lowest-numbered requested floor first (Floor 0 has the highest priority).

## Project Files

| File | Description |
|---|---|
| `lift_controller.v` | Main Verilog module implementing the elevator controller |
| `tb_controller.v` | Testbench used to verify the controller |
| `state_diagram.png` | FSM state diagram |

## Simulation and Testing

The testbench can be used to verify the following scenarios:

- Resetting the elevator to Floor 0.
- Moving the elevator to Floor 2.
- Moving down to Floor 0.
- Moving up to Floor 3.
- Activating the emergency stop during movement.
- Checking the movement and motor stop signals.

### How to Run

1. Open the project in a Verilog simulator such as **ModelSim, QuestaSim, or Icarus Verilog**.
2. Add `controller.v` and `tb_controller.v` to the project.
3. Compile both files.
4. Set `tb_controller` as the top-level simulation module.
5. Run the simulation and observe the output signals in the console or waveform viewer.

### Example Using Icarus Verilog

Compile the files:

```bash
iverilog -o elevator_sim lift_controller.v tb_controller.v
```

Run the simulation:

```bash
vvp elevator_sim
```

To view waveforms, add `$dumpfile` and `$dumpvars` to the testbench, then open the generated VCD file using GTKWave.

## Tools and Technologies

- **Language:** Verilog HDL
- **Design Concept:** Finite State Machine (FSM)
- **Verification:** Verilog Testbench
- **Simulation:** ModelSim / QuestaSim / Icarus Verilog
- **Version Control:** Git and GitHub

## Applications

- Elevator control system design
- FSM design and verification
- Digital logic and RTL design practice
- Learning Verilog HDL and hardware simulation

## Future Improvements

- Support for more floors.
- Improved scheduling for multiple floor requests.
- Door opening and closing control.
- Floor arrival indicators.
- More comprehensive emergency handling and verification.

## Disclaimer

This project is intended for educational purposes and simulation practice. It is not designed or verified for use in a real elevator safety system.

**Your Name**

