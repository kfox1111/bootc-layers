ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG K8S_VER=v1.30
ARG TIMESYNC=

COPY calico.conf /etc/NetworkManager/conf.d/calico.conf
COPY 99-k8s.conf /usr/lib/sysctl.d/99-k8s.conf
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
COPY opt-cni-bin.mount /usr/lib/systemd/system/opt-cni-bin.mount
RUN \
  dnf remove -y zram-generator && \
  chmod 600 /etc/NetworkManager/conf.d/calico.conf && \
  sed -i "s/@K8S_VER@/${K8S_VER}/g" /etc/yum.repos.d/kubernetes.repo && \
  dnf install -y kubeadm kubectl kubelet && \
  systemctl enable kubelet && \
  echo 'kargs = ["cgroup_enable=memory","cgroup_memory=1"]' > /usr/lib/bootc/kargs.d/00-cgroup-memory.toml && \
  echo br_netfilter > /etc/modules-load.d/k8s.conf && \
  mkdir -p /usr/libexec/kubernetes/kubelet-plugins/volume/exec && \
  mv /opt/cni/bin /etc/cni/bin && \
  mkdir -p /opt/cni/bin && \
  systemctl enable opt-cni-bin.mount && \
  ( if [ "x$TIMESYNC" != "x" ]; then mkdir -p /etc/systemd/system/kubelet.service.d; mkdir -p /etc/systemd/system/time-sync.target.d; echo -e '[Unit]\nAfter=time-sync.target\nRequires=time-sync.target' > /etc/systemd/system/kubelet.service.d/99-time-sync.conf; echo -e '[Unit]\nRequires=chrony-wait.service' > /etc/systemd/system/time-sync.target.d/requires.conf; systemctl enable chronyd chrony-wait.service; fi; true )
