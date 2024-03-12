from libqtile import layout
from libqtile.config import Click, Drag, Match
from libqtile.lazy import lazy
from libqtile import hook

from keys import keys, mod
from screens import screens
from groups import groups

import os
import subprocess

# Only really use the master and stack layout

layouts = [
    layout.MonadTall(border_focus="#285577", border_width=1, margin=0),
    layout.MonadWide(border_focus="#285577", border_width=1, margin=0),
    layout.Max(border_width=1,border_focus="#285577", margin=0),
]

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

# Run my startup script
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.local/bin/startup")
    subprocess.Popen([home])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
wl_input_rules = None

wmname = "qtile"
