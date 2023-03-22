#!/usr/bin/python3
import os

current_date = os.popen("date +%Y-%m-%d").read()
class Task:
    def __init__(self, lines: list[str]):
        for line in lines:
            self.done = "TODO" in line
            self.today = current_date.replace("\n", "") in line

    def __repr__(self):
        return "repr(self)"

    def __str__(self):
        return "str(self)"

tasks: list[Task] = []

def getTasks():
    files = os.popen("emacsclient --eval '(org-agenda-files)'").read()
    files = files.split(" ")
    for file in files:
        file = file.replace("(", "").replace(")", "").replace("\"", "").replace("\n", "")
        with open(file) as f:
            content = f.readlines()
            task = Task(content)
            if task.today and not task.done:
                tasks.append(task)
getTasks()
print(tasks)
