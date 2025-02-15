ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG VIRTCTL_VER=v1.3.1
ARG HELM_VER=v3.16.1
ARG YQ_VER=v4.44.5

RUN \
  ARCH2="$(uname -m | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)" && \
  dnf install -y vim-enhanced && \
  cd /tmp && \
  curl -L -o /usr/bin/virtctl https://github.com/kubevirt/kubevirt/releases/download/${VIRTCTL_VER}/virtctl-${VIRTCTL_VER}-linux-${ARCH2} && \
  chmod +x /usr/bin/virtctl && \
  curl -o helm.tgz https://get.helm.sh/helm-${HELM_VER}-linux-${ARCH2}.tar.gz && \
  tar -xvf helm.tgz && \
  mv linux-${ARCH2}/helm /usr/bin/helm && \
  curl -L -o /usr/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VER}/yq_linux_arm64" && \
  chmod +x /usr/bin/yq && \
  rm -rf /tmp/*
