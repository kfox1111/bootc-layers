ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

ARG OVS_CNI_VER=v0.38.0
FROM ghcr.io/k8snetworkplumbingwg/ovs-cni-plugin:${OVS_CNI_VER} as driver

FROM $BASE
COPY --from=driver /ovs /etc/cni/bin/ovs
