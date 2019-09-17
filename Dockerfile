FROM python:3.7-alpine

MAINTAINER WindSekirun <windsekirun@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
          org.label-schema.name="Ligaturizer-Docker" \
          org.label-schema.description="Make any font using Ligaturizer powered by Docker " \
          org.label-schema.vcs-ref=$VCS_REF \
          org.label-schema.vcs-url="https://github.com/WindSekirun/Ligaturizer-Docker" \
          org.label-schema.vendor="WindSekirun" \
          org.label-schema.version=$VERSION \
          org.label-schema.schema-version="1.0"

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

RUN mkdir -p /input
RUN mkdir -p /output
RUN rm -rf input-fonts/
RUN rm -rf /usr/src/app/output-fonts/

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

VOLUME /input
VOLUME /output
CMD ["./entrypoint.sh"]
