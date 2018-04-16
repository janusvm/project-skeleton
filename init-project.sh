#!/usr/bin/env bash
#
# Initialise project


# Read project info from user input
printf "Project name (will be used for folder name and document title): "
read PROJ_NAME
printf "Project author (will be used for document author): "
read PROJ_AUTHOR

# TODO: rest of script...
R_PKG="r"
R_PKG+=$(echo "$PROJ_NAME" | sed -e "s/$/ /" -e "s/\([^ ]\)[^ ]* /\U\1/g" -e "s/^ *//")
echo "$R_PKG"
