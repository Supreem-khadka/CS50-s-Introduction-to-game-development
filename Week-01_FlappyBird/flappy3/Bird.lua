Bird = Class{}

local GRAVITY = 20      -- constant value for implmenting gravity

function Bird:init()
    self.image = love.graphics.newImage("bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end


function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    self.y = self.y + self.dy
end


--[[function Bird:jump(dt)
    self.dy = self.dy + GRAVITY * dt 
    self.y = self.y - self.dy    
end
--]]
