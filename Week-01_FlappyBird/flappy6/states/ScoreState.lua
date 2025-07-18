ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params["score"]    
end


function ScoreState:update()
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("count")
    end
end


function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf("Oof! You lost!", 0, 64, VIRTUAL_WIDTH, "center")
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score: " .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, "center")

    love.graphics.printf("Presss Enter to Play Again!", 0, 160, VIRTUAL_WIDTH, "center")
end