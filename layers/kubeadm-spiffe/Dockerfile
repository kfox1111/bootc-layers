ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

#FIXME depends on step-cli

#FIXME ca from a helper for kubelet -> apiserver

ARG EXAMPLES_SNAPSHOT=2025-01-26-1
ARG K8S_SPIFFE_WORKLOAD_JWT_EXEC_AUTH_VER=0.0.4

RUN \
  dnf install -y https://github.com/spiffe/spire-examples/releases/download/${EXAMPLES_SNAPSHOT}/k8s-spiffe-workload-jwt-exec-auth-${K8S_SPIFFE_WORKLOAD_JWT_EXEC_AUTH_VER}-1.$(uname -m).rpm

COPY kubelet.conf /etc/kubernetes/kubelet.conf
COPY kubelet-config.yaml /etc/kubernetes/kubelet-config.yaml
COPY 20-spiffe.conf /usr/lib/systemd/system/kubelet.service.d/20-spiffe.conf
COPY ca.crt /etc/kubernetes/pki/ca.crt
