#!/usr/bin/python
import sys
import os

dir = sys.argv[1]

def CheckForEmpteyFiles(dir: str) -> list[str]:
    empteyFiles: list[str] = []

    for root, dirs, files in os.walk(dir):
        for filename in files:
            empteyFiles.append(filename)

    return empteyFiles


files = CheckForEmpteyFiles(dir)
filesToRm: list[str] = []

for file in files:
        if os.stat(f"{dir}/{file}").st_size == 0 or os.stat(f"{dir}/{file}").st_size == 1:
            filesToRm.append(f"{dir}/{file}")

delte = input(f"About to delete\n {filesToRm}\n Y to Delete N to not delete")

if delte == "Y":
    for file in filesToRm:
        os.remove(file)
else:
    exit(0)
