# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_APP_DOMAIN = "vagrant.dev"
VAGRANT_HOSTNAME = "vagrant"
VAGRANT_IP = '192.168.10.201'

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true
  config.vm.network :forwarded_port, guest: 3000, host: 3000 # Rails
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # Mysql
  config.vm.network :forwarded_port, guest: 5432, host: 5432 # Postgresql
  config.vm.network :forwarded_port, guest: 3001, host: 3001 # Gulp server
  config.vm.network :forwarded_port, guest: 9000, host: 9000 # Gulp server
  config.vm.network :forwarded_port, guest: 9200, host: 9200 # Elasticsearch

  config.vm.network :private_network, ip: VAGRANT_IP
  config.vm.hostname = VAGRANT_HOSTNAME

  config.vm.synced_folder './code', '/home/vagrant/code', type: 'nfs_guest'

  config.vm.provider :virtualbox do |vm|
    vm.customize ["modifyvm", :id, "--name", 'vagrant_dev']
    vm.customize ["modifyvm", :id, "--memory", ENV['VM_MEM'] ? ENV['VM_MEM'].to_i : 4096]
    vm.customize ["modifyvm", :id, "--cpus", 2]
  end

  config.vm.provision "shell", path: 'provisions/repositories.sh'
  config.vm.provision "shell", path: 'provisions/packages.sh'
  config.vm.provision "shell", path: 'provisions/db.sh'
  config.vm.provision "shell", path: 'provisions/env.sh', privileged: false

  subdomains = [nil]
  subdomains += %w(www admin demo thumball
  shop assets saharok wannabe app api thumbor)
  #subdomains << '*' if RUBY_PLATFORM =~ /darwin/
  config.hostsupdater.aliases = subdomains.map { |s| [s, VAGRANT_APP_DOMAIN].compact * '.' }

  config.ssh.forward_agent = true
  config.ssh.pty = false
end
