ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM docker.io/library/golang:1.23-bookworm as go
ARG OVS_CNI_VER=v0.35.0

RUN \
  apt-get update && \
  apt-get install -y jq && \
  cd /tmp && \
  curl -L -o ovs.tgz https://github.com/k8snetworkplumbingwg/ovs-cni/archive/refs/tags/v0.35.0.tar.gz && \
  tar -xvf ovs.tgz && \
  cd ovs* && \
  cd cmd && \
  echo building... && \
  go build plugin/main.go && \
  mv main /ovs

FROM $BASE
COPY --from=go /ovs /ovs
