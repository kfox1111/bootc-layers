ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

ARG USEROPS_NAME=userops
ARG USEROPS_UID=500

RUN \
  dnf install -y policycoreutils-python-utils && \
  mkdir -p /usr/lib/userdb && \
  echo '{"userName": "'${USEROPS_NAME}'", "uid": '${USEROPS_UID}', "memberOf": "wheel", "disposition": "regular"}' > /usr/lib/userdb/${USEROPS_NAME}.user && \
  ln -s ${USEROPS_NAME}.user /usr/lib/userdb/${USEROPS_UID}.user && \
  echo "d /var/${USEROPS_NAME}home 0700 ${USEROPS_NAME} wheel - -" > /usr/lib/tmpfiles.d/${USEROPS_NAME}.conf && \
  echo "d /var/${USEROPS_NAME}home/.ssh 0700 ${USEROPS_NAME} wheel - -" >> /usr/lib/tmpfiles.d/${USEROPS_NAME}.conf && \
  echo "z /var/${USEROPS_NAME}home/.ssh 0700 ${USEROPS_NAME} wheel - -" >> /usr/lib/tmpfiles.d/${USEROPS_NAME}.conf && \
  echo "f /var/${USEROPS_NAME}home/.ssh/authorized_keys 0700 ${USEROPS_NAME} wheel -" >> /usr/lib/tmpfiles.d/${USEROPS_NAME}.conf && \
  echo "z /var/${USEROPS_NAME}home/.ssh/authorized_keys 0700 ${USEROPS_NAME} wheel - -" >> /usr/lib/tmpfiles.d/${USEROPS_NAME}.conf && \
  ln -s /var/${USEROPS_NAME}home /${USEROPS_NAME} && \
  semanage fcontext -a -t user_home_dir_t "/${USEROPS_NAME}" && \
  semanage fcontext -a -t user_home_dir_t "/var/${USEROPS_NAME}home" && \
  semanage fcontext -a -t ssh_home_t "/var/${USEROPS_NAME}home/.ssh" && \
  semanage fcontext -a -t ssh_home_t "/var/${USEROPS_NAME}home/.ssh/authorized_keys" && \
  mkdir -p /var/${USEROPS_NAME}home/.ssh && \
  touch /var/${USEROPS_NAME}home/.ssh/authorized_keys && \
  echo "${USEROPS_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USEROPS_NAME} && \
  chmod 600 /etc/sudoers.d/${USEROPS_NAME} && \
  echo "PermitRootLogin no" > /etc/ssh/sshd_config.d/10-nologin.conf
