# CentOS-7 with supervisord launcher

This is a CentOS-7 Docker [million12/centos-supervisor](https://registry.hub.docker.com/u/million12/centos-supervisor/) image, perfect in case when you need to launch more then one process inside a container. This image is based on official [centos:centos7](https://registry.hub.docker.com/_/centos/) and it adds only ca. 20MB on top of it.

Things included:

##### - init scripts

Add your .sh scripts to `/config/init` to have them executed when container starts. The bootstrap script is configured to run them just before supervisord starts. See [million12/nginx](https://github.com/million12/docker-nginx) for examples.

##### - supervisord

Just add you supervisord config(s) to `/etc/supervisor.d/` directory to launch your service. For example in your `Dockerfile` you could put:  
```ADD my-supervisord-service.conf /etc/supervisord.d/my-supervisord-service.conf```

Learn more about about [supervisord inside containers on official Docker documentation](https://docs.docker.com/articles/using_supervisord/).

##### - error logging

Logfile for supervisord is switched off to avoid logging inside container. Instead, all logs are easily available via `docker logs [container name]`.

This is probably the best approach if you'd like to source your logs from outside the container via `docker logs` (also via CoreOS `journald') and you don't want to worry about logging and log management inside your container and/or data volume.

##### - /data volume

The `/data` directory is meant to be used to simply and easily deploy web applications using a volume binding on `/data`, presumably using [data only containers](https://docs.docker.com/userguide/dockervolumes/) pattern.

Recommended structure:  
```
/data/run/ # pid, sockets
/data/conf/ # extra configs for your services
/data/logs/ # logs
/data/www/ # your web application data
```


## Usage

This container is configured to run your service(s) both in interactive and non-interactive mode (see [bootstrap.sh](config/init/bootstrap.sh) script).
  
`docker run -it million12/centos-supervisor` (interactive)  
`docker run -d million12/centos-supervisor` (detached, non-interactive)


## Build

`docker build --tag=million12/centos-supervisor`


## Author

Author: Marcin Ryzycki (<marcin@m12.io>)  
Author: Przemyslaw Ozgo (<linux@ozgo.info>)

This work is also inspired by [maxexcloo](https://github.com/maxexcloo)'s work on his [docker images](https://github.com/maxexcloo/Docker). Thanks!
