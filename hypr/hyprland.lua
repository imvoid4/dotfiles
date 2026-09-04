-- =====================
-- Hyprland config
-- =====================

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "foot"
local fileManager = "dolphin"
local menu        = "hyprlauncher"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -i /home/imlost/Downloads/wallpaper.jpg")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("mako")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        border_size = 2,
        gaps_in = 4,
        gaps_out = 4,

        col = {
            active_border = "rgba(008866ff)",
            inactive_border = "rgba(222222ff)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = true,
        },
    },
})


-----------------------
---- DWINDLE LAYOUT ----
-----------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "gb",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"


-- -------------------
-- Apps
-- -------------------

-- Launcher
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- Terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- Close window
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

-- Exit Hyprland
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())


-- -------------------
-- Window movement
-- -------------------

-- Focus windows
hl.bind(mainMod .. " + LEFT",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + DOWN",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + UP",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }))


-- Move windows
hl.bind(mainMod .. " + SHIFT + LEFT",
    hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + SHIFT + DOWN",
    hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + UP",
    hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + SHIFT + RIGHT",
    hl.dsp.window.move({ direction = "right" }))


-- Mouse movement / resizing
hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)


-- -------------------
-- Layouts
-- -------------------

-- Horizontal split / resize ratio
hl.bind(
    mainMod .. " + H",
    hl.dsp.layout("splitratio", -0.1)
)

-- Vertical split / resize ratio
hl.bind(
    mainMod .. " + V",
    hl.dsp.layout("splitratio", 0.1)
)

-- Fullscreen
hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen()
)

-- Toggle split direction
hl.bind(
    mainMod .. " + E",
    hl.dsp.layout("togglesplit")
)

-- Toggle floating
hl.bind(
    mainMod .. " + SHIFT + SPACE",
    hl.dsp.window.float({ action = "toggle" })
)


---------------------
---- WORKSPACES ----
---------------------

for i = 1, 5 do
    hl.bind(
        mainMod .. " + " .. i,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i })
    )
end


-------------------
---- VOLUME ----
-------------------

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("swayosd-client --output-volume raise")
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("swayosd-client --output-volume lower")
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle")
)


---------------------
---- SCREENSHOT ----
---------------------

hl.bind(
    "PRINT",
    hl.dsp.exec_cmd("screenshot")
)


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Floating dialogs
hl.window_rule({
    name = "float-open-dialog",
    match = { title = "^Open$" },
    float = true,
})

hl.window_rule({
    name = "float-save-dialog",
    match = { title = "^Save$" },
    float = true,
})

hl.window_rule({
    name = "float-save-as-dialog",
    match = { title = "^Save As$" },
    float = true,
})

hl.window_rule({
    name = "float-preferences-dialog",
    match = { title = "^Preferences$" },
    float = true,
})

hl.window_rule({
    name = "float-file-upload-dialog",
    match = { title = "^File Upload$" },
    float = true,
})

-- Force opacity and blur specifically for foot windows
windowrulev2 = {
    "opacity 0.85 0.85, class:^(foot)$",
    "opacity 0.85 0.85, class:^(foot-client)$",
    "blur, class:^(foot)$",
    "blur, class:^(foot-client)$",
    "ignorezero, class:^(foot)$",
}
