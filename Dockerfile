# znc
#
# VERSION               0.1

FROM ubuntu:14.04
MAINTAINER Werner R. Mendizabal "werner.mendizabal@gmail.com"

RUN apt-get update
RUN apt-get install -y znc gettext-base ssl-cert expect

RUN echo "America/Chicago" > /etc/timezone
RUN dpkg-reconfigure tzdata

RUN groupadd znc
RUN useradd -g znc znc

ADD files/znc.conf /
ADD files/run.sh /

EXPOSE 6667

VOLUME ["/znc"]

CMD ./run.sh
