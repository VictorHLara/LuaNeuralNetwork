local NeuralNetwork = {}
NeuralNetwork.__index = NeuralNetwork

local activationFunctions = {
 
    sigmoid = {
        func = function(x) return 1 / (1 + math.exp(-x)) end,
        derivative = function(x) return x * (1 - x) end
    },
    
    relu = {
        func = function(x) return math.max(0, x) end,
        derivative = function(x) return x > 0 and 1 or 0 end
    },
    
    leaky_relu = {
        func = function(x) return x > 0 and x or 0.01 * x end,
        derivative = function(x) return x > 0 and 1 or 0.01 end
    },
    
    tanh = {
        func = function(x) return math.tanh(x) end,
        derivative = function(x) return 1 - (x * x) end
    }
}

function NeuralNetwork.new(inputSize, hiddenSize, outputSize, learningRate, activation)
    local self = setmetatable({}, NeuralNetwork)

    self.activation = activation or "sigmoid"  -- Padrão: sigmoid
    self.activationFunc = activationFunctions[self.activation].func
    self.activationDerivative = activationFunctions[self.activation].derivative
    
    self.inputSize = inputSize
    self.hiddenSize = hiddenSize
    self.outputSize = outputSize
    self.learningRate = learningRate

    self:initializeWeights()
    return self
end

function NeuralNetwork:initializeWeights()
    self.weightsInputHidden = {}
    self.weightsHiddenOutput = {}

    -- Weights inicialization input and hidden
    for i = 1, self.inputSize do
        self.weightsInputHidden[i] = {}
        for j = 1, self.hiddenSize do
            self.weightsInputHidden[i][j] = math.random() * 2 - 1
        end
    end

    -- Weights inicialization hidden and output
    for i = 1, self.hiddenSize do
        self.weightsHiddenOutput[i] = math.random() * 2 - 1
    end
end

function NeuralNetwork:predict(inputs)
    local hidden = {}
    for i = 1, self.hiddenSize do
        hidden[i] = 0  -- Inicialização corrigida!
        for j = 1, self.inputSize do
            hidden[i] = hidden[i] + inputs[j] * self.weightsInputHidden[j][i]
        end
        hidden[i] = self.activationFunc(hidden[i])
    end

    local output = 0
    for i = 1, self.hiddenSize do
        output = output + hidden[i] * self.weightsHiddenOutput[i]
    end
    output = self.activationFunc(output)

    return hidden, output
end

function NeuralNetwork:train(inputs, target)
    local hidden, output = self:predict(inputs)
    
    local errorOutput = target - output 
    
    local deltaOutput = errorOutput * self.activationDerivative(output)
    
    for i = 1, self.hiddenSize do
        self.weightsHiddenOutput[i] = self.weightsHiddenOutput[i] + 
            self.learningRate * deltaOutput * hidden[i]
    end

    return math.abs(errorOutput)
end

return NeuralNetwork