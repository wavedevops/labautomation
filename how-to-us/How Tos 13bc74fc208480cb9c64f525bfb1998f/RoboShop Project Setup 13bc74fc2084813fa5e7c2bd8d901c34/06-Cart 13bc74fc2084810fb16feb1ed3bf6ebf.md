# 06-Cart

# **Cart Service**

This service is responsible for Cart Service in RobotShop e-commerce portal.

1. This service is written in NodeJS, Hence need to install NodeJS in the system.

On CentOS-7

```bash
# curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
# yum install nodejs -y

```

On CentOS-8

```bash
# curl -sL https://rpm.nodesource.com/setup_lts.x | bash
# yum install nodejs -y
```

1. Let's now set up the cart application.

As part of operating system standards, we run all the applications and databases as a normal user but not with root user.

So to run the cart service we choose to run as a normal user and that user name should be more relevant to the project. Hence we will use `roboshop` as the username to run the service.

```bash
# useradd roboshop
```

1. So let's switch to the `roboshop` user and run the following commands to download the application code and download application dependencies

```bash
$ curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
$ cd /home/roboshop
$ unzip /tmp/cart.zip
$ mv cart-main cart
$ cd cart
$ npm install
```

1. Update SystemD service file 
    
          Update `REDIS_ENDPOINT` with REDIS server IP Address
          Update `CATALOGUE_ENDPOINT` with Catalogue server IP address
    
2. Now, lets set up the service with systemctl.

```bash
# mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
# systemctl daemon-reload
# systemctl start cart
# systemctl enable cart
```