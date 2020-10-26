--[[
    GD50 Final Project
    Dyna50

    This is a base state so we don't have to reinitiate every time we make a state
]]

BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end