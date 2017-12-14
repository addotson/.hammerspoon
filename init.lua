-----------------------------------------------
-- Begin -- Set up that works on OSX Sierra with Karabiner-Elements with adjusted config file.
-----------------------------------------------
require("hs.application")
require("hs.window")
hs.window.animationDuration = 0

-- Bind the Hyper key
local hyper = {'ctrl', 'cmd', 'shift', 'alt'}

-----------------------------------------------
-- End -- Set up
-----------------------------------------------

--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x
        f.y = max.h * y
        f.w = max.w * w
        f.h = max.h * h
        win:setFrame(f, 0)
    end
end

-- feature spectacle/another window sizing apps
hs.hotkey.bind(hyper, 'g', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(hyper, 'j', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind(hyper, 'n', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(hyper, 'y', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(hyper, 't', baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind(hyper, 'u', baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind(hyper, 'b', baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind(hyper, 'm', baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind(hyper, 'h', hs.grid.maximizeWindow)

-----------------------------------------------
-- App bindings
-----------------------------------------------
function openApp(x)
    return function()
      hs.application.launchOrFocus(x)
    end
end

hs.hotkey.bind(hyper,'d',openApp("Google Chrome"))
hs.hotkey.bind(hyper,'c',openApp("Calendar"))
hs.hotkey.bind(hyper,'r',openApp("Terminal"))
hs.hotkey.bind(hyper,'e',openApp("Atom"))
hs.hotkey.bind(hyper,'v',openApp("Mailplane 3"))
hs.hotkey.bind(hyper,'f',openApp("Messages"))

-----------------------------------------------
-- Hyper a to show window hints
-----------------------------------------------

hs.hotkey.bind(hyper,'a',function()
    hs.hints.windowHints()
end)

-----------------------------------------------
-- Hyper ` to reload config
-----------------------------------------------

hs.hotkey.bind(hyper,'`',function()
    hs.reload()
end)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/",
reload_config):start()
hs.alert.show("Config reloaded")
