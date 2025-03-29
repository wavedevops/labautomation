*  from [elk-2.0.0](elk-2.0.0)
*  logstash.conf file
*  update password from elk dashboard
*  password => "{{secrets.ELK_PASSWORD}}" in [vars](elk-2.0.0/vars) this fie
*shell command*
```bsah
ansible-playbook -i elk.chowdary.cloud, -e ansible_user=ec2-user -e ansible_password=DevOps321  setup-tool-service.yaml 
```