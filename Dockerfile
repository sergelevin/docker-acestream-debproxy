# Set base to Debian jessie
FROM debian:jessie

MAINTAINER Serge A. Levin <serge.levin.spb@gmail.com>

# install base packages
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y \
      ca-certificates \
      libpython2.7 \
      python-apsw \
      python-gevent \
      python-m2crypto \
      python-psutil \
      supervisor \
      unzip \
      wget \
    && \
    apt-get install -y --no-install-recommends vlc-nox && \

# create user to run aceproxy
    useradd --system --create-home --no-user-group --gid nogroup aceproxy && \

# install acestream-engine
    wget  -o - http://dl.acestream.org/linux/acestream_3.1.16_debian_8.7_x86_64.tar.gz && \
    tar --show-transformed-names --transform='s/acestream_3.1.16_debian_8.7_x86_64/acestream/' -vzxf acestream_3.1.16_debian_8.7_x86_64.tar.gz && \
    mv acestream /usr/share && \
    rm -rf /tmp/* && \

# obtain and unpack aceproxy
    wget -o - https://github.com/sergelevin/aceproxy/archive/master.zip -O aceproxy.zip && \
    unzip -d /home/aceproxy aceproxy.zip && \
    mv /home/aceproxy/aceproxy-* /home/aceproxy/aceproxy && \
    rm -rf /tmp/*

# add services
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

EXPOSE 8000
VOLUME /etc/aceproxy

WORKDIR /
ENTRYPOINT ["/usr/bin/start.sh"]
