ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
RUN \
  dnf install -y centos-release-nfv-openvswitch && \
  dnf install -y NetworkManager-ovs openvswitch3.4 && \
  systemctl enable openvswitch

COPY setup-openvswitch.sh /usr/sbin/setup-openvswitch.sh
