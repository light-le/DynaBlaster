--[[
    GD50 Final Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Entity definition:
    Beside Player, there are 6 kinds of monster, from easiest to hardest
    slow means 1/2 player speed, medium = player speed, fast = 2x player speed

    - baloon: slow, move random, cant pass brick
    - toad: medium speed, move random, cant pass prick
    - bat: slow, follow you, can pass brick
    - coin: medium speed, move random, pass brick
    - rat: fast, follow you, cant pass brick, (optional) double speed after 1st bomb hit
    - sweeper: medium speed, follow you, pass brick

]]

ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {7, 8, 7, 9},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-right'] = {
                frames = {12, 11, 12, 10},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-up'] = {
                frames = {4, 5, 4, 6},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-down'] = {
                frames = {1, 2, 1, 3},
                interval = 0.15,
                texture = 'player'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'player'
            },
            ['idle-right'] = {
                frames = {12},
                texture = 'player'
            },
            ['idle-up'] = {
                frames = {4},
                texture = 'player'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'player'
            },
            ['die'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.25,
                texture = 'playdie',
                looping = false
            }
        }
    },

    ['bomb'] = {
        walkSpeed = 0,
        animations = {
            ['idle'] = {
                frames = {37, 38, 39, 38},
                interval = 0.5,
                texture = 'tiles',
                looping = true
            },
            ['explode'] = {
                frames = {29, 28, 27, 26, 25, 26, 27, 28},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            }
        }
    },
    ['brick'] = {
        walkSpeed = 0,
        animations = {
            ['normal'] = {
                frames = {60},
            },
            ['explode'] = {
                frames = {60, 30, 31, 32, 33, 34, 35, 36},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['shiny'] = {
                frames = {30, 60},
                interval = 0.05,
                texture = 'tiles',
                looping = true
            }
        }
    },

    ['fire'] = {
        walkSpeed = 0,
        animations = {
            ['midup'] = {
                frames = {46, 20, 19, 18, 17, 18, 19, 20},  -- the first frame 46 is empty
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['middown'] = {
                frames = {46, 20, 19, 18, 17, 18, 19, 20},  -- the first frame 46 is empty
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['midleft'] = {
                frames = {46, 24, 23, 22, 21, 22, 23, 24},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['midright'] = {
                frames = {46, 24, 23, 22, 21, 22, 23, 24},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['up'] = {
                frames = {46, 4, 3, 2, 1, 2, 3, 4},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['down'] = {
                frames = {46, 12, 11, 10, 9, 10, 11, 12},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['left'] = {
                frames = {46, 16, 15, 14, 13, 14, 15, 16},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            },
            ['right'] = {
                frames = {46, 8, 7, 6, 5, 6, 7, 8},
                interval = 0.1,
                texture = 'tiles',
                looping = false
            }
        }
    },

    ['baloon'] = {
        walkSpeed = PLAYER_WALK_SPEED/2,
        animations = {
            ['walk-left'] = {
                frames = {8,9,8,10}, -- flip quad for this
                interval = 0.15,
                texture = 'monsters',
                looping = true
            },
            ['walk-down'] = {
                frames = {8,9,8,10},
                interval = 0.15,
                texture = 'monsters',
                looping = true
            },
            ['walk-up'] = {
                frames = {8,9,8,10},
                interval = 0.15,
                texture = 'monsters',
                looping = true
            },
            ['walk-right'] = {
                frames = {8,9,8,10},
                interval = 0.15,
                texture = 'monsters',
                looping = true
            },
            ['die'] = {
                frames = {11, 12, 1, 2, 3, 4}, -- to be added more frame later  
                interval = 0.15,
                texture = 'monsters',
                looping = false
            },
        }
    }
}