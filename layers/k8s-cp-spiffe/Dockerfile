ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

#FIXME remove once upstreamed. k8s-spiffe-oidc-discovery-provider.conf domains is wrong pending a bug fix.
FROM docker.io/library/golang:1.23-bookworm as go
RUN \
  apt-get update && \
  apt-get install -y patch && \
  cd /tmp/ && \
  git clone https://github.com/kfox1111/spire && \
  cd spire && \
  git checkout oidc-expand-env && \
  curl https://patch-diff.githubusercontent.com/raw/spiffe/spire/pull/5690.patch | patch -p1 && \
  make bin/oidc-discovery-provider

FROM $BASE

ARG K8S_SPIFFE_WORKLOAD_AUTH_CONFIG_VER=v0.0.7
ARG SPIRE_VER=v1.11.1

COPY k8s-spiffe-oidc-discovery-provider.conf /etc/spiffe/k8s-oidc-discovery-provider.conf
COPY k8s-spiffe-oidc-discovery-provider-helper.conf /etc/spiffe/k8s-oidc-discovery-provider-helper.conf
COPY k8s-spiffe-oidc-discovery-provider.service /usr/lib/systemd/system/k8s-spiffe-oidc-discovery-provider.service
COPY auth-config.yaml /etc/kubernetes/auth-config.yaml

RUN \
  cd /tmp && \
  ARCH="$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)" && \
  ARCH2="$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)" && \
  curl -L -o auth-config.tgz https://github.com/spiffe/k8s-spiffe-workload-auth-config/releases/download/${K8S_SPIFFE_WORKLOAD_AUTH_CONFIG_VER}/k8s-spiffe-workload-auth-config_Linux_${ARCH}.tar.gz && \
  tar -xvf auth-config.tgz && \
  mv k8s-spiffe-workload-auth-config /usr/bin && \
  mv systemd/k8s-spiffe-workload-auth-config.service /usr/lib/systemd/system && \
  curl -L -o extras.tgz https://github.com/spiffe/spire/releases/download/${SPIRE_VER}/spire-extras-$(echo ${SPIRE_VER} | tr -d v)-linux-${ARCH2}-musl.tar.gz && \
  tar -xvf extras.tgz && \
  cp -a spire-extras*/bin/oidc-discovery-provider /usr/bin/spiffe-oidc-discovery-provider && \
  rm -rf /tmp/* && \
  systemctl enable k8s-spiffe-workload-auth-config && \
  systemctl enable k8s-spiffe-oidc-discovery-provider

COPY --from=go /tmp/spire/bin/oidc-discovery-provider /usr/bin/spiffe-oidc-discovery-provider
