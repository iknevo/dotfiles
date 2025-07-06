-- local wezterm = require("wezterm")
-- local act = wezterm.action
-- local config = wezterm.config_builder()

-- config.initial_rows = 24
-- config.max_fps = 144
-- config.default_cursor_style = "BlinkingBar"
-- config.animation_fps = 1
-- config.cursor_blink_rate = 500
-- config.term = "xterm-256color"
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.cell_width = 0.9

-- config.window_background_opacity = 1
-- config.prefer_egl = false
-- config.front_end = "OpenGL"
-- config.font_size = 14

-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

-- config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true
-- config.window_close_confirmation = "NeverPrompt"

-- -- start in a certain size
-- wezterm.on("gui-startup", function(cmd)
--   local screen = wezterm.gui.screens().active
--   local ratio = 0.7
--   local width, height = screen.width * ratio, screen.height * ratio
--   local tab, pane, window = wezterm.mux.spawn_window {
--     position = {
--       x = (screen.width - width) / 2,
--       y = (screen.height - height) / 2,
--       origin = 'ActiveScreen' }
--   }
--   if window then
--   window:gui_window():set_inner_size(width, height)
--   end
-- end)

-- -- start in full screen mode
-- -- local mux = wezterm.mux
-- -- wezterm.on('gui-startup', function()
-- --   local tab, pane, window = mux.spawn_window({})
-- --   window:gui_window():toggle_fullscreen()
-- -- end)

-- config.color_scheme = "Cloud (terminal.sexy)"
-- config.colors = {
-- 	background = "#0c0b0f",
-- 	cursor_border = "#ffffff",
-- 	cursor_bg = "#ffffff",

-- 	tab_bar = {
-- 		background = "#0c0b0f",
-- 		active_tab = {
-- 			bg_color = "#0c0b0f",
-- 			fg_color = "#fff",
-- 			intensity = "Normal",
-- 			underline = "None",
-- 			italic = false,
-- 			strikethrough = false,
-- 		},
-- 		inactive_tab = {
-- 			bg_color = "#0c0b0f",
-- 			fg_color = "#f8f2f5",
-- 			intensity = "Normal",
-- 			underline = "None",
-- 			italic = false,
-- 			strikethrough = false,
-- 		},

-- 		new_tab = {
-- 			bg_color = "#0c0b0f",
-- 			fg_color = "white",
-- 		},
-- 	},
-- }

-- config.window_frame = {
-- 	font = wezterm.font({ family = "mononoki", weight = "Regular" }),
-- 	active_titlebar_bg = "#0c0b0f",
-- }

-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
-- config.default_prog = { "pwsh.exe", "-NoLogo"}
-- config.initial_cols = 80

-- return config

-- WezTerm Keybindings Documentation by dragonlobster
-- ===================================================
-- Leader Key:
-- The leader key is set to ALT + q, with a timeout of 2000 milliseconds (2 seconds).
-- To execute any keybinding, press the leader key (ALT + q) first, then the corresponding key.

-- Keybindings:
-- 1. Tab Management:
--    - LEADER + c: Create a new tab in the current pane's domain.
--    - LEADER + x: Close the current pane (with confirmation).
--    - LEADER + b: Switch to the previous tab.
--    - LEADER + n: Switch to the next tab.
--    - LEADER + <number>: Switch to a specific tab (0–9).

-- 2. Pane Splitting:
--    - LEADER + |: Split the current pane horizontally into two panes.
--    - LEADER + -: Split the current pane vertically into two panes.

-- 3. Pane Navigation:
--    - LEADER + h: Move to the pane on the left.
--    - LEADER + j: Move to the pane below.
--    - LEADER + k: Move to the pane above.
--    - LEADER + l: Move to the pane on the right.

-- 4. Pane Resizing:
--    - LEADER + LeftArrow: Increase the pane size to the left by 5 units.
--    - LEADER + RightArrow: Increase the pane size to the right by 5 units.
--    - LEADER + DownArrow: Increase the pane size downward by 5 units.
--    - LEADER + UpArrow: Increase the pane size upward by 5 units.

-- 5. Status Line:
--    - The status line indicates when the leader key is active, displaying an ocean wave emoji (🌊).

-- Miscellaneous Configurations:
-- - Tabs are shown even if there's only one tab.
-- - The tab bar is located at the bottom of the terminal window.
-- - Tab and split indices are zero-based.


-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
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

-- -- start in a certain size
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


-- -- start in full screen mode
-- local mux = wezterm.mux
-- wezterm.on('gui-startup', function()
--   local tab, pane, window = mux.spawn_window({})
--   window:gui_window():toggle_fullscreen()
-- end)

config.default_prog = { "pwsh.exe", "-NoLogo"}


-- For example, changing the color scheme:
-- config.color_scheme = "Catppuccin Macchiato"
config.font =
    wezterm.font("FiraCode Nerd Font")
config.font_size = 16

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

-- tmux
config.leader = { key = "j", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "w",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "LEADER",
        key = "p",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "LEADER",
        key = "s",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "v",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
}

for i = 0, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i),
    })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

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

    window:set_left_status(wezterm.format {
        { Background = { Color = "#000" } },
        { Text = prefix },
        ARROW_FOREGROUND,
        { Text = SOLID_LEFT_ARROW }
    })
end)

config.color_scheme = "Cloud (terminal.sexy)"
config.colors = {
	background = "#0c0b0f",
	cursor_border = "#ffffff",
	cursor_bg = "#ffffff",

	tab_bar = {
		background = "#0c0b0f",
		active_tab = {
			bg_color = "#a5b5b5",
			fg_color = "#000000",
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

-- and finally, return the configuration to wezterm
return config
