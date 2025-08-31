local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.default_cursor_style = "BlinkingBar"
-- wezterm.on("gui-startup", function()
-- 	local screen = wezterm.gui.screens().active
-- 	local ratio = 0.8
-- 	local width, height = screen.width * ratio, screen.height * ratio
-- 	local window = wezterm.mux.spawn_window({
-- 		position = {
-- 			x = (screen.width - width) / 2,
-- 			y = (screen.height - height) / 2,
-- 			origin = "ActiveScreen",
-- 		},
-- 	})
-- 	if window then
-- 		window:gui_window():set_inner_size(width, height)
-- 	end
-- end)
local mux = wezterm.mux
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():toggle_fullscreen()
end)

config.default_prog = { "pwsh.exe", "-NoLogo" }

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"



-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.tab_max_width = 30

-- tmux status
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#fff" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#000" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

config.color_scheme = "Cloud (terminal.sexy)"
-- config.color_scheme = 'Geohot (Gogh)'
-- config.color_scheme = 'Canvased Pastel (terminal.sexy)'
-- config.color_scheme = 'Github Dark (Gogh)'
config.colors = {
	background = "#000",
	-- cursor_border = "#ffffff",
	-- cursor_bg = "#ffffff",

	tab_bar = {
		background = "#000",
		active_tab = {
			bg_color = "#000",
			fg_color = "#ffffff",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#000",
			fg_color = "#0F4C5C",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},

		new_tab = {
			bg_color = "#000",
			fg_color = "#fff",
		},
	},
}

config.initial_rows = 24
config.max_fps = 144
config.default_cursor_style = "BlinkingBar"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color"
config.cell_width = 0.9

config.window_background_opacity = 1
config.prefer_egl = false
config.front_end = "OpenGL"

config.audible_bell = "Disabled"
config.check_for_updates = false


-- tmux
config.leader = { key = "j", mods = "ALT" }
config.disable_default_key_bindings = true
config.keys = {
		-- focus the current panel to fullscreen mode
		{ key = "f", mods = "LEADER",       action="TogglePaneZoomState" },
		-- panel splitting 
		{ key = "v", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
		{ key = "s",mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
		-- new tab
		{ key = "n", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
		-- navigation inside panel
		{ key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
		{ key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
		{ key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
		{ key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
		-- panel resizing
		{ key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
		{ key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
		{ key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
		{ key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
		-- close current tab
		{ key = "?", mods = "SHIFT|CTRL", action=wezterm.action{CloseCurrentTab={confirm=true}}},
		-- close current pane
		{ key = "w", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
		-- toggle fullscreen mode for the entire app
		{ key = "n", mods="SHIFT|CTRL",     action="ToggleFullScreen" },
		-- clipboard
		-- activate copy mode "use v to select"
		{ key = "y", mods = "LEADER",  action = wezterm.action.ActivateCopyMode },
		-- copy and paste
		{ key = "y",  mods="CTRL",    action=wezterm.action.CopyTo 'Clipboard'},
		{ key = "p",  mods="CTRL",    action=wezterm.action.PasteFrom 'Clipboard'},
		-- font sizes
		{ key = "i", mods="SHIFT|CTRL",     action="IncreaseFontSize" },
		{ key = "u", mods="SHIFT|CTRL",     action="DecreaseFontSize" },
		{ key = "o", mods="SHIFT|CTRL",     action="ResetFontSize" },
}

for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

return config