FROM debian:jessie

MAINTAINER Lucas Saboya <lucas.saboya@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ORACLE_HOME "/u01/app/oracle/product/11.2.0/xe"
ENV PATH $ORACLE_HOME/bin:$PATH
ENV ORACLE_SID XE


ADD assets /assets

RUN cat /assets/oracle-xe_11.2.0-1.0_amd64.deba* > /assets/oracle-xe_11.2.0-1.0_amd64.deb

RUN apt-get update && \
apt-get install libaio1 net-tools bc -y && \
ln -s /usr/bin/awk /bin/awk && \
mv /assets/chkconfig /sbin/chkconfig && \
mkdir /var/lock/subsys && \
chmod 755 /sbin/chkconfig

RUN dpkg --install /assets/oracle-xe_11.2.0-1.0_amd64.deb

RUN cp /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora.tmpl && \
cp /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora.tmpl


RUN mv /assets/init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts && \
mv /assets/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

RUN printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure

RUN mv /assets/start.sh /usr/sbin/start.sh
RUN chmod +x /usr/sbin/start.sh

RUN rm -r /assets/ && \
/var/cache/apt/ && \
/var/lib/apt/lists/

RUN apt-get clean

EXPOSE 1521

CMD ["/usr/sbin/start.sh"]
