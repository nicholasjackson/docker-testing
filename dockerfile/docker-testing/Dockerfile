FROM progrium/busybox

EXPOSE 8001

RUN mkdir /docker-testing

ADD ./server /docker-testing/server

RUN chmod 755 /docker-testing/server

# consul-template
RUN opkg-install install wget tar

RUN wget --no-check-certificate https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_386.tar.gz
RUN tar -xvzf consul-template_0.10.0_linux_386.tar.gz
RUN mv consul-template_0.10.0_linux_386/consul-template /usr/bin/consul-template

# Add s6 binaries and config
ADD s6-bin /usr/bin
ADD s6-etc /etc/s6
RUN chmod -R 777 /usr/bin
RUN chmod -R 777 /etc/s6

# Add consul template
ADD config.ctmpl /docker-testing/config.ctmpl

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
CMD []
