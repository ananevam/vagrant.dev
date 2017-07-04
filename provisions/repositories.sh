#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# locale
if ! grep -q -F 'LC_ALL' /etc/default/locale; then
  grep -q -F 'LC_ALL' /etc/default/locale || echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
  apt-get install language-pack-ru
  locale-gen en_US en_US.UTF-8
  dpkg-reconfigure locales
fi

# Java repo
if [ ! -f /etc/apt/sources.list.d/webupd8team-java-trusty.list ]; then
  add-apt-repository ppa:webupd8team/java
fi

# Elastic repo
if [ ! -f /etc/apt/sources.list.d/elasticsearch-2.x.list ]; then
  wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
  tee /etc/apt/sources.list.d/elasticsearch-2.x.list > /dev/null 2>&1 <<EOF
deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
EOF
fi

# Sphinxsearch repo
#if [ ! -f /etc/apt/sources.list.d/builds-sphinxsearch-rel22-trusty.list ]; then
#  add-apt-repository ppa:builds/sphinxsearch-rel22
#fi

# Mongodb repo
if [ ! -f /etc/apt/mongodb-org-3.2.list ]; then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
fi

apt-get update

exit 0
