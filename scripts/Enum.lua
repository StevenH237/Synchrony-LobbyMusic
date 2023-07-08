local Enum = require "system.utils.Enum"
local RNG  = require "necro.game.system.RNG"

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
    desc = "Zone and boss music are interspersed. Zones play forward.",
    order = { 1, 2, 3, 4, 5, 6, 19, 7, 8, 9, 20, 10, 11, 12, 21, 13, 14, 15, 22, 16, 17, 18, 23, 24,
      25, 26, 27, 28 }
  }),
  ALTERNATE = Enum.entry(2, {
    name = "Alternate order",
    desc = "All zone music is played before any boss music. Zones play forward.",
    order = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
      24, 25, 26, 27, 28 }
  }),
  ARIA = Enum.entry(3, {
    name = "Aria's Ascent",
    desc = "Zone and boss music are interspersed. Zones play in reverse.",
    order = { 1, 2, 3, 16, 17, 18, 23, 13, 14, 15, 22, 10, 11, 12, 21, 7, 8, 9, 20, 4, 5, 6, 19, 24,
      25, 26, 27, 28 }
  }),
  SHUFFLE = Enum.entry(4, {
    name = "Shuffled",
    desc = "Tracks are played in random order.",
    order = function()
      local tracks = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
        28 }
      RNG.shuffle(tracks, RNG.Channel.SOUNDTRACK)
      return tracks
    end
  }),
  DEBUG_TEMPO = Enum.entry(5, {
    name = "Debug",
    desc = "Zone 3 musics for debug purposes.",
    order = { 10, 11, 12 }
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
