ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

ARG CID2PID_VER=0.0.3
FROM ghcr.io/kfox1111/cid2pid:v${CID2PID_VER} as cid2pid

FROM $BASE

ARG EXAMPLES_SNAPSHOT=2025-01-27-1
ARG SPIRE_HA_AGENT_VER=0.0.12

#FIXME break this up so that socat and trust-sync are per task.
COPY --from=cid2pid /usr/bin/cid2pid /usr/bin/cid2pid
RUN \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-ha-agent-${SPIRE_HA_AGENT_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-trust-sync-${SPIRE_HA_AGENT_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spire-socat-${SPIRE_HA_AGENT_VER}-1.$(uname -m).rpm && \
  systemctl enable spire-ha-agent@main && \
  systemctl disable spire-agent@main && \
  systemctl enable spire-agent@a && \
  systemctl enable spire-agent@b && \
  echo -e "vsock" > /usr/lib/modules-load.d/spire-ha-agent.conf
