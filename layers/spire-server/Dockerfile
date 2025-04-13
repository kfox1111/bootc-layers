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

COPY usr-share-nginx-html.mount /usr/lib/systemd/system/usr-share-nginx-html.mount

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-common spire-server spire-server-nodeattestor-tpmdirect spire-server-attestor-tpm-sign spire-server-attestor-tpm-signer-http nginx && \
  systemctl enable spire-server.target spire.target && \
  mkdir -p /etc/spire/server/main/manifests && \
  mv /usr/share/nginx/html /etc/nginx/html && \
  mkdir -p /usr/share/nginx/html && \
  systemctl enable usr-share-nginx-html.mount

COPY nginx-spire.conf /etc/nginx/conf.d/spire.conf

COPY default.conf /etc/spire/server/default.conf
#FIXME move later.
COPY --from=go /tmp/spire-controller-manager/bin/spire-controller-manager /usr/bin/spire-controller-manager
COPY spire-controller-manager@.service /usr/lib/systemd/system/spire-controller-manager@.service
COPY spire-controller-manager-default.conf /etc/spire/controller-manager/default.conf
COPY start.sh /usr/libexec/spire/controller-manager/start.sh
