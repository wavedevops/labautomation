import os
import subprocess

# Colors for terminal output
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
NC = '\033[0m'  # No Color

# Initialize the count file if it doesn't exist
count_file = os.path.expanduser('~/.count')
if not os.path.exists(count_file):
    with open(count_file, 'w') as f:
        f.write('0\n')

# Read the current commit count
with open(count_file, 'r') as f:
    commit_count = int(f.read().strip())

# Loop through all Git repositories
for dir_path in subprocess.getoutput("find . -type d -name .git | sed -e 's|/.git||'").splitlines():
    dir_name = os.path.basename(dir_path)  # Get the base directory name
    print(f"{YELLOW}********* {dir_name} *********{NC}")
    os.chdir(dir_path)

    # Pull the latest changes
    subprocess.run(['git', 'pull'])

    # Add all changes
    subprocess.run(['git', 'add', '-A'])

    # Increment the commit count
    commit_count += 1

    # Save the new commit count to the file
    with open(count_file, 'w') as f:
        f.write(f"{commit_count}\n")

    # Commit the changes with a message
    subprocess.run(['git', 'commit', '-m', f"automated commit #{commit_count}"])

    # Push the changes
    subprocess.run(['git', 'push'])

    # Push tags if any
    subprocess.run(['git', 'push', '--tags'])

    # Go back to the original directory
    os.chdir('..')

# Output the total commits made
print(f"{GREEN}Total commits made: {commit_count}{NC}")
