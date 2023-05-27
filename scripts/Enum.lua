local Enum = require "system.utils.Enum"

local module = {}

module.SoundtrackOrder = Enum.sequence {
  ORDERED = Enum.entry(1, {
    name = "In order",
    desc = "All tracks play from a soundtrack, then the next (in the order below) plays"
  }),
  RANDOM_EACH_LOOP = Enum.entry(2, {
    name = "Random each loop",
    desc = "A random soundtrack is picked and all tracks play before picking again"
  }),
  RANDOM_EACH_TRACK = Enum.entry(3, {
    name = "Random each track",
    desc = "A random soundtrack is picked for every track"
  })
}

module.TrackOrder = Enum.sequence {
  ORDERED = Enum.entry(1, {
    name = "Fully ordered",
    desc = "Zone and boss music are interspersed. Zones play forward."
  }),
  ALTERNATE = Enum.entry(2, {
    name = "Alternate order",
    desc = "All zone music is played before any boss music. Zones play forward."
  }),
  ARIA = Enum.entry(3, {
    name = "Aria's Ascent",
    desc = "Zone and boss music are interspersed. Zones play in reverse."
  }),
  SHUFFLE = Enum.entry(4, {
    name = "Shuffled",
    desc = "Tracks are played in random order."
  })
}

module.HotCold = Enum.sequence {
  COLD = Enum.entry(1, {
    name = "Cold only",
    desc = "Zone 3 tracks play cold."
  }),
  HOT = Enum.entry(2, {
    name = "Hot only",
    desc = "Zone 3 tracks play hot."
  }),
  BALANCED = Enum.entry(3, {
    name = "Balanced",
    desc = "Zone 3 tracks play both sides evenly."
  }),
  RANDOM = Enum.entry(4, {
    name = "Random",
    desc = "Zone 3 tracks play either hot or cold, chosen at random."
  })
}

return module
