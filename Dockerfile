FROM chambana/uwsgi-php:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends ca-certificates unzip wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 80

VOLUME ["/var/www"]

ADD podcastgen.conf /etc/uwsgi/apps-available/podcastgen.conf

## Add startup script.
ADD bin/init.sh /app/bin/init.sh
RUN chmod 0755 /app/bin/init.sh

CMD ["/app/bin/init.sh"]
