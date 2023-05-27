local Boss            = require "necro.game.level.Boss"
local GameDLC         = require "necro.game.data.resource.GameDLC"
local Music           = require "necro.audio.Music"
local Player          = require "necro.game.character.Player"
local PlayerList      = require "necro.client.PlayerList"
local RNG             = require "necro.game.system.RNG"
local SettingsStorage = require "necro.config.SettingsStorage"
local Soundtrack      = require "necro.game.data.Soundtrack"
local Utilities       = require "system.utils.Utilities"

local LMEnum     = require "LobbyMusic.Enum"
local LMSettings = require "LobbyMusic.Settings"

local module = {}

local tracklist = {
  Tracks = {
    { index = 1, params = { type = "lobby" }, fade = true },
    { index = 2, params = { type = "training" }, fade = true },
    { index = 3, params = { type = "tutorial" }, fade = true },
    { index = 4, params = { type = "zone", zone = 1, floor = 1 } },
    { index = 5, params = { type = "zone", zone = 1, floor = 2 } },
    { index = 6, params = { type = "zone", zone = 1, floor = 3 } },
    { index = 7, params = { type = "zone", zone = 2, floor = 1 } },
    { index = 8, params = { type = "zone", zone = 2, floor = 2 } },
    { index = 9, params = { type = "zone", zone = 2, floor = 3 } },
    { index = 10, params = { type = "zone", zone = 3, floor = 1 }, func = "z3Temp" },
    { index = 11, params = { type = "zone", zone = 3, floor = 2 }, func = "z3Temp" },
    { index = 12, params = { type = "zone", zone = 3, floor = 3 }, func = "z3Temp" },
    { index = 13, params = { type = "zone", zone = 4, floor = 1 } },
    { index = 14, params = { type = "zone", zone = 4, floor = 2 } },
    { index = 15, params = { type = "zone", zone = 4, floor = 3 } },
    { index = 16, params = { type = "zone", zone = 5, floor = 1 }, condition = GameDLC.isAmplifiedAvailable },
    { index = 17, params = { type = "zone", zone = 5, floor = 2 }, condition = GameDLC.isAmplifiedAvailable },
    { index = 18, params = { type = "zone", zone = 5, floor = 3 }, condition = GameDLC.isAmplifiedAvailable },
    { index = 19, params = { type = "boss", boss = Boss.Type.KING_CONGA }, fade = true },
    { index = 20, params = { type = "boss", boss = Boss.Type.DEATH_METAL }, fade = true },
    { index = 21, params = { type = "boss", boss = Boss.Type.DEEP_BLUES }, fade = true },
    { index = 22, params = { type = "boss", boss = Boss.Type.CORAL_RIFF }, func = "crInstruments", fade = true },
    { index = 23, params = { type = "boss", boss = Boss.Type.FORTISSIMOLE }, condition = GameDLC.isAmplifiedAvailable,
      fade = true },
    { index = 24, params = { type = "boss", boss = Boss.Type.DEAD_RINGER }, fade = true },
    { index = 25, params = { type = "boss", boss = Boss.Type.NECRODANCER }, fade = true },
    { index = 26, params = { type = "boss", boss = Boss.Type.GOLDEN_LUTE }, fade = true },
    { index = 27, params = { type = "boss", boss = Boss.Type.FRANKENSTEINWAY }, condition = GameDLC.isAmplifiedAvailable,
      fade = true },
    { index = 28, params = { type = "boss", boss = Boss.Type.CONDUCTOR }, condition = GameDLC.isAmplifiedAvailable,
      fade = true },
  },
  Orders = {
    [LMEnum.TrackOrder.ORDERED] = { 1, 2, 3, 4, 5, 6, 19, 7, 8, 9, 20, 10, 11, 12, 21, 13, 14, 15, 22, 16, 17, 18, 23, 24,
      25, 26, 27, 28 },
    [LMEnum.TrackOrder.ALTERNATE] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
      24, 25, 26, 27, 28 },
    [LMEnum.TrackOrder.ARIA] = { 1, 2, 3, 16, 17, 18, 23, 13, 14, 15, 22, 10, 11, 12, 21, 7, 8, 9, 20, 4, 5, 6, 19, 24,
      25, 26, 27, 28 },
    [LMEnum.TrackOrder.SHUFFLE] = function()
      local tracks = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
        28 }
      RNG.shuffle(tracks, RNG.Channel.SOUNDTRACK)
      return tracks
    end
  },
  SkipShop = {
    [Soundtrack.Artist.DANGANRONPA] = true
  }
}

module.getTracklist = function() return Utilities.deepCopy(tracklist.Tracks) end
module.getOrders = function() return Utilities.deepCopy(tracklist.Orders) end

module.regenQueue = function()
  local queue = tracklist.Orders[LMSettings.get("trackOrder")]
  if type(queue) == "table" then
    queue = Utilities.fastCopy(queue)
  else
    queue = queue()
  end
  return queue
end

module.getNextTrack = function()
  -- Get the queued track list
  local queue = LMSettings.get("nowPlaying.queue")
  local regen = false
  local nextTrack = nil

  while nextTrack == nil do
    -- If empty, generate a new one
    if #queue == 0 then
      queue = module.regenQueue()
      regen = true
    end

    -- Pop the top track off the queue
    local check = Utilities.deepCopy(tracklist.Tracks[table.remove(queue, 1)])

    SettingsStorage.set("mod.LobbyMusic.nowPlaying.queue", queue)

    -- Make sure we can play it
    -- (for example Z5 music needs the Amplified DLC)
    if check.condition == nil or check.condition() then
      nextTrack = check
    end
  end

  -- Which artist are we going to use?
  local artist = Soundtrack.getCharacterArtist(Player.getCharacterType() or PlayerList.getCharacter()) or
      Soundtrack.getDefaultArtist()

  if LMSettings.get("soundtracks.randomize") or artist == Soundtrack.Artist.RANDOM then
    -- Do we actually *need* to change artists?
    local stOrder = LMSettings.get("soundtracks.order")
    artist = LMSettings.get("nowPlaying.artist")

    -- Do we change artists every track and/or have we regenned in this loop?
    if stOrder == LMEnum.SoundtrackOrder.RANDOM_EACH_TRACK or regen then
      local artistsA = {}
      local artistsB = {}
      local artists = artistsA

      for i, v in ipairs(Soundtrack.Artist.names) do
        if v ~= "CUSTOM" and v ~= "RANDOM" then
          if LMSettings.get("soundtracks." .. v:lower()) then
            table.insert(artists, i)
          end
          -- The artistsA artistsB thing
          if i == artist then
            artists = artistsB
          end
        end
      end

      Utilities.concatArrays(artistsB, artistsA)
      artists = artistsB

      if #artists == 0 then
        -- If we've disabled all artists, it won't work. Default to Danny B.
        artist = Soundtrack.Artist.DANNY_B
      elseif stOrder == LMEnum.SoundtrackOrder.ORDERED then
        artist = artists[1]
      else
        artist = RNG.choice(artists, RNG.Channel.SOUNDTRACK)
      end

      SettingsStorage.set("mod.LobbyMusic.nowPlaying.artist", artist)
    end
  end

  nextTrack.params.artist = artist

  -- Which shopkeeper are we going to use?
  -- This only applies to zone music of course
  -- Also skip the shopkeeper on incongruous soundtracks
  if nextTrack.params.type == "zone" and not tracklist.SkipShop[artist] then
    local shopkeeper

    if LMSettings.get("shopkeepers.randomize") then
      local shopkeepers = { "" }
      for k, v in pairs(Soundtrack.Vocals) do
        if k ~= "NONE" then
          if LMSettings.get("shopkeepers." .. k:lower()) then
            table.insert(shopkeepers, v)
          end
        end
      end

      shopkeeper = RNG.choice(shopkeepers, RNG.Channel.SOUNDTRACK)
    else
      shopkeeper = RNG.choice({ "", SettingsStorage.get("audio.soundtrack.vocals") }, RNG.Channel.SOUNDTRACK)
    end

    nextTrack.params.vocals = shopkeeper
  end

  return nextTrack
end

return module
