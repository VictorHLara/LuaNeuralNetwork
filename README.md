# Neural Network Visualization with LÖVE

[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://lua.org)
[![LÖVE](https://img.shields.io/badge/LÖVE-FF0000?style=for-the-badge&logo=love2d&logoColor=white)](https://love2d.org)

A visually engaging implementation of a neural network solving the XOR problem, complete with real-time graphical visualization using the LÖVE2D framework.


## ✨ Features

- **Interactive Neural Network Visualization**
  - Real-time rendering of network architecture
  - Dynamic connection lines between layers
  - Color-coded neurons (input/hidden/output)
- **Multiple Activation Functions**
  - Sigmoid (default)
  - ReLU
  - Leaky ReLU
  - Tanh
- **Training Controls**
  - Adjustable learning rate
  - Variable training speed (↑/↓ keys)
  - Real-time error tracking
- **Modular Architecture**
  - Separated neural network logic and rendering
  - Easy-to-modify configuration

## 🚀 Installation

1. **Install LÖVE Framework**:
   - Windows/macOS: [Download installer](https://love2d.org)
   - Linux:
     ```bash
     sudo apt install love
     ```

2. **Clone Repository**:
   ```bash
   git clone https://github.com/your-username/neural-network-love2d.git
   cd neural-network-love2d
   
3. **Run Project**:
  ```bash
    love .
  ```
## 🎮 Usage

  1. Start training visualization
  ```bash
      love .
```

  2. Keyboard Controls:
     ```bash
     ↑ - Increase training speed
     ↓ - Decrease training speed

## 🛠️ Customization

Modify main.lua to experiment:
```bash
local config = {  
    inputSize = 2,  
    hiddenSize = 4,  
    outputSize = 1,  
    learningRate = 0.3,  
    trainingDelay = 0.5,  
    activation = "leaky_relu",  -- Try: sigmoid/relu/tanh  
}
```
## 📸 Preview

![Neural Network in training visualization]
(https://github.com/user-attachments/assets/6b50066c-3552-4805-a712-16f9590de74e) 



