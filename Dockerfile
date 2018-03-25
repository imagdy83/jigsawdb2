FROM centos:centos7
ADD ./db2.tar.gz /tmp
RUN sh /tmp/server_awse_o/extras/copy.sh && cd /tmp/server_awse_o/extras/ && yum clean all && yum install -y glibc-2.17-196.el7_4.2.x86_64 libXp-1.0.2-2.1.el7.x86_64 libXau-1.0.8-2.1.el7.x86_64 libXext-1.3.3-3.el7.x86_64 libX11-1.6.5-1.el7.x86_64 libxcb-1.12-1.el7.x86_64 libXmu-1.1.2-2.el7.x86_64 nss-softokn-freebl-3.28.3-8.el7_4.x86_64 glibc-2.17-196.el7_4.2.i686 compat-libstdc++-33-3.2.3-72.el7.i686.rpm compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm pam-1.1.8-18.el7.i686 libstdc++-4.8.5-16.el7_4.1.i686 libaio-0.3.109-13.el7.i686 libaio-0.3.109-13.el7.x86_64 numactl-libs-2.0.9-6.el7_2.i686 numactl-libs-2.0.9-6.el7_2.x86_64 && yum clean all && setenforce=0 && groupadd db2iadm1 && useradd db2inst1 -g db2iadm1 && /tmp/server_awse_o/db2setup -r db2server.rsp /bin/su -c "db2licm -a /db2/license/db2awse_o.lic" - db2inst1 && rm -rf /tmp/*
ENV PATH="/SETUP/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" LD_LIBRARY_PATH="/home/db2inst1/sqllib/lib64:/home/db2inst1/sqllib/lib64/gskit:/home/db2inst1/sqllib/lib32" DB2INST1_PASSWORD="passw0rd"
RUN echo "hyveP@ssw0rd" | passwd --stdin root && echo "0 jigsawdb2 0" > /home/db2inst1/sqllib/db2nodes.cfg && chmod +x entrypoint.sh
ENTRYPOINT ["/bin/bash","./entrypoint.sh"]
CMD ["start"]

EXPOSE 50000
