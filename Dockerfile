FROM ubuntu:xenial-20170710

ARG TIMEZONE

RUN apt-get -yq update && \
    apt-get -yq install python3 python3-pip wkhtmltopdf pdftk xvfb cups-bsd tzdata && \
    pip3 install -U pip

ADD requirements.txt /root/requirements.txt
RUN pip3 install -r /root/requirements.txt

RUN ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

ADD docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh

ADD . /usr/src/ioiprint
WORKDIR /usr/src/ioiprint

ENTRYPOINT ["/root/docker-entrypoint.sh"]
