--[[
    Author -> Supreem Khadka
    Flappy Bird 5 The Infinite Pipe Update
--]]

push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local images = {
    ["background"] = love.graphics.newImage("background.png"),
    ["ground"] = love.graphics.newImage("ground.png"),
}

backgroundScroll = 0
groundScroll = 0

BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 60

local flappy = Bird()

local pipes = {}

local spawnTimer = 0

function love.load()
    math.randomseed(os.time())

    --love.graphics.setDefaultFilter("nearest", "nearest")
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    
    -- initializing a table to store the keys pressed
    love.keyboard.keyspressed = {}

    love.window.setTitle("Flappy Bird")
end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    love.keyboard.keyspressed[key] = true

    if key == "escape" then
        love.event.quit()
    end
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keyspressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % 412
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        table.insert(pipes, Pipe())
        spawnTimer = 0
    end

    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end
    end

    -- implement gravity
    flappy:update(dt)
    
    love.keyboard.keyspressed = {}
end


function love.draw()
    push:start()

    love.graphics.draw(images["background"], -backgroundScroll, 0)
    for k, pipe in pairs(pipes) do
        pipe:render()
    end
    love.graphics.draw(images["ground"], -groundScroll, VIRTUAL_HEIGHT - 16)
    flappy:render()

    push:finish()
end
