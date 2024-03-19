FROM ubuntu:22.04
LABEL engg="pratik"

USER root
RUN apt update
RUN apt install python-pip python-3dev mysql-server libmysqlclient-dev
RUN apt install wkhtmltopdf
COPY . .
RUN pip install virtualenv
RUN python3 -m venv myvenv
RUN source myvenv/bin/activate
RUN pip install -r requirements.txt
EXPOSE 8000
ENTRYPOINT ["python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]