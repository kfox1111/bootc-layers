ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
RUN \
  curl -L -o /etc/yum.repos.d/spire-examples.repo https://raw.githubusercontent.com/spiffe/spire-examples/refs/heads/main/examples/rpms/spire-examples.repo && \
  dnf install -y k8s-spire-agent && \
  systemctl enable k8s-spire-agent@main
