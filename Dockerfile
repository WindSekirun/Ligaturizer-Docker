FROM python:3.7-alpine

MAINTAINER WindSekirun <windsekirun@gmail.com>

ENV FONT_NAME_PREFIX=
ENV FILE_NAME_PREFIX=
USER root

# Install requirements
RUN apk update
RUN apk add --no-cache --virtual build git wget unzip
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing fontforge

# Clone latest of Ligaturizer
RUN git clone --depth 1 https://github.com/ToxicFrog/Ligaturizer.git /usr/local/src

# Download FiraCode version 2 and unzip
RUN mkdir -p fonts/fira/distr
RUN wget -O fira.zip https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip
RUN unzip fira.zip 'otf/*' -d fonts/fira/distr

RUN touch /input
RUN mkdir -p /output
RUN rm -rf input-fonts/
RUN rm -rf /usr/src/app/output-fonts/

COPY entrypoint.sh
RUN chmod +x entrypoint.sh

VOLUME /output
CMD ["./entrypoint.sh"]
