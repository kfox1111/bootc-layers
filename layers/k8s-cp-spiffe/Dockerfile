ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

#FIXME remove once upstreamed.
FROM docker.io/library/golang:1.23-bookworm as go
RUN \
  cd /tmp/ && \
  git clone https://github.com/spiffe/spire && \
  make bin/oidc-discovery-provider

FROM $BASE

#FIXME Move these into an rpm too
COPY k8s-spiffe-oidc-discovery-provider.conf /etc/spiffe/k8s-oidc-discovery-provider.conf
COPY k8s-spiffe-oidc-discovery-provider-helper.conf /etc/spiffe/k8s-oidc-discovery-provider-helper.conf
COPY k8s-spiffe-oidc-discovery-provider.service /usr/lib/systemd/system/k8s-spiffe-oidc-discovery-provider.service

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y k8s-spiffe-workload-auth-config spiffe-oidc-discovery-provider && \
  systemctl enable k8s-spiffe-workload-auth-config k8s-spiffe-oidc-discovery-provider

COPY --from=go /tmp/spire/bin/oidc-discovery-provider /usr/bin/spiffe-oidc-discovery-provider
