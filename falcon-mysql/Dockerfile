#### falcon need mysql and redis
FROM  up/mysql:5.5
MAINTAINER XingHui,Hou<xinghui.hou@upai.com>

RUN  yum install -y git redis && \
     yum clean all

COPY db_install.sh /root/db_install.sh
COPY redis.tar.gz /root/redis.tar.gz

RUN  chmod +x /root/db_install.sh

VOLUME ["/date/mysql/"]

EXPOSE 3306 6380

CMD ["/usr/bin/bash", "/root/db_install.sh"]


