#
# Build: 
#    docker build -t apt-cacher .
# Run: 
#    docker run -d -p 3142:3142 --name apt-cacher-run coreindustries/apt-cacher:latest
#
# and then you can run containers with:
#   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ ubuntu /bin/bash
#
# Here, `dockerhost` is the IP address or FQDN of a host running the Docker daemon
# which acts as an APT proxy server.
#
# On OSX, you can replace "dockerhost" with $(ipconfig getifaddr en0)
#
FROM        ubuntu
MAINTAINER  SvenDowideit@docker.com

# this will persist the data across runs
VOLUME      ["/var/cache/apt-cacher-ng"]

# http://layer0.authentise.com/docker-4-useful-tips-you-may-not-know-about.html
# pick a mirror for apt-get
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update

RUN     apt-get update && apt-get install -y apt-cacher-ng

EXPOSE      3142
CMD     chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*

