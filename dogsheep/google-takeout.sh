#!/bin/bash

# Install it
pip install --user google-takeout-to-sqlite

# Populate the files
google-takeout-to-sqlite my-activity takeout.db ~/Downloads/takeout.zip
google-takeout-to-sqlite location-history takeout.db ~/Downloads/takeout.zip

# Remove it

pip uninstall google-takeout-to-sqlite

# Instructions for viewing
echo "To be able to view the data, install datasette using pip and then run: "
echo "$ pip install datasette"
echo "$ datasette takeout.db"
echo "Install the datasette-cluster-map plugin to see your location history on a map: "
echo "$ pip install datasette-cluster-map"