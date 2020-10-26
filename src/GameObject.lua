--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Object class: includes bricks, pillar, pickups, door, bomb, and fire
    All the things that interacts with players and monsters beside the outer walls
]]

GameObject = Class{}

function GameObject:init(def, xtile, ytile)
    self.type = type  -- type of object, bricks, pillar, pickups, door, bomb

    -- image display for this object
    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle, apply for pillar, bomb (special), brick (special)
    self.solid = def.solid

    -- whether it can be triggered on explosion by bomb
    self.explodable = def.explodable

    -- whether it can be consumed, apply for pickup
    self.consumable = def.consumable

    -- whether it can be walked thru, apply for bricks
    self.canWalkThru = def.canWalkThru

    -- whether it moves upon collision with player
    self.kickable = def.kickable or false


    -- states
    self.defaultState = def.defaultState
    self.state = def.defaultState
    self.states = def.states

    -- position
    self.xtile = xtile
    self.ytile = ytile
    self.width = def.width or TILE_SIZE
    self.height = def.height or TILE_SIZE
    -- translate to x and y coordinates for render
    self.x = (self.xtile - 1)*TILE_SIZE
    self.y = (self.ytile - 1)*TILE_SIZE + OFFSET_Y 

    -- default empty collision callback
    self.onCollision = function() end

    -- default empty explosion callback
    self.onExplosion = function() end
end

function GameObject:update(dt)

end

function GameObject:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state] or self.frame],
                       (self.xtile-1)*TILE_SIZE, (self.ytile-1)*TILE_SIZE+OFFSET_Y)
end


