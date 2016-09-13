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
    mkdir -p /disk/ssd1/logs/supervisor

