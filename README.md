# telegraf

## Info:
Based on Alpine:latest

Kudos to benningm

## Usage:
`sudo docker rm -f telegraf; sudo docker run -d -e TZ=Europe/Prague --name telegraf --net host -v /:/hostfs:ro -e HOST_MOUNT_PREFIX=/hostfs -e HOST_ETC=/hostfs/etc  -v /var/run/utmp:/var/run/utmp:ro  -v /var/run/docker.sock:/var/run/docker.sock:ro -v telegraf:/config mytelegraf`

```
  -e 'NETATMO_CLIENT_ID=<hex-value>'
  -e 'NETATMO_CLIENT_SECRET=<hex-value>'
  -e 'NETATMO_USERNAME=<email>
  -e 'NETATMO_PASSWORD=<secret>'
  -e 'NETATMO_DEVICE_ID=<station MAC>'
  ```
