# My Site
# Version: 1
FROM ubuntu:16.04
# Install Python and Package Libraries
RUN apt-get update 
RUN apt-get -y install python2.7
RUN apt-get -y install python-django
RUN apt-get -y install -y python-pip
RUN pip install pymysql
RUN apt-get -y install vim
# Project Files and Settings
#ARG PROJECT=myproject
ARG PROJECT_DIR=/home/ubuntu/athul/Golang/
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR
COPY . ./
WORKDIR $PROJECT_DIR/golang
EXPOSE 8000
EXPOSE 3306
STOPSIGNAL SIGINT
#CMD python manage.py migrate 
#RUN python manage.py createsuperuser 
#CMD echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'pass')" | python manage.py shell
# Server
#CMD python manage.py runserver 0.0.0.0:8000
RUN chmod 777 ./exec_cmd.sh
CMD ./exec_cmd.sh

