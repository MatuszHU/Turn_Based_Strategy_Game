local EffectManager = {}
EffectManager.__index = EffectManager

function EffectManager:new(battle, effectImplementations)
    local self = setmetatable({}, EffectManager)
    self.battle = battle
    self.effects = effectImplementations or {}
    return self
end

-- 🔹 Apply an effect by name (calls its apply function)
function EffectManager:applyEffect(target, effectName, ...)
    local effect = self.effects[effectName]
    if not effect then
        print("⚠️ Unknown effect:", effectName)
        return
    end
    if effect.apply then
        effect.apply(target, ...)
    else
        print("⚠️ Effect " .. effectName .. " has no apply() function.")
    end
end

-- 🔹 Call at the end of a turn (delegates to all active effects)
function EffectManager:onTurnEnd(target)
    if not target or not target.effects then return end

    for name, _ in pairs(target.effects) do
        local effect = self.effects[name]
        if effect and effect.onTurnEnd then
            effect.onTurnEnd(target)
        end
    end
end

-- 🔹 Called when a character takes damage
function EffectManager:onDamageTaken(target, damage)
    if not target or not target.effects then return damage end
    local finalDamage = damage

    for name, _ in pairs(target.effects) do
        local effect = self.effects[name]
        if effect and effect.onDamageTaken then
            finalDamage = effect.onDamageTaken(target, finalDamage)
        end
    end

    return finalDamage
end

-- 🔹 Modify outgoing damage (for effects like Berserk)
function EffectManager:modifyOutgoingDamage(damage, attacker)
    local modified = damage
    if not attacker or not attacker.effects then return modified end

    for name, _ in pairs(attacker.effects) do
        local effect = self.effects[name]
        if effect and effect.modifyOutgoingDamage then
            modified = effect.modifyOutgoingDamage(modified, attacker)
        end
    end

    return modified
end

-- 🔹 Modify incoming damage (for effects like Shield)
function EffectManager:modifyIncomingDamage(damage, target)
    local modified = damage
    if not target or not target.effects then return modified end

    for name, _ in pairs(target.effects) do
        local effect = self.effects[name]
        if effect and effect.modifyIncomingDamage then
            modified = effect.modifyIncomingDamage(modified, target)
        end
    end

    return modified
end

-- 🔹 Remove a specific effect cleanly
function EffectManager:removeEffect(target, effectName)
    if not target or not target.effects then return end

    if target.effects[effectName] then
        target.effects[effectName] = nil
        print(effectName .. " removed from " .. target.name)
    end
end

-- 🔹 Utility: check if a character has a given effect active
function EffectManager:hasEffect(target, effectName)
    return target and target.effects and target.effects[effectName] ~= nil
end

-- 🔹 Update all characters (typically once per turn)
function EffectManager:updateAllEffects()
    for _, char in ipairs(self.battle.characterManager.characters) do
        self:onTurnEnd(char)
    end
end

return EffectManager
