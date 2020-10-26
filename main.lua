--[[
    GD50
    Final Project

    Author:
    Anh Quang Le
    aerortsanh@gmail.com

    Dyna50

    Also known as Bomberman, which is developed by HudsonSoft, DynaBlaster is the European version
    released in the 1990s. It has a player going around planting bombs, which take about 3 seconds
    to explode. There are also some monsters running around trying to eat the player. If the bomb
    blasting range hits either player or monster, they die. If the player blows up all the monsters,
    they win and progress to the next level. There are a few powerup that enhance the bomb range
    and count.

    Music credit to
    https://freesound.org/people/tyops/sounds/423805/ game theme #4 by tyops
    https://freesound.org/people/DominikBraun/sounds/483502/ Let me see ya bounce by DominikBraun

    Background intro Artwork by caveman in https://www.wallpapercave.com

    Sprite Art Sheet credit to Ragey
    http://eab.abime.net/attachment.php?...9&d=1109068442
    http://eab.abime.net/attachment.php?...0&d=1109068454
]]

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('DynaBlaster')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(gFonts['small'])

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    gStateMachine:render()
    push:finish()
end