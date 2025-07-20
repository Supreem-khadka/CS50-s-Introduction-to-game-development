PipePairs = Class()


function PipePairs:init(y, gap)
    self.y = y
    self.x = VIRTUAL_WIDTH

    self.remove = false
    self.scored = false

    self.gap = gap

    self.pipes = {
        ["topPipe"] = Pipe("top", y),
        ["bottomPipe"] = Pipe("bottom", y + self.gap + PIPE_HEIGHT)
    }
end


function PipePairs:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes["topPipe"].x = self.x
        self.pipes["bottomPipe"].x = self.x
    else
        self.remove = true
    end
end


function PipePairs:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
