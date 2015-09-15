FROM ubuntu:14.04

EXPOSE 8001

RUN mkdir /docker-testing

ADD ./server /docker-testing/server

RUN chmod 755 /docker-testing/server

CMD ["/docker-testing/server","MAILSERVER_1_PORT_1080_TCP_ADDR","MAILSERVER_1_PORT_1025_TCP_PORT","HELLOWORLDSERVER_1_PORT_11988_TCP_ADDR","HELLOWORLDSERVER_1_PORT_11988_TCP_PORT"]
