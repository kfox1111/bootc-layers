ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
ARG ALLOW=127.0.0.1
ARG POOL=
ARG NTPSERVERS=
RUN \
  ( if [ "x$ALLOW" != "x" ]; then echo "allow $ALLOW" > /etc/chrony.conf; fi; true ) && \
  ( if [ "x$POOL" != "x" ]; then echo "pool $POOL iburst" >> /etc/chrony.conf; fi; true ) && \
  ( if [ "x$NTPSERVERS" != "x" ]; then echo "$NTPSERVERS" | tr ',' '\n' | sed 's/^/server /;s/$/ iburst/' >> /etc/chrony.conf; fi; true )

