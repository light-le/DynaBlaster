--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com


    Explode state for bomb 
]]

BombExplodeState = Class{__includes = BaseState}

function BombExplodeState:init(bomb, room)
    self.bomb = bomb
    self.room = room
    self.bomb:changeAnimation('explode')
    self.time = 0


    self.deployed = false -- no longer deployed if exploded
    self.fires = self:spawnFires(self.bomb, self.room)  -- init empty fire object first
    gSounds['boom']:play()
end

function BombExplodeState:spawnFires(bomb, room)
    -- initiate fires in 4 directions, stop when hits brick, wall or pillar
    dxtile = {
        ['up'] = 0,
        ['down'] = 0,
        ['left'] = -1,
        ['right'] = 1
    }
    dytile = {
        ['up'] = -1,
        ['down'] = 1,
        ['left'] = 0,
        ['right'] = 0    
    }
    local fires = {}
    local directions = {'up', 'down', 'left', 'right'}
    for d, direction in pairs(directions) do 
        local fire_ytile = bomb.ytile  -- only y would change
        local fire_xtile = bomb.xtile  -- only y would change
        
        for firetile = 1, room.player.firerange do
            -- check if hits wall, pillar or brick to stop range
            fire_ytile = fire_ytile + dytile[direction]
            fire_xtile = fire_xtile + dxtile[direction]
            if hitBrickPillarWallBomb(fire_xtile, fire_ytile, room) then -- if hitting any hard stuff
                if room.brick_coors[fire_ytile][fire_xtile] then -- if hit brick, trigger destroy
                    room.brick_coors[fire_ytile][fire_xtile]:getExploded()
                end
                break -- stop the loop
            else
                table.insert(fires, Fire {
                    animations = ENTITY_DEFS['fire'].animations,
                    xtile = fire_xtile,
                    ytile = fire_ytile,
                    
                    width = TILE_SIZE,
                    height = TILE_SIZE,
                })
                
                -- trigger the bomb in range to explosion too, ERROR stack overflow
                -- for b, bomb in pairs(self.room.bombs) do
                --     if bomb.xtile == fire_xtile and bomb.ytile == fire_ytile and bomb.deployed then
                --         bomb:changeState('explode')
                --     end
                -- end
            end
            if firetile == room.player.firerange then -- if it's the end of the fire range
                fires[#fires]:changeAnimation(direction)
            else
            fires[#fires]:changeAnimation('mid' .. direction)
            end
        end
    end
    return fires
end


function BombExplodeState:update(dt)
    for f, fire in pairs(self.fires) do
        fire:update(dt)
        if fire:collides(self.room.player) and not self.room.player.dead then
            self.room.player:changeState('die')
        end
        for m, monster in pairs(self.room.monsters) do
            if fire:collides(monster) then
                monster.dead = true
            end
        end
    end
    
    
    -- exploding duration (animation and stuff)
    self.time = self.time + dt
    local anim = self.bomb.currentAnimation
    if self.time >= #anim.frames*anim.interval then
        -- after explosion, remove bomb and exploded brick
        for ytile = 1, #self.room.brick_coors do
            for xtile = 1, #self.room.brick_coors[ytile] do
                if self.room.brick_coors[ytile][xtile] then
                    if self.room.brick_coors[ytile][xtile].dead then
                        self.room.brick_coors[ytile][xtile] = false
                    end
                end
            end
        end

        self.bomb.dead = true
        self.bomb.x = 0
        self.bomb.y = 0
        anim:refresh()
        self.bomb:changeState('idle')
    end
end


function BombExplodeState:render()
    local anim = self.bomb.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
                       self.bomb.x, self.bomb.y)
    for f, fire in pairs(self.fires) do
        local fireanim = fire.currentAnimation
        love.graphics.draw(gTextures[fireanim.texture], gFrames[fireanim.texture][fireanim:getCurrentFrame()],
                           fire.x, fire.y)
    end
end