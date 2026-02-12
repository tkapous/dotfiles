local wezterm = require("wezterm")

local themes = {
  Default = "Catppuccin Latte",
  Light = "Catppuccin Latte",
  Dark = "Catppuccin Mocha",
  LightHighContrast = "Catppuccin Latte",
  DarkHighContrast = "Catppuccin Mocha",
}

local function change_theme(window)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = themes[appearance] or themes.default
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end

wezterm.on("window-config-reloaded", change_theme)
