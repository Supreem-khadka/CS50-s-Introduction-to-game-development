ScoreState = Class{__includes = BaseState}

function ScoreState:init()
    self.score = 0
end


function ScoreState:enter(score)
    self.score = score["score"]
end


function ScoreState:update(dt)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("countdown")
    end
end


function ScoreState:render()
    love.graphics.setFont(fonts["flappy"])
    love.graphics.printf((self.score > 0 and "Woo Hoo" or "BETTER LUCK NEXT TIME"), 0, 5, VIRTUAL_WIDTH, "center")
    
    love.graphics.setFont(fonts["medium"])
    love.graphics.printf("Your score: " ..tostring(self.score), 0, 40, VIRTUAL_WIDTH, "center")
    
    if self.score < 4 then
        love.graphics.draw(images["third"], (VIRTUAL_WIDTH / 2) - (images["third"]:getWidth() / 2), 70)
    elseif self.score < 10 then
        love.graphics.draw(images["second"], (VIRTUAL_WIDTH / 2) - (images["second"]:getWidth() / 2), 70)
    else
        love.graphics.draw(images["first"], (VIRTUAL_WIDTH / 2) - (images["first"]:getWidth() / 2), 70)
    end
    
    love.graphics.printf("Press Enter to start again", 0, 250, VIRTUAL_WIDTH, "center")
end
