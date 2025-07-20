--[[

    Author - Supreem Khadka
    GD50 flappy week 1 assignment
    Objectives
        - Influence the generation of pipes so as to bring about more complicated level generation
        - Give the player a medal for their performance, along with their score
        - Implement a pause feature, just in case life gets in the way of jumping through the pipes
        
--]]

Class = require 'class'

push = require 'push'

require 'Bird'

require 'Pipe'

require 'PipePairs'

require 'StateMachine'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288



-- local variable to store the images table 
images = {
    ["background"] = love.graphics.newImage("images/background.png"),
    ["ground"] = love.graphics.newImage("images/ground.png"),
    ["first"] = love.graphics.newImage("images/first.jpg"),
    ["second"] = love.graphics.newImage("images/second.jpg"),
    ["third"] = love.graphics.newImage("images/third.jpg")
}

local scrollSpeed = {
    ["background"] = 30,
    ["ground"] = 60
}


local imagesXPosition = {
    ["background"] = 0,
    ["ground"] = 0
}


-- initializing a table to store the pressed keys
love.keyboard.keysPressed = {}

love.mouse.buttonsPressed = {}

scrolling = true

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("Flappy Bird Assignment")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true
    })

    fonts = {
        ["flappy"] = love.graphics.newFont("fonts/flappy.ttf", 28),
        ["small"] = love.graphics.newFont("fonts/font.ttf", 8),
        ["medium"] = love.graphics.newFont("fonts/flappy.ttf", 14),
        ["huge"] = love.graphics.newFont("fonts/flappy.ttf", 56)
    }

    sounds = {
        ["explosion"] = love.audio.newSource("sounds/explosion.wav", "static"),
        ["hurt"] = love.audio.newSource("sounds/hurt.wav", "static"),
        ["jump"] = love.audio.newSource("sounds/jump.wav", "static"),
        ["music"] = love.audio.newSource("sounds/marios_way.mp3", "static"),
        ["score"] = love.audio.newSource("sounds/score.wav", "static")
    }

    sounds["music"]:setLooping(true)
    sounds["music"]:play()

    gStateMachine = StateMachine{
        ["title"] = function() return TitleScreenState() end,
        ["play"] = function() return PlayState() end,
        ["countdown"] = function() return CountdownState() end,
        ["score"] = function() return ScoreState() end
    }

    gStateMachine:change("title")
end


-- callback function of love for resize
function love.resize(w, h)
    push:resize(w, h)
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == "escape" then
        love.event.quit()
    end
end


function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end


function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end


function love.mouse.wasClikced(button)
    return love.mouse.buttonsPressed[button]
end


function love.update(dt)
    if love.keyboard.wasPressed("p") then
        if scrolling then
            scrolling = false
        else
            scrolling = true
        end
        
    end

    if scrolling then
        -- implement parallax-scrolling to provide an illusion of movement
        imagesXPosition.background = parallax(scrollSpeed.background, imagesXPosition.background, dt, 412)
        imagesXPosition.ground = parallax(scrollSpeed.ground, imagesXPosition.ground, dt, VIRTUAL_WIDTH)

        gStateMachine:update(dt)
    end

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end


function parallax(speed, position, dt, mod)
    return ((position + speed * dt) % mod)
end


function love.draw()
    push:start()

    -- draw the background
    love.graphics.draw(images["background"], -imagesXPosition.background, 0)
    
    gStateMachine:render()

    -- draw the ground, after the background otherwise the background will be over the ground and the ground won't be visible
    love.graphics.draw(images["ground"], -imagesXPosition.ground, VIRTUAL_HEIGHT - 16)
    push:finish()
end

