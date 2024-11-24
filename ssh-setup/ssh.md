**Run in the remort**
---
```bash
cp /root/.ssh/id_rsa /home/ec2-user/
```

```bash
chown ec2-user:ec2-user /home/ec2-user/id_rsa
```

```bash
chmod 600 /home/ec2-user/id_rsa
```
---
# Run in the local

```bash
scp ec2-user@50.16.27.226:/home/ec2-user/id_rsa ~/.ssh/

```
---
OR
---
install ssh pass to pass password to one line command
---
```shell
brew install sshpass
```
```bash
sshpass -p 'DevOps321' scp ec2-user@50.16.27.226:/home/ec2-user/id_rsa ~/.ssh/
````
---