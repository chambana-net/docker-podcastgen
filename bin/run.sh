#!/bin/bash - 

. /app/lib/common.sh

CHECK_BIN "wget"
CHECK_BIN "unzip"
CHECK_BIN "uwsgi"
CHECK_VAR PODCASTGEN_VERSION

DIR=/var/www/PodcastGenerator-${PODCASTGEN_VERSION}

if [[ ! -d $DIR ]]; then
	MSG "Downloading podcastgen..."
	wget -O /tmp/podcastgen.zip \
		https://sourceforge.net/projects/podcastgen/files/podcastgen/podcastgen-${PODCASTGEN_VERSION}/podcastgen-${PODCASTGEN_VERSION}.zip/download
	[[ $? -eq 0 ]] || { ERR "Failed to download podcastgen, aborting."; exit 1; }
	unzip -o -d /var/www /tmp/podcastgen.zip
	[[ $? -eq 0 ]] || { ERR "Failed to unzip podcastgen, perhaps file is invalid?"; exit 1; }
	[[ -d $DIR ]] || { ERR "Directory $DIR does not exist, aborting."; exit 1; }
	chown -R www-data:www-data /var/www/
	sed -i -e "s#^php-docroot\ *=.*#php-docroot\ =\ ${DIR}#" \
		-e "s#^static-safe\ *=\ {{\ PODCASTGEN_DIR\ }}#static-safe\ =\ ${DIR}#" \
		/etc/uwsgi/apps-available/podcastgen.conf
fi

MSG "Serving site..."

exec "$@"
