ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG SANDBOX_IMAGE=registry.k8s.io/pause:3.9
ARG CONTAINERD_VER=

COPY containerd.toml /etc/containerd/config.toml
COPY docker-io.repo /etc/yum.repos.d/docker-io.repo
RUN \
  export COMPUTED_CONTAINERD_VER="${CONTAINERD_VER}" && export COMPUTED_CONTAINERD_VER="${COMPUTED_CONTAINERD_VER:+"-"$COMPUTED_CONTAINERD_VER}" && \
  sed -i "s^@SANDBOX_IMAGE@^${SANDBOX_IMAGE}^g" /etc/containerd/config.toml && \
  mkdir -p /etc/containerd/certs.d && \
  dnf install -y "containerd.io${COMPUTED_CONTAINERD_VER}" && \
  systemctl enable containerd && \
  mkdir -p /usr/lib/systemd/system/containerd.service.d && \
  echo '[Service]' > /usr/lib/systemd/system/containerd.service.d/10-nofile.conf && \
  echo 'LimitNOFILE=524288' >> /usr/lib/systemd/system/containerd.service.d/10-nofile.conf
