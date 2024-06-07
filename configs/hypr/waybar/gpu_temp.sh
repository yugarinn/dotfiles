#!/bin/bash

sensors amdgpu-pci-2d00 | awk '/edge:/ {gsub(/\+|\.0/, "", $2); print $2}'
