#!/usr/bin/python3
from dataclasses import dataclass

@dataclass
class Album:
    artist: str
    title: str
    id: int

def main():
    albums = []
    albumList = []
    with open("/home/yoni/album_list") as f:
        content = f.readlines()
    content = [x.strip() for x in content]

    for album in content:
       albumList.append(album.split("|"))

    for album in albumList:
        albums.append(Album(album[0], album[1], album[2]))

    for album in albums:
        print(album)

if __name__ == "__main__":
    main()
