ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
ARG K8S_CLUSTER_NAME=main

RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y k8s-spiffe-workload-auth-config k8s-spiffe-oidc-discovery-provider && \
  systemctl enable k8s-spiffe-workload-auth-config k8s-spiffe-oidc-discovery-provider && \
  echo "K8S_CLUSTER_NAME=${K8S_CLUSTER_NAME}" > /etc/spiffe/k8s-workload-auth-config.env
