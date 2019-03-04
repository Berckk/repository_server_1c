# Сервер хранилища 1С 8.3
#
FROM i386/debian:stretch-slim
MAINTAINER asda.ru (Andrey Mamaev)

ENV DIST deb_8_3_13_1644.tar.gz 


RUN apt-get update && apt-get install -y \
	wget


ENV SRV1CV8_REPOSITORY /opt/1C/repository

RUN mkdir /opt/dist && cd /opt/dist/ \
	&& wget http://casa.ru/${DIST} --no-check-certificate \
	&& tar xzf ${DIST} && dpkg -i *.deb && rm -rf *
	
RUN mkdir -p /var/log/1c/dumps && chmod -R 777 /var/log/1c

COPY run.sh /
RUN chmod +x /run.sh
RUN mkdir ${SRV1CV8_REPOSITORY}
RUN chmod 777 ${SRV1CV8_REPOSITORY}


VOLUME ${SRV1CV8_REPOSITORY}

EXPOSE 1542
CMD ["/run.sh"]
