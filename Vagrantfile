Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |virtualbox|
    # virtualbox.gui = true
    virtualbox.memory = 4096
    virtualbox.cpus = 1
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "debian" do |debian|
    debian.vm.box = "generic/ubuntu2204"
    debian.vm.network "forwarded_port", guest: 8080, host: 8081
    debian.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "HXTool-Ubuntu"
    end
  end

  config.vm.define "redhat" do |redhat|
    redhat.vm.box = "generic/centos9s"
    redhat.vm.network "forwarded_port", guest: 8080, host: 8082
    redhat.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "HXTool-RedHat"
    end
  end

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = "ansible/site.yml"
    ansible.config_file = "ansible/ansible.cfg"
  end

end
