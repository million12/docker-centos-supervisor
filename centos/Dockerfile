FROM centos:centos7

ENV SUPERVISOR_VERSION=4.0.2

RUN \
  rpm --rebuilddb && yum clean all; \
  yum install -y epel-release; \
  yum update -y; \
  yum install -y \
    iproute \
    python-setuptools \
    hostname \
    inotify-tools \
    yum-utils \
    which \
    jq \
    rsync \
    telnet \
    htop \
    atop \
    iotop \
    mtr \
    vim && \
  yum clean all && rm -rf /tmp/yum*; \
  easy_install pip; \
  pip install supervisor==${SUPERVISOR_VERSION}

ADD container-files /

VOLUME ["/data"]

ENTRYPOINT ["/config/bootstrap.sh"]

EXPOSE 9111
