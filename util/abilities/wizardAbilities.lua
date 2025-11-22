local effectImplementations = require "util.effectImplementations"

return {
    ability1 = {
        name = "Flame Orb",
        cooldown = 2,
        passive = false,
        effect = function(user)

            local damage = math.floor(user.stats.magic * 1.20)
            return damage
        end
    },
    ability2 = {
        name = "Frost Shard",
        cooldown = 3,
        passive = false,
        effect = function(user)

            local damage = math.floor(user.stats.magic * 1.50)
            return damage
        end
    },
    ability3 = {
        name = "Mind Focus",
        cooldown = 3,
        passive = false,
        effect = function(user)
            effectImplementations.mindFocusTurns.apply(user, 3)
        end
    },
    ability4 = {
        name = "Arcane Insight",
        cooldown = 0,
        passive = true,
        effect = function(user)
            user.stats.accuracy = user.stats.accuracy + 10
        end
    },
    ability5 = {
        name = "Meteor Burst",
        cooldown = 6,
        passive = false,
        effect = function(user)
            local damage = user.stats.magic * 1.60
        end
    }
}
