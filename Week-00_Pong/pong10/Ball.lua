Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end


function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end


function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end


function Ball:collides(paddle)
    -- check if the paddle and the ball collides
    if self.x > paddle.x + paddle.width or self.x + self.width < paddle.x then
        return false
    end

    if self.y > paddle.y + paddle.height or self.y + self.height < paddle.y then
        return false
    end

    -- if the ball is neither above nor below and neither ahead or behind then there is a collision
    return true
end


function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
