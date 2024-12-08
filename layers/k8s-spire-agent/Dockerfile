ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
COPY k8s-spire-agent@.service /usr/lib/systemd/system/k8s-spire-agent@.service
RUN \
  systemctl enable k8s-spire-agent@main
