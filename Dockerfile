FROM ubuntu:22.04
LABEL engg="pratik"

USER root
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    default-libmysqlclient-dev \
    python3-venv \
    build-essential \
    libffi-dev \
    libjpeg-dev \
    libtiff-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev

# Create and activate virtual environment
RUN python3 -m venv /opt/myvenv
RUN /opt/myvenv/bin/pip install --upgrade pip setuptools

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install project dependencies
RUN /opt/myvenv/bin/pip install -r requirements.txt
RUN pip install --no-binary :all: cffi
EXPOSE 8000
CMD ["/opt/myvenv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]