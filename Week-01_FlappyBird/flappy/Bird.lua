Bird = Class()

local GRAVITY = 15
local ANTI_GRAVITY = -3

function Bird:init()
    self.image = love.graphics.newImage("images/bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0 -- implement velocity
end


function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    if love.keyboard.wasPressed("space") or love.mouse.wasClikced(1) then
        sounds["jump"]:play()
        self.dy = ANTI_GRAVITY
    end
    self.y = self.y + self.dy
end


function Bird:collides(pipe)
    if self.x + 2 > pipe.x + PIPE_WIDTH or (self.x + 2) + (self.width - 4) < pipe.x then
        return false
    end
    
    if (self.y + 2) > pipe.y + PIPE_HEIGHT or (self.y + 2) + (self.height - 4) < pipe.y then
        return false
    end

    return true
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end