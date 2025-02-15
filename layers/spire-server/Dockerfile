ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM docker.io/library/golang:1.23.6-bookworm as go
RUN \
  apt-get update && \
  apt-get install -y patch && \
  cd /tmp/ && \
  git clone https://github.com/kfox1111/spire-controller-manager && \
  cd spire-controller-manager && \
  git checkout static && \
  make bin/spire-controller-manager

FROM $BASE

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-server spire-server-nodeattestor-tpmdirect && \
  systemctl enable spire-server.target spire.target && \
  mkdir -p /etc/spire/server/main/manifests

COPY default.conf /etc/spire/server/default.conf
#FIXME move later.
COPY --from=go /tmp/spire-controller-manager/bin/spire-controller-manager /usr/bin/spire-controller-manager
COPY spire-controller-manager@.service /usr/lib/systemd/system/spire-controller-manager@.service
COPY spire-controller-manager-default.conf /etc/spire/controller-manager/default.conf
