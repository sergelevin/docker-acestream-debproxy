docker-acestream-debproxy
=========================

Debian based docker image for aceproxy.

##Installation

First, install docker into your system. Instructions on how to install docker can be found on https://docs.docker.com/

Then you should:

1. Build the image
  ```
  docker build -t sergelevin/acestream-debproxy git://github.com/sergelevin/docker-acestream-debproxy.git
  ```

  OR download the pre-built one, this should be faster
  ```
  docker pull sergelevin/acestream-debproxy:latest
  ```

2. Create the container based on downloaded or built image
  ```
  docker create --name=aceproxy -p 8000:8000 -v /etc/aceproxy:/etc/aceproxy:ro sergelevin/acestream-debproxy
  ```

3. If you have any configuration files for the aceproxy, put them to /etc/aceproxy on the host. aceconfig.py will be used as main config file and plugin-specific config files will be automatically copied to plugins/conf within the docker image upon start. Since these files might contain sensitive information (e.g. passwords) make sure noone but root can read them.


##Usage

Start the container
```
docker start aceproxy
```

Then you could copy the following URL into your player to get the playlist
```
http://[SERVER_IP]:8000/channels/?type=m3u
```

Further instrustions on configuring and using aceproxy could be found here: https://github.com/ValdikSS/aceproxy/wiki

##Acknowledgements

Thanks to ValdikSS for [aceproxy](https://github.com/ValdikSS/aceproxy/).
Thanks to ikatson for [ubuntu based aceproxy container](https://github.com/ikatson/docker-acestream-proxy) which was used as a sample to create debian-based one.

