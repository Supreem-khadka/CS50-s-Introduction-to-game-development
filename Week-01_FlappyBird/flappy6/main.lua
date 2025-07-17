--[[
    Author -> Supreem Khadka
    The Pipe Pair Update
--]]

push = require 'push'

Class = require 'class'

require 'Bird'

require 'Pipe'

require 'PipePair'


-- all code related to game state and state machines
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'

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

-- variable to set the scrolling on and off
local scrolling = true

-- global variable for keeping track of left button click in the mouse
leftButton = false

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("Flappy Bird")

    -- initialize the fonts
    smallFont = love.graphics.newFont("font.ttf", 8)
    mediumFont = love.graphics.newFont("flappy.ttf", 14)
    flappyFont = love.graphics.newFont("flappy.ttf", 28)
    hugeFont = love.graphics.newFont("flappy.ttf", 56)
    love.graphics.setFont(flappyFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true
    })

    -- initialize state machines with all state-returning functions
    gStateMachine = StateMachine {
        ["title"] = function() return TitleScreenState() end,
        ["play"] = function() return PlayState() end,
        ["score"] = function() return ScoreState() end,
        ["count"] = function() return CountdownState() end
    }


    -- audio
    explosion = love.audio.newSource("explosion.wav", "static")
    hurt = love.audio.newSource("hurt.wav", "static")
    jump = love.audio.newSource("jump.wav", "static")
    marios_way = love.audio.newSource("marios_way.mp3", "static")
    score = love.audio.newSource("score.wav", "static")

    marios_way:setLooping(true)
    marios_way:play()

    gStateMachine:change('title')

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


function love.mousepressed(x, y, button)
    if button == 1 then
        leftButton = true
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
    
    -- parallax scrolling
    background_scroll = (background_scroll + BACKGROUND_SCROLL_SPEED * dt) % 412
    ground_scroll = (ground_scroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH 

    gStateMachine:update(dt)
    
    leftButton = false
    love.keyboard.keysPressed = {}

end


function love.draw()
    push:start()

    -- draw the loaded image
    love.graphics.draw(background_image, -background_scroll, 0)

    gStateMachine:render()

    love.graphics.draw(ground_image, -ground_scroll, VIRTUAL_HEIGHT - 16)
    

    push:finish()
end
