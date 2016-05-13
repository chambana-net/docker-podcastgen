FROM chambana/uwsgi-php:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends unzip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ADD podcastgen.conf /etc/uwsgi/apps-available/podcastgen.conf

EXPOSE 80

VOLUME ["/var/www"]

CMD ["/opt/chambana/bin/init.sh"]
