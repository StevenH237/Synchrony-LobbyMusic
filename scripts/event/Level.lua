local Boss            = require "necro.game.level.Boss"
local CurrentLevel    = require "necro.game.level.CurrentLevel"
local Event           = require "necro.event.Event"
local Player          = require "necro.game.character.Player"
local PlayerList      = require "necro.client.PlayerList"
local RNG             = require "necro.game.system.RNG"
local SettingsStorage = require "necro.config.SettingsStorage"
local Soundtrack      = require "necro.game.data.Soundtrack"

local LMSettings  = require "LobbyMusic.Settings"
local LMTrackList = require "LobbyMusic.Tracklist"
local LMTick      = require "LobbyMusic.Tick"

Event.levelLoad.add("queueDifferentTrack", { order = "music", sequence = -1 }, function(ev)
  LMTick.CancelFadeOut()
  LMTick.CancelPlayNext()

  if not CurrentLevel.isLobby() then return end

  if LMSettings.get("alwaysLobbyFirst") then
    local listing = LMSettings.get("nowPlaying.queue")
    if listing[1] ~= 1 then
      table.insert(listing, 1, 1)
    end
  end

  local nt = LMTrackList.getNextTrack()
  -- print(nt.params)
  ev.music = nt.params
  SettingsStorage.set("mod.LobbyMusic.nowPlaying.track", nt)
end)
