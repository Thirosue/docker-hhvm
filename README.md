# docker-hhvm

[![](https://images.microbadger.com/badges/image/mirrored1976/hhvm.svg)](https://microbadger.com/images/mirrored1976/hhvm "Get your own image badge on microbadger.com")

## RUN Not FastCGI
```
#start script replace
$ cp sample/start.sh scripts/
$ docker build -t hhvm .
$ docker run -p 9000:9000 -d --name hhvm hhvm

#add phpinfo to app root
$ docker cp sample/phpinfo.php hhvm:/app/

#test
$ curl http://localhost:9000/phpinfo.php
```

## Type Check Test
```
#run background container (client pc)
$ docker run -p 9000:9000 -d --name hhvm hhvm

#add error smaple to app root (client pc)
$ docker cp sample/error.hh hhvm:/app/

#enter container (client pc)
$ docker exec -ti hhvm /bin/bash

#run NG (container)
$ hhvm /app/error.hh

Catchable fatal error: Hack type error: Invalid return type at /app/error.hh line 4

#hh_client check NG (This creates an empty file that hh_client looks for as the root of your code to being typechecking.)
$ cd /app/ ; hh_client ; echo $?
error.hh:4:10,29: Invalid return type (Typing[4110])
  error.hh:3:15,17: This is an int
  error.hh:4:10,29: It is incompatible with a string
2

#add ok smaple to app root (client pc)
$ docker cp sample/ok.hh hhvm:/app/

#run OK (container)
$ rm /app/error.hh ; hhvm /app/ok.hh
ok! I am string

#hh_client check OK
$ cd /app/ ; hh_client ; echo $?
No errors!
0
```
