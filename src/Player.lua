--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Player class, based on Entity class but with some extra functions
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def, 3, 2)
    -- self.life = def.life
    self.bombstock = def.bombstock or 5
    self.firerange = def.firerange or 4
    self.timer = 0
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:collides(target)
    -- because player head perspective could overlap with target, only account for half of y
    -- local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width - 1 < target.x or self.x + 1 > target.x + target.width or
                -- selfY - 1 + selfHeight < target.y or selfY > target.y + target.height)
                self.y + self.height - 1 < target.y or self.y + 4 > target.y + target.height) 
end

function Player:die(dt)
    -- triggered when fire or monster hit
    
    self:changeAnimation('die')
    self.life = self.life - 1
    self.timer = self.timer + dt

    -- for tracking animations
    if self.timer >= #self.currentAnimation.frames*self.currentAnimation.interval then
        -- after die animation, move back to origin
        -- self.currentAnimation:refresh()
        self.x = TILE_SIZE*2
        self.y = OFFSET_Y + TILE_SIZE*2-self.height
        self:changeAnimation('idle-down')
    end
end


function Player:render()
    Entity.render(self)
end