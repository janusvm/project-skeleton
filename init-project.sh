#!/usr/bin/env bash
#
# Initialise project


# Delete stuff from skeleton repository
rm -rf .git LICENSE README.md

# Read project info from user input
printf "Project name (will be used for folder name and document title): "
read PROJECT
printf "Project author (will be used for document author): "
read AUTHOR

# Create a short name for local R package based on project name
R_PKG="r"
R_PKG+=$(echo "$PROJECT" | sed -e "s/$/ /" -e "s/\([^ ]\)[^ ]* /\U\1/g" -e "s/^ *//")

# Insert variables into files
sed -i -e "s/<PROJECT>/${PROJECT}/g" -e "s/<AUTHOR>/${AUTHOR}/g" -e "s/<R_PKG>/${R_PKG}/g" \
    Makefile master.tex .Rprofile R/install_pkg.R

# Rename RStudio project file
mv PROJECT.Rproj "${PROJECT}.Rproj"

# Rename containing directory
mv "$PWD" "${PWD%/*}/$PROJECT"

# Create README for project
echo "# $PROJECT" > README.md

# Create local R package
Rscript --vanilla --slave -e "devtools::create('R/${R_PKG}')"
echo "library(devtools)" > "R/${R_PKG}/.Rprofile"
echo "# ${R_PKG}" > "R/${R_PKG}/README.md"

# Create some directories
mkdir data fig R/scripts/analysis R/scripts/data \
      tex/tabs tex/tikz

# TODO: git stuff
# TODO: run certain make commands
