#!/bin/bash

current_hostname=$(hostname)

if [[ ! "$current_hostname" =~ ^soyuz[0-9]+$ ]]; then
    exit 1
else
    exit 0
fi
