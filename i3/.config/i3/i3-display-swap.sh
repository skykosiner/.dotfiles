#!/usr/bin/env bash
# requires jq

# TODO: Modify this script to work with up/down of the laptop screens not just at my desk

IFS=:
i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"' | grep -v '^null:null$' | \
while read -r name current_workspace; do
    echo "moving ${current_workspace} right..."
    i3-msg workspace "${current_workspace}"
    i3-msg move workspace to output left
done
