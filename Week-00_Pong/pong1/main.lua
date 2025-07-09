--[[
    Author -> Supreem Khadka
    Implementation of pong with low resolution to give it a retro feel
--]]

push = require 'push'       -- using the push libraryn

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280

VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")    -- using the nearest neighbour filtering to avoid blurring effect

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        fullscreen = false,
        vsync = true
    })
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end


function love.draw()
    push:apply('start')
    love.graphics.printf("Pong 01", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, "center")
    push:apply('end')
end


