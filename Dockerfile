FROM ubuntu:15.10

MAINTAINER takeshi.hirosue@bigtreetc.com

RUN apt-get update \
        && apt-get install -y software-properties-common \
        && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 \
        && add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main" 
RUN apt-get update 
RUN apt-get install -y hhvm \
        && apt-get install -y apache2 \
        && a2enmod proxy_http

ADD conf/hhvm_proxy_fcgi.conf /etc/apache2/mods-available/
ADD scripts/ /scripts/
RUN chmod 755 /scripts/*.sh \
        && rm /etc/apache2/sites-enabled/000-default.conf \
        && ln -s /etc/apache2/mods-available/hhvm_proxy_fcgi.conf /etc/apache2/sites-enabled/

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
