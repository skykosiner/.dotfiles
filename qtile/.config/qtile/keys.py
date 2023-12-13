from libqtile.lazy import lazy
from libqtile.config import Key, KeyChord
from groups import groups

mod = "mod4"
alt = "mod1"
terminal = "st"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    # Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),

    # Switch between windows
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows around in stack
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    Key([mod], "h", lazy.layout.grow(), desc="Grow window to the left"),
    Key([mod], "l", lazy.layout.shrink(), desc="Grow window to the right"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
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

    # TODO: Figure out a way to go the other way?
    # Key([mod], "period", lazy.previous_screen(), desc="Move to previous screen"),

    # Emacs??
    KeyChord([mod], "e", [
        Key([], "e", lazy.spawn("emacsclient -c -a emacs"), desc="Open Emacs"),
        Key([], "b", lazy.spawn("emacsclient -c -a emacs --eval '(ibuffer)' "), desc="Open emacs ibuffer"),
        Key([], "t", lazy.spawn("emacsclient -c -a emacs --eval '(org-agenda-list)' "), desc="Open emacs in org agenda"),
        Key([], "d", lazy.spawn("emacsclient -c -a emacs --eval '(dired nil)' "), desc="Open emacs dired"),
        Key([], "k", lazy.spawn("killall emacs"),
                      lazy.spawn("/usr/bin/emacs --daemon"),
                      desc='Kill/restart the Emacs daemon')
        ]),

    # Airco control
    KeyChord([mod], "a", [
        Key([], "o", lazy.spawn("/home/sky/.local/bin/aircon toggle"), desc=""),
        Key([], "c", lazy.spawn("/home/sky/.local/bin/cold"), desc=""),
        Key([], "h", lazy.spawn("/home/sky/.local/bin/hot"), desc=""),
        # Key([mod | alt], "c", lazy.spawn("/home/sky/.local/bin/aircon conflict"), desc=""),
        Key([], "n", lazy.spawn("/home/sky/.local/bin/airconControl -change"), desc=""),
        Key(["shift"], "h", lazy.spawn("/home/sky/.local/bin/aircon hot"), desc=""),
        Key(["shift"], "c", lazy.spawn("/home/sky/.local/bin/aircon cold"), desc=""),
        Key([], "f", lazy.spawn("/home/sky/.local/bin/airconControl -sellect-fan"), desc=""),
        ]),

    # Light control
    KeyChord([alt], "l", [
        Key([], "l", lazy.spawn("/home/sky/.local/bin/lights ceiling"), desc=""),
        Key([], "r", lazy.spawn("/home/sky/.local/bin/lights others"), desc=""),
        Key([], "a", lazy.spawn("/home/sky/.local/bin/lights all"), desc=""),
        Key([], "p", lazy.spawn("/home/sky/.local/bin/light-percent"), desc=""),
        Key([], "t", lazy.spawn("/home/sky/.local/bin/light-temp"), desc=""),
    ]),

    # Dmenu stuff
    KeyChord([mod], "p", [
        Key([], "p", lazy.spawn("dmenu_run"), desc="using dmenu to launch programs"),
        Key([], "o", lazy.spawn("/home/sky/.local/bin/search-org"), desc="Use dmenu to search my org files"),
        Key([], "t", lazy.spawn("/home/sky/.local/bin/time-tracking"), desc="Start time tracking"),
        Key([], "e", lazy.spawn("/home/sky/.local/bin/configEdit"), desc="Open config in neovim"),
        Key(["shift"], "p", lazy.spawn("/home/sky/.local/bin/onepassword"), desc=""),
        Key([], "m", lazy.spawn("/home/sky/.local/bin/screens"), desc=""),
        Key(["shift"], "t", lazy.spawn("/home/sky/.local/bin/torrents -dmenu"), desc=""),
        Key(["shift"], "e", lazy.spawn("/home/sky/.local/bin/menu-emoji"), desc=""),
        Key([], "s", lazy.spawn("/home/sky/.local/bin/snipets"), desc=""),
        Key(["shift"], "s", lazy.spawn("/home/sky/.local/bin/system-action"), desc=""),
        ]),


    # Spotify control
    KeyChord([mod], "s", [
        Key([], "p", lazy.spawn("/home/sky/.local/bin/spotify-control -togglePlay"), desc=""),
        Key([], "period", lazy.spawn("/home/sky/.local/bin/spotify-control -next"), desc=""),
        Key([], "comma", lazy.spawn("/home/sky/.local/bin/spotify-control -prev"), desc=""),
        Key(["shift"], "p", lazy.spawn("/home/sky/.local/bin/spotify-control -play-song"), desc=""),
        Key([], "a", lazy.spawn("/home/sky/.local/bin/spotify-control -select-album"), desc=""),
        Key([], "s", lazy.spawn("/home/sky/.local/bin/spotify-control -select-playlist"), desc=""),
        Key([], "m", lazy.spawn("st -e spt"), desc=""),
        Key([], "l", lazy.spawn("st -e sptlrx"), desc=""),
        ]),

    # App launcher stuff
    KeyChord([mod], "m", [
        Key([], "s", lazy.spawn("spotify-launcher"), desc="Open spotify"),
        Key([], "e", lazy.spawn("st -e neomutt"), desc="Open spotify"),
        Key([], "b", lazy.spawn("beeper"), desc="Open beeper"),
        Key([], "r", lazy.spawn("prime-run /opt/resolve/bin/resolve"), desc="Open resolve"),
        Key(["shift"], "r", lazy.spawn("polychromatic-controller"), desc="Open resolve"),
        Key([], "p", lazy.spawn("st -e pulsemixer"), desc="Open resolve"),
        Key([], "o", lazy.spawn("obsidian"), desc="Open obsidian"),
        Key(["shift"], "o", lazy.spawn("prime-run obs"), desc="Open obs"),
        Key([], "f", lazy.spawn("thunar"), desc="Open thunar")
        ]),

    Key([mod, "control"], "b",
        lazy.hide_show_bar(),
        desc="Toggle qtile bar",
        ),


    Key([mod, "shift"], "w", lazy.spawn("/usr/bin/firefox"), desc=""),
    Key([mod], "w", lazy.spawn("sxiv -t /home/sky/.dotfiles/backgrounds/"), desc=""),
    Key([alt], "bracketleft", lazy.spawn("/home/sky/.dotfiles/bin/.local/bin/brightness up"), desc=""),
    Key([alt], "braceleft", lazy.spawn("/home/sky/.dotfiles/bin/.local/bin/brightness down"), desc=""),

    Key([mod, "shift"], "g", lazy.spawn("/home/sky/.local/bin/picomToggle"), desc=""),

    Key([alt], "plus", lazy.spawn("/home/sky/.local/bin/volumeControl up"), desc=""),
    Key([alt], "minus", lazy.spawn("/home/sky/.local/bin/volumeControl down"), desc=""),
    Key([alt], "m", lazy.spawn("/home/sky/.local/bin/volumeControl mute"), desc=""),
    Key([mod], "o", lazy.spawn("st -e /home/sky/.local/bin/lfub"), desc=""),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui -p /home/sky/Pictures/Captures"), desc=""),
    Key([mod, "shift"], "b", lazy.spawn("/home/sky/.local/bin/change_background_dmenu"), desc=""),
    Key([alt], "d", lazy.spawn("setxkbmap -layout real-prog-dvorak"), desc=""),
    Key([alt], "q", lazy.spawn("setxkbmap -layout us"), desc=""),
    Key([mod, "shift"], "space", lazy.spawn("/home/sky/.local/bin/todoist --today"), desc=""),
    Key([alt], "space", lazy.spawn("/home/sky/.local/bin/quick-add-task"), desc=""),
    Key([alt, "shift"], "space", lazy.spawn("/home/sky/.local/bin/obsidian-cli quick-note"), desc=""),
    Key([alt], "F1", lazy.spawn("/home/sky/.local/bin/keyboard-connected"), desc=""),
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
