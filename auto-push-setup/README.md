```shell
alias pms='pmset sleepnow'
```
---
```shell
alias gitp='source ~/.customCommands/gitp.sh'
```
---
```shell
alias gitpp='python3.11 /Users/chowdary/.customCommands/all-repo-push.py'
```
---


# **Process to `getp.sh` setup**


### **1. Create or Confirm the Existence of `gitp.sh`**
Make sure the script `gitp.sh` exists in the `~/.customCommands` directory. If you haven't created it yet, you can do so with the following steps:

1. Create the `.customCommands` directory if it doesn’t exist:
   ```bash
   mkdir -p ~/.customCommands
   ```

2. Create or edit the `gitp.sh` file:
   ```bash
   vim ~/.customCommands/gitp.sh
   ```

3. Add your Git-related commands to this file. For example:
   ```bash
    #!/bin/bash

    FILE=~/.count

    git_push () {
        variableCount=$(cat ~/.count)
        git add .
        echo $(($(cat ~/.count) + 1)) > ~/.count
        git commit -m "automated commit #$variableCount"
        git push
    }

    if [ -f $FILE ]; then
    git_push
    else
    echo "0" > ~/.count
    git_push
    fi
   ```

4. Save and exit. Make the file executable:
   ```bash
   chmod +x ~/.customCommands/gitp.sh
   ```

---

### **2. Add `gitp` Alias to Your Shell Configuration**

1. Open your shell configuration file. Since you're using **zsh**, the file is `~/.zshrc`:
   ```bash
   vim ~/.zshrc
   ```

2. Add the alias:
   ```bash
   alias gitp='source ~/.customCommands/gitp.sh'
   ```

3. Save and exit the file.

---

### **3. Reload Your Shell Configuration**

Reload the `~/.zshrc` file to apply the changes:
```bash
source ~/.zshrc
```

---

### **4. Test the Command**

Run the `gitp` command to verify it works:
```bash
gitp
```

You should see the output of the commands in `gitp.sh`.

---

### **Optional: Debugging**

- If the command doesn’t work, verify the alias was added correctly by running:
  ```bash
  alias
  ```
  Look for the `gitp` alias in the output.

- Ensure the `gitp.sh` script has the correct file path and is executable.

Let me know if you run into any issues!


---
# **`all-repo-push.py` file all ready exits on local**

### **Step 1: Ensure the Script is Executable**
Make sure your script has executable permissions.

```bash
chmod +x /Users/chowdary/.customCommands/all-repo-push.py
```
---

### **Step 2: Add an Alias for the Script**
1. Open your shell configuration file:
   - For `zsh` (default shell): 
     ```bash
     vim ~/.zshrc
     ```


2. Add an alias for your script. For example:
   ```bash
    alias gitpp='python3.11 /Users/chowdary/.customCommands/all-repo-push.py'
   ```

---

### **Step 3: Reload the Configuration**
Apply the changes by sourcing the configuration file:
```bash
source ~/.zshrc   # For zsh
```

---

### **Step 4: Run the Command**
Now you can run the script using the alias:
```bash
gitpp
```

---
