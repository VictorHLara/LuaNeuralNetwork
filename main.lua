local NeuralNetwork = require("NeuralNetwork")
local NetworkRenderer = require("NetworkRenderer")

-- Network configurations 
local config = {
    inputSize = 2,   
    hiddenSize = 3, 
    outputSize = 1,
    learningRate = 0.3,
    trainingDelay = 0.5,
    activation = "sigmoid"
}

function love.load()
    love.window.setTitle("Neural Network")
    love.window.setMode(800, 600)

    network = NeuralNetwork.new(
        config.inputSize,
        config.hiddenSize,
        config.outputSize,
        config.learningRate,
        config.activation
    )

    renderer = NetworkRenderer.new(config.inputSize, config.hiddenSize)
    
    inputs = {0, 0}
    target = 0
    errorHistory = {}
    trainingTimer = 0
end

function love.update(dt)
    trainingTimer = trainingTimer + dt

    if trainingTimer >= config.trainingDelay then
        trainingTimer = 0
        local dataset = {
            {inputs = {0, 0}, target = 0},
            {inputs = {0, 1}, target = 1},
            {inputs = {1, 0}, target = 1},
            {inputs = {1, 1}, target = 0}
        }
        
        local sample = dataset[2] --you can change the input here
        inputs = sample.inputs
        target = sample.target
        local error = network:train(inputs, target)
        table.insert(errorHistory, error)
        if #errorHistory > 100 then table.remove(errorHistory, 1) end
    end

    -- Speed controls
    if love.keyboard.isDown("up") then
        config.trainingDelay = math.max(0.1, config.trainingDelay - 0.1)
    elseif love.keyboard.isDown("down") then
        config.trainingDelay = config.trainingDelay + 0.1
    end
end

function love.draw()
    local _, prediction = network:predict(inputs)
    renderer:draw(network, inputs, prediction) 
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Error: " .. string.format("%.4f", errorHistory[#errorHistory] or 0), 10, 10)
    love.graphics.print("Inputs: [" .. table.concat(inputs, ", ") .. "]", 10, 30)
    love.graphics.print("Output: " .. string.format("%.2f", prediction), 10, 50)
    love.graphics.print("Delay: " .. string.format("%.1f", config.trainingDelay) .. "s (use the arrows to adjust)", 10, 70)
end