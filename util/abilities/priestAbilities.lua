local effectImplementations = require "util.effectImplementations"

return {
    ability1 = {
        name = "Holy Mend",
        cooldown = 2,
        passive = false,
        effect = function(user)
            return -1 * (user.stats.magic * 0.6)
        end
    },
    ability2 = {
        name = "Smite of Faith",
        cooldown = 2,
        passive = false,
        effect = function(user)
            return user.stats.magic * 1.05
        end
    },
    ability3 = {
        name = "Curse of Weakness",
        cooldown = 3,
        passive = false,
        effect = function(user)
            effectImplementations.curseTurns.apply(user, 3)
        end
    },
    ability4 = {
        name = "Divine Fortitude",
        cooldown = 0,
        passive = true,
        effect = function(user)
            user.stats.resistance = user.stats.resistance + 10
        end
    },
    ability5 = {
        name = "Divine Restoration",
        cooldown = 6,
        passive = false,
        effect = function(user, ally)
            return -1 * (user.stats.magic * 60)
        end
    }
}
