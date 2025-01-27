ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM docker.io/library/golang:1.23-bookworm as go
RUN \
  apt-get update && \
  apt-get install -y patch && \
  cd /tmp/ && \
  git clone https://github.com/spiffe/spire && \
  cd spire && \
  make bin/spire-server && \
  git clone https://github.com/kfox1111/spire-controller-manager && \
  cd spire-controller-manager && \
  git checkout static && \
  make bin/spire-controller-manager

FROM $BASE

ARG EXAMPLES_SNAPSHOT=2025-01-27-1
ARG SPIRE_VER=1.11.1
ARG SPIRE_TPM_PLUGIN_VER=1.8.7

RUN \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-common-${SPIRE_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-server-${SPIRE_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-server-nodeattestor-tpmdirect-${SPIRE_TPM_PLUGIN_VER}-1.$(uname -m).rpm && \
  mkdir -p /etc/spire/server && \
  systemctl enable spire-server.target spire.target && \
  mkdir -p /etc/spire/server/main/manifests

COPY default.conf /etc/spire/server/default.conf
COPY --from=go /tmp/spire/bin/spire-server /usr/bin/spire-server
#FIXME move later.
COPY --from=go /tmp/spire/spire-controller-manager/bin/spire-controller-manager /usr/bin/spire-controller-manager
COPY spire-controller-manager@.service /usr/lib/systemd/system/spire-controller-manager@.service
COPY spire-controller-manager-default.conf /etc/spire/controller-manager/default.conf
