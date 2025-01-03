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

ARG SPIRE_VER=v1.11.1
ARG SPIRE_TPM_PLUGIN_VER=v1.8.7

RUN \
  cd /tmp && \
  ls -l /tmp && \
  ARCH2="$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)" && \
  curl -L -o spire.tgz "https://github.com/spiffe/spire/releases/download/${SPIRE_VER}/spire-$(echo ${SPIRE_VER} | tr -d v)-linux-${ARCH2}-musl.tar.gz" && \
  tar -xvf spire.tgz && \
  mv spire-*/bin/spire-server /bin && \
  curl -L -o tpm.tgz "https://github.com/boxboat/spire-tpm-plugin/releases/download/${SPIRE_TPM_PLUGIN_VER}/spire_tpm_plugin_tpm_attestor_server_linux_${ARCH2}_${SPIRE_TPM_PLUGIN_VER}.tar.gz" && \
  tar -xvf tpm.tgz && \
  mv tpm_attestor_server /usr/bin && \
  chown root.wheel /usr/bin/tpm_attestor_server && \
  chmod 755 /usr/bin/tpm_attestor_server && \
  curl -L -o /usr/lib/systemd/system/spire-server.target https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/systemd/system/spire-server.target && \
  curl -L -o /usr/lib/systemd/system/spire-server@.service https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/systemd/system/spire-server@.service && \
  sed -i 's/PrivateTmp=false/PrivateTmp=true/' /usr/lib/systemd/system/spire-server@.service && \
  mkdir -p /etc/spire/server && \
  systemctl enable spire-server.target spire.target && \
  mkdir -p /etc/spire/server/main/manifests

COPY default.conf /etc/spire/server/default.conf
COPY --from=go /tmp/spire/bin/spire-server /usr/bin/spire-server
#FIXME move later.
COPY --from=go /tmp/spire/spire-controller-manager/bin/spire-controller-manager /usr/bin/spire-controller-manager
COPY spire-controller-manager@.service /usr/lib/systemd/system/spire-controller-manager@.service
COPY spire-controller-manager-default.conf /etc/spire/controller-manager/default.conf
COPY spire-server@.service /usr/lib/systemd/system/spire-server@.service
