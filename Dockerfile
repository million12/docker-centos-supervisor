FROM centos:centos7
MAINTAINER Marcin Ryzycki marcin@m12.io, Przemyslaw Ozgo linux@ozgo.info

# - Install basic packages like wget, vi, tar, git etc
# - Install EPEL & Remi yum repository
# - Install supervisord (via python's easy_install - it has the newest 3.x version)
RUN \
  yum install -y epel-release wget yum-utils python-setuptools which vim-minimal tar && \
  yum update -y && \
  yum clean all && \
  
  rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
  yum-config-manager -q --enable remi && \

  easy_install supervisor && \
  mkdir -p /etc/supervisord.d /var/log/supervisor


# Bootstrap
RUN mkdir -p /config/init /config/data /config/temp
ADD config/ /config/

ADD supervisord.conf /etc/supervisord.conf

CMD ["/config/bootstrap.sh"]
