ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

#FIXME remove once upstreamed.
FROM docker.io/library/golang:1.23-bookworm as go
RUN \
  apt-get update && \
  apt-get install -y patch && \
  cd /tmp/ && \
  git clone https://github.com/kfox1111/spire && \
  cd spire && \
  git checkout issuer-fix && \
  make bin/oidc-discovery-provider

FROM $BASE

ARG EXAMPLES_SNAPSHOT=2025-01-27-1
ARG SPIRE_VER=1.11.1
ARG K8S_SPIFFE_WORKLOAD_AUTH_CONFIG_VER=0.0.8

COPY k8s-spiffe-oidc-discovery-provider.conf /etc/spiffe/k8s-oidc-discovery-provider.conf
COPY k8s-spiffe-oidc-discovery-provider-helper.conf /etc/spiffe/k8s-oidc-discovery-provider-helper.conf
COPY k8s-spiffe-oidc-discovery-provider.service /usr/lib/systemd/system/k8s-spiffe-oidc-discovery-provider.service
COPY auth-config.yaml /etc/kubernetes/auth-config.yaml

RUN \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/k8s-spiffe-workload-auth-config-${K8S_SPIFFE_WORKLOAD_AUTH_CONFIG_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spiffe-oidc-discovery-provider-${SPIRE_VER}-1.$(uname -m).rpm && \
  systemctl enable k8s-spiffe-workload-auth-config && \
  systemctl enable k8s-spiffe-oidc-discovery-provider

COPY --from=go /tmp/spire/bin/oidc-discovery-provider /usr/bin/spiffe-oidc-discovery-provider
