FROM centos:7 as c7-systemd
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

FROM c7-systemd as dind
RUN yum -y update; \
yum install -y yum-utils; \
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo; \
yum makecache fast; \
yum install -y docker-ce docker-ce-cli containerd.io; \
systemctl enable docker; \
yum clean all; \
curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
chmod +x /usr/local/bin/docker-compose;

FROM dind as sandwich
ENV BASE_DIR="/home/dind"
COPY dind $BASE_DIR
RUN chmod +x $BASE_DIR/service-start.sh;
CMD ["/usr/sbin/init"]
