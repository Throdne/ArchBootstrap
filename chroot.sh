#!/bin/bash
echo "Inside Arch Linux bootstrap environment..."

pacman-key --init
pacman-key --populate

exit 0