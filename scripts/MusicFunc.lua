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

  -- Make sure we haven't *already run this*
  local track = LMSettings.get("nowPlaying.track")
  if track.z3set then return end

  -- If it's balanced, we don't need to do anything.
  if whichTemp == LMEnum.HotCold.BALANCED then
    track.z3set = "duet"
    LMSettings.set("nowPlaying.track", track)
    return
  end

  -- If it's random, pick one.
  if whichTemp == LMEnum.HotCold.RANDOM then
    whichTemp = RNG.choice({ LMEnum.HotCold.HOT, LMEnum.HotCold.COLD }, RNG.Channel.SOUNDTRACK)
  end

  if whichTemp == LMEnum.HotCold.HOT then
    track.z3set = "hot"
    MusicLayers.setVolume(Soundtrack.LayerType.COLD, 0)
    MusicLayers.setVolume(Soundtrack.LayerType.HOT, 1)
  elseif whichTemp == LMEnum.HotCold.COLD then
    track.z3set = "cold"
    MusicLayers.setVolume(Soundtrack.LayerType.HOT, 0)
    MusicLayers.setVolume(Soundtrack.LayerType.COLD, 1)
  end

  LMSettings.set("nowPlaying.track", track)
end

function module.crInstruments()
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_DRUMS, 1)
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_HORNS, 1)
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_STRINGS, 1)
  MusicLayers.setVolume(Soundtrack.LayerType.TENTACLE_KEYTAR, 1)
end

function module.setLayerVolumes()
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
  local trackInfo = LMSettings.get("nowPlaying.track")

  -- If there's a function, invoke it.
  if trackInfo.func then
    module[trackInfo.func]()
  end

  -- Single volume shopkeeper isn't quite audible.
  MusicLayers.multiplyVolume(Soundtrack.LayerType.SHOPKEEPER, 2)
end

return module
