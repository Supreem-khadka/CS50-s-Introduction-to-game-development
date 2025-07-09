--[[
    Author -> Supreem Khadka
    02 implementation of pong, a simple rectangle will be drawn
--]]

push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243 


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    retroFont = love.graphics.newFont("font.ttf", 8)
    love.graphics.setFont(retroFont)
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end


function love.draw()
    push:apply('start')
    
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    love.graphics.printf("Pong 02", 0, 10, VIRTUAL_WIDTH, "center")

    love.graphics.rectangle("fill", 5, 30, 5, 20)    -- left paddle

    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)     -- right paddle

    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 -2, VIRTUAL_HEIGHT /2 - 2, 4, 4)  -- ball

    push:apply('end')
end