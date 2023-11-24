from Xlib import display as xdisplay
from libqtile import bar, widget
from libqtile.config import Screen
from libqtile import qtile
from keys import terminal
import subprocess

colors =  [
        ["#000000aa", "#00000077"], # color 0
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

widget_defaults = dict(
    font="sans",
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
                update_interval = 5000,
                func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-ip", shell=True, text=True),
                mouse_callbacks = {"Button2": lambda: qtile.cmd_spawn(terminal + " -e nmtui")},
                fmt= "🌐 {}"
                ),

            widget.Spacer(length = widget_space),

            widget.GenPollText(
                    update_interval = 1,
                    func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-music", shell=True, text=True),
                fmt= "🎵 {}"
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

            widget.Spacer(length = widget_space),

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

            widget.GenPollText(
                update_interval = 60,
                func = lambda: subprocess.check_output("/home/sky/.local/bin/statusbar/sb-timeDate", shell=True, text=True)
                ),
            ]

def init_widget():
    return widget_list()


screens = [
    Screen(
        top=bar.Bar(init_widget(), 30, background=colors[0], foreground=colors[1]),
    ),
]

if num_monitors > 1:
    for Monitor in range(num_monitors):
        screens.append(
                Screen(
                    top=bar.Bar(init_widget(), 30, background=colors[0], foreground=colors[1]),
                    )
                )
