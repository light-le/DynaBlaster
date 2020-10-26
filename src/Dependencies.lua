--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'


require 'src/constants'
require 'src/Util'
require 'src/Animation'
require 'src/GameObject'
require 'src/game_object_defs'
require 'src/Entity'
require 'src/entity_defs'
require 'src/Player'
require 'src/Brick'
require 'src/Bomb'
require 'src/Fire'
require 'src/Room'

require 'src/states/StateMachine'
require 'src/states/BaseState'

require 'src/states/entities/EntityWalkState'
require 'src/states/entities/EntityDieState'
require 'src/states/entities/PlayerIdleState'
require 'src/states/entities/PlayerWalkState'
require 'src/states/entities/PlayerDieState'
require 'src/states/entities/BombExplodeState'
require 'src/states/entities/BombIdleState'
require 'src/states/game/GameOverState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'


gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['monsters'] = love.graphics.newImage('graphics/monsters.png'),
    ['playdie'] = love.graphics.newImage('graphics/playdie.png'),
    ['wallpaper'] = love.graphics.newImage('graphics/wallpaper.jpg')
}

gFrames = {
    ['tiles'] = GenerateTileQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE, 1, 1),
    ['monsters'] = GenerateTileQuads(gTextures['monsters'], TILE_SIZE, 18, 1, 1),
    ['player'] = GenerateTileQuads(gTextures['player'], TILE_SIZE, 19, 1),
    ['playdie'] = GenerateTileQuads(gTextures['playdie'], 21, 23, 1)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['arcade_large'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32),
    ['arcade_medium'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 16)
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
    ['intro'] = love.audio.newSource('sounds/intro.mp3', 'static'),
    ['boom'] = love.audio.newSource('sounds/boom.wav', 'static'),
    ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
    ['die'] = love.audio.newSource('sounds/die.wav', 'static')
}