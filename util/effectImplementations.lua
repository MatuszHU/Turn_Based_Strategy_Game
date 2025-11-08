effectImplementations = {}

local function ensureEffectsTable(char)
    if not char.effects then
        char.effects = {}
    end
end

effectImplementations.burn = {
    burn = function(self)
        --TODO
    end
}

effectImplementations.freeze = {
    freeze = function(self)
        --TODO
    end
}

effectImplementations.berserkTurns = {
    apply = function(char)
        ensureEffectsTable(char)
        if not char.effects.berserkTurns then
            char.effects.berserkTurns = { remaining = 2, active = true }
            print(char.name .. " enters Berserk mode! Deals and takes double damage for 2 turns.")
        end
    end,

    modifyOutgoingDamage = function(damage, char)
        if char.effects.berserkTurns and char.effects.berserkTurns.active then
            return damage * 2
        end
        return damage
    end,

    modifyIncomingDamage = function(damage, char)
        if char.effects.berserkTurns and char.effects.berserkTurns.active then
            return damage * 2
        end
        return damage
    end,

    onTurnEnd = function(char)
        local eff = char.effects.berserkTurns
        if eff and eff.active then
            eff.remaining = eff.remaining - 1
            if eff.remaining <= 0 then
                print(char.name .. " calms down. Berserk has ended.")
                char.effects.berserkTurns = nil
            end
        end
    end
}

effectImplementations.battleCryTurns = {
    battleCryTurns = function(self)
        --TODO
    end
}

function effectImplementations:updateEffects(char)
    if not char.effects then return end

    for effectName, effData in pairs(char.effects) do
        local impl = self[effectName]
        if impl and impl.onTurnEnd then
            impl.onTurnEnd(char)
        end
    end
end

return effectImplementations