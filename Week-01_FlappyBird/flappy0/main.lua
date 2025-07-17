--[[
    Author -> Supreem Khadka
    Flappy Bird 1 Parallax Update
--]]

push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

function love.load()
    --love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    images = {
        ["background"] = love.graphics.newImage("background.png"),
        ["ground"] = love.graphics.newImage("ground.png")
    }
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end


function love.draw()
    push:start()
    love.graphics.draw(images["background"], 0, 0)
    love.graphics.draw(images["ground"], 0, VIRTUAL_HEIGHT - 16)
    push:finish()
end
