local Soundtrack = require "necro.game.data.Soundtrack"

-- Track order matches the "Tracklist" module.

local info = {
  titles = {
    default = {
      "Rhythmortis",
      "Watch your Step",
      "Tombtorial",
      "Disco Descent",
      "Cryptique",
      "Mausoleum Mash",
      "Fungal Funk",
      "Grave Throbbing",
      "Portabellohead",
      -- The Neutral titles listed here are the work of me and TheJazMaster.
      -- DannyB's official Hot and Cold titles are listed at the bottom.
      "Petrichor",
      "Waltz of the Vulgar",
      "A Simmering Fury",
      -- Back to regularly scheduled DannyB titles.
      "Styx and Stones",
      "Heart of the Crypt",
      "The Wight to Remain",
      "Voltzwaltz",
      "Power Cords",
      "Six Feet Thunder",
      "Konga Conga Kappa",
      "Metalmancy",
      "Knight to C-Sharp",
      "Deep Sea Bass",
      "Notorious D.I.G.",
      "For Whom the Knell Tolls",
      "Momentum Mori",
      "Absolutetion",
      "Steinway to Heaven",
      "Vamplified",
      z31c = "Stone Cold",
      z31h = "Igneous Rock",
      z32c = "Dance of the Decorous",
      z32h = "March of the Profane",
      z33c = "A Cold Sweat",
      z33h = "A Hot Mess"
    },
    [Soundtrack.Artist.FAMILYJULES7X] = {
      "Breath before the Chaos",
      "Eye of the Terror", -- if overridden by resource pack
      "Wrath with Every Step", -- if overridden by resource pack
      "Infernal Descent",
      "The Deranged",
      "Spectral Storm",
      "Blaze Hazard",
      "Undead Desperation",
      "Dark Means",
      -- The Neutral titles listed here are the work of me and TheJazMaster.
      -- FamilyJules's official Hot and Cold titles are listed at the bottom.
      "Steaming Manic",
      "Soul of the Flood",
      "A Watery Grave",
      -- Back to your regularly scheduled FamilyJules titles!
      "Apex and Bones",
      "Fury of the Crypt",
      "A Shadow to Prevail",
      "Tesla Toil",
      "Power Corpse",
      "Trial of Thunder",
      "Stronger Konga",
      "Pyrodancer",
      "Knight Fall",
      "Deap Fear Octobass",
      "Molevolence",
      "Peril of the Bells", -- if overridden by resource pack
      "Echoes of the Necrodancer", -- if overridden by resource pack
      "Resolute", -- if overridden by resource pack
      "Steinway to Hell", -- if overridden by LobbyMusicExtra
      "Shockalypse", -- if overridden by LobbyMusicExtra
      z31c = "Frozen in Panic",
      z31h = "Scorched Volcanic",
      z32c = "Anguish of the Frost",
      z32h = "Heart of the Flame",
      z33c = "A Glacial Death",
      z33h = "A Dragon's Breath"
    },
    [Soundtrack.Artist.DANGANRONPA] = {
      "DANGANRONPA",
      nil, -- no track exists
      nil, -- no track exists
      "Last VERSUS",
      "Junk Food for a Dashing Youth",
      "Discussion -HEAT UP-",
      "5th Island Theme",
      "Wonderful Dead",
      "Alice in the Children's Land",
      "BOX 15.5",
      "It's a Monokuma World",
      "Supplementary Lessons for the Perplexing",
      "DISTRUST",
      "Kill Command",
      "Class Trial (Future Edition)",
      nil, -- no track exists
      nil, -- no track exists
      nil, -- no track exists
      "Mr. Monokuma's Extracurricular Lesson",
      "Monster That Shouts Its Love in the Center of Hell",
      "Punishment",
      "Trial Underground",
      nil, -- no track exists
      nil, -- no track exists
      nil, -- no track exists
      nil, -- no track exists
      nil, -- no track exists
      nil, -- no track exists
      z31c = "BOX 15",
      z31h = "BOX 16",
      -- 3-2 music is "It's a Monokuma World" in all temperatures.
      z33c = "Supplementary Lessons for the Unlucky",
      z33h = "Supplementary Lessons for the Mysterious",
    }
  },
  artists = {
    default = {
      default = "Unknown artist"
    },
    [Soundtrack.Artist.DANNY_B] = {
      default = "Danny Baranowsky",
      [10] = "Danny Baranowsky feat. FamilyJules", -- 3-1 Neutral
      [11] = "Danny Baranowsky feat. FamilyJules", -- 3-2 Neutral
      [12] = "Danny Baranowsky feat. FamilyJules", -- 3-3 Neutral
      [20] = "Danny Baranowsky feat. FamilyJules", -- Death Metal
      [26] = "Danny Baranowsky feat. FamilyJules", -- The Golden Lute
      z31c = "Danny Baranowsky", -- 3-1 Cold
      z32c = "Danny Baranowsky", -- 3-2 Cold
      z33c = "Danny Baranowsky" -- 3-3 Cold
    },
    [Soundtrack.Artist.A_RIVAL] = {
      default = "A_Rival"
    },
    [Soundtrack.Artist.FAMILYJULES7X] = {
      default = "FamilyJules"
    },
    [Soundtrack.Artist.VIRT] = {
      default = "Jake Kaufman" -- Jake, not Virt, as shown on the album's bandcamp page.
    },
    [Soundtrack.Artist.GIRLFRIEND_RECORDS] = {
      prefix = "Girlfriend Records - ",
      "Johnatron", -- Lobby
      nil, -- No track exists (Training)
      nil, -- No track exists (Tutorial)
      "Johnatron", -- 1-1
      "Johnatron", -- 1-2
      "Johnatron", -- 1-3
      "Sferro", -- 2-1
      "Sferro", -- 2-2
      "Sferro", -- 2-3
      "Sferro and Tommy '86", -- 3-1 Neutral
      "Sferro and Tommy '86", -- 3-2 Neutral
      "Sferro and Tommy '86", -- 3-3 Neutral
      "Tommy '86", -- 4-1
      "Tommy '86", -- 4-2
      "Tommy '86", -- 4-3
      "Tommy '86", -- 5-1
      "Sferro", -- 5-2
      "Johnatron", -- 5-3
      "Johnatron", -- King Conga
      "Sferro", -- Death Metal
      "Johnatron", -- Deep Blues
      "Tommy '86", -- Coral Riff
      "Johnatron", -- Fortissimole (variant no letter)
      -- No tracks exist (story bosses),
      z31c = "Sferro", -- 3-1 Cold
      z31h = "Tommy '86", -- 3-1 Hot
      z32c = "Sferro", -- 3-2 Cold
      z32h = "Tommy '86", -- 3-2 Hot
      z33c = "Sferro", -- 3-3 Cold
      z33h = "Tommy '86", -- 3-3 Hot
      fma = "Sferro", -- Fortissimole (variant a)
      fmb = "Tommy '86" -- Fortissimole (variant b)
      -- hey thanks for not putting the fortissimoles in the right order in the bandcamp release :)
    },
    [Soundtrack.Artist.OC_REMIX] = {
      prefix = "OC ReMix - ",
      "Flexstyle", -- Lobby
      "Ben Briggs", -- Training (if overridden by resource pack)
      "Chimpazilla", -- Tutorial (if overriddey by resource pack)
      "DDRKirby(ISQ)", -- 1-1
      "RoboRob", -- 1-2
      "Chimpazilla", -- 1-3
      "bLiNd", -- 2-1
      "Phonetic Hero", -- 2-2
      "Funk Fiction", -- 2-3
      "Flexstyle (feat. Nabeel Ansari) and Sir_NutS", -- 3-1 Neutral
      "bLiNd and Kruai", -- 3-2 Neutral
      "bLiNd and Phonetic Hero", -- 3-3 Neutral
      "RoBKTA", -- 4-1
      "Funk Fiction", -- 4-2
      "Flexstyle feat. DjjD", -- 4-3
      "Chimpazilla", -- 5-1
      "PrototypeRaptor", -- 5-2
      "Funk Fiction", -- 5-3
      "RoboRob", -- King Conga
      "Flexstyle", -- Death Metal
      "James Landino", -- Deep Blues
      "PrototypeRaptor", -- Coral Riff
      "RoboRob", -- Fortissimole
      "timaeus222", -- Dead Ringer (if overridden by resource pack)
      "PrototypeRaptor", -- Necrodancer Phase 1 (if overridden by resource pack)
      "RoboRob", -- The Golden Lute (if overridden by resource pack)
      -- no file exists for Frankensteinway or Conductor
      z31c = "Flexstyle feat. Nabeel Ansari",
      z31h = "Sir_NutS",
      z32c = "bLiNd",
      z32h = "Kruai",
      z33c = "bLiNd",
      z33h = "Phonetic Hero"
    },
    [Soundtrack.Artist.CHIPZEL] = {
      default = "Chipzel"
    },
    [Soundtrack.Artist.DANGANRONPA] = {
      default = "Masafumi Takada"
    }
  },
  shopkeepers = {
    [Soundtrack.Vocals.NONE] = "None",
    [Soundtrack.Vocals.SHOPKEEPER] = "Freddie Merchantry",
    [Soundtrack.Vocals.MONSTROUS_SHOPKEEPER] = "Deaddie Merchantry",
    [Soundtrack.Vocals.NICOLAS_DAOUST] = "Nicolas Daoust"
  },
  fortissimoles = {
    default = "Mega Ran",
    -- If replaced by LobbyMusicExtra
    [Soundtrack.Artist.FAMILYJULES7X] = "Ahren Gray",
    [Soundtrack.Artist.CHIPZEL] = "Adriana Figueroa"
  }
}

return info
