--[[
    GD50 Final Project
    Dyna 50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Bomb is an entiy, it has animations and states just like any other entity
]]

Bomb = Class{__includes = Entity}

function Bomb:init(def)
    Entity.init(self, def)
    self.deployed = false
    self.canplayeron = true  -- player is always on when deployed
end

function Bomb:update(dt)
    Entity.update(self, dt)
end


function Bomb:render()
    Entity.render(self)
end