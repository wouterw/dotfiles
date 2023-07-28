local wezterm = require("wezterm")

return {
	font = wezterm.font("Berkeley Mono"),
	font_size = 12.0,
	color_scheme = "Jellybeans",
	window_background_opacity = 1,
	window_decorations = "RESIZE",
	window_padding = { left = "2cell", right = "2cell", top = "0.5cell", bottom = "0.5cell" },
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
}
