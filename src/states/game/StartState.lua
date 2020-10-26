--[[
    GD50 Final Project
    Dyna50
    
    Author: Anh Quang Le
    aerortsanh@gmail.com
    ]]
    
    StartState = Class{__includes = BaseState}
    
function StartState:init()
    gSounds['intro']:setLooping(true)
    gSounds['intro']:play()
    self.player = Player{
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = PLAYER_WALK_SPEED,

        xtile = 3,
        ytile = 2,

        width = TILE_SIZE,
        height = 19,

        life = 3
    }
end

function StartState:enter(params)

end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['intro']:stop()
        gStateMachine:change('play', {level = 1, score = 0, player = self.player})
    end
end

function StartState:render()
    love.graphics.draw(gTextures['wallpaper'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['wallpaper']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['wallpaper']:getHeight())

    love.graphics.setFont(gFonts['arcade_large'])
    love.graphics.setColor(34/255, 34/255, 34/255, 255/255)
    love.graphics.printf('Dyna 50', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    love.graphics.printf('Dyna 50', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['arcade_medium'])
    love.graphics.setColor(248/255, 48/255, 111/255, 255/255)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end