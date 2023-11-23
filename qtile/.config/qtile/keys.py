from libqtile.lazy import lazy
from libqtile.config import Key
from groups import groups

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
    Key([mod, "control"], "h", lazy.layout.grow(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.shrink(), desc="Grow window to the right"),
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

    Key([mod], "comma", lazy.next_screen(), desc="Move to next screen"),
    # Figure out a way to go the other way?
    # Key([mod], "period", lazy.previous_screen(), desc="Move to previous screen"),

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
keyToUse = {
        "1": "plus",
        "2": "bracketleft",
        "3": "braceleft",
        "4": "parenleft",
        "5": "ampersand",
        "6": "equal",
        "7": "parenright",
        "8": "braceright",
        "9": "bracketright",
        "10": "asterisk"
        }

for i in groups:
    keys.extend(
            [
                Key(
                    [mod],
                    keyToUse[i.name],
                    lazy.group[i.name].toscreen(),
                    desc="Switch to group {}".format(i.name),
                    ),

                Key(
                    [mod, "shift"],
                    keyToUse[i.name],
                    lazy.window.togroup(i.name, switch_group=False),
                    desc="Switch to & move focused window to group {}".format(i.name),
                    ),
                ]
            )

def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)

# Move window to opisote screens
keys.extend([
    Key([mod,"shift"],  "comma",  lazy.function(window_to_next_screen)),
    Key([mod,"shift"],  "period", lazy.function(window_to_previous_screen)),
])
