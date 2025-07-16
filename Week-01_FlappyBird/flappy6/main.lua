--[[
    Author -> Supreem Khadka
    The Pipe Pair Update
--]]

push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- images
local background_image = love.graphics.newImage("background.png")
local ground_image = love.graphics.newImage("ground.png")

-- scroll speed for images
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- the x-axis position that will get updated
local background_scroll = 0
local ground_scroll = 0

local bird = Bird()

local pipePairs = {}

local spawnTimer = 0

-- initialize the last recorded Y value for a gap to base other gaps off of
local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- variable to set the scrolling on and off
local scrolling = true
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true
    })

    -- table for storing boolean values for if the keys are pressed
    love.keyboard.keysPressed = {}

end


function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == "escape" then
        love.event.quit()
    end
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end


function love.update(dt)
    if scrolling then
        -- parallax scrolling
        background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % 412
        ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH 

        spawnTimer = spawnTimer + dt
        -- create a new pipe pair if the timer is past 2 seconds
        if spawnTimer > 2 then
            local y = math.max(-PIPE_HEIGHT + 10, 
                math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
            lastY = y
            table.insert(pipePairs, PipePair(y))
            spawnTimer = 0
        end


        -- bird:update(dt)
        bird:update(dt)

        for k, pair in pairs(pipePairs) do 
            pair:update(dt)

            for l, pipe in pairs(pair.pipes) do
                if bird:collides(pipe) then
                    scrolling = false
                end
            end
            
        end

        -- remove the remove flaged pipes
        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end
    end

    love.keyboard.keysPressed = {}

end


function love.draw()
    push:start()

    -- draw the loaded image
    love.graphics.draw(background_image, -background_scroll, 0)

    for k, pair in pairs(pipePairs) do
        pair:render()
    end

    love.graphics.draw(ground_image, -ground_scroll, VIRTUAL_HEIGHT - 16)

    bird:render()
    

    push:finish()
end
