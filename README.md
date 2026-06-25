# Microprocessors and Microcontrollers

This repository contains coursework for the **Microprocessors and Microcontrollers** course at the **University of Information Technology – VNUHCM**.

The course provides a comprehensive introduction to the architecture, organization, and operation of microprocessors and microcontrollers. It covers processor components, instruction execution, registers, memory organization, addressing modes, interrupts, timers, digital input and output, peripheral interfacing, and serial communication.

The course primarily focuses on the **Intel 8086 microprocessor** and the **8051 microcontroller family**, which are used as foundational platforms for understanding processor architecture and low-level embedded programming. It also provides a brief introduction to modern platforms, including **STM32 microcontrollers** and **ARM-based architectures**.

Through theoretical lessons, laboratory exercises, and a course project, students gain practical experience in Assembly programming, processor architecture, embedded-system design, hardware interfacing, simulation, debugging, and signal processing.

---

## Course Information

| Item | Details |
|---|---|
| **Course** | Microprocessors and Microcontrollers |
| **Course Code** | CE103 |
| **Class Code** | CE103.Q24 |
| **Semester** | Semester II, 2025–2026 |
| **Instructor** | M.Sc. Than The Tung |

---

## Tools and Technologies

- Assembly Language
- Intel 8086 Microprocessor
- 8051 Microcontroller Family
- AT89C51 / AT89S52
- STM32 and ARM Fundamentals
- Proteus
- emu8086
- Timer and Interrupt Programming
- UART Communication
- I2C Communication
- Peripheral Interfacing

---

## Course Project

### [Heart Rate Monitor Using 8051 and MAX30102](./PROJECT)

The course project implements a heart rate monitoring system using the **AT89S52 microcontroller** and the **MAX30102 optical sensor**.

The system collects photoplethysmography data from the user's fingertip, processes the signal using an Assembly-based algorithm, calculates the heart rate in beats per minute, and displays the result on an LCD1602.

### Main Components

- AT89S52 microcontroller
- MAX30102 optical heart-rate sensor
- LCD1602 display
- PCF8574 I2C interface module
- AMS1117 voltage regulator
- USB-to-TTL module
- Heartbeat indicator LED
- 11.0592 MHz crystal oscillator

### Main Features

- Software-based I2C communication with the MAX30102
- Separate I2C communication with the LCD1602
- Periodic signal sampling using Timer 0
- UART transmission at 9600 bps
- AC and DC signal-component separation
- Adaptive threshold and peak detection
- Noise rejection after each detected heartbeat
- BPM calculation using multiple inter-beat intervals
- Real-time PPG signal transmission through UART
- Heart-rate display on the LCD1602
- Heartbeat indication using an LED

### System Flow

```text
MAX30102 Sensor
       ↓
PPG Signal Sampling
       ↓
AC/DC Signal Separation
       ↓
Adaptive Threshold
       ↓
Peak Detection
       ↓
Inter-Beat Interval Calculation
       ↓
BPM Calculation
       ↓
LCD Display and UART Output
```

### Team Members

| Student | Student ID | Contribution |
|---|---:|---:|
| Nguyen Gia Hung | 24520603 | 50% |
| Nguyen Do Nhat Khuyen | 24520878 | 50% |

---

## Laboratory Exercises

### [LAB01 – Introduction to Proteus and the 8051 Microcontroller](./LAB_EXERCISES/LAB01)

Design and simulation of a 32-LED heart-shaped circuit controlled by the AT89C51 microcontroller.

The Assembly program implements multiple LED effects, including alternating even and odd LEDs, sequential single-LED movement, and a rotating five-LED pattern.

### [LAB02 – 7-Segment LED Display and Timer](./LAB_EXERCISES/LAB02)

Implementation of a 24-hour digital clock using six multiplexed 7-segment LEDs.

The exercise compares two delay-generation methods: hardware timing with Timer 0 and software timing with nested loops.

### [LAB03 – Interrupt Programming](./LAB_EXERCISES/LAB03)

Implementation of a sports stopwatch using Timer 0 interrupts and four multiplexed 7-segment displays.

Push buttons are used to pause or resume the timer, reset the display, increase the time by one second, and decrease the time by one second.

### [LAB04 – UART Communication](./LAB_EXERCISES/LAB04)

Design of a calculator using an AT89C51 microcontroller and a 4 × 4 matrix keypad.

The system performs basic arithmetic operations and transmits the input and calculation results to a serial LCD through UART at 9600 bps.

### [LAB05 – 32-Bit Arithmetic on the 8086 Processor](./LAB_EXERCISES/LAB05)

Implementation of 32-bit addition and subtraction on the 16-bit Intel 8086 processor.

Each 32-bit operand is divided into high and low 16-bit words. The program handles carry, borrow, signed overflow, and displays the operands and results in binary form.

### [LAB06 – I/O Processing, Calculation, and Memory on the 8086](./LAB_EXERCISES/LAB06)

Implementation of an Assembly program that reads a two-digit number and prints the corresponding Fibonacci sequence.

The exercise uses different large-number storage approaches, including decimal arrays and groups of memory words, allowing Fibonacci values larger than the 16-bit register limit to be processed.

---

Each laboratory directory contains:

- Assembly source code
- Practice report in PDF format
- A separate README describing the implementation
