#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Misk
if ! dpkg -l htop > /dev/null 2>&1; then
  # apt-get install -y build-essential patch htop mc

  # for nokigiri
  apt-get -y install libxml2-dev zlib1g-dev liblzma-dev libgmp-dev libxslt1-dev

  # GIT
  apt-get -y install git

  # Imagemagick
  apt-get -y install libmagickwand-dev imagemagick

  # For ruby
  apt-get -y install libssl-dev libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev

  # TagLib Audio Meta-Data Library
  apt-get -y install libtag1-dev

  apt-get -y install docker.io

  apt-get -y install yarn

  sysctl -w vm.max_map_count=262144

  docker run --name elastic6 --restart unless-stopped -d -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:6.4.0
  docker run --name thumbor --restart unless-stopped -d -p 8888:80 minimalcompact/thumbor
fi

exit 0
