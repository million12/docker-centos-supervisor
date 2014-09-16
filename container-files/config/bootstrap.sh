#!/bin/bash

set -e

# Create directories for supervisor's UNIX socket and logs (which might be missing
# as container might start with /data mounted from another data-container).
mkdir -p /data/run /data/logs

if [ "$(ls /config/init/)" ]; then
  for init in /config/init/*.sh; do
    . $init
  done
fi


SUPERVISOR_PARAMS='-c /etc/supervisord.conf'

# Do we have TTY?
if test -t 0; then
  supervisord $SUPERVISOR_PARAMS
  while true; do
    # echo "Exit supervisorctl with Ctrl-D. Detach with Ctrl-P + Ctrl-Q."
    # supervisorctl $SUPERVISOR_PARAMS
    echo "Exit shell with Ctrl-D. Detach with Ctrl-P + Ctrl-Q."
    export PS1='[\u@\h : \w]\$ '
    bash
  done
fi

# Run supervisord in foreground when no TTY
supervisord -n $SUPERVISOR_PARAMS
