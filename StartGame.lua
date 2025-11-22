local font = require "util.fonts"

local StartGame = {}
local timer = 0
local holdTime = 1.2
local fadeInTime = 1
local fadeOutTime = 1
local finished = false
local soundEffect = love.audio.newSource("assets/audio/startup.mp3", "static")

function StartGame.load()
    timer = 0
    finished = false
end

function StartGame.update(dt)
    if finished then return end
    timer = timer + dt
    if timer >= fadeInTime + holdTime + fadeOutTime then
        finished = true
    end
end

function StartGame.draw()
    if finished then return end

    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local alpha, textAlpha = 1, 1
    soundEffect:play()
    if timer < fadeInTime then
        alpha = timer / fadeInTime
        textAlpha = alpha
    elseif timer < fadeInTime + holdTime then
        alpha, textAlpha = 1, 1
    elseif timer < fadeInTime + holdTime + fadeOutTime then
        local t = timer - (fadeInTime + holdTime)
        alpha = 1 - t / fadeOutTime
        textAlpha = alpha
    end

    love.graphics.setColor(0, 0, 0, alpha)
    love.graphics.rectangle("fill", 0, 0, w, h)
    love.graphics.setColor(1, 1, 1, textAlpha)

    love.graphics.printf("Fantasy Yoga Club", 0, h * 0.35, w, "center")
    love.graphics.setFont(love.graphics.newFont(22))
    love.graphics.printf("Szabó Balázs - Kiss Álmos - Majoros Máté - Zsibók Bence", 0, h * 0.45, w, "center")
end

function StartGame.isDone()
    return finished
end

return StartGame
