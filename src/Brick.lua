--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Brick object, can stop fire but somehow get destroyed along with it
    could stop some monster and player
]]

Brick = Class{__includes = Entity}

function Brick:init(def)
    Entity.init(self, def)
end

function Brick:update(dt)
    Entity.update(self, dt)
end

function Brick:getExploded()
    -- triggered when fire hits
    self:changeAnimation('explode')
    self.dead = true
end

function Brick:render()
    local anim = self.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()], self.x, self.y)
end

