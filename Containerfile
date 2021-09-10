FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
      apt-get -y dist-upgrade && \
      apt-get install -y --no-install-recommends smokeping dma && \
      apt-get clean
RUN sed -i 's#run/smokeping#tmp#' /etc/smokeping/config.d/pathnames
# the package sets cap_net_raw+ep, but then you can't execute fping
# in an unprivileged container anymore
RUN setcap cap_net_raw-ep /usr/bin/fping
RUN chmod 4755 /usr/bin/fping
RUN chown smokeping /var/cache/smokeping/images

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
USER smokeping
VOLUME ["/var/lib/smokeping", "/var/cache/smokeping"]
WORKDIR /var/lib/smokeping
