--[[
    Author -> Supreem Khadka
    Flappy Bird 1 Parallax Update
--]]

push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local images = {
    ["background"] = love.graphics.newImage("background.png"),
    ["ground"] = love.graphics.newImage("ground.png")
}

backgroundScroll = 0
groundScroll = 0

BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 60


function love.load()
    --love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    
    love.window.setTitle("Flappy Bird 1")
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end


function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % 412
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
end


function love.draw()
    push:start()
    love.graphics.draw(images["background"], -backgroundScroll, 0)
    love.graphics.draw(images["ground"], -groundScroll, VIRTUAL_HEIGHT - 16)
    love.graphics.print(tostring(images["background"]:getWidth()), 0, 0)
    push:finish()
end
