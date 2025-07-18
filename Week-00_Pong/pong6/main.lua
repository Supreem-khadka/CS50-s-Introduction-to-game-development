--[[
    Author -> Supreem Khadka
    Pong 06 FPS update
--]]

Class = require 'class'

push = require 'push'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("Pong 06 - The FPS update")

    math.randomseed(os.time())

    retroFont = love.graphics.newFont("font.ttf", 8)
    headingFont = love.graphics.newFont("font.ttf", 24)
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        fullscreen = false,
        vsync = true
    })

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = "start"
end


function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "enter" or key == "return" then
        if gameState == "start" then
            gameState = "play"
        else
            gameState = "start"
            ball:reset()
        end
    end
end


function love.draw()
    push:apply("start")
    
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    love.graphics.setFont(retroFont)

    love.graphics.printf("Pong 05 - FPS Update", 0, 10, VIRTUAL_WIDTH, "center")
    if gameState == "play" then
        love.graphics.printf("PLAY", 0, 20, VIRTUAL_WIDTH, "center")
    else
        love.graphics.printf("START", 0, 20, VIRTUAL_WIDTH, "center")        
    end

    love.graphics.setFont(headingFont)
    love.graphics.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 30, VIRTUAL_HEIGHT / 5)
    love.graphics.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 5)

    player1:render()
    player2:render()
    ball:render()

    displayFPS()

    push:apply("end")
end

function displayFPS()
    love.graphics.setFont(retroFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end