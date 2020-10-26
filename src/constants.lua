--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com
    
    some constants to make the world goes around
]]


VIRTUAL_WIDTH = 400
VIRTUAL_HEIGHT = 224

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

TILE_SIZE = 16

MAP_WIDTH = VIRTUAL_WIDTH/TILE_SIZE  -- including wall outside
MAP_HEIGHT = VIRTUAL_HEIGHT/TILE_SIZE - 1  -- leave some room for score, level, and life points

OFFSET_Y = VIRTUAL_HEIGHT - MAP_HEIGHT*TILE_SIZE

--
-- entity constants
--
PLAYER_WALK_SPEED = 60
TIME_TO_EXPLODE = 3  -- seconds
MAX_BOMB_DEPLOYS = 10 -- maximum bomb you can deploy, no matter how many pickups you get


--
-- tile id constants
--
WALL_IDS = {
    TOP = 43,
    TOPLEFT = 42,
    TOPRIGHT = 44,
    LEFT = 41,
    RIGHT = 45,
    BOTTOM = 47,  -- also used for bottom left and bottom right
    LEFTMOST = 49,
    RIGHTMOST = 50,
    MANHOLE = {
        LEFTUP = 56,
        LEFTDOWN = 57,
        RIGHTUP = 58,
        RIGHTDOWN = 59
    }
}
GRASS_IDS = {
    SHADOWED = 61,
    NORMAL = 62
}
PILLAR_ID = 40
EMPTY_TILE = 46 -- transparent tile
