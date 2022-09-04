local wezterm = require 'wezterm'
local launch_menu = {}
local default_prog = {}
local set_environment_variables = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_prog = { 'pwsh.exe', '-NoLogo' }
elseif wezterm.target_triple == 'aarch64-apple-darwin' then
    default_prog = { '/bin/zsh', '-l' }
end
function basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local title = basename(pane.foreground_process_name)

    return { {
        Text = tab.tab_index .. ': ' .. title .. ' '
    } }
end)

local config = {
    default_prog = default_prog,
    window_decorations = 'RESIZE',
    font = wezterm.font_with_fallback({
        'MesloLGM Nerd Font',
        'Hei',
    }),
    font_size = 14,
    line_height = 1.1,
    cell_width = 1.0,
    color_scheme = 'Atom',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    initial_cols = 80,
    initial_rows = 20,
    tab_max_width = 48,
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = true,
    enable_scroll_bar = true,
    -- colors = {
    --     tab_bar = {
    --         background = "#2C3333",
    --         active_tab = {
    --             bg_color = "#0e0e0e",
    --             fg_color = "#2C3333",
    --         },

    --         inactive_tab = {
    --             bg_color = "#2C3333",
    --             fg_color = "#2C3333",
    --         },

    --         inactive_tab_hover = {
    --             bg_color = "#3b3052",
    --             fg_color = "#2C3333",
    --             italic = true,
    --         },
    --     }
    -- },
    inactive_pane_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 1.0
    },
    window_padding = {
        left = 10,
        right = 10,
        top = 5,
        bottom = 5
    },
    window_background_image_hsb = {
        brightness = 0.8,
        hue = 1.0,
        saturation = 1.0
    },
    window_background_opacity = 0.98,
    keys = {
        { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    },
    window_close_confirmation = 'NeverPrompt',
}
return config
