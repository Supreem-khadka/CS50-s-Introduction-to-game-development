Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage("pipe.png")
local PIPE_SCROLL = -60

function Pipe:init() 
    self.x = VIRTUAL_WIDTH
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_IMAGE:getHeight()
end


function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end
