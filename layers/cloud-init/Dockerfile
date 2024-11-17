ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

RUN \
  dnf install -y cloud-init &&\
  systemctl enable cloud-init

