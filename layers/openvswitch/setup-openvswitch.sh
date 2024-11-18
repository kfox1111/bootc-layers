#!/bin/bash

ADDR=$1
INTERFACE="${INTERFACE:-eth0}"
SUBNET="${SUBNET:-24}"
MTU="${MTU:-1500}"

if [[ ! -v ADDR ]]; then
  echo ADDR must be defined
  exit -1
fi

if [[ ! -v GW ]]; then
  GW=$(echo $ADDR | awk -F. '{printf "%s.%s.%s.1\n", $1, $2, $3}')
fi

cat > /etc/NetworkManager/system-connections/ovs-bridge-ovsbr0.nmconnection <<EOF
[connection]
id=ovs-bridge-ovsbr0
uuid=$(uuidgen)
type=ovs-bridge
interface-name=ovsbr0
[ovs-bridge]
[ipv4]
method=auto
[ipv6]
addr-gen-mode=stable-privacy
method=ignore
may-fail=true
never-default=true
[proxy]
[802-3-ethernet]
mtu=${MTU}
EOF

cat > /etc/NetworkManager/system-connections/int-main.nmconnection <<EOF
[connection]
id=int-main
uuid=$(uuidgen)
type=ovs-interface
interface-name=int-main
master=int-main-port
slave-type=ovs-port
zone=public
[ovs-interface]
type=internal
[ipv4]
address1=${ADDR}/${SUBNET},${GW}
method=manual
[ipv6]
addr-gen-mode=stable-privacy
method=ignore
may-fail=true
never-default=true
[proxy]
[802-3-ethernet]
mtu=${MTU}
EOF

cat > /etc/NetworkManager/system-connections/ovs-port-int-main.nmconnection <<EOF
[connection]
id=ovs-port-int-main
uuid=$(uuidgen)
type=ovs-port
interface-name=int-main-port
master=ovsbr0
slave-type=ovs-bridge
[ovs-port]
[802-3-ethernet]
mtu=1500
EOF

cat > /etc/NetworkManager/system-connections/${INTERFACE}.nmconnection <<EOF
[connection]
id=${INTERFACE}
uuid=$(uuidgen)
type=ethernet
interface-name=${INTERFACE}
master=${INTERFACE}-port
slave-type=ovs-port
[ethernet]
[ovs-interface]
type=system
[802-3-ethernet]
mtu=${MTU}
EOF

cat > /etc/NetworkManager/system-connections/ovs-port-${INTERFACE}.nmconnection <<EOF
[connection]
id=port-${INTERFACE}
uuid=$(uuidgen)
type=ovs-port
interface-name=${INTERFACE}-port
master=ovsbr0
slave-type=ovs-bridge
[ovs-port]
[802-3-ethernet]
mtu=${MTU}
EOF

chmod 600 /etc/NetworkManager/system-connections/*
