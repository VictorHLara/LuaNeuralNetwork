local NeuralNetwork = {}
NeuralNetwork.__index = NeuralNetwork


-- Activation Function
local function sigmoid(x)
    return 1 / (1 + math.exp(-x))
end

function NeuralNetwork.new(inputSize, hiddenSize, outputSize, learningRate)
    local self = setmetatable({}, NeuralNetwork)
    
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
        hidden[i] = 0
        for j = 1, self.inputSize do
            hidden[i] = hidden[i] + inputs[j] * self.weightsInputHidden[j][i]
        end
        hidden[i] = sigmoid(hidden[i])
    end

    local output = 0
    for i = 1, self.hiddenSize do
        output = output + hidden[i] * self.weightsHiddenOutput[i]
    end
    output = sigmoid(output)

    return hidden, output
end

function NeuralNetwork:train(inputs, target)
    local hidden, output = self:predict(inputs)
    local errorOutput = target - output
    local deltaOutput = errorOutput * output * (1 - output)

    for i = 1, self.hiddenSize do
        self.weightsHiddenOutput[i] = self.weightsHiddenOutput[i] + 
            self.learningRate * deltaOutput * hidden[i]
    end

    return math.abs(errorOutput)
end

return NeuralNetwork