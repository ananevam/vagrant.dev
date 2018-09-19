#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# locale
if ! grep -q -F 'LC_ALL' /etc/default/locale; then
  grep -q -F 'LC_ALL' /etc/default/locale || echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
  apt-get install language-pack-ru
  locale-gen en_US en_US.UTF-8
  dpkg-reconfigure locales
fi

if [ ! -f /etc/apt/sources.list.d/yarn.list ]; then
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
fi

apt-get update

exit 0
