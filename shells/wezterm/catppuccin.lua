local wezterm = require("wezterm")

local schemes = wezterm.get_builtin_color_schemes()
local catppuccin_mocha = schemes["Catppuccin Mocha"]

catppuccin_mocha.background = "#0b0f14"

return {
  ["Catppuccin Mocha"] = catppuccin_mocha,
}
