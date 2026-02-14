# UART_TX_Project
# UART Transmitter (Parameterized, Verilog)

## 📌 Overview
This project implements a parameterized UART Transmitter using Verilog.  
The design is fully simulated and verified using a self-checking testbench.

The transmitter supports configurable baud rate and data width and is implemented using a clean FSM-based architecture.

---

## 🎯 Objective
To design and verify a UART Transmitter capable of:

- Configurable baud rate
- Configurable data width
- Start bit generation
- Data transmission (LSB first)
- Stop bit generation
- Busy signal indication

---

## 🏗️ Architecture

The UART transmitter is implemented using a Finite State Machine (FSM).

### FSM States:
1. IDLE  – Wait for transmission request  
2. START – Transmit start bit (logic 0)  
3. DATA  – Transmit data bits (LSB first)  
4. STOP  – Transmit stop bit (logic 1)  

---

## ⚙️ Parameters

| Parameter    | Description                    |
|-------------|--------------------------------|
| CLK_FREQ    | System clock frequency         |
| BAUD_RATE   | UART baud rate                 |
| DATA_BITS   | Number of data bits transmitted|

### Baud Rate Calculation:

CLKS_PER_BIT = CLK_FREQ / BAUD_RATE


This determines how many clock cycles each UART bit occupies.

Example configuration:
- CLK_FREQ = 100 MHz
- BAUD_RATE = 9600
- DATA_BITS = 8

---

## 🧪 Simulation

### Verification Performed:

- Reset behavior verification
- Single byte transmission
- Start bit timing verification
- Data bits transmission (LSB first)
- Stop bit verification
- Busy signal validation

The waveform confirms:
- Start bit is logic 0
- Data bits transmitted correctly
- Stop bit is logic 1
- Proper bit timing based on baud divider

Waveform screenshot is available in the Simulation folder.

---

## 🛠️ Project Structure

UART_TX_Project/
│
├── uart_tx.v
│
│
├── uart_tx_tb.v
│
│
├── uart_simulation.png
│
│
└── README.md


---

## 🧠 Key Learnings

- FSM-based control logic design
- Clock divider implementation for baud rate generation
- Importance of accurate bit timing
- UART protocol fundamentals
- Writing synthesizable and structured RTL
- Simulation-based functional verification

---

## ⚠️ Current Status

- Functional simulation completed successfully.
- Synthesis and hardware validation planned for future enhancement.

---

## 🚀 Future Improvements

- Add UART Receiver module
- Implement parity support
- Add error detection (framing error)
- Perform synthesis and timing analysis
- Integrate TX + RX into full UART system

---

## 📎 Tools Used

- Xilinx Vivado (Simulation)

---

## 📌 Conclusion

The UART transmitter was successfully designed and functionally verified through simulation.  
This project demonstrates understanding of UART protocol, FSM design, and clock-based timing control in RTL design.
