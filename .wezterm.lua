local wezterm = require("wezterm")
local act = wezterm.action

local function ends_with(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

local function is_macos()
  return ends_with(wezterm.target_triple, "-apple-darwin")
end

local function is_windows()
  return ends_with(wezterm.target_triple, "-pc-windows-msvc")
end

local config = wezterm.config_builder()
config.disable_default_key_bindings = false
config.color_scheme = "Wez (Gogh)"
config.front_end = "WebGpu"
config.keys = {
  { key = "L", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
  { key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
  { key = "d", mods = "SHIFT|SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
}
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.35,
}
config.send_composed_key_when_left_alt_is_pressed = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

if is_macos() then
  config.initial_cols = 240
  config.initial_rows = 86
elseif is_windows() then
  config.initial_cols = 120
  config.initial_rows = 40
  config.launch_menu = {
    {
      label = "Git Bash",
      args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
    },
    {
      label = "PowerShell",
      args = { "powershell.exe", "-NoLogo" },
    },
    {
      label = "Command Prompt",
      args = { "cmd.exe" },
    },
  }
  config.default_prog = config.launch_menu[1].args
end

return config
