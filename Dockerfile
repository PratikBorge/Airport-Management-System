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
RUN apt-get install -y build-essential python3-dev libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev
RUN pip install --upgrade pip setuptools
RUN pip install --no-binary :all: cffi
RUN pip install -r requirements.txt
EXPOSE 8000
ENTRYPOINT ["python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]