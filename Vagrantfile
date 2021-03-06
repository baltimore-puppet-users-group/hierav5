# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
	# The most common configuration options are documented and commented below.
	# For a complete reference, please see the online documentation at
	# https://docs.vagrantup.com.

	# Every Vagrant development environment requires a box. You can search for
	# boxes at https://atlas.hashicorp.com/search.
	config.vm.box = "bento/centos-7.3"

	# Disable automatic box update checking. If you disable this, then
	# boxes will only be checked for updates when the user runs
	# `vagrant box outdated`. This is not recommended.
	# config.vm.box_check_update = false

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	#	config.vm.network "forwarded_port", guest: 80, host: 8080

	# Create a private network, which allows host-only access to the machine
	# using a specific IP.
	# config.vm.network "private_network", ip: "192.168.33.10"

	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on
	# your network.
	# config.vm.network "public_network"

	# Share an additional folder to the guest VM. The first argument is
	# the path on the host to the actual folder. The second argument is
	# the path on the guest to mount the folder. And the optional third
	# argument is a set of non-required options.
	# config.vm.synced_folder "../data", "/vagrant_data"

	# Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant. These expose provider-specific options.
	# Example for VirtualBox:
	#
	# config.vm.provider "virtualbox" do |vb|
	#   # Display the VirtualBox GUI when booting the machine
	#   vb.gui = true
	#
	#   # Customize the amount of memory on the VM:
	#   vb.memory = "1024"
	# end
	#
	# View the documentation for the provider you are using for more
	# information on available options.

	# Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
	# such as FTP and Heroku are also available. See the documentation at
	# https://docs.vagrantup.com/v2/push/atlas.html for more information.
	# config.push.define "atlas" do |push|
	#   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
	# end

	# Enable provisioning with a shell script. Additional provisioners such as
	# Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
	# documentation for more information about their specific syntax and use.
	# config.vm.provision "shell", inline: <<-SHELL
	#   apt-get update
	#   apt-get install -y apache2
	# SHELL
	{
		"web1" => '192.168.42.3',
		"web2" => '192.168.42.4',
		"dc1" => '192.168.42.5'
	}.each do |node, ip|
		config.vm.define "#{node}" do |config|
			config.vm.network :private_network, ip: ip
			config.vm.hostname = "#{node}.acmeholding.com"
			config.vm.provider "virtualbox" do |vb|
				vb.memory = "1024"
			end
			case node
			when "web1"
				config.vm.network "forwarded_port", guest: 80, host: 8080
				site = "acme"
			when "web2"
				config.vm.network "forwarded_port", guest: 80, host: 8081

				site = "thinkit"
			end
			config.vm.provision "shell", inline: <<-SHELL
     sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
     sudo yum install puppet-agent -y
     sudo service firewalld stop
     sudo sh -c 'echo "sitename=#{site}" >/opt/puppetlabs/facter/facts.d/sitename.txt'
     sudo /opt/puppetlabs/bin/puppet resource package git ensure=installed
     sudo /opt/puppetlabs/puppet/bin/gem install r10k
     sudo /opt/puppetlabs/puppet/bin/r10k deploy -c /vagrant/r10k.yaml environment -pv

     sudo /opt/puppetlabs/bin/puppet apply /vagrant/manifests/site.pp
			SHELL
		end
	end

end
