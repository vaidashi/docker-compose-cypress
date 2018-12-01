FROM docker:stable-dind as docker
FROM cypress/browsers:latest

RUN mkdir /var/lib/docker/;

COPY --from=docker /usr/local/bin/* /usr/local/bin/
COPY --from=docker /var/lib/docker/ /var/lib/docker/

RUN apt-get install -y iptables aufs-tools; \
  curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose; \
  chmod +x /usr/local/bin/docker-compose; \
  docker-compose --version;

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh"]
