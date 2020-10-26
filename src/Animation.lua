--[[
    GD50 Final  Project
    Dyna50

    Author: Anh Quang Le
    aerortsanh@gmail.com

    Animation class

    Used for repeated animations such as bomb idling, player walking, monsters moving, items flashing
    as wells as non repeated animations such as fire blasting, brick explosion 
]]

Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.texture = def.texture
    self.looping = def.looping == nil and true or def.looping

    self.timer = 0
    self.currentFrame = 1

    -- used to see if we've seen a whole loop of the animation
    self.timesPlayed = 0
end

function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    -- if not a looping animation and we've played at least once, exit
    if not self.looping and self.timesPlayed > 0 then
        return
    end

    -- no need to update if animation is only one frame
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = self.currentFrame + 1

            -- if it gets above loopthen we've looped back to the beginning, record
            if self.currentFrame > #self.frames then
                self.currentFrame = self.looping and 1 or #self.frames
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end