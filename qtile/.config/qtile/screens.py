import os
from libqtile import bar, widget
from libqtile.config import Screen
from libqtile import qtile
from keys import terminal
import subprocess

colors =  [
    ["#000000AA", "#000000BB"], # color 0
    ["#A8A8A8", "#A8A8A8"], # color 1
    ["#f99db3", "#f99db3"], # color 2
    ["#B9BCDF", "#B9BCDF"], # color 3
    ["#000000", "#000000"], # color 4
    ["#ffffff", "#ffffff"], # color 5
    ["#C7CAEF", "#C7CAEF"], # color 6
    ["#F9A9BC", "#F9A9BC"], # color 7
    ["#b79feb", "#b79feb"], # color 8
    ["#bbebca", "#bbebca"], # color 9
    ["#DCDEFC"]] # color 10

num_monitors = int(os.popen("xrandr --query | grep ' connected' | wc -l").read().strip())

widget_defaults = dict(
    font="BerkeleyMono Nerd Font",
    fontsize=15,
    padding=3,
)

extension_defaults = widget_defaults.copy()

widget_space = 5

def widget_list():
    return [
        widget.GroupBox(
            margin_y=4,
            margin_x=4,
            padding_y=5,
            padding_x=3,
            borderwidth=7,
            inactive=colors[6],
            # active=colors[4],
            rounded=True,
            # highlight_color=colors[0],
            highlight_method="block",
            # this_current_screen_border=colors[6],
            block_highlight_text_color=colors[5],
        ),
        widget.TextBox(
            text = '|',
            padding = 2,
            fontsize = 14
        ),
        widget.CurrentLayoutIcon(
            padding = 0,
            scale = 0.7
        ),
        widget.CurrentLayout(
            padding = 5
        ),
        widget.TextBox(
            text = '|',
            padding = 2,
            fontsize = 14
        ),
        widget.WindowName(),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 60,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-time-tracking", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn("/home/sky/.local/bin/toggl www")},
            fmt= "{}"
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 5000,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-ip", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e nmtui"), "Button1": lambda: qtile.cmd_spawn("networkmanager_dmenu")},
            fmt= "🌐 {}"
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 20,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-todoist", shell=True, text=True),
            fmt = "✅ {}"
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 150,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-mailbox", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e neomutt")},
        ),

        widget.Spacer(length = widget_space),

        widget.Volume(
            fmt = "🔉{}",
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e pulsemixer")},
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 100,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-batteryLife", shell=True, text=True)
        ),

        widget.GenPollText(
            update_interval = 1000,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-weather", shell=True, text=True),
            mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e less -Srf /home/sky/.cache/weatherreport")},
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 20,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-aircon", shell=True, text=True),
            fmt = "🌤️ {}"
        ),

        widget.Spacer(length = widget_space),

        widget.GenPollText(
            update_interval = 60,
            func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-timeDate", shell=True, text=True)
        ),

    ]

def init_widget():
    return widget_list()


screens = [
    Screen(
        bottom=bar.Bar(init_widget(), 30, background=colors[0], foreground=colors[1]),
    ),
]

if num_monitors > 1:
    for Monitor in range(num_monitors):
        screens.append(
            Screen(
                bottom=bar.Bar(init_widget(), 30, background=colors[0], foreground=colors[1]),
            )
        )
