--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Treating fire tile as an entity, we would have 6 different classes behaving slightly different
]]

Fire = Class{__includes = Entity}

function Fire:init(def)
    Entity.init(self, def)
end

function Fire:collides(target)
    -- some horizontal lee way to trigger collion on fire inside tiles
    -- the 2 is for some leeway
    -- the 3 is for target height goes out of tile size
    return not (self.x + self.width - 2 < target.x or self.x + 2 > target.x + target.width or
                self.y + self.height - 2 < target.y + 3 or self.y + 2 > target.y + target.height) 
end

function Fire:update(dt)
    Entity.update(self, dt)
end


function Fire:render()
    Entity.render(self)
end