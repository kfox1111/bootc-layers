ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG K8S_VER=v1.30

COPY calico.conf /etc/NetworkManager/conf.d/calico.conf
COPY 99-k8s.conf /usr/lib/sysctl.d/99-k8s.conf
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
COPY opt-cni-bin.mount /usr/lib/systemd/system/opt-cni-bin.mount
RUN \
  chmod 600 /etc/NetworkManager/conf.d/calico.conf && \
  sed -i "s/@K8S_VER@/${K8S_VER}/g" /etc/yum.repos.d/kubernetes.repo && \
  dnf install -y kubeadm kubectl kubelet && \
  systemctl enable kubelet && \
  echo 'kargs = ["cgroup_enable=memory","cgroup_memory=1"]' > /usr/lib/bootc/kargs.d/00-cgroup-memory.toml && \
  echo br_netfilter > /etc/modules-load.d/k8s.conf && \
  mkdir -p /usr/libexec/kubernetes/kubelet-plugins/volume/exec && \
  mv /opt/cni/bin /etc/cni/bin && \
  mkdir -p /opt/cni/bin && \
  systemctl enable opt-cni-bin.mount
