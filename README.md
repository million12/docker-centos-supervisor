# CentOS-7 with supervisord launcher

This is a CentOS-7 docker image used as a base image for other MILLION12 container. It is available on Docker registry as [million12/centos](https://registry.hub.docker.com/u/million12/centos/). This image is based on official [centos:centos7](https://registry.hub.docker.com/_/centos/) and it adds only ca. 20MB on top of it.

Things included:

##### - yum: EPEL and Remi repos included/enabled

##### - init scripts

Add your .sh scripts to `/config/init` to have them executed when container starts. The bootstrap script is configured to run them just before supervisord starts. See [million12/nginx](https://github.com/million12/docker-nginx) for examples.


##### - supervisord

Just add you supervisord config(s) to `/etc/supervisor.d/` directory to launch your service. For example in your `Dockerfile` you could put:  
```ADD my-supervisord-service.conf /etc/supervisord.d/my-supervisord-service.conf```

Learn more about about [supervisord inside containers on official Docker documentation](https://docs.docker.com/articles/using_supervisord/).

##### - /data volume

The `/data` directory is meant to be used to simply and easily deploy web applications using a volume binding on `/data`, presumably using [data only containers](https://docs.docker.com/userguide/dockervolumes/) pattern.

Recommended structure:  
```
/data/run/ # pid, sockets to easily control running services (e.g. supervisord)
/data/conf/ # extra configs for your services
/data/logs/ # logs
/data/www/ # you application data
```


## Usage

This container is configured to run your service(s) both in interactive and non-interactive mode (see [bootstrap.sh](config/init/bootstrap.sh) script).
  
`docker run -it million12/centos` (interactive)  
`docker run -d million12/centos` (detached, non-interactive)

#### Controlling supervisord

Supervisord is configured so it uses socket in /data/run/supervisord.sock. Therefore, when using data-only containers you can control it from other container, which has supervisorctl client installed. For instance:  
```
# Run your web app as usually:
docker run -d -v /data --name=web-data busybox
docker run -d --volumes-from=web-data -p=80:80 million12/nginx

# Now run any interactive container (with supervisorctl client installed):
docker run -ti --volumes-from=web-data million12/centos
$ supervisorctl status nginx
$ supervisorctl tail nginx
```

## Build

`docker build --tag=million12/centos`


## Author

Author: ryzy (<marcin@m12.io>)  
Author: pozgo (<linux@ozgo.info>)  
This work is significantly inspired by [maxexcloo](https://github.com/maxexcloo)'s work on his [docker images](https://github.com/maxexcloo/Docker).
