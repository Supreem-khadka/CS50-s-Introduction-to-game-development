TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update()
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("countdown")
    end
end


function TitleScreenState:render()
    love.graphics.setFont(fonts["flappy"])
    love.graphics.printf("Flappy Bird", 0, 64, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(fonts["medium"])
    love.graphics.printf("Press Enter", 0, 100, VIRTUAL_WIDTH, "center")
end

