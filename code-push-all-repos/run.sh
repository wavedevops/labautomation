#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Initialize the count file if it doesn't exist
FILE=~/.count
if [ ! -f $FILE ]; then
    echo 0 > $FILE
fi

# Read the current commit count
commit_count=$(cat $FILE)

# Loop through all Git repositories
for dir in $(find . -type d -name .git | sed -e 's|/.git||'); do
    dir_name=$(basename $dir)  # Get the directory name without the path
    echo -e "${YELLOW}********* $dir_name *********${NC}"
    cd $dir
    
    # Pull the latest changes
    git pull
    
    # Add all changes
    git add -A
    
    # Increment the commit count
    commit_count=$((commit_count + 1))
    
    # Save the new commit count to the file
    echo $commit_count > $FILE
    
    # Commit the changes with a message
    git commit -m "automated commit #$commit_count"
    
    # Push the changes
    git push
    
    # Push tags if any
    git push --tags
    
    # Go back to the original directory
    cd -
done

# Output the total commits made
echo -e "${GREEN}Total commits made: $commit_count${NC}"
