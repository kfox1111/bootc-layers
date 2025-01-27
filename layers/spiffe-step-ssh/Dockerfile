ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG EXAMPLES_SNAPSHOT=2025-01-26-1
ARG SPIFFE_HELPER_VER=0.9.0
ARG SPIFFE_STEP_SSH_VER=0.0.5
ARG STEP_VER=0.28.2

#FIXME Rework once there is a dnf repo.

RUN \
  dnf install -y https://dl.smallstep.com/gh-release/cli/gh-release-header/v${STEP_VER}/step-cli-${STEP_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spiffe-helper-${SPIFFE_HELPER_VER}-1.$(uname -m).rpm && \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/spiffe-step-ssh-${SPIFFE_STEP_SSH_VER}-1.$(uname -m).rpm && \
  (ln -s /usr/bin/step-cli /usr/bin/step || true)
