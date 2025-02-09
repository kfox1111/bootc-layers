ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

RUN \
  set -x && \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-agent spire-agent-nodeattestor-tpmdirect spiffe-helper && \
  systemctl enable spire.target spire-agent.target && \
  ( if ! spire-ha-agent; then systemctl enable spire-agent@main; fi; true )

COPY default.conf /etc/spire/agent/default.conf
