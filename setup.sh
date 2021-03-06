#!/bin/sh
# This is a comment!

pubIP=$(echo $PUBIP)
sudo apt-get -y install docker
sudo apt-get -y install docker.io
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
#export MYSQL_PWD root
#sudo echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
#sudo echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
#sudo apt-get -y install mysql-server
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

sudo sed -i '/bind-address*/c\bind-address    = 0.0.0.0' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
cd /home/ubuntu/athul/Golang
sudo docker build -t golang-demo:1.0 .
#sudo docker run -p 8080:8000 --env db_host=$pubIP golang-demo:1.0
#sudo docker run -p 8080:8000 -e PUBIP golang-demo:1.0
