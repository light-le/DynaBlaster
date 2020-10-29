--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com


    idle state for bomb when it's just deployed 
]]

BombIdleState = Class{__includes = BaseState}

function BombIdleState:init(bomb, player)
    self.player = player
    self.bomb = bomb
    self.bomb:changeAnimation('idle')
    self.time = 0
    self.bomb.dead = true
    self.bomb.x = (self.bomb.xtile-1)*TILE_SIZE
    self.bomb.y = OFFSET_Y + (self.bomb.ytile-1)*TILE_SIZE
    self.bomb.canplayeron = true
end


function BombIdleState:update(dt)
    if self.bomb.dead then
        self.time = 0  -- this to make sure it doesn't get exploded when dead
    else
        self.bomb.x = (self.bomb.xtile-1)*TILE_SIZE
        self.bomb.y = OFFSET_Y + (self.bomb.ytile-1)*TILE_SIZE
        self.time = self.time + dt
        
        -- if player nolonger collides (on) bomb after deploy, change the state to false to block player from moving
        if not self.player:collides(self.bomb) then
            self.bomb.canplayeron = false
        end
    end
    
    if self.time >= TIME_TO_EXPLODE then
        self.bomb:changeState('explode')
    end
end


function BombIdleState:render()
    local anim = self.bomb.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
                       self.bomb.x, self.bomb.y)
end