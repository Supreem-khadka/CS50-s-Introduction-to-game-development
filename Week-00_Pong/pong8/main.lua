--[[
    Author -> Supreem Khadka
    Pong 08 The score update
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

    love.window.setTitle("Pong 08 - The Score Update")

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

    servingPlayer = 1

    gameState = "start"
end


function love.update(dt)
    if gameState == "serve" then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    end


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
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            -- randomize the angle the ball bounces back
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end


        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            -- randomize the angle the ball bounces back
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)

    if ball.x < 0 then
        servingPlayer = 1
        player2.score = player2.score + 1
        ball:reset()
        gameState = "serve"
    end

    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1.score = player1.score + 1
        ball:reset()
        gameState = "serve"
    end
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "enter" or key == "return" then
        if gameState == "start" then
            gameState = "serve"
        elseif gameState == "serve" then
            gameState = "play"
        end
    end
end


function love.draw()
    push:apply("start")
    
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    displayScore()

    love.graphics.setFont(retroFont)

    love.graphics.printf("Pong 08 - The Score Update", 0, 10, VIRTUAL_WIDTH, "center")
    if gameState == "play" then
        love.graphics.printf("PLAY", 0, 20, VIRTUAL_WIDTH, "center")
    elseif gameState == "start" then
        love.graphics.printf("START", 0, 20, VIRTUAL_WIDTH, "center")        
    else
        love.graphics.printf("Player " .. tostring(servingPlayer).. "'s Serve!", 0, 20, VIRTUAL_WIDTH, "center")
    end

    

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

function displayScore()
    love.graphics.setFont(headingFont)
    love.graphics.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 30, VIRTUAL_HEIGHT / 5)
    love.graphics.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 5)
end
