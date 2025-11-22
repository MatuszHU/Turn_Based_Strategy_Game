local NameManager = require "util.nameManager"

local Player2Roster = {}
Player2Roster.__index = Player2Roster

function Player2Roster:new(characterManager)
    local self = setmetatable({}, Player2Roster)
    self.characterManager = characterManager
    self.nameManager = NameManager()

    -- Permanent player-owned characters
    self.characters = {
        characterManager:addCharacter(self.nameManager:getRandomName("elf", "male"), "goblin", "knight", 1, 10, 4),
        characterManager:addCharacter(self.nameManager:getRandomName("human", "male"), "goblin", "cavalry", 1, 14, 4),
        characterManager:addCharacter(self.nameManager:getRandomName("human", "male"), "goblin", "wizard", 1, 15, 5),
        characterManager:addCharacter(self.nameManager:getRandomName("human", "male"), "goblin", "priest", 1, 16, 5),
    }

    return self
end

function Player2Roster:addCharacter(name, race, class, spriteIndex, gridX, gridY, level)
    local char = self.characterManager:addCharacter(name, race, class, spriteIndex, gridX, gridY)
    char.level = level or 1
    table.insert(self.characters, char)
    print("Recruited new character: " .. name)
end

function Player2Roster:resetAfterBattle()
    local startPositions = {
        { x = 3, y = 4 },
        { x = 5, y = 4 },
        { x = 4, y = 5 }
    }

    for i, char in ipairs(self.characters) do
        char.isDefeated = false
        if char.stats then
            char.stats.hp = char.stats.max_hp or 1
        end
        if startPositions[i] then
            char.gridX = startPositions[i].x
            char.gridY = startPositions[i].y
        end
        if char.loadSprite then
            char:loadSprite(char.offsetX)
        end
        if char.spriteManager then
            local cw, ch = self.characterManager.gridManager.cellW, self.characterManager.gridManager.cellH
            local sw, sh = char.spriteManager.sheetWidth, char.spriteManager.sheetHeight
            char.scale = { x = cw / (sw / 3), y = ch / (sh / 2) }
        end
    end
end

function Player2Roster:getTeam()
    return self.characters
end

return Player2Roster
