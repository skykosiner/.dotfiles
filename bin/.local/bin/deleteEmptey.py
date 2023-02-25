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

for file in files:
        if os.stat(f"{dir}/{file}").st_size == 0 or os.stat(f"{dir}/{file}").st_size == 1:
            print(file)
            os.remove(f"{dir}/{file}")
