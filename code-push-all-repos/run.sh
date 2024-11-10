#!/bin/bash

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

# Initialize the count file if it doesn't exist
count_file=~/.count
if [ ! -f "$count_file" ]; then
    echo 0 > "$count_file"
fi

# Read the current commit count
commit_count=$(cat "$count_file")

# Loop through all Git repositories
for dir_path in $(find . -type d -name .git | sed -e 's|/.git||'); do
    dir_name=$(basename "$dir_path")  # Get the base directory name
    echo -e "${YELLOW}********* $dir_name *********${NC}"
    cd "$dir_path" || continue

    # Pull the latest changes
    git pull

    # Add all changes
    git add -A

    # Check if there are changes to commit
    status=$(git status --porcelain)

    if [ -n "$status" ]; then  # If there are changes to commit
        # Increment the commit count
        commit_count=$((commit_count + 1))

        # Save the new commit count to the file
        echo "$commit_count" > "$count_file"

        # Commit the changes with a message
        git commit -m "automated commit #$commit_count"

        # Push the changes
        git push

        # Push tags if any
        git push --tags
    else
        echo -e "${RED}No changes to commit in $dir_name${NC}"
    fi

    # Go back to the original directory
    cd - || continue
done

# Output the total commits made
echo -e "${GREEN}Total commits made: $commit_count${NC}"
