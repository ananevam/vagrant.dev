#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Redis
if ! dpkg -l redis-server > /dev/null 2>&1; then
  apt-get -y install memcached redis-server
fi

# Elasticsearch
# if ! dpkg -l elasticsearch > /dev/null 2>&1; then
#   apt-get -y install elasticsearch=2.3.3
#   update-rc.d elasticsearch defaults 95 10
#   test -d /usr/share/elasticsearch/plugins/elasticsearch-analysis-morphology || /usr/share/elasticsearch/bin/plugin install http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/2.3.3/elasticsearch-analysis-morphology-2.3.3.zip
#   service elasticsearch start
# fi

# Sphinxsearch
# if ! dpkg -l sphinxsearch > /dev/null 2>&1; then
#   apt-get install -y sphinxsearch
# fi

# Mongodb
# if ! dpkg -l mongodb-org > /dev/null 2>&1; then
#   apt-get install -y mongodb-org
# fi

# Postgresql
# if ! dpkg -l postgresql > /dev/null 2>&1; then
#   apt-get -y install postgresql postgresql-contrib libpq-dev
#
#   service postgresql restart
#   createuser vagrant -U postgres -s
# fi
# tee /etc/postgresql/9.3/main/pg_hba.conf > /dev/null 2>&1 <<EOF
# local   all             postgres                                trust
# local   all             all                                     trust
# # host    all             all             127.0.0.1/32            trust
# # host    all             all             ::1/128                 trust
# host    all       all   0.0.0.0/0     trust
# EOF
# grep -q -F "listen_addresses = '*'" /etc/postgresql/9.3/main/postgresql.conf || echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf
#
#
# service postgresql restart

# Mysql
if ! dpkg -l mysql-server > /dev/null 2>&1; then
  debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
  debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
  apt-get -y install mysql-server mysql-client libmysqlclient-dev
fi

exit 0
