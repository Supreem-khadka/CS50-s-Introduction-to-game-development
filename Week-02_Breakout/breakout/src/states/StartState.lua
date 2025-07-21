StartState = Class{__includes = BaseState}

-- whether we are highlighting "start" or "High Scores"
local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed("up") or love.keyboard.wasPressed("down") then
       highlighted = highlighted == 1 and 2 or 1
       gSounds["paddle-hit"]:play()
    end

end


function StartState:render()
    -- title
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")

    -- instruction
    love.graphics.setFont(gFonts["medium"])

    -- if we're highlighting 1, we need to render that option in blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, "center")

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- if the option 2 blue if highlighted is 2
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, "center")

    love.graphics.setColor(1, 1, 1, 1)
end