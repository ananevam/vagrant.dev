# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_APP_DOMAIN = "vagrant.dev"
VAGRANT_HOSTNAME = "vagrant"
VAGRANT_IP = '192.168.10.202'

Vagrant.configure(2) do |config|
  # config.vm.provider :virtualbox do |vb|
  #   vb.gui = true
  # end

  config.vm.box = "ubuntu/bionic64"

  config.disksize.size = '50GB'

  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # Rails
  config.vm.network :forwarded_port, guest: 3808, host: 3808 # webpack
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # Mysql
  config.vm.network :forwarded_port, guest: 5432, host: 5432 # Postgresql
  config.vm.network :forwarded_port, guest: 3001, host: 3001 # Gulp server
  config.vm.network :forwarded_port, guest: 9000, host: 9000 # Gulp server
  config.vm.network :forwarded_port, guest: 8888, host: 8888 # thumbor
  config.vm.network :forwarded_port, guest: 9200, host: 9200 # Elasticsearch
  config.vm.network :forwarded_port, guest: 8083, host: 8083 # influxdb admin
  config.vm.network :forwarded_port, guest: 8086, host: 8086 # influxdb
  config.vm.network :forwarded_port, guest: 8123, host: 8123 # clickhouse
  config.vm.network :forwarded_port, guest: 3035, host: 3035 # webpack dev server
  config.vm.network :forwarded_port, guest: 8050, host: 8050
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # https://github.com/tabixio/tabix
  config.vm.network :forwarded_port, guest: 8001, host: 8001 # https://rdbtools.com/docs/install/docker/


  config.vm.network :private_network, ip: VAGRANT_IP
  config.vm.hostname = VAGRANT_HOSTNAME

  config.vm.synced_folder './code', '/home/vagrant/code', type: 'nfs_guest'

  config.vm.provider :virtualbox do |vm|
    vm.customize ["modifyvm", :id, "--name", 'vagrant_dev']
    vm.customize ["modifyvm", :id, "--memory", ENV['VM_MEM'] ? ENV['VM_MEM'].to_i : 6144]
    vm.customize ["modifyvm", :id, "--cpus", 2]
  end

  config.vm.provision "shell", path: 'provisions/repositories.sh'
  config.vm.provision "shell", path: 'provisions/packages.sh'
  config.vm.provision "shell", path: 'provisions/db.sh'
  config.vm.provision "shell", path: 'provisions/env.sh', privileged: false

  # config.ssh.pty = false
end
