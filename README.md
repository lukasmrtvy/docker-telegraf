# telegraf

`sudo docker rm -f telegraf; sudo docker run -d -e TZ=Europe/Prague --name telegraf --net host -v /:/hostfs:ro -e HOST_MOUNT_PREFIX=/hostfs -e HOST_ETC=/hostfs/etc  -v /var/run/utmp:/var/run/utmp:ro  -v /var/run/docker.sock:/var/run/docker.sock:ro mytelegraf`
