# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger

import os
import subprocess
from libqtile import hook
from Xlib import display as xdisplay

def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

num_monitors = get_num_monitors()
groups = [Group(i) for i in "123456789"]

mod = "mod1"
mod4 = "mod4"
terminal = "st"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
        ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    Key([mod], "comma", lazy.to_screen(0)),
    Key([mod], "period",lazy.to_screen(1)),

    Key([mod], "p", lazy.spawn("dmenu_run"), desc="Dmenu"),
    Key([mod4], "t", lazy.spawn("/home/sky/.local/bin/time-tracking"), desc="Start time tracking"),
    Key([mod, "shift"], "e", lazy.spawn("/home/sky/.local/bin/configEdit"), desc="Open config in neovim"),

    Key([mod, "shift"], "p", lazy.spawn("/home/sky/.local/bin/passmenu"), desc=""),
    Key([mod, "shift"], "w", lazy.spawn("/usr/bin/brave"), desc=""),
    Key([mod4], "w", lazy.spawn("sxiv -t $(find /home/sky/.dotfiles/backgrounds/ | sort)"), desc=""),
    Key([mod4], "bracketleft", lazy.spawn("/home/sky/.dotfiles/bin/.local/bin/brightness up"), desc=""),
    Key([mod4], "braceleft", lazy.spawn("/home/sky/.dotfiles/bin/.local/bin/brightness down"), desc=""),

    Key([mod4, "shift"], "o", lazy.spawn("/home/sky/.local/bin/aircon toggle"), desc=""),
    Key([mod4, "shift"], "c", lazy.spawn("/home/sky/.local/bin/cold"), desc=""),
    Key([mod4, "shift"], "h", lazy.spawn("/home/sky/.local/bin/hot"), desc=""),
    # Key([mod | mod4], "c", lazy.spawn("/home/sky/.local/bin/aircon conflict"), desc=""),
    Key([mod4], "n", lazy.spawn("/home/sky/.local/bin/airconControl -change"), desc=""),
    Key([mod4], "h", lazy.spawn("/home/sky/.local/bin/aircon hot"), desc=""),
    Key([mod4], "c", lazy.spawn("/home/sky/.local/bin/aircon cold"), desc=""),
    Key([mod4], "f", lazy.spawn("/home/sky/.local/bin/airconControl -sellect-fan"), desc=""),

    Key([mod4, "shift"], "l", lazy.spawn("/home/sky/.local/bin/lights ceiling"), desc=""),
    Key([mod4, "shift"], "r", lazy.spawn("/home/sky/.local/bin/lights others"), desc=""),
    Key([mod4, "shift"], "a", lazy.spawn("/home/sky/.local/bin/lights all"), desc=""),
    Key([mod, "shift"], "l", lazy.spawn("/home/sky/.local/bin/light-percent"), desc=""),
    Key([mod, "shift"], "l", lazy.spawn("/home/sky/.local/bin/light-percent"), desc=""),
    Key([mod, "shift"], "c", lazy.spawn("/home/sky/.local/bin/light-temp"), desc=""),


    Key([mod4, "shift"], "m", lazy.spawn("/home/sky/.local/bin/screens"), desc=""),
    Key([mod4, "shift"], "g", lazy.spawn("/home/sky/.local/bin/picomToggle"), desc=""),

    Key([mod4], "p", lazy.spawn("/home/sky/.local/bin/spotify-control -togglePlay"), desc=""),
    Key([mod4], "period", lazy.spawn("/home/sky/.local/bin/spotify-control -next"), desc=""),
    Key([mod4], "comma", lazy.spawn("/home/sky/.local/bin/spotify-control -prev"), desc=""),
    Key([mod4, "shift"], "p", lazy.spawn("/home/sky/.local/bin/spotify-control -play-song"), desc=""),
    Key([mod], "a", lazy.spawn("/home/sky/.local/bin/spotify-control -select-album"), desc=""),
    Key([mod, "shift"], "s", lazy.spawn("/home/sky/.local/bin/spotify-control -select-playlist"), desc=""),
    Key([mod, "shift"], "m", lazy.spawn("st -e spt"), desc=""),
    Key([mod4], "l", lazy.spawn("st -e sptlrx"), desc=""),

    Key([mod4], "plus", lazy.spawn("/home/sky/.local/bin/volumeControl up"), desc=""),
    Key([mod4], "minus", lazy.spawn("/home/sky/.local/bin/volumeControl down"), desc=""),
    Key([mod4], "m", lazy.spawn("/home/sky/.local/bin/volumeControl mute"), desc=""),
    Key([mod4], "o", lazy.spawn("st -e /home/sky/.local/bin/lfub"), desc=""),
    Key([mod4, "shift"], "s", lazy.spawn("flameshot gui -p /home/sky/Pictures/Captures"), desc=""),
    Key([mod, "shift"], "b", lazy.spawn("/home/sky/.local/bin/change_background_dmenu"), desc=""),
    Key([mod4, "shift"], "t", lazy.spawn("/home/sky/.local/bin/torrents -dmenu"), desc=""),
    Key([mod4], "d", lazy.spawn("setxkbmap -layout real-prog-dvorak"), desc=""),
    Key([mod4], "q", lazy.spawn("setxkbmap -layout us"), desc=""),
    Key([mod4, "shift"], "e", lazy.spawn("/home/sky/.local/bin/menu-emoji"), desc=""),
    Key([mod4], "s", lazy.spawn("/home/sky/.local/bin/snipets"), desc=""),
    Key([mod, "shift"], "space", lazy.spawn("/home/sky/.local/bin/todoist --today"), desc=""),
    Key([mod4], "space", lazy.spawn("/home/sky/.local/bin/quick-add-task"), desc=""),
    Key([mod4, "shift"], "space", lazy.spawn("/home/sky/.local/bin/obsidian-cli quick-note"), desc=""),
    Key([mod4], "backslash", lazy.spawn("clipmenu"), desc=""),
    Key([mod4], "u", lazy.spawn("/home/sky/.local/bin/mount-usb"), desc=""),
    Key([mod4], "e", lazy.spawn("st -e neomutt"), desc=""),
    Key([mod], "s", lazy.spawn("/home/sky/.local/bin/system-action"), desc=""),
    Key([mod], "F1", lazy.spawn("/home/sky/.local/bin/keyboard-connected"), desc=""),
    Key([mod], "F2", lazy.spawn("st -e pulsemixer"), desc=""),
    Key([mod], "F3", lazy.spawn("thunar"), desc=""),
]


# A hacky way to get my keyboard layout and qtile to play nicely
for i in groups:
    keyToUse = {
            "1": "plus",
            "2": "bracketleft",
            "3": "braceleft",
            "4": "parenleft",
            "5": "ampersand",
            "6": "equal",
            "7": "parenright",
            "8": "braceright",
            "9": "bracketright"
        }

    keys.extend(
            [
                Key(
                    [mod],
                    keyToUse[i.name],
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                    ),
                # mod1 + shift + letter of group = switch to & move focused window to group
                Key(
                    [mod, "shift"],
                    keyToUse[i.name],
                    lazy.window.togroup(i.name, switch_group=False),
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                ]
            )

layouts = [
    layout.MonadTall(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=3, margin=20),
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=3),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=15,
    padding=3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                # GenPollText(update_interval=60, func=lambda: subprocess.check_output("sh /home/sky/.local/bin/statusbar/sb-timeDate").decode("utf-8")),
                widget.Volume(),
                widget.Battery(),
            ],
            30,
        ),
    ),
]

if num_monitors > 1:
    for Monitor in range(num_monitors):
        screens.append(
            Screen(
                top=bar.Bar(
                    [
                        widget.GroupBox(),
                        widget.WindowName(),
                        widget.Chord(
                            chords_colors={
                                "launch": ("#ff0000", "#ffffff"),
                                },
                            name_transform=lambda name: name.upper(),
                            ),
                        # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                        # widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                        # GenPollText(update_interval=60, func=lambda: subprocess.check_output("sh /home/sky/.local/bin/statusbar/sb-timeDate").decode("utf-8")),
                        widget.Volume(),
                        widget.Battery(),
                        ],
                    30,
                    ),
                )
            )

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.local/bin/startup')
    subprocess.Popen([home])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "qtile"
