#!/bin/bash

# Install it
pip install --user pocket-to-sqlite

# Configure

pocket-to-sqlite auth

# Fetch items

pocket-to-sqlite fetch pocket.db

# The first time you run this command it will fetch all of your items, and display a progress bar while it does it.

# On subsequent runs it will only fetch new items.

# You can force it to fetch everything from the beginning again using --all. Use --silent to disable the progress bar.


# Uninstall it for the time being
pip uninstall pocket-to-sqlite

# Instructions for viewing
echo "To be able to view the data, install datasette using pip and then run: "
echo "$ pip install datasette"
echo "$ datasette pocket.db"