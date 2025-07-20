PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.pipeTimer = 0
    self.pipePairs = {}
    self.score = 0
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    self.pipeSpawnTime = math.random(2, 3)
    self.gap = math.random(100, 130)
end


function PlayState:update(dt)
    self.pipeTimer = self.pipeTimer + dt
    if self.pipeTimer > self.pipeSpawnTime then
        self.gap = math.random(100, 130)
        self.pipeSpawnTime = math.random(2, 3)
        local y = math.max(-PIPE_HEIGHT + 10,
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - self.gap - PIPE_HEIGHT)
        )
        self.lastY = y
        table.insert(self.pipePairs, PipePairs(y,self.gap))
        
        self.pipeTimer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.scored == false then
            -- the bird has passed the pipe
            if pair.x + PIPE_WIDTH < self.bird.x then
                sounds["score"]:play()
                self.score = self.score + 1
                pair.scored = true
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        for l, pipes in pairs(pair.pipes) do
            if self.bird:collides(pipes) then
                sounds["explosion"]:play()
                sounds["hurt"]:play()
                gStateMachine:change("score", {
                    ["score"] = self.score
                })
            end
        end
    end

    -- remove the pair from the table after the pipes go off the screen
    for k, pair in pairs(self.pipePairs) do
        if pair.remove == true then
            table.remove(self.pipePairs, k)
        end
    end

    if self.bird.y + self.bird.height >= VIRTUAL_HEIGHT - 16 then
        sounds["explosion"]:play()
        sounds["hurt"]:play()
        gStateMachine:change("score", {
            ["score"] = self.score
        })
    end

    self.bird:update(dt)
end

function PlayState:render()
     for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(fonts["flappy"])
    love.graphics.print("Score: " .. tostring(self.score), 8, 8)
    self.bird:render()
end
