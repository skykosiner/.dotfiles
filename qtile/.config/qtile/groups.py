from libqtile.config import  Group, DropDown, Match, ScratchPad

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



scratchpads = [
    ScratchPad("spotify", [DropDown("spotify", "/usr/bin/spotify-launcher", x=0.12, y=0.02, width=0.75, height=0.9, on_focus_lost_hide=True, opacity=1)]),
    ScratchPad("beeper", [DropDown("beeper", "/usr/bin/beeper", x=0.12, y=0.02, width=0.75, height=0.9, on_focus_lost_hide=True, opacity=1, match=Match(wm_class='beeper'))]),
    ScratchPad("todoist", [DropDown("todoist", "/usr/local/bin/todoist", x=0.12, y=0.02, width=0.75, height=0.9, on_focus_lost_hide=False, opacity=1, match=Match(wm_class='todoist'))]),
    ScratchPad("bc", [DropDown("bc", "kitty -e bc -ql", x=0.12, y=0.02, width=0.75, height=0.9, on_focus_lost_hide=True, opacity=1)]),
]

for i in range(len(scratchpads)):
    groups.append(scratchpads[i])
