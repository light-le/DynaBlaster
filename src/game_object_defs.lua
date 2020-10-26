--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com
]]


GAME_OBJECT_DEFS = {
    ['brick'] = {
        type = 'brick',
        texture = 'tiles',
        frame = 60,
        solid = true,
        explodable = true,
        consumable = false,
        canWalkThru = true,
        defaultState = 'normal',
        animations = {
            ['normal'] = {60},
            ['exploded'] = {30, 31, 32, 33, 34, 35, 36},
            ['shiny'] = {30, 60}
        }
    },
    ['extrabomb'] = {
        type = 'pickup',
        texture = 'tiles',
        frame = 79,
        solid = false,
        explodable = true,
        consumable = true,
        canWalkThru = true,
        defaultState = 'idle',
        states = {
            ['idle'] = 79,
            ['flashing'] = {79, 63}
        }
    },
    ['biggerblast'] = {
        type = 'pickup',
        texture = 'tiles',
        frame = 80,
        solid = false,
        explodable = true,
        consumable = true,
        canWalkThru = true,
        defaultState = 'idle',
        states = {
            ['idle'] = 80,
            ['flashing'] = {80, 64}
        }
    },
    ['fastermove'] = {
        type = 'pickup',
        texture = 'tiles',
        frame = 82,
        solid = false,
        explodable = true,
        consumable = true,
        canWalkThru = true,
        defaultState = 'idle',
        states = {
            ['idle'] = 82,
            ['flashing'] = {82, 66}
        }
    },
    ['door'] = {
        type = 'door',
        texture = 'tiles',
        frame = 78,
        solid = false,
        explodable = false,
        consumable = true,
        canWalkThru = true,
        defaultState = 'idle',
        states = {
            ['idle'] = 78,
            ['flashing'] = {78, 94}
        }
    }
}