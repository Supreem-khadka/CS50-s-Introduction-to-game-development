PipePair = Class{}

local GAP_HEIGHT = 90

function PipePair:init(y)
    -- place the pipe after the end of the screen
    self.x = VIRTUAL_WIDTH + 32

    -- value for the topmost pipe, the value for the lower pipe will be figured out using the gap
    self.y = y

    self.pipes = {
        ["upper"] = Pipe("top", self.y),
        ["lower"] = Pipe("bottom", self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    self.remove = false
end


function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes["upper"].x = self.x
        self.pipes["lower"].x = self.x
    else
        self.remove = true
    end
end


function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end

