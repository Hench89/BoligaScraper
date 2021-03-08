FROM arm32v7/python:3.8-slim-buster

# install project dependencies
RUN mkdir -p /app/src
WORKDIR /app

# using poetry, install project
COPY src /app/src
COPY static /app/static

# setup the locale setting
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# da_DK.UTF-8 UTF-8/da_DK.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=da_DK.UTF-8
ENV LANG da_DK.UTF-8

# map output folder to outside of container
RUN mkdir -p /app/output
VOLUME output /app/output

# run
RUN chmod -R 755 /app/src
CMD ["python", "./src/scraper"]