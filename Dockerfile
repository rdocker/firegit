FROM comdeng/nginx
MAINTAINER ronnie <comdeng@live.com>

# install fcgiwrap
RUN \
    cd /opt/ &&\
    curl  https://github.com/gnosek/fcgiwrap/archive/master.zip -L -o fcgiwrap.zip &&\
    yum -y install unzip &&\
    unzip fcgiwrap.zip &&\
    curl http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm -o epel-release.rpm &&\
    rpm -Uvh epel-release.rpm &&\
    yum -y install fcgi-devel autoconf automake gcc &&\
    cd /opt/fcgiwrap-master &&\
    autoreconf -i &&\
    ./configure --prefix=/opt/fcgiwrap &&\
    make install &&\
    cd /opt/ &&\
    rm fcgiwrap.zip fcgiwrap-master epel-release.rpm -rf &&\
    \
    cd /opt/ &&\
    yum -y install tar openssl-devel libcurl-devel expat-devel perl-CPAN tcl tk gettext &&\
    curl https://github.com/git/git/archive/v2.8.1.tar.gz -L -o git.tar.gz &&\
    tar xvfz git.tar.gz &&\
    cd /opt/git-2.8.1 &&\
    make install &&\
    rm /opt/git.tar.gz &&\
    yum -y erase unzip tar gcc openssl-devel libcurl-devel expat-devel perl-CPAN perl-devel tcl tk gettext autoconf fcgi-devel &&\
    yum clean all
#ENTRYPOINT ["/opt/php/sbin/php-fpm","--nodaemonize"]
