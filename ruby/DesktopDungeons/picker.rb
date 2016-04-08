#!/usr/bin/env ruby

# Random whatever pickup for Desktop Dungeons

races = [
    "Human",
    "Elven",
    "Dwarven",
    "Orcish",
    "Halfling",
    "Gnomish",
    "Goblin"
]

classes = [
    "Fighter",
    "Berserker",
    "Warlord",
    "Thief",
    "Rogue",
    "Assassin",
    "Wizard",
    "Sorceror",
    "Bloodmage",
    "Priest",
    "Monk",
    "Paladin",
    "Transmuter",
    "Crusader",
    "Tinker",
    "Chemist"
]

class Array
    def random
        self[rand(self.length)]
    end
end

puts "Hey! You should play a #{races.random} #{classes.random}."
