local Boss            = require "necro.game.level.Boss"
local GameDLC         = require "necro.game.data.resource.GameDLC"
local Music           = require "necro.audio.Music"
local MusicLayers     = require "necro.audio.MusicLayers"
local Player          = require "necro.game.character.Player"
local PlayerList      = require "necro.client.PlayerList"
local RNG             = require "necro.game.system.RNG"
local SettingsStorage = require "necro.config.SettingsStorage"
local Soundtrack      = require "necro.game.data.Soundtrack"
local Utilities       = require "system.utils.Utilities"

local LMEnum     = require "LobbyMusic.Enum"
local LMSettings = require "LobbyMusic.Settings"

local module = {}

function module.z3Temp()
  local whichTemp = LMSettings.get("zone3")

  -- If it's balanced, we don't need to do anything.
  if whichTemp == LMEnum.HotCold.BALANCED then return end

  -- If it's random, pick one.
  if whichTemp == LMEnum.HotCold.RANDOM then
    whichTemp = RNG.choice({ LMEnum.HotCold.HOT, LMEnum.HotCold.COLD }, RNG.Channel.SOUNDTRACK)
  end

  if whichTemp == LMEnum.HotCold.HOT then
    MusicLayers.setVolume(Soundtrack.LayerType.COLD, 0)
    MusicLayers.setVolume(Soundtrack.LayerType.HOT, 1)
  elseif whichTemp == LMEnum.HotCold.COLD then
    MusicLayers.setVolume(Soundtrack.LayerType.HOT, 0)
    MusicLayers.setVolume(Soundtrack.LayerType.COLD, 1)
  end
end

function module.crInstruments()
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_DRUMS, 1)
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_HORNS, 1)
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_STRINGS, 1)
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_KEYTAR, 1)
end

return module
