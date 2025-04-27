ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE
RUN \
  cp -a /usr/share/raspberrypi2-kernel*/*/boot/bcm2712-rpi-5-b.dtb $(readlink -f /usr/lib/modules/*/)/devicetree
