# OFDM-System-Simulation-with-Channel-Impairments
This repository contains a MATLAB implementation of a complete Orthogonal Frequency Division Multiplexing (OFDM) transceiver. The simulation focuses on the robustness of OFDM against common wireless communication challenges.

🚀 Overview

The project simulates the end-to-end physical layer of an OFDM system, incorporating 16-QAM modulation and signal processing techniques to mitigate channel distortions.

<img width="1396" height="623" alt="image" src="https://github.com/user-attachments/assets/03b4fe6d-3cf7-466c-a6e4-a6059b960e14" />

🛠 Key Features & Impairments

The simulation models three critical channel impairments:

    Additive White Gaussian Noise (AWGN): Evaluates performance across a range of SNR levels (0dB to 20dB).

    Carrier Frequency Offset (CFO): Simulates synchronization errors and demonstrates phase rotation/ICI.

    Multipath Fading: Implements a frequency-selective fading channel using a multi-tap impulse response.
    
🏗 System Architecture

    Transmitter: QAM Mapping → IFFT → Cyclic Prefix (CP) Insertion.

    Channel Model: Convolution with channel impulse response + CFO application + AWGN.

    Receiver: CFO Correction → CP Removal → FFT → Zero-Forcing (ZF) Equalization → QAM Demapping.
    
📊 Visualizations

The script generates two primary analytical plots:

    BER vs. SNR (Waterfall Curve): Displays the Bit Error Rate performance, validating the system's reliability.

    Constellation Diagram: Provides a visual representation of the received signal quality and the effectiveness of the equalizer and CFO correction.

💻 Usage

Simply run AdaptiveModulationinFadingChannels.m in MATLAB. You can adjust parameters like numSubcarriers, cfo, or the channel vector h to observe different system behaviors.    
    
