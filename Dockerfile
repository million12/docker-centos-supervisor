FROM centos:centos7
MAINTAINER Marcin Ryzycki marcin@m12.io, Przemyslaw Ozgo linux@ozgo.info

# - Install basic packages like wget, vi, tar, git etc
# - Install EPEL & Remi yum repository
# - Install supervisord (via python's easy_install - it has the newest 3.x version)
RUN \
  yum install -y wget yum-utils && \

  wget -q http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
  rpm -Uvh remi-release-*.rpm epel-release-*.rpm && \
  rm -f remi-release-*.rpm epel-release-*.rpm && \
  
  yum-config-manager -q --enable remi && \

  yum update -y && \

  yum install -y python-setuptools which vim-minimal tar && \
  yum clean all && \

  easy_install supervisor && \
  mkdir -p /etc/supervisord.d /var/log/supervisor


# Bootstrap
RUN mkdir -p /config/init /config/data /config/temp
ADD config/ /config/

ADD supervisord.conf /etc/supervisord.conf

CMD ["/config/bootstrap.sh"]
