import os
import subprocess

FILE = os.path.expanduser("~/.count")

def git_push():
    with open(FILE, 'r') as f:
        variable_count = int(f.read().strip())

    # Execute git commands
    subprocess.run(["git", "add", "."])

    new_count = variable_count + 1
    with open(FILE, 'w') as f:
        f.write(str(new_count))

    commit_message = f"automated commit #{variable_count}"
    subprocess.run(["git", "commit", "-m", commit_message])
    subprocess.run(["git", "push"])

if os.path.isfile(FILE):
    git_push()
else:
    with open(FILE, 'w') as f:
        f.write("0")
    git_push()

