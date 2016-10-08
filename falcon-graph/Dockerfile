##
## open-falcon docker (graph ,judge,hbs,query)
#
FROM  centos:centos7.1.1503
MAINTAINER XingHui,Hou<xinghui.hou@upai.com>

RUN yum install -y epel-release && \
    yum install -y python-setuptools m2crypto python-pip && \
    yum clean all

RUN pip install supervisor

RUN mkdir -p /etc/supervisor.d && \
    mkdir -p /disk/ssd1/logs/supervisor/logs/supervisor && \
    mkdir -p /usr/local/open-falcon/config 

ADD soft/open-falcon.tar.gz /usr/local/ 
ADD ./config /usr/local/open-falcon/config/
ADD ./config/falcon.conf /etc/supervisor.d/
ADD ./config/supervisord.conf /etc/

EXPOSE 6070 6080 6030 8433

VOLUME ["/disk/ssd1/"]


CMD ["/usr/bin/supervisord", "-n" , "-c", "/etc/supervisord.conf"]


