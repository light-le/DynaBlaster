--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Entity class, is a base class for players as well as monsters, and bomb, and fire and brick
]]

Entity = Class{}

function Entity:init(def)
    self.direction = 'down'


    -- positions, in tile and in xy
    self.xtile = def.xtile
    self.ytile = def.ytile
    self.width = def.width or TILE_SIZE
    self.height = def.height or TILE_SIZE  -- 18 is monster tile size while 19 is players'
    self.x = (self.xtile-1)*TILE_SIZE
    -- minus difference between height and TILE_SIZE to simulate height/perspective
    self.y = (self.ytile-1)*TILE_SIZE + OFFSET_Y - (self.height - TILE_SIZE)
    -- geometric center, this is help with passing between pillars without getting stuck
    self.centerx = self.x + self.width / 2
    self.centery = self.y + self.height / 2

    self.animations = self:createAnimations(def.animations)

    -- whether they can walkthru bricks or follow player
    self.canWalkThru = def.canWalkThru or false
    self.follow_player = def.follow_player or false

    self.walkSpeed = def.walkSpeed

    -- whether it's dead or not
    self.dead = def.dead or false
    self.life = def.life or 1
    self.inplay = true  -- remove from table if false

    self.timer = 0
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'tiles',
            frames = animationDef.frames,
            interval = animationDef.interval,
            looping = animationDef.looping
        }
    end

    return animationsReturned
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:update(dt)
    self.currentAnimation:update(dt)
    if self.stateMachine then -- not everything has a state
        self.stateMachine:update(dt)
    end
end

function Entity:render()
    self.stateMachine:render()
end

function Entity:getKilled(dt)
    self:changeAnimation('die')
    self.timer = self.timer + dt
    if self.timer >= #self.currentAnimation.frames*self.currentAnimation.interval then
        self.x = VIRTUAL_WIDTH
        self.y = VIRTUAL_HEIGHT
        self.inplay = false
    end
end