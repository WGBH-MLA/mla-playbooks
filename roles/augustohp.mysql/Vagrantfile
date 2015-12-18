# vi: set ft=ruby et ts=2 sw=2:

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "base"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define "debian6", primary: true, autostart: true do |debian|
      debian.vm.box = "chef/debian-6.0.8"
      debian.vm.network "private_network", ip: "192.168.42.31"
      debian.vm.hostname = "debian6.mysql.local"

      debian.vm.provider :virtualbox do |vbox|
          vbox.name = "debian6.ansible-mysql-role"
      end

      debian.vm.provision "ansible" do |ansible|
          ansible.playbook = "test.yml"
          ansible.limit = "all"
      end
  end

  config.vm.define "centos6" do |centos|
      centos.vm.box = "chef/centos-6.5"
      centos.vm.network "private_network", ip: "192.168.42.32"
      centos.vm.hostname = "centos.mysql.local"

      centos.vm.provider :virtualbox do |vbox|
          vbox.name = "centos.ansible-mysql-role"
      end

      centos.vm.provision "ansible" do |ansible|
          ansible.playbook = "test.yml"
          ansible.limit = "all"
      end
  end

end
