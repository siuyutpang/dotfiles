local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}
config.color_scheme = 'Dracula (Official)'

-- dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}
config.use_fancy_tab_bar = false

-- config.text_background_opacity = 0.3
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.default_cursor_style = 'SteadyBar'

-- config.font = wezterm.font("Inconsolata-Regular", { weight = "Regular" })
config.font = wezterm.font_with_fallback({
  family = "Monaco",
  family = "Comic Code Ligatures",
  { family = "JetbrainsMono Nerd Font", weight = "Regular" },
  family = "LXGW WenKai Mono",
})
config.font_size = 19
config.use_cap_height_to_scale_fallback_fonts = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.scrollback_lines = 5000

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "-", mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
  { key = "x", mods = "LEADER",       action = act.CloseCurrentPane { confirm = true } },
  { key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },

  { key = "n", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER",       action = act.ActivateTabRelative(1) },
  { key = "t", mods = "LEADER",       action = act.ShowTabNavigator },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1)
  })
end

return config
