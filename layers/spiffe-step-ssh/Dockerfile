ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG SPIFFE_STEP_SSH_VER=v0.0.2
ARG STEP_VER=v0.27.5

RUN \
  dnf install -y https://dl.smallstep.com/gh-release/cli/gh-release-header/${STEP_VER}/step-cli-$(echo ${STEP_VER} | tr -d v)-1.$(uname -m).rpm && \
  ARCH2="$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)" && \
  cd /tmp && \
  (ln -s /usr/bin/step-cli /usr/bin/step || true) && \
  curl -L -o /tmp/spiffe-step-ssh.tar.gz https://github.com/spiffe/spiffe-step-ssh/archive/refs/tags/${SPIFFE_STEP_SSH_VER}.tar.gz && \
  tar -xvf spiffe-step-ssh.tar.gz && \
  cd /tmp/spiffe-step-ssh-* && \
  mkdir -p /usr/libexec/spiffe-step-ssh && \
  mkdir -p /usr/lib/systemd/system/sshd.service.d && \
  mv scripts/reset.sh /usr/libexec/spiffe-step-ssh/reset.sh && \
  mv scripts/update.sh /usr/libexec/spiffe-step-ssh/update.sh && \
  mv systemd/spiffe-step-ssh-cleanup.service /usr/lib/systemd/system/ && \
  mv systemd/spiffe-step-ssh@.service /usr/lib/systemd/system/ && \
  mv conf/10-spiffe-step-ssh.conf /usr/lib/systemd/system/sshd.service.d/10-spiffe-step-ssh.conf && \
  systemctl enable spiffe-step-ssh-cleanup.service && \
  cd /tmp && \
  rm -rf /tmp/*
