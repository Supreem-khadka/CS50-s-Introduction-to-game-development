Pipe = Class{}

local pipeImage = love.graphics.newImage("images/pipe.png")
PIPE_WIDTH = 70
PIPE_HEIGHT = 288
PIPE_SPEED = 60

function Pipe:init(position, y)
    self.width = PIPE_WIDTH
    self.height = PIPE_HEIGHT

    self.position = position or "bottom"
    
    self.x = VIRTUAL_WIDTH
    self.y = y
end


function Pipe:update(dt)
    
end


function Pipe:render()
    love.graphics.draw(pipeImage, self.x, 
    (self.position == "top" and self.y + self.height or self.y),
    0, 1, 
    (self.position == "top" and -1 or 1))
end

