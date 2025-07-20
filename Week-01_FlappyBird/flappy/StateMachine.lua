StateMachine = Class{}

function StateMachine:init(states)
    self.empty = {
        enter = function() end,
        render = function() end,
        exit = function() end,
        update = function() end
    }

    self.states  = states or {}  -- formate for states -> [statename] = {function that returns state object}
    self.current = self.empty
end


function StateMachine:change(stateName, arg)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(arg)
end


function StateMachine:update(dt)
    self.current:update(dt)
end


function StateMachine:render()
    self.current:render()
end