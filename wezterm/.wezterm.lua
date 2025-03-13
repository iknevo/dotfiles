local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.initial_rows = 24
config.max_fps = 144
config.default_cursor_style = "BlinkingBar"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("mononoki")
config.cell_width = 0.9

config.window_background_opacity = 1
config.prefer_egl = false
config.front_end = "OpenGL"
config.font_size = 16

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_close_confirmation = "NeverPrompt"


wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local ratio = 0.7
  local width, height = screen.width * ratio, screen.height * ratio
  local tab, pane, window = wezterm.mux.spawn_window {
    position = {
      x = (screen.width - width) / 2,
      y = (screen.height - height) / 2,
      origin = 'ActiveScreen' }
  }
  if window then
  window:gui_window():set_inner_size(width, height)
  end
end)

config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	background = "#0c0b0f",
	cursor_border = "#ffffff",
	cursor_bg = "#ffffff",

	tab_bar = {
		background = "#0c0b0f",
		active_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#fff",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#0c0b0f",
			fg_color = "#f8f2f5",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			bg_color = "#0c0b0f",
			fg_color = "white",
		},
	},
}

config.window_frame = {
	font = wezterm.font({ family = "mononoki", weight = "Regular" }),
	active_titlebar_bg = "#0c0b0f",
}

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.default_prog = { "pwsh.exe", "-NoLogo"}
config.initial_cols = 80

return config
