--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    gSounds['music']:setLooping(true)
    gSounds['music']:play()
end

function PlayState:enter(params)
    self.level = params.level
    if self.level > 1 then
        gSounds['victory']:play()
    end
    self.player = params.player
    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['walk'] = function() return PlayerWalkState(self.player, self.room) end,
        ['die'] = function() return PlayerDieState(self.player) end
    }
    self.player:changeState('idle')
    self.room = Room(self.player, self.level)
    self.score = params.score or 0
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    self.room:update(dt)
end

function PlayState:render()
    self.room:render()
end