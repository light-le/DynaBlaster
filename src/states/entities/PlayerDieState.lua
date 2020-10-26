--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail

    Player die state, triggered when hit by fire of monster.
    Play the animation, then move back to original square
]]

PlayerDieState = Class{__includes = BaseState}

function PlayerDieState:init(player)
    self.player = player
    self.player.dead = true

    self.player.life = self.player.life - 1

    self.player:changeAnimation('die')
    self.timer = 0
    gSounds['die']:play()
end

function PlayerDieState:update(dt)
    self.timer = self.timer + dt
    -- for tracking animations
    if self.timer >= #self.player.currentAnimation.frames*self.player.currentAnimation.interval then
        -- after die animation, move back to origin
        self.player.currentAnimation:refresh()
        self.player.x = TILE_SIZE*2
        self.player.y = OFFSET_Y + TILE_SIZE*2-self.player.height
        self.player.direction = 'down'
        self.player.dead = false
        if self.player.life == 0 then
            gStateMachine:change('game-over')
        end
        self.player:changeState('idle')
    end
end

function PlayerDieState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
                       self.player.x, self.player.y)
end