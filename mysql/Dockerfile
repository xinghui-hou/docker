## mysql docker 
FROM centos:centos7.1.1503
MAINTAINER XingHui,Hou<xinghui.hou@upai.com>

ENV DATA_DIR /date/mysql/date
ENV DATE_LOG /date/mysql/log

RUN yum install -y  git wget tar libaio  && yum clean all
COPY  install_mysql5.5.sh /root/install_mysql5.5.sh

RUN chmod +x /root/install_mysql5.5.sh
RUN /usr/bin/bash /root/install_mysql5.5.sh

EXPOSE 3306 

VOLUME ["/date/mysql/"]

ENTRYPOINT ["/etc/init.d/mysqld restart"]
