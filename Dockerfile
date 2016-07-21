FROM ubuntu:15.10

MAINTAINER takeshi.hirosue@bigtreetc.com

RUN apt-get update \
        && apt-get install -y software-properties-common \
        && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 \
        && add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main" 
RUN apt-get update 
RUN apt-get install -y hhvm 

ADD scripts/ /scripts/
RUN chmod 755 /scripts/*.sh

EXPOSE 9000

CMD ["/scripts/start.sh"]

