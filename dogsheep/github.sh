#!/bin/bash

# Install

pip install --user github-to-sqlite

# Configure/Auth
# Make sure to get a auth token from https://github.com/settings/tokens first
#

github-to-sqlite auth

# Let's fetch all the github emojis, because, why not?
#

github-to-sqlite emojis emojis.db --fetch

# Let's fetch all their repos, the ones they collaborate on
# and the organisations that they have access to
#
# Also save their README and the HTML version

github-to-sqlite repos github.db --readme --readme-html

# Now let's fetch all the issues and stuff for each repo
# Also, let's fetch all the users who have starred our repos
# NOTE: MIGHT TAKE A LONG TIME FOR SOME

sqlite3 "github.db" "SELECT full_name FROM repos" | while read -r line; do
	# Name of repo
	repoName=$(echo -e "$line" | cut -d '|' -f1)
	# Fetch PRs
	github-to-sqlite pull-requests github.db $repoName
	# Fetch issues and comments
	github-to-sqlite issues github.db $repoName
	github-to-sqlite issue-comments github.db $repoName
	# Fetch commits, releases and tags
	github-to-sqlite commits github.db $repoName
	github-to-sqlite releases github.db $repoName
	github-to-sqlite tags github.db $repoName
	# Fetch contributors and stargazers( _maybe we should fetch their profile later too?_ )
	github-to-sqlite contributors github.db $repoName
	github-to-sqlite stargazers github.db $repoName
	# Fetch workflows and scrape dependents
	github-to-sqlite workflows github.db $repoName
	github-to-sqlite scrape-dependents github.db $repoName
	echo "Fetched $repoName";
done
	

# Let's fetch all the repos that our user has starred

github-to-sqlite starred github.db

# With this, I think we pretty much backed-up the whole user

# So, let's uninstall ig?

pip uninstall github-to-sqlite

# Instructions for viewing
echo "To be able to view the data, install datasette using pip and then run: "
echo "$ pip install datasette"
echo "$ datasette github.db"