#!/bin/sh
# This is a comment!

pubIP=$(echo PUBIP)
sudo apt-get -y install docker
sudo apt -y install docker.io
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
export MYSQL_PWD root
echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
sudo apt-get -y install mysql-server
sudo apt-get -y install mysql-server
sudo apt-get install -y python-pip 
sudo pip install pymysql
sudo netstat -plutn | grep -i sql

mysql --user=root --password=root << eof 
CREATE DATABASE golangdb;
CREATE USER 'root'@$pubIP IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON golangdb.* TO 'root'@$pubIP;
FLUSH PRIVILEGES;
eof

sed -i '/#bind-address*/c\bind-address= 0.0.0.0' /etc/mysql/mysql.conf.d/mysqld.cnf

cd /home/ubuntu/athul/Golang
sudo docker build -t golang-demo:1.0
sudo docker run -it -p 8080:8000 -e db_host=$pubIP django:1.0
