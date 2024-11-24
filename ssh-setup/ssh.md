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
scp ec2-user@50.16.27.226:/root/.ssh/id_rsa ~/.ssh/
```
```bash
ec2-user@50.16.27.226's password:DevOps321
```
---