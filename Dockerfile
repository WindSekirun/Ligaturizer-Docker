FROM ubuntu

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

USER root

WORKDIR /usr/local/src

# Install requirements
RUN apt-get update
RUN apt-get install git wget unzip make python-fontforge --no-install-recommends

# Clone latest of Ligaturizer
RUN git clone --depth 1 https://github.com/ToxicFrog/Ligaturizer .

RUN rm -rf fonts

# Download FiraCode version 2 and unzip
RUN mkdir -p fonts/fira/distr
RUN wget -O fira.zip https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip
RUN unzip -o fira.zip 'otf/*' -d fonts/fira/distr

COPY build.py .
COPY entrypoint.sh .

RUN mkdir -p input-fonts/
RUN mkdir -p output-fonts/

VOLUME input-fonts/
VOLUME output-fonts/

RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]