#!/bin/bash
# Automatically update the PDF on the pdf branch with Travis. Based on
# http://www.steveklabnik.com/automatically_update_github_pages_with_travis_example/

# Exit on errors
set -o errexit -o nounset

# Begin
echo "Building docs..."

# Get git hash
rev=$(git rev-parse --short HEAD)

# Create *new* git repo in html folder
cd _build
git init
git config user.name "Rodrigo Luger"
git config user.email "rodluger@gmail.com"

# We will push to gh-pages
git remote add upstream "https://$GH_TOKEN@github.com/rodluger/cv.git"
git fetch upstream && git reset upstream/pdf

# Refresh all files
touch .

# Commit and push!
git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages