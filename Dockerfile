FROM debian:wheezy
MAINTAINER Tobias Svensson <tob@tobiassvensson.co.uk>

RUN set -x \
  && echo "deb http://repos.mesosphere.io/debian wheezy main" > /etc/apt/sources.list.d/mesosphere.list \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
  && apt-get update \
  && apt-get -y install --no-install-recommends \
    mesos \
    chronos \
  && rm -rfv /var/lib/apt/lists/*

RUN rm -rf /etc/mesos
RUN rm -rf /etc/chronos/conf

EXPOSE 4400
E
ENTRYPOINT ["java", "-Xmx512m", "-Djava.library.path=/usr/local/lib:/usr/lib64:/usr/lib", "-cp", "/usr/bin/chronos", "org.apache.mesos.chronos.scheduler.Main", "--http_port", "4400"]

