##
## open-falcon docker (graph ,judge,hbs,query)
#
FROM  centos:centos6
MAINTAINER XingHui,Hou<xinghui.hou@upai.com>

RUN yum install -y epel-release && \
    yum install -y mysql python-setuptools m2crypto python-pip python-virtualenv  && \
    yum clean all

RUN mkdir -p /disk/ssd1/falcon/dashboard/

ADD soft/falcon-query.tar.gz /usr/local/ 

EXPOSE 8081  5050  9966
VOLUME ["/date/falcon"]

CMD /usr/local/open-falcon/dashboard/control start ; /usr/local/open-falcon/portal/control start ;/usr/local/open-falcon/query/control start
#CMD ["/usr/local/open-falcon/dashboard/control", "start"]
#CMD ["/usr/local/open-falcon/portal/control", "start"]
#CMD ["/usr/local/open-falcon/query/control", "start"]


