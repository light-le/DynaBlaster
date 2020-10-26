--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Walk state for monsters and player, for monster their AI would make sure they not get bumbed into
    wall or brick or pillar
]]

EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity, room)
    self.entity = entity
    self.entity:changeAnimation('walk-down')
    self.room = room

    self.in_movement = false  -- a brief moment to decide moving direction between tiles
    self.prv_direction = nil
    self.directions_avail = {}

    self.origin_x = self.entity.x
    self.origin_y = self.entity.y
end


function EntityWalkState:update(dt)

end

function EntityWalkState:processAI(room, dt)
    self.directions_avail = {} -- empty table at first
    if self.entity.follow_player then -- and can see player in view
        -- TODO: make entity follow player if they can see them
    else
        -- dumb monsters move randomly in any direction available
        -- check up first
        -- decide to move only if not in movement
        if not self.in_movement then
            if not hitBrickPillarWallBomb(ComputeXtile(self.entity.x), ComputeYtile(self.entity.y+self.entity.height-TILE_SIZE-1), room) then -- maybe it can walkthru?
                table.insert(self.directions_avail, 'up')
            end
            -- then down
            if not hitBrickPillarWallBomb(ComputeXtile(self.entity.x), ComputeYtile(self.entity.y+self.entity.height+1), room) then
                table.insert(self.directions_avail, 'down')
            end
            if not hitBrickPillarWallBomb(ComputeXtile(self.entity.x-1), ComputeYtile(self.entity.y+self.entity.height-TILE_SIZE), room) then
                table.insert(self.directions_avail, 'left')
            end
            if not hitBrickPillarWallBomb(ComputeXtile(self.entity.x+self.entity.width+1), ComputeYtile(self.entity.y+self.entity.height-TILE_SIZE), room) then
                table.insert(self.directions_avail, 'right')
            end

            -- pick a direction to process with it, 
            -- monsters are thrice likely to follow the same direction as before, if possible
            if self.prv_direction then
                if has_value(self.directions_avail, self.prv_direction) then
                    table.insert(self.directions_avail, self.prv_direction)
                    table.insert(self.directions_avail, self.prv_direction)
                    table.insert(self.directions_avail, self.prv_direction)
                    table.insert(self.directions_avail, self.prv_direction)
                end
            end

            -- only move if there's available space
            if self.directions_avail then
                -- pick a random
                self.entity.direction = self.directions_avail[math.random(#self.directions_avail)]

                -- flag movement to true to NOT redecide during move
                self.in_movement = true
            else
                self.entity.direction = nil
            end

            -- record the original coordinates
            self.origin_x = self.entity.x
            self.origin_y = self.entity.y
        end


        if self.entity.direction == 'up' then
            local ydest = self.origin_y - TILE_SIZE
            if ydest < self.entity.y then -- keep moving until get matched
                self.entity.y = self.entity.y - dt*self.entity.walkSpeed
            else  -- once it reaches destination
                self.entity.y = ydest -- snap up
                self.in_movement = false -- briefly stop to decide where to move
            end
        elseif self.entity.direction == 'down' then
            local ydest = self.origin_y + TILE_SIZE
            if ydest > self.entity.y then
                self.entity.y = self.entity.y + dt*self.entity.walkSpeed
            else
                self.entity.y = ydest
                self.in_movement = false -- briefly stop to decide where to move
            end
        elseif self.entity.direction == 'left' then
            local xdest = self.origin_x - TILE_SIZE
            if xdest < self.entity.x then
                self.entity.x = self.entity.x - dt*self.entity.walkSpeed
            else
                self.entity.x = xdest
                self.in_movement = false -- briefly stop to decide where to move
            end
        elseif self.entity.direction == 'right' then
            local xdest = self.origin_x + TILE_SIZE
            if xdest > self.entity.x then
                self.entity.x = self.entity.x + dt*self.entity.walkSpeed
            else
                self.entity.x = xdest
                self.in_movement = false -- briefly stop to decide where to move
            end
        end
        -- update xtile and ytile
        self.entity.xtile = ComputeXtile(self.entity.x)
        self.entity.ytile = ComputeYtile(self.entity.y + self.entity.height - TILE_SIZE)
        self.prv_direction = self.entity.direction
    end
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
                       self.entity.x, self.entity.y)
end