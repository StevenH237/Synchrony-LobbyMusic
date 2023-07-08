local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local Music        = require "necro.audio.Music"
local MusicLayers  = require "necro.audio.MusicLayers"
local Soundtrack   = require "necro.game.data.Soundtrack"
local Tick         = require "necro.cycles.Tick"

local LMMusicFunc = require "LobbyMusic.MusicFunc"
local LMSettings  = require "LobbyMusic.Settings"
local LMTracklist = require "LobbyMusic.Tracklist"
local LMTick      = require "LobbyMusic.Tick"

Event.musicLayersUpdateVolume.add("lobbyMusicLayerControl", { order = "musicChange", sequence = 1 }, function(ev)
  if CurrentLevel.isLobby() then
    LMMusicFunc.setLayerVolumes()
  end
end)

Event.musicPlay.add("lobbyMusicAutoplay", { order = "playAudio", sequence = 1 }, function(ev)
  if CurrentLevel.isLobby() then
    -- print("musicPlay")
    LMMusicFunc.setLayerVolumes()
    local len = Music.getMusicLength()
    LMTick.DoFadeOut({}, len - 0.01667)
  end
end)
