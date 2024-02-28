from libqtile.lazy import lazy
from libqtile.config import  Group, Key
from keys import keys, mod

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))



# groups.append(
#         ScratchPad("scratchpad", [
#             DropDown("org-today", "emacsclient -c -a emacs --eval '(org-agenda-list)'",
#                      x=0.05, y=0.4, width=0.9, height=0.6, opacity=0.9,
#                      on_focus_lost_hide=True),
#             ]),
#         )

keys.extend([
    Key([mod, "shift"], "plus", lazy.group["1"].toscreen()),
])
