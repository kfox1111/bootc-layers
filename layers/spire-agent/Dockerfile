ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG EXAMPLES_SNAPSHOT=2025-01-27-1
ARG SPIRE_VER=1.11.1
ARG SPIRE_TPM_PLUGIN_VER=1.8.7
ARG SPIFFE_HELPER_VER=0.9.0

#FIXME Rework once there is a dnf repo.

RUN \
  set -x && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-common-${SPIRE_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-agent-${SPIRE_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-agent-nodeattestor-tpmdirect-${SPIRE_TPM_PLUGIN_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spiffe-helper-${SPIFFE_HELPER_VER}-1.$(uname -m).rpm && \
  systemctl enable spire.target spire-agent.target && \
  ( if ! spire-ha-agent; then systemctl enable spire-agent@main; fi; true )

COPY default.conf /etc/spire/agent/default.conf
