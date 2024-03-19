FROM centos:7 
LABEL engg="pratik"

USER root
RUN yum update
RUN yum install python-pip python-dev mysql-server libmysqlclient-dev
RUN yum install wkhtmltopdf
COPY . .
RUN pip install virtualenv
RUN python3 -m venv myvenv
RUN source myvenv/bin/activate
RUN pip install -r requirements.txt
EXPOSE 8000
ENTRYPOINT ["python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]