--[[
    Author -> Supreem Khadka
    Implemetation of Week 00 of CS50's Introduction to game development
--]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    love.graphics.printf(
        "Pong Week 00",     -- text to print
        0,
        WINDOW_HEIGHT / 2,
        WINDOW_WIDTH,
        "center"
    )
end

love.