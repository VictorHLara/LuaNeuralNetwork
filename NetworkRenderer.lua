-- Graphics

local NetworkRenderer = {}

function NetworkRenderer.new(inputSize, hiddenSize)
    local self = {
        inputSize = inputSize,
        hiddenSize = hiddenSize,
        neuronRadius = 20,
        layerSpacing = 200
    }

    -- Methods
    function self:draw(network, inputs, prediction)
        love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
        self:drawInputLayer(inputs)
        self:drawHiddenLayer()
        self:drawOutputLayer(prediction)
        self:drawConnections()
    end

    function self:drawInputLayer(inputs)
        for i = 1, self.inputSize do
            love.graphics.setColor(0.2, 0.6, 1)
            love.graphics.circle("fill", 100, 100 + i * 80, self.neuronRadius)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(string.format("%.1f", inputs[i] or 0), 80, 100 + i * 80 - 10)
        end
    end

    function self:drawHiddenLayer()
        for i = 1, self.hiddenSize do
            love.graphics.setColor(0.2, 0.8, 0.2)
            love.graphics.circle("fill", 300, 100 + i * 80, self.neuronRadius)
        end
    end

    function self:drawOutputLayer(prediction)
        love.graphics.setColor(1, 0.2, 0.2)
        love.graphics.circle("fill", 500, 180, self.neuronRadius)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("%.2f", prediction or 0), 480, 170)
    end

    function self:drawConnections()
        love.graphics.setColor(1, 1, 1, 0.2)
        for i = 1, self.inputSize do
            for j = 1, self.hiddenSize do
                love.graphics.line(100 + self.neuronRadius, 100 + i * 80, 300 - self.neuronRadius, 100 + j * 80)
            end
        end

        for i = 1, self.hiddenSize do
            love.graphics.line(300 + self.neuronRadius, 100 + i * 80, 500 - self.neuronRadius, 180)
        end
    end

    return self
end

return NetworkRenderer