# FPGA Digital Logic Projects

VHDL and schematic projects developed by Gary Xiong for ECE 124 at the University of Waterloo. The projects target the LogicalStep board's Intel MAX 10 FPGA and explore combinational logic, arithmetic, control systems, and finite-state machines.

## Featured project: Traffic light controller

[Watch the hardware demonstration](https://youtu.be/kYevFzLy6EA)

A 16-state controller models a two-direction intersection. Push-button filtering, synchronizers, and holding registers capture requests; clock division and clock-enable pulses control timing; multiplexed seven-segment displays and LEDs show the system state. The design includes a selectable flashing mode.

## Projects

| Folder | Focus |
| --- | --- |
| [logic-gates-and-polarity-control](logic-gates-and-polarity-control) | Logic gates, schematic design, and selectable signal inversion |
| [four-bit-adder-and-logic-unit](four-bit-adder-and-logic-unit) | Ripple-carry addition, Boolean operations, multiplexers, and hexadecimal displays |
| [hvac-temperature-controller](hvac-temperature-controller) | Comparators, heating/cooling control, counters, and a bidirectional shift register |
| [traffic-light-controller](traffic-light-controller) | Finite-state control, input synchronization, request storage, and display timing |

## Open a project

1. Install Intel Quartus Prime with MAX 10 device support. The saved projects were last used with Quartus Prime 18.1.
2. Open the `.qpf` file inside the desired project folder.
3. Review the saved pin assignments for the LogicalStep board and compile the design.
4. Connect the board and use Quartus Programmer to load the generated programming file. The `.vwf` files provide saved waveform inputs for simulation.

Source files, schematics, pin assignments, and project settings are included. Build databases, programming outputs, backup files, and simulation caches are excluded. Stale project references to absent generated files were removed from this publication copy; the logic source is unchanged. No fresh Quartus compilation was performed for this repository setup.

## Attribution

These are coursework implementations using course-provided project scaffolding and board support. Existing third-party notices are retained. No blanket license is applied to course or vendor materials.
