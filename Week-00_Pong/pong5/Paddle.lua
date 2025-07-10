Paddle = Class{}


-- initialization method, only called once at the beginning
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.score = 0
end


-- move the paddle based on users input
function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end


-- function to be called by love.draw() to render the paddle
function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

