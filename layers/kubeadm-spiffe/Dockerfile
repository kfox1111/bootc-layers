ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

#FIXME depends on step-cli

#FIXME ca from a helper for kubelet -> apiserver

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y k8s-spiffe-workload-jwt-exec-auth

COPY kubelet.conf /etc/kubernetes/kubelet.conf
COPY kubelet-config.yaml /etc/kubernetes/kubelet-config.yaml
COPY 20-spiffe.conf /usr/lib/systemd/system/kubelet.service.d/20-spiffe.conf
COPY ca.crt /etc/kubernetes/pki/ca.crt
