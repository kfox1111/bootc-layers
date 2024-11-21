ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG USEROPS_NAME=userops
ARG USEROPS_UID=500

RUN \
  echo "u ${USEROPS_NAME} ${USEROPS_UID} ${USEROPS_NAME} /${USEROPS_NAME} /bin/bash" > /usr/lib/sysusers.d/userops.conf && \
  echo "m ${USEROPS_NAME} wheel" >> /usr/lib/sysusers.d/userops.conf && \
  echo "d /var/${USEROPS_NAME}home 0700 ${USEROPS_NAME} wheel - -" > /usr/lib/tmpfiles.d/userops.conf && \
  echo "d /var/${USEROPS_NAME}home/.ssh 0700 ${USEROPS_NAME} wheel - -" >> /usr/lib/tmpfiles.d/userops.conf && \
  echo "f /var/${USEROPS_NAME}home/.ssh/authorized_keys 0700 ${USEROPS_NAME} wheel -" >> /usr/lib/tmpfiles.d/userops.conf && \
  ln -s /var/${USEROPS_NAME}home /${USEROPS_NAME} && \
  semanage fcontext -a -t user_home_dir_t "/${USEROPS_NAME}" && \
  semanage fcontext -a -t user_home_dir_t "/var/${USEROPS_NAME}home" && \
  echo "${USEROPS_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USEROPS_NAME} && \
  chmod 600 /etc/sudoers.d/${USEROPS_NAME}
