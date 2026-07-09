# Digital_250102094 

This repository contains my solutions for the **Electrothon Digital Problem Statement**, covering both hardware design and Verilog-based digital system design challenges. 

## Challenge 1

### Part A – 4-Bit ALU Core (20 Points)
Designed a 4-bit ALU capable of performing:
- Addition (with Carry Out and Overflow detection)
- Bitwise AND
- Bitwise OR
- Logical Right Shift

### Part B – 4-Bit Synchronous Up-Down Counter (30 Points)
Designed a synchronous 4-bit binary counter featuring:
- Up and Down counting modes
- Synchronous reset
- Clock-driven operation

---

## Challenge 2

### Part A – FSM Sequence Detector (30 Points)
Designed a Verilog circuit that detects the sequence **"101"** within the latest four input bits.

Implemented using:
- Mealy FSM
- Moore FSM

### Part B – UART Frame Packet Receiver (50 Points)
Implemented a UART frame packet receiver in Verilog that receives packets in the format:

```
Start Bit | 8 Data Bits | Even Parity | Stop Bit
```

The receiver:
- Detects valid packets
- Checks parity and frame errors
- Outputs the received byte on successful reception
- Generates `done`, `parity_err`, and `frame_err` signals

---

## Bonus Challenge

Implemented a **Command Receiver** that extends the UART packet receiver by decoding command bits and performing operations on internal registers.

Supported commands:
- Load Register A
- Load Register B
- Add Registers A and B
- Clear Registers

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Deeds Digital Logic Simulator

---

This project was completed as part of the **Electrothon Digital Challenge**, focusing on digital logic design, finite state machines, sequential circuits, and UART communication. 

NAME:- Siddhartha Ch V S   
ROLL NO:- 250102094


