FROM ubuntu:22.04
LABEL engg="pratik"

USER root
RUN apt update
RUN apt install -y python-pip python3-dev default-libmysqlclient-dev
COPY . .
RUN pip install virtualenv
RUN python3 -m venv myvenv
RUN source myvenv/bin/activate
RUN pip install -r requirements.txt
EXPOSE 8000
ENTRYPOINT ["python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]