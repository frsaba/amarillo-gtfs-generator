FROM tiangolo/uvicorn-gunicorn:python3.10-slim

LABEL maintainer="info@mfdz.de"

WORKDIR /app

EXPOSE 80

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

COPY ./amarillo_gtfs_generator /app/amarillo_gtfs_generator
COPY ./logging.conf /app

ENV MODULE_NAME=amarillo_gtfs_generator.gtfs_generator
ENV MAX_WORKERS=1

RUN useradd amarillo
USER amarillo

# This image inherits uvicorn-gunicorn's CMD. If you'd like to start uvicorn, use this instead
# CMD ["uvicorn", "amarillo.main:app", "--host", "0.0.0.0", "--port", "8000"]

#`docker run -it --rm --name amarillo-gtfs-generator -p 8002:80 -e TZ=Europe/Berlin -v $(pwd)/data:/app/data amarillo-gtfs-generator