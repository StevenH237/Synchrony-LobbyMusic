local GameDLC         = require "necro.game.data.resource.GameDLC"
local Music           = require "necro.audio.Music"
local SettingsStorage = require "necro.config.SettingsStorage"
local Soundtrack      = require "necro.game.data.Soundtrack"

local PowerSettings = require "PowerSettings.PowerSettings"

local LMEnum = require "LobbyMusic.Enum"
local LMTracklist = require "LobbyMusic.Tracklist"

PowerSettings.autoRegister()
PowerSettings.saveVersionNumber() -- I don't think I'll be making any custom rules but just in case

--------------
-- SETTINGS --
--#region-----

PowerSettings.user.enum {
  name = "Track order",
  desc = "What order should tracks play in?",
  id = "trackOrder",
  order = 1,
  enum = LMEnum.TrackOrder,
  default = LMEnum.TrackOrder.SHUFFLE,
  setter = LMTracklist.regenQueue
}

PowerSettings.user.group {
  name = "Allowed soundtracks",
  desc = "Select which soundtracks may play",
  id = "soundtracks",
  order = 2
}

--#region Soundtracks

PowerSettings.user.bool {
  name = "Always randomize?",
  desc = "Should random soundtracks be used, or only the one set in Change Soundtrack?\nThe below options will be used either if this one's on or Change Soundtrack is set to Random.",
  id = "soundtracks.randomize",
  order = 0,
  default = false
}

PowerSettings.user.enum {
  name = "Soundtrack ordering",
  desc = "In what order should soundtracks play?",
  id = "soundtracks.order",
  order = 1,
  enum = LMEnum.SoundtrackOrder,
  default = LMEnum.SoundtrackOrder.RANDOM_EACH_TRACK
}

PowerSettings.user.bool {
  name = "Danny Baranowsky",
  id = "soundtracks.danny_b",
  order = 2,
  default = true
}

PowerSettings.user.bool {
  name = "A_Rival",
  id = "soundtracks.a_rival",
  order = 3,
  default = true
}

PowerSettings.user.bool {
  name = "FamilyJules",
  id = "soundtracks.familyjules7x",
  -- I wonder how necessary this disclaimer actually is.
  desc = "This isn't miswritten; he doesn't use the 7x in his branding any more.",
  order = 4,
  default = true
}

PowerSettings.user.bool {
  name = "Virt",
  id = "soundtracks.virt",
  order = 5,
  default = true
}

PowerSettings.user.bool {
  name = "Girlfriend Records",
  id = "soundtracks.girlfriend_records",
  order = 6,
  default = true
}

PowerSettings.user.bool {
  name = "OC Remix",
  id = "soundtracks.oc_remix",
  order = 7,
  default = true,
  visibleIf = GameDLC.isAmplifiedAvailable,
  ignoredIf = function() return not GameDLC.isAmplifiedAvailable() end,
  ignoredValue = false
}

PowerSettings.user.bool {
  name = "Chipzel",
  id = "soundtracks.chipzel",
  order = 8,
  default = true
}

PowerSettings.user.bool {
  name = "Danganronpa",
  id = "soundtracks.danganronpa",
  order = 9,
  default = false
}

--#endregion Soundtracks

PowerSettings.user.group {
  name = "Shopkeepers",
  desc = "Select which shopkeepers may be heard",
  id = "shopkeepers",
  order = 3
}

--#region Shopkeepers

PowerSettings.user.bool {
  name = "Use random shopkeeper?",
  desc = "Should a random shopkeeper (from the below choices) be used, or just the one selected in Audio Options?",
  id = "shopkeepers.randomize",
  order = 1,
  default = false
}

PowerSettings.user.bool {
  name = "Frederick",
  id = "shopkeepers.shopkeeper",
  order = 2,
  default = true
}

PowerSettings.user.bool {
  name = "Deadrick",
  id = "shopkeepers.monstrous_shopkeeper",
  order = 3,
  default = false
}

PowerSettings.user.bool {
  name = "Nicolas Daoust",
  id = "shopkeepers.nicolas_daoust",
  order = 4,
  default = true,
  visibleIf = GameDLC.isAmplifiedAvailable,
  ignoredIf = function() return not GameDLC.isAmplifiedAvailable() end,
  ignoredValue = false
}

--#endregion

PowerSettings.user.enum {
  name = "Zone 3 tracks",
  desc = "Should zone 3 music play with hot, cold, or both?",
  id = "zone3",
  order = 4,
  enum = LMEnum.HotCold,
  default = LMEnum.HotCold.RANDOM
}

PowerSettings.user.bool {
  name = "Always open with lobby music",
  desc = "Should a lobby theme always be the first played when loading the lobby?",
  id = "alwaysLobbyFirst",
  order = 5,
  default = true
}

PowerSettings.user.bool {
  name = "Show now playing",
  desc = "Should the now playing track be shown in the bottom right?",
  id = "showNowPlaying",
  order = 6,
  default = true
}

--#endregion Settings

---------------------
-- HIDDEN SETTINGS --
--#region------------

PowerSettings.user.table {
  name = "Upcoming tracks",
  id = "nowPlaying.queue",
  visibility = PowerSettings.Visibility.HIDDEN,
  default = {}
}

PowerSettings.user.table {
  name = "Last played track",
  id = "nowPlaying.track",
  visibility = PowerSettings.Visibility.HIDDEN,
  default = {}
}

PowerSettings.user.enum {
  name = "Last played artist",
  id = "nowPlaying.artist",
  visibility = PowerSettings.Visibility.HIDDEN,
  enum = Soundtrack.Artist,
  default = Soundtrack.Artist.DANNY_B
}

return {
  get = function(setting, ...)
    local val = PowerSettings.get("mod.LobbyMusic." .. setting, ...)
    return val
  end,
  set = function(setting, ...)
    SettingsStorage.set("mod.LobbyMusic." .. setting, ...)
  end
}
