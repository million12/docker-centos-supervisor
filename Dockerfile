FROM centos:centos7
MAINTAINER Marcin Ryzycki marcin@m12.io, Przemyslaw Ozgo linux@ozgo.info

# - Install basic packages needed by supervisord
# - Install inotify, needed to automate daemon restarts after config file changes
# - Install supervisord (via python's easy_install - as it has the newest 3.x version)
RUN \
  yum install -y epel-release python-setuptools && \
  yum install -y inotify-tools && \
  yum update -y && \
  yum clean all && \

  easy_install supervisor

# Add supervisord conf, bootstrap.sh files
ADD container-files /

VOLUME ["/data"]

ENTRYPOINT ["/config/bootstrap.sh"]
