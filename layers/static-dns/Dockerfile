ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
ARG DNSSERVERS=1.1.1.1,8.8.8.8
RUN \
  echo -e '[main]\ndns=none' > /etc/NetworkManager/conf.d/90-dns-none.conf && \
  echo "$DNSSERVERS" | tr ',' '\n' | sed 's/^/nameserver /' > /etc/resolv.conf

