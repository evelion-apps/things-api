FROM ruby:3.0

ARG RACK_ENV
ENV RACK_ENV="production"

ARG PORT
ENV PORT=3080

ARG DB
ENV DB="/app/db"

RUN echo '' > /etc/apt/sources.list && \
    echo 'deb http://deb.debian.org/debian bullseye main contrib non-free' >> /etc/apt/sources.list && \
    echo 'deb-src http://deb.debian.org/debian bullseye main contrib non-free' >> /etc/apt/sources.list && \
    echo 'deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free' >> /etc/apt/sources.list && \
    echo 'deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free' >> /etc/apt/sources.list && \
    echo 'deb http://deb.debian.org/debian bullseye-updates main contrib non-free' >> /etc/apt/sources.list && \
    echo 'deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free' >> /etc/apt/sources.list

RUN apt update && \
    apt -y install rsync sshpass

WORKDIR /app
COPY . /app

RUN bundle install

RUN rm .env.local && \
    rm /app/db/*.sqlite*

CMD ["/app/bin/docker-entrypoint"]
