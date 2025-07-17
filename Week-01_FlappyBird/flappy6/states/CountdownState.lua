CountdownState = Class{__includes = BaseState}

local timer  = 0

function CountdownState:init()
    self.time = 3
end


function CountdownState:update(dt)
    timer = timer + dt
    if timer >= 1 then
        self.time = self.time - 1
        timer = 0
    end

    if self.time < 1 then
        gStateMachine:change("play")
    end
end

function CountdownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.time), 0, 100, VIRTUAL_WIDTH, "center")
end