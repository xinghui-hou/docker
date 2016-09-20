## mysql docker 
FROM centos:centos7.1.1503
MAINTAINER XingHui,Hou<xinghui.hou@upai.com>

ENV DATA_DIR /date/mysql/date
ENV DATE_LOG /date/mysql/log

RUN yum install -y wget tar libaio hostname  && yum clean all

COPY  install_mysql5.5.sh /root/install_mysql5.5.sh
COPY  mysqld_start /etc/init.d/mysql 

RUN chmod +x /root/install_mysql5.5.sh && \ 
    /usr/bin/bash /root/install_mysql5.5.sh && \
    chmod +x /etc/init.d/mysql  
    

VOLUME ["/date/mysql/"]

EXPOSE 3306 

CMD  ["/usr/bin/bash", "/etc/init.d/mysql"]
