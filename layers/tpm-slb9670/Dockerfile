ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
RUN \
  cd /tmp && \
  md5sum /usr/lib/modules/*/devicetree && \
  cp /usr/lib/modules/*/devicetree dtb.orig && \
  dtmerge dtb.orig /usr/lib/modules/*/devicetree /usr/share/raspberrypi2-kernel*/*/boot/overlays/tpm-slb9670.dtbo spi=on && \
  rm dtb.orig && \
  md5sum /usr/lib/modules/*/devicetree
