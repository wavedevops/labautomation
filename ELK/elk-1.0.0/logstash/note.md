you can create app user 
### both frontend and backend 
```yaml
- name: Add App User
  ansible.builtin.user:
    name: "{{app_user}}"
```
backend variables
```yaml
component: backend
app_user: expense
log_file: /var/log/backend.log
```
frontend variables
```yaml
component: frontend
app_user: expense
log_file: /var/log/frontend.log
```

how to import logstash role
```yaml
- name: Install Logstash
  ansible.builtin.import_role:
    name: logstash
  when: logstash_config_needed | bool and not only_deployment | bool
```