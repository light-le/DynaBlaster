--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    walk state for player, inherited from playerWalkState with a few extra functions like bumping
    deploying bomb
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, room)
    self.player = player
    self.room = room
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.player.direction = 'up'
        self.player:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.player.direction = 'down'
        self.player:changeAnimation('walk-down')
    else
        self.player:changeState('idle')
    end

    self.player.xtile = ComputeXtile(self.player.x + self.player.width/2)
    self.player.ytile = ComputeYtile(self.player.y + self.player.height - TILE_SIZE/2)

    -- auto snap during move
    -- TODO makes player cannot pass bomb here after bomb.canplayeron is false
    if self.player.direction == 'left' or self.player.direction == 'right' then
        local dirvec = self.player.direction == 'right' and 1 or -1
        if not self.player.canWalkThru then -- check for brick if player has no walkthru ability
            if self.player.direction == 'left' and hitBrick(ComputeXtile(self.player.x-1), self.player.ytile, self.room) then  -- self.room.brick_coors[self.player.ytile][ComputeXtile(self.player.x-1)] then
                dirvec = 0
            end
            if self.player.direction == 'right' and hitBrick(ComputeXtile(self.player.x+self.player.width+1), self.player.ytile, self.room) then -- self.room.brick_coors[self.player.ytile][ComputeXtile(self.player.x+self.player.width+1)] then
                dirvec = 0
            end
        end

        -- when moving horizontally, y should not change, snap to the right grid
        if self.player.ytile % 2 == 0 then -- only move at non pillar row
            self.player.y = OFFSET_Y + self.player.ytile*TILE_SIZE - self.player.height
            self.player.x = self.player.x + self.player.walkSpeed*dt*dirvec
        end

        -- cancel movement if hit bomb
        for b, bomb in pairs(self.room.bombs) do
            if self.player:collides(bomb) and not bomb.canplayeron then
                self.player.x = self.player.x - self.player.walkSpeed*dt*dirvec
            end
        end
    elseif self.player.direction == 'up' or self.player.direction == 'down' then
        local dirvec = self.player.direction == 'down' and 1 or -1
        if not self.player.canWalkThru then
            if self.player.direction == 'up' and hitBrick(self.player.xtile, ComputeYtile(self.player.y + self.player.height - TILE_SIZE - 1), self.room) then
                dirvec = 0
            end
            if self.player.direction == 'down' and hitBrick(self.player.xtile, ComputeYtile(self.player.y + self.player.height + 1), self.room) then
                dirvec = 0
            end
        end
        -- when moving vertically, x should not change, snap to the right grid
        if self.player.xtile % 2 == 1 then
            self.player.x = (self.player.xtile-1)*TILE_SIZE
            self.player.y = self.player.y + self.player.walkSpeed*dt*dirvec
        end

        -- cancel movement if hit bomb
        for b, bomb in pairs(self.room.bombs) do
            if self.player:collides(bomb) and not bomb.canplayeron then
                self.player.y = self.player.y - self.player.walkSpeed*dt*dirvec
            end
        end
    end

    -- make sure player does not go pass the boundary wall
    self.player.x = math.min(math.max(self.player.x, 2*TILE_SIZE), VIRTUAL_WIDTH - 3*TILE_SIZE)
    self.player.y = math.min(math.max(self.player.y, OFFSET_Y + 2*TILE_SIZE - self.player.height),
                             VIRTUAL_HEIGHT - TILE_SIZE - self.player.height)
end

function PlayerWalkState:render() -- have to leave this here because entitywalkstate would not have its own animation
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
                        self.player.x, self.player.y)
end