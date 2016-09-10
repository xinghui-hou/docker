#
# docker shadowsocks 
# will install shadowsocks-2.8.2 and  supervisor-3.3.1
FROM       centos:centos7.1.1503
MAINTAINER XingHui,Hou<xinghui.hou@upai.com>

RUN yum install -y epel-release && \
    yum install -y python-setuptools m2crypto python-pip libsodium && \
    yum clean all  

RUN pip install supervisor && \
    pip install shadowsocks 

RUN mkdir -p /etc/supervisor.d && \
    mkdir -p /disk/ssd1/logs/supervisor

ADD supervisord.conf /etc/supervisord.conf 
ADD shadows.conf /etc/supervisor.d/shadows.conf
ADD shadowsocks.json /etc/shadowsocks.json
ADD shadow-chacha.json  /etc/shadow-chacha.json 

EXPOSE 8888
EXPOSE 8889

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
