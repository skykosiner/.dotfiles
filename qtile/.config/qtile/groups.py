from libqtile.config import Group

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
