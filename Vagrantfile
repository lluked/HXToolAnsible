Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.gui = true
    virtualbox.memory = 4096
    virtualbox.cpus = 1
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "debian-virtualbox" do |virtualbox|
    virtualbox.vm.box = "generic/ubuntu2204"
    virtualbox.vm.network "forwarded_port", guest: 8080, host: 8081
    virtualbox.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "HXTool-Ubuntu"
    end
  end

  config.vm.define "redhat-virtualbox" do |virtualbox|
    virtualbox.vm.box = "generic/centos9s"
    virtualbox.vm.network "forwarded_port", guest: 8080, host: 8082
    virtualbox.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "HXTool-RedHat"
    end
  end

  config.vm.define "debian-vmware" do |vmware|
    vmware.vm.box = "generic/ubuntu2204"
    vmware.vm.network "forwarded_port", guest: 8080, host: 8083
    vmware.vm.provider "vmware" do |vmware|
      vmware.vmx['displayname'] = "HXTool-Ubuntu"
    end
  end

  config.vm.define "redhat-vmware" do |redhat|
    redhat.vm.box = "generic/centos9s"
    redhat.vm.network "forwarded_port", guest: 8080, host: 8084
    redhat.vm.provider "vmware" do |vmware|
      vmware.vmx['displayname'] = "HXTool-RedHat"
    end
  end

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = "ansible/site.yml"
    ansible.config_file = "ansible/ansible.cfg"
  end

end
