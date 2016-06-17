docker-podcastgen
=================
A docker container for installing and running [Podcast Generator](http://podcastgenerator.net).

Usage
-----
This container simple downloads the newest version of Podcast Generator and installs it into a volume mounted inside the container at `/var/www`, then serves it on port 80. Follow the standard Podcast Generator setup process to configure it.
