ARG BASE=quay.io/almalinuxorg/almalinux-bootc:9

FROM $BASE

RUN \
  echo ChallengeResponseAuthentication no > /etc/ssh/sshd_config.d/50-nopasswd.conf && \
  echo PasswordAuthentication no >> /etc/ssh/sshd_config.d/50-nopasswd.conf && \
  echo UsePAM no >> /etc/ssh/sshd_config.d/50-nopasswd.conf
