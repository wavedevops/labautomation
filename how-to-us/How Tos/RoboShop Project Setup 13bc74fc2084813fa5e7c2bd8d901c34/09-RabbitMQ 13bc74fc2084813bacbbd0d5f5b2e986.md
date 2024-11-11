# 09-RabbitMQ

RabbitMQ is a messaging Queue which is used by some components of the applications.

## **Manual Installation**

1. Erlang is a dependency which is needed for RabbitMQ.

```bash
# curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash

# yum install erlang -y
```

1. Setup YUM repositories for RabbitMQ.

```bash
# curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
```

1. Install RabbitMQ

```bash
# yum install rabbitmq-server -y
```

1. Start RabbitMQ

```bash
# systemctl enable rabbitmq-server 
# systemctl start rabbitmq-server
```

RabbitMQ comes with a default username / password as `guest`/`guest`. But this user cannot be used to connect. Hence we need to create one user for the application.

1. Create application user

```bash
# rabbitmqctl add_user roboshop roboshop123
# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
```

Ref link : [https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management](https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management)