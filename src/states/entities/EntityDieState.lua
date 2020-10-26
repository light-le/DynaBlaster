--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    entity die state, triggered when fire hits
]]

EntityDieState = Class{__includes = BaseState}

function EntityDieState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('die')

    self.timer = 0
    self.entity.dead = true
end

function EntityDieState:update(dt)
    self.timer = self.timer + dt -- for tracking animation
    if self.timer >= #self.entity.currentAnimation.frames*self.entity.currentAnimation.interval then
        -- move it to off screen
        self.entity.x = VIRTUAL_WIDTH
        self.entity.y = VIRTUAL_HEIGHT
    end
    self.entity.xtile = ComputeXtile(self.entity.x)
    self.entity.ytile = ComputeYtile(self.entity.y)
end

function EntityDieState:processAI()
    -- just a frame, no need for any actual AI here
end

function EntityDieState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
                       self.entity.x, self.entity.y)
end