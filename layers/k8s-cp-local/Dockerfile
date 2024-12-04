ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG K8S_APISERVER_LB_ADDR=1.2.3.4
ARG K8S_APISERVER_LB_PORT=6443

RUN \
  dnf install -y iptables-nft-services && \
  systemctl enable iptables.service && \
  cat > /etc/sysconfig/iptables <<EOF
*nat
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A OUTPUT --dst ${K8S_APISERVER_LB_ADDR} -p tcp --dport ${K8S_APISERVER_LB_PORT} -j REDIRECT --to-ports 6443
COMMIT
EOF
