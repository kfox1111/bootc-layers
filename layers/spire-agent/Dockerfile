ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM docker.io/library/golang:1.23-bookworm as go

ARG SPIFFE_HELPER_VER=v0.8.0

RUN \
  cd /tmp && \
  curl -o spiffe-helper.tar.gz https://github.com/spiffe/spiffe-helper/archive/refs/tags/${SPIFFE_HELPER_VER}.tar.gz -L && \
  tar -xvf spiffe-helper.tar.gz && \
  cd spiffe-helper-* && \
  make && \
  ls -l && \
  mv spiffe-helper /

FROM $BASE

ARG SPIRE_VER=v1.11.1
ARG SPIRE_TPM_PLUGIN_VER=v1.8.7

RUN \
  set -x && \
  ARCH="$(uname -m | sed s/aarch64/arm64/)" && \
  ARCH2="$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)" && \
  cd /tmp && \
  curl -L -o spire.tgz "https://github.com/spiffe/spire/releases/download/${SPIRE_VER}/spire-$(echo ${SPIRE_VER} | tr -d v)-linux-${ARCH}-musl.tar.gz" && \
  tar -xvf spire.tgz && \
  mv spire-*/bin/spire-agent /bin && \
  curl -L -o /usr/lib/systemd/system/spire-agent.target https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/systemd/system/spire-agent.target && \
  curl -L -o /usr/lib/systemd/system/spire-agent@.service https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/systemd/system/spire-agent@.service && \
  curl -L -o /usr/lib/systemd/system/spire.target https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/systemd/system/spire.target && \
  curl -L -o tpm.tar.gz https://github.com/boxboat/spire-tpm-plugin/releases/download/${SPIRE_TPM_PLUGIN_VER}/spire_tpm_plugin_get_tpm_pubhash_linux_${ARCH}_${SPIRE_TPM_PLUGIN_VER}.tar.gz && \
  tar -xvf tpm.tar.gz && \
  mv get_tpm_pubhash /bin && \
  curl -L -o tpm.tar.gz https://github.com/boxboat/spire-tpm-plugin/releases/download/${SPIRE_TPM_PLUGIN_VER}/spire_tpm_plugin_tpm_attestor_agent_linux_${ARCH}_${SPIRE_TPM_PLUGIN_VER}.tar.gz && \
  tar -xvf tpm.tar.gz && \
  mv tpm_attestor_agent /bin && \
  chown root.wheel /bin/get_tpm_pubhash && \
  chown root.wheel /bin/tpm_attestor_agent && \
  rm -rf /tmp/* && \
  systemctl enable spire.target spire-agent.target && \
  mkdir -p /etc/spiffe && \
  echo 'SPIFFE_TRUST_DOMAIN=example.org' >> /etc/spiffe/default-trust-domain.env && \
  ( if ! spire-ha-agent; then systemctl enable spire-agent@main; fi; true )

COPY --from=go /spiffe-helper /usr/bin/spiffe-helper
COPY default.conf /etc/spire/agent/default.conf
#FIXME remove
COPY spire-agent@.service /usr/lib/systemd/system/spire-agent@.service
