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
	unzip -o -f -d /var/www /tmp/podcastgen.zip
	[[ -d $DIR ]] || { ERR "Directory $DIR does not exist, aborting."; exit 1; }
	chown -R www-data:www-data /var/www/
fi

MSG "Serving site..."

exec "$@"
