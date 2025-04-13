ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

ARG CID2PID_VER=0.0.3
FROM ghcr.io/kfox1111/cid2pid:v${CID2PID_VER} as cid2pid

FROM $BASE
ARG A_PEM=""
ARG B_PEM=""

#FIXME break this up so that socat and trust-sync are per task.
COPY --from=cid2pid /usr/bin/cid2pid /usr/bin/cid2pid
RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y spire-ha-agent spire-socat && \
  systemctl enable spire-ha-agent@main && \
  systemctl disable spire-agent@main && \
  systemctl enable spire-agent@a && \
  systemctl enable spire-agent@b && \
  echo -e "vsock" > /usr/lib/modules-load.d/spire-ha-agent.conf && \
  mkdir -p /etc/spire/server-attestor-tpm/keys && \
  ( if [ "x${A_PEM}" != "x" ]; then echo "${A_PEM}" | base64 -d > /etc/spire/server-attestor-tpm/keys/a.pem; fi; true ) && \
  ( if [ "x${B_PEM}" != "x" ]; then echo "${B_PEM}" | base64 -d > /etc/spire/server-attestor-tpm/keys/b.pem; fi; true )

COPY simple-verifier.conf /etc/spire/server-attestor-tpm/verifier.conf
