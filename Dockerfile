FROM ubuntu:22.04
LABEL engg="pratik"

USER root
RUN apt update
RUN apt install -y python3-pip python3-dev default-libmysqlclient-dev
COPY . .
RUN pip install virtualenv
RUN apt install -y python3.10-venv
RUN python3 -m venv myvenv
RUN . myvenv/bin/activate
RUN apt-get install -y build-essential python3-dev libffi-dev libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev
RUN pip install --upgrade pip setuptools
RUN pip install -r requirements.txt
RUN pip install --no-binary :all: cffi
WORKDIR /~/Airport_Management-System
EXPOSE 8000
RUN python manage.py makemigrations
RUN python manage.py migrate 
RUN python manage.py runserver