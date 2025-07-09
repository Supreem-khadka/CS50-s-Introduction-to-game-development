--[[
    Author -> Supreem Khadka
    "Pong 03 implementation paddle update"
--]]

push = require "push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 100      -- the speed at which the paddle will move

function love.load()

    -- make the graphics crisp and feel retro
    love.graphics.setDefaultFilter("nearest", "nearest")

    retroFont = love.graphics.newFont("font.ttf", 8)

    scoreFont = love.graphics.newFont("font.ttf", 30)
    

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        fullscreen = false,
        vsync = true
    })

    -- Variables to store the score of players
    player1Score = 0
    player2Score = 0

    -- paddle position on the y-axis 
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    -- paddle movement for player 1
    if love.keyboard.isDown("w") then
        if player1Y > 0 then
            player1Y = player1Y + -PADDLE_SPEED * dt
        end
    elseif love.keyboard.isDown("s") then
        if ( player1Y + 20 ) < VIRTUAL_HEIGHT  then
            player1Y = player1Y + PADDLE_SPEED * dt
        end
    end

    -- paddle movement for player 2
    if love.keyboard.isDown("up") then
        if player2Y > 0 then
            player2Y = player2Y + -PADDLE_SPEED * dt
        end
    elseif love.keyboard.isDown("down") then
        if ( player2Y + 20 ) < VIRTUAL_HEIGHT then
            player2Y = player2Y + PADDLE_SPEED * dt
        end
    end
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end


function love.draw()
    push:apply("start")

    -- setup the background color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- print pong03 paddle update on the screen
    love.graphics.setFont(retroFont)
    love.graphics.printf("Pong03 - Paddle Update", 0, 10, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 4)        --player 1 score
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 4)        --player 2 score

    -- left rectangle
    love.graphics.rectangle("fill", 5, player1Y, 5, 20)

    -- right rectangle
    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- ball at the center
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply("end")

end

