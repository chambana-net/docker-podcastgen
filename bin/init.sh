#!/bin/bash - 

. /opt/chambana/lib/common.sh

CHECK_BIN "wget"
CHECK_BIN "unzip"
CHECK_BIN "uwsgi"

DIR=/var/www/PodcastGenerator-Master

if [[ ! -d $DIR ]]; then
	MSG "Downloading podcastgen..."
	wget -O /tmp/podcastgen.zip https://sourceforge.net/projects/podcastgen/files/latest/download
	[[ $? -eq 0 ]] || { ERR "Failed to download podcastgen, aborting."; exit 1; }
	unzip -d /var/www /tmp/podcastgen.zip
	[[ -d $DIR ]] || { ERR "Directory $DIR does not exist, aborting."; exit 1; }
	chown -R www-data:www-data /var/www/
fi

MSG "Serving site..."
uwsgi --uid www-data --gid www-data --ini /etc/uwsgi/apps-available/podcastgen.conf
