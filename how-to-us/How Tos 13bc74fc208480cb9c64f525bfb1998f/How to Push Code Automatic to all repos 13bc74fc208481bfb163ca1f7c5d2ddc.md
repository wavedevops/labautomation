# How to Push Code Automatic to all repos

Though it is unethical practice, yet we want to push the code to save some time, We can take this approach. 

In this video I have explained how to push the code to multiple repositories at a time.

[https://youtu.be/OhRMNpY0Q88](https://youtu.be/OhRMNpY0Q88)

In this video we have written a shell script, The content of the script is given below.

```bash
#!/bin/bash

for dir in `find . -type d -name .git | sed -e 's|/.git||'`; do
	 echo "-------- $dir --------"
	 cd $dir
	 git pull
	 git add -A
	 git commit -m "updating $dir"
	 git push
   git push --tags
	 cd -

done
```

# Additional Video Links

1. How to connect to an EC2 server from Windows Desktop Using Putty.

[https://youtu.be/qc4TaYMKf0c](https://youtu.be/qc4TaYMKf0c)

2. Best Options that Makes Putty more Productive.

[https://youtu.be/PGpKq6lWyB4](https://youtu.be/PGpKq6lWyB4)