#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Misk
if ! dpkg -l git > /dev/null 2>&1; then
  apt-get install -y build-essential patch htop mc

  # for nokigiri
  apt-get -y install libxml2-dev zlib1g-dev liblzma-dev libgmp-dev libxslt1-dev

  # GIT
  apt-get -y install git

  # Imagemagick
  apt-get -y install libmagickwand-dev imagemagick

  # For ruby
  apt-get -y install libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev

  # TagLib Audio Meta-Data Library
  apt-get -y install libtag1-dev
fi

# Geo package
if [ ! -f /usr/share/GeoIP/GeoLiteCity.dat ]; then
  wget --no-verbose -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
  gunzip GeoLiteCity.dat.gz
  test -d /usr/share/GeoIP || mkdir /usr/share/GeoIP
  mv GeoLiteCity.dat /usr/share/GeoIP/
fi

# Java
if ! dpkg -l oracle-java7-installer > /dev/null 2>&1; then
   # accept licence
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
  apt-get -y install oracle-java7-installer
fi

exit 0
