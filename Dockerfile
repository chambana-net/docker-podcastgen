FROM chambana/uwsgi-php:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends unzip wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 80

VOLUME ["/var/www"]

ADD podcastgen.conf /etc/uwsgi/apps-available/podcastgen.conf

## Add startup script.
ADD bin/init.sh /opt/chambana/bin/init.sh
RUN chmod 0755 /opt/chambana/bin/init.sh

CMD ["/opt/chambana/bin/init.sh"]
