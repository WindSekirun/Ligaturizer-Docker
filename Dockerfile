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

ENV FILE_NAME_PREFIX=
USER root

WORKDIR /usr/local/src

# Install requirements
RUN apk update
RUN apk add --no-cache --virtual build git wget unzip make
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing fontforge

# Clone latest of Ligaturizer
RUN git clone --depth 1 https://github.com/rojiani/Ligaturizer-2.0.git .

# Download FiraCode version 2 and unzip
RUN mkdir -p fonts/fira/distr
RUN wget -O fira.zip https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip
RUN unzip fira.zip -o 'otf/*' -d fonts/fira/distr

COPY build.py .

RUN rm -rf /usr/src/app/input-fonts/
RUN rm -rf /usr/src/app/output-fonts/

CMD cat build.py
CMD ["make"]

# COPY entrypoint.sh .
# RUN chmod +x entrypoint.sh
# CMD ["./entrypoint.sh"]
