ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM docker.io/library/ubuntu:24.10 as go

ARG CID2PID_VER=v0.0.1

RUN \
  apt-get update && \
  apt-get install -y curl gcc libtracefs-dev pkg-config libtraceevent-dev golang-go git && \
  cd /tmp && \
  curl -L -o cid2pid.tar.gz https://github.com/kfox1111/cid2pid/archive/refs/tags/${CID2PID_VER}.tar.gz && \
  tar -xvf cid2pid.tar.gz && \
  cd cid2pid-* && \
  gcc -o /cid2pid cid2pid.c -static /usr/lib/*-linux-gnu/libtracefs.a /usr/lib/*-linux-gnu/libtraceevent.a -I/usr/include/tracefs -I/usr/include/traceevent

FROM $BASE

ARG SPIRE_HA_AGENT_VER=v0.0.3

COPY --from=go /cid2pid /usr/bin/cid2pid
RUN \
  ARCH="$(uname -m | sed s/aarch64/arm64/)" && \
  mkdir -p /tmp/spire-ha-agent && \
  cd /tmp/spire-ha-agent && \
  curl -L -o /tmp/spire-ha-agent.tar.gz "https://github.com/spiffe/spire-ha-agent/releases/download/${SPIRE_HA_AGENT_VER}/spire-ha-agent_Linux_${ARCH}.tar.gz" && \
  tar -xvf /tmp/spire-ha-agent.tar.gz && \
  mv spire-ha-agent /usr/bin && \
  mv systemd/* /usr/lib/systemd/system/ && \
  cd /tmp && \
  rm -rf /tmp/spire-ha-agent && \
  systemctl enable spire-ha-agent@main && \
  systemctl disable spire-agent@main && \
  systemctl enable spire-agent@a && \
  systemctl enable spire-agent@b && \
  mkdir -p /etc/spire/socat && \
  echo 'SPIRE_SOCAT_PORT=997' > /etc/spire/socat/a.conf && \
  echo 'SPIRE_SOCAT_PORT=998' > /etc/spire/socat/b.conf && \
  echo 'SPIRE_SOCAT_PORT=999' > /etc/spire/socat/main.conf && \
  mkdir -p /etc/spiffe/step-ssh
