local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

config.color_scheme = 'Dracula (Official)'

-- dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

config.text_background_opacity = 0.8
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

-- tab bar
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.default_cursor_style = 'SteadyBar'

config.font = wezterm.font('monospace')
config.font_size = 18

config.use_cap_height_to_scale_fallback_fonts = false
config.bold_brightens_ansi_colors = 'No'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.scrollback_lines = 5000

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "c", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
  { key = "x", mods = "LEADER",       action = act.CloseCurrentPane { confirm = true } },

  { key = "[", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER",       action = act.ActivateTabRelative(1) },

  { key = "-", mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "\\", mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },

  { key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },

  { key = "LeftArrow",  mods = "LEADER", action = act.AdjustPaneSize { "Left", 3 } },
  { key = "RightArrow", mods = "LEADER", action = act.AdjustPaneSize { "Right", 3 } },
  { key = "DownArrow",  mods = "LEADER", action = act.AdjustPaneSize { "Down", 3 } },
  { key = "UpArrow",    mods = "LEADER", action = act.AdjustPaneSize { "Up", 3 } },

  { key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },

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
