import os
from libqtile import bar, widget
from libqtile.config import Screen
from libqtile import qtile
from keys import terminal
import subprocess

colors =  [
    ["#000000CC", "#000000CC"], # color 0
    ["#A10A10A10", "#A10A10A10"], # color 1
    ["#f99db3", "#f99db3"], # color 2
    ["#B9BCDF", "#B9BCDF"], # color 3
    ["#000000", "#000000"], # color 4
    ["#ffffff", "#ffffff"], # color 5
    ["#C7CAEF", "#C7CAEF"], # color 6
    ["#F9A9BC", "#F9A9BC"], # color 7
    ["#b79feb", "#b79feb"], # color 10
    ["#bbebca", "#bbebca"], # color 9
    ["#DCDEFC"]] # color 10

num_monitors = int(os.popen("xrandr --query | grep ' connected' | wc -l").read().strip())

widget_defaults = dict(
    font="BerkeleyMono Nerd Font",
    fontsize=16,
    padding=5,
)

extension_defaults = widget_defaults.copy()

widget_space = 2

def widget_list():
    return [
        widget.GroupBox(
            margin_y=4,
            margin_x=4,
            padding_y=5,
            padding_x=3,
            borderwidth=5,
            inactive=colors[6],
            # active=colors[4],
            rounded=True,
            # highlight_color=colors[0],
            highlight_method="block",
            # this_current_screen_border=colors[6],
            block_highlight_text_color=colors[5],
            fontsize=10
        ),
        widget.TextBox(
            text = '|',
            padding = 2,
            fontsize=10
        ),
        widget.CurrentLayoutIcon(
            padding = 0,
            scale = 0.7,
            fontsize=10
        ),
        widget.CurrentLayout(
            padding = 5,
            fontsize=10
        ),
        widget.TextBox(
            text = '|',
            padding = 2,
            fontsize=10
        ),
        widget.WindowName(
            fontsize=10
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 150,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-mailbox", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e neomutt")},
            fontsize=10
        ),

        widget.GenPollText(
            update_interval = 20,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-todoist", shell=True, text=True),
            fmt = "✅ {}",
            fontsize=10
        ),

        widget.Spacer(length = widget_space),

        widget.Volume(
            fmt = "🔉{}",
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e pulsemixer")},
            fontsize=10
        ),

        widget.GenPollText(
            update_interval = 60,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-time-tracking", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn("/home/sky/.local/bin/toggl www")},
            fmt= "{}",
            fontsize=10
        ),

        widget.GenPollText(
            update_interval = 100,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-batteryLife", shell=True, text=True),
            fontsize=10
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 120,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-ip", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e nmtui"), "Button1": lambda: qtile.cmd_spawn("networkmanager_dmenu")},
            fmt = "🌐 {}",
            fontsize=10
        ),

        widget.GenPollText(
            update_interval = 1000,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-weather", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e less -Srf /home/sky/.cache/weatherreport")},
            fontsize=10
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 20,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-aircon", shell=True, text=True),
            fmt = "🌤️ {}",
            fontsize=10
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 60,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-timeDate", shell=True, text=True),
            fontsize=10
        ),

    ]

def init_widget():
    return widget_list()


screens = [
    Screen(
        top=bar.Bar(init_widget(), 15, background=colors[0], foreground=colors[1]),
    ),
]

if num_monitors > 1:
    for Monitor in range(num_monitors):
        screens.append(
            Screen(
                top=bar.Bar(init_widget(), 15, background=colors[0], foreground=colors[1]),
            )
        )
