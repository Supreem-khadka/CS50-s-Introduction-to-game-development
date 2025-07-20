CountdownState = Class{__includes = BaseState}

function CountdownState:init()
    self.count = 3
    self.time = 0
end

function CountdownState:update(dt)
    self.time = self.time + dt
    if self.time >= 1 then
        self.count = self.count - 1
        self.time = 0
    end
    
    if self.count < 0 then
        gStateMachine:change("play")
    end
end

function CountdownState:render()
    love.graphics.setFont(fonts["huge"])
    love.graphics.printf((self.count == 0 and "PLAY" or tostring(self.count)), 0, 120, VIRTUAL_WIDTH, "center")
end