#!/bin/bash

sensors k10temp-pci-00c3 | awk '/Tctl:/ {gsub(/\+|\.[0-9]+/, "", $2); print $2}'
