local wezterm = require("wezterm")

local schemes = wezterm.color.get_builtin_schemes()

local catppuccin_mocha = schemes["Catppuccin Mocha"]
catppuccin_mocha.background = "#0b0f14"

local catppuccin_latte = schemes["Catppuccin Latte"]
catppuccin_latte.background = "#ffffff"

return {
  ["Catppuccin Mocha"] = catppuccin_mocha,
  ["Catppuccin Latte"] = catppuccin_latte,
}
