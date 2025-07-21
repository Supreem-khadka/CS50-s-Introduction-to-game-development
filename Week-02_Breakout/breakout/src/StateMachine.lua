StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
        enter = function() end,
        exit = function() end,
        update = function() end,
        render = function() end
    }
    self.states = states or {}
    self.current = self.empty
end


function StateMachine:change(state, arg)
    assert(self.states[state])
    self.current:exit()
    self.current = self.states[state]()
    self.current:enter(arg)
end


function StateMachine:update(dt)
    self.current:update(dt)
end


function StateMachine:render()
    self.current:render()
end
