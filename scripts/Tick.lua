local CurrentLevel = require "necro.game.level.CurrentLevel"
local Event        = require "necro.event.Event"
local Music        = require "necro.audio.Music"
local MusicLayers  = require "necro.audio.MusicLayers"
local Soundtrack   = require "necro.game.data.Soundtrack"
local Tick         = require "necro.cycles.Tick"

local LMMusicFunc = require "LobbyMusic.MusicFunc"
local LMSettings  = require "LobbyMusic.Settings"
local LMTracklist = require "LobbyMusic.TrackList"

PlayNext, CancelPlayNext = Tick.registerDelay(function()
  Music.setMusic(LMTracklist.getNextTrack().params)
end, "playNext")

FadeOut, CancelFadeOut = Tick.registerDelay(function()
  -- Pull up the info of the now playing track.
  local trackInfo = LMTracklist.getTracklist()[LMSettings.get("nowPlaying.track")]

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
