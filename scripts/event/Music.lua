local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local Music        = require "necro.audio.Music"
local MusicLayers  = require "necro.audio.MusicLayers"
local Soundtrack   = require "necro.game.data.Soundtrack"
local Tick         = require "necro.cycles.Tick"

local LMMusicFunc = require "LobbyMusic.MusicFunc"
local LMSettings  = require "LobbyMusic.Settings"
local LMTracklist = require "LobbyMusic.TrackList"
local LMTick      = require "LobbyMusic.Tick"

local function setLayerVolumes()
  -- Start up the shopkeepers and mole, if necessary.
  local count = Music.getLayerCount()
  -- First, we'll need to get the existing max volume.
  local volume = 0
  for i = 1, count do
    volume = math.max(volume, Music.getLayerVolume(i))
  end
  -- LIMIT IT TO 1 FOR ARCEUS'S SAKE! (my ears ;w;)
  volume = math.min(1, volume)
  -- Then, set any shopkeeper or mole layer to that volume.
  -- print(volume)
  MusicLayers.setVolume(Soundtrack.LayerType.SHOPKEEPER, volume)
  MusicLayers.setVolume(Soundtrack.LayerType.FORTISSIMOLE, volume)

  -- Pull up the info of the now playing track.
  local trackInfo = LMTracklist.getTracklist()[LMSettings.get("nowPlaying.track")]

  -- If there's a function, invoke it.
  if trackInfo.func then
    LMMusicFunc[trackInfo.func]()
  end

  -- Single volume shopkeeper isn't quite audible.
  MusicLayers.multiplyVolume(Soundtrack.LayerType.SHOPKEEPER, 2)
end

Event.musicLayersUpdateVolume.add("lobbyMusicLayerControl", { order = "musicChange", sequence = 1 }, function(ev)
  if CurrentLevel.isLobby() then
    setLayerVolumes()
  end
end)

Event.musicPlay.add("lobbyMusicAutoplay", { order = "playAudio", sequence = 1 }, function(ev)
  if CurrentLevel.isLobby() then
    local len = Music.getMusicLength()
    LMTick.DoFadeOut({}, len)
  end
end)
