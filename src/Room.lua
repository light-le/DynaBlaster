--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com
]]

Room = Class{}

function Room:init(player, level)

    self.player = player
    self.level = level
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    -- generate base tiles like wall, grass, for background effect
    self.tiles = {}
    self.pickups = {}  -- both are hidden under bricks but should never overlap
    self.door = nil 
    self.brick_coors = {} -- yx coordinates of brick, for more optimal algo
    
    -- an empty table for monster entities
    self.monsters = {}
    self.max_monsters = 3 + self.level*2
    
    
    -- create an array for all the bombs possible, no matter how many we can deploy
    self.bombs = {}
    for i = 1, MAX_BOMB_DEPLOYS do
        local bomb = Bomb {
            animations = ENTITY_DEFS['bomb'].animations,
            xtile = 1, -- should be 0, but will not get rendered if dead anyway
            ytile = 1,
            
            width = TILE_SIZE,
            height = TILE_SIZE,
            dead = true
        }
        table.insert(self.bombs, bomb)
        self.bombs[i].stateMachine = StateMachine {
            ['idle'] = function() return BombIdleState(bomb, self.player) end,
            ['explode'] = function() return BombExplodeState(bomb, self) end
        }
        self.bombs[i]:changeState('idle')  -- idle first, but dead
    end
    self:generateTilesEntities()
end


function Room:generateTilesEntities()
    -- generate everything from wall to door except for bomb or fire
    local pickups = {'extrabomb', 'biggerblast'}  -- only 2 pickups for now
    local mons = 0  -- number of monster count
    for y = 1, self.height do
        table.insert(self.tiles, {})
        table.insert(self.brick_coors, {})
        for x = 1, self.width do
            local id = TILE_EMPTY
            local brick_object = false

            -- generate outer walls
            if x == 2 and y == 1 then
                id = WALL_IDS.TOPLEFT
            elseif x == self.width - 1 and y == 1 then
                id = WALL_IDS.TOPRIGHT
            elseif x == 1 then
                id = WALL_IDS.LEFTMOST
            elseif x == self.width then
                id = WALL_IDS.RIGHTMOST
            elseif y == self.height then
                id = WALL_IDS.BOTTOM
            elseif x == 2 then
                if y == 4 or y == self.height - 3 then
                    id = WALL_IDS.MANHOLE.LEFTUP
                elseif y == 5 or y == self.height - 2 then
                    id = WALL_IDS.MANHOLE.LEFTDOWN
                else 
                    id = WALL_IDS.LEFT
                end
            elseif x == self.width - 1 then
                if y == 4 or y == self.height - 3 then
                    id = WALL_IDS.MANHOLE.RIGHTUP
                elseif y == 5 or y == self.height - 2 then
                    id = WALL_IDS.MANHOLE.RIGHTDOWN
                else
                    id = WALL_IDS.RIGHT
                end
            elseif y == 1 then
                id = WALL_IDS.TOP
                
            -- generate pillar for odd rows and even column
            elseif y % 2 == 1 and x % 2 == 0 then
                id = PILLAR_ID
            -- the last are just grass, normal and shadowed
            else
                if y % 2 == 0 and x % 2 == 0 and y >= 4 then  -- below pillar
                    id = GRASS_IDS.SHADOWED
                else
                    id = GRASS_IDS.NORMAL
                end
                -- generate bricks and pickups on grass, randomly, but make sure leaving 3 tiles for 2nd rows
                if (y > 2 or x > 5) and math.random(10) <= 2 then
                    -- even random for pickups under bridge
                    if math.random(10) <= 2 then
                        -- choose a random pickup
                        local pickup = pickups[math.random(#pickups)]
                        table.insert(self.pickups, GameObject(GAME_OBJECT_DEFS[pickup], x, y))
                    end
                    -- put a brick over it
                    brick_object = Brick{
                        xtile = x,
                        ytile = y,
                        animations = ENTITY_DEFS['brick'].animations
                    }
                    brick_object:changeAnimation('normal')
                elseif (y > 2 or x > 5) and math.random(10) == 1 and mons < self.max_monsters then
                    -- generate monster entity if there's grass and no brick,
                    -- will think of different monster based on difficulty
                    mons = mons + 1
                    table.insert(self.monsters, Entity {
                        xtile = x,
                        ytile = y,
                        walkSpeed = ENTITY_DEFS['baloon'].walkSpeed,
                        animations = ENTITY_DEFS['baloon'].animations,
                        width = TILE_SIZE,
                        height = 18,
                    })
                    
                    self.monsters[mons].stateMachine = StateMachine {
                        ['walk'] = function() return EntityWalkState(self.monsters[mons], self) end,
                        ['die'] = function() return EntityDieState(self.monsters[mons]) end,
                    }
                    self.monsters[mons]:changeState('walk')
                end
            end
            
            -- insert those tiles
            table.insert(self.tiles[y], {id = id})
            table.insert(self.brick_coors[y], brick_object)
        end
    end
end


function Room:update(dt)
    self.player:update(dt)
    
    if love.keyboard.wasPressed('space') then
        for b = 1, self.player.bombstock do
            local bomb = self.bombs[b]
            if bomb.dead then  -- only deploy bomb if its dead or in stock
                bomb.xtile = self.player.xtile
                bomb.ytile = self.player.ytile
                bomb.dead = false
                bomb.deployed = true
                break
            end
        end
    end

    for b, bomb in pairs(self.bombs) do
        bomb:update(dt)
    end

    for y = 1,self.height do
        for x = 1,self.width do
            if self.brick_coors[y][x] then
                self.brick_coors[y][x]:update(dt)
            end
        end
    end
    for m, monster in pairs(self.monsters) do
        monster:update(dt)
        if not monster.dead then
            monster:processAI(self, dt)
            if self.player:collides(monster) and not self.player.dead then
                self.player:changeState('die')
            end
        else
            monster:getKilled(dt)
            if not monster.inplay then table.remove(self.monsters, m) end
        end
    end

    if #self.monsters == 0 then
        gStateMachine:change('play', {level = self.level + 1, score = 0,
                                      player = Player{
                                        animations = ENTITY_DEFS['player'].animations,
                                        walkSpeed = self.player.walkSpeed,
                          
                                        xtile = 3,
                                        ytile = 2,
                                
                                        width = TILE_SIZE,
                                        height = 19,
                                
                                        life = self.player.life,
                                        bombstock = self.player.bombstock,
                                        firerange = self.player.firerange
                                    
                                      }})
    end
end

function Room:render()
    for y = 1,self.height do
        for x = 1,self.width do
            -- first draw the tiles in background
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                               (x-1)*TILE_SIZE, (y-1)*TILE_SIZE + OFFSET_Y)

            local brick = self.brick_coors[y][x]
            if brick then  -- if there's a brick in this coordinate
                brick:render()
            end
        end
    end
    
    -- draw item and door first WAIT UNTIL BRICK IS RESOLVED
    -- for i, pickup in pairs(self.pickups) do
    --     love.graphics.draw(gTextures[pickup.texture], gFrames[pickup.texture][pickup.frame], pickup.x, pickup.y)
    -- end
    
    -- bomb, if any
    for i, bomb in pairs(self.bombs) do
        if not bomb.dead then
            bomb:render()
        end
    end
    
    
    for m, monster in pairs(self.monsters) do
        monster:render()
    end
    
    -- last but not least, player
    self.player:render()


    -- dashboard display
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][86], 0, 0)
    love.graphics.print(tostring(self.player.life), 20, 0)
    love.graphics.print('Level: ' .. tostring(self.level), 50, 0)
end