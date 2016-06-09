#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Oh my zsh
if ! dpkg -l zsh > /dev/null 2>&1; then
  sudo apt-get -y install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sudo chsh -s $(which zsh) $USER
fi

# Меняем тему по умолчанию что бы не путаться где находишься
sed -i -E 's/(^ZSH_THEME.+$)/ZSH_THEME="gentoo"/g' ~/.zshrc
sed -i -E 's/(^plugins=.+$)/plugins=(git bundler)/g' ~/.zshrc

# Nvm
if [ ! -d ~/.nvm/ ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
  grep -q -F 'export NVM_DIR' ~/.zshrc || echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
  grep -q -F '[ -s "$NVM_DIR/nvm.sh" ]' ~/.zshrc || echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zshrc

  source ~/.nvm/nvm.sh

  nvm install 5.0
  npm install -g bower
fi

# Rbenv
if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.zshrc
  echo 'eval "$(rbenv init -)"' >> /home/vagrant/.zshrc

  export RBENV_ROOT=/home/vagrant/.rbenv
  export PATH=${RBENV_ROOT}/bin:$PATH

  eval "$(rbenv init)"

  rbenv install 2.1.4
  rbenv local 2.1.4
  gem install bundle

  rbenv install 2.2.4
  rbenv local 2.2.4
  gem install bundle

  rbenv global 2.2.4

  rbenv rehash
fi

exit 0
