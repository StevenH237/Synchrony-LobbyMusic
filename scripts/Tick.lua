local Beatmap         = require "necro.audio.Beatmap"
local CurrentLevel    = require "necro.game.level.CurrentLevel"
local Event           = require "necro.event.Event"
local Music           = require "necro.audio.Music"
local MusicLayers     = require "necro.audio.MusicLayers"
local SettingsStorage = require "necro.config.SettingsStorage"
local Soundtrack      = require "necro.game.data.Soundtrack"
local Tick            = require "necro.cycles.Tick"

local LMMusicFunc = require "LobbyMusic.MusicFunc"
local LMSettings  = require "LobbyMusic.Settings"
local LMTracklist = require "LobbyMusic.Tracklist"

PlayNext, CancelPlayNext = Tick.registerDelay(function()
  local nt = LMTracklist.getNextTrack()

  Music.setMusic(nt.params, 0)

  -- Set the time properly
  local n = Music.getMusicTime()
  local t = Music.getMusicLength()
  local p = n + t - (n % t)
  Music.setMusicTime(p, false)

  -- Set the beatmap too
  Beatmap.reset()
  Beatmap.skipOverdueBeatsImmediately() -- not sure we need this?

  -- And the layer volumes
  LMMusicFunc.setLayerVolumes()

  SettingsStorage.set("mod.LobbyMusic.nowPlaying.track", nt)
end, "playNext")

FadeOut, CancelFadeOut = Tick.registerDelay(function()
  -- Pull up the info of the now playing track.
  local trackInfo = LMSettings.get("nowPlaying.track")

  local fadeTime

  -- Should it fade?
  if trackInfo.fade then
    fadeTime = 5
  else
    fadeTime = 0
  end

  -- Fade it out
  Music.fadeOut(fadeTime)

  -- And then start the next track
  PlayNext({}, fadeTime)
end, "fadeOut")

return {
  DoPlayNext = PlayNext,
  CancelPlayNext = CancelPlayNext,
  DoFadeOut = FadeOut,
  CancelFadeOut = CancelFadeOut
}
