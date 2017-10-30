# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
nodes = [
  { :hostname => 'kubernetes-master',  :ip => '192.168.30.10', :ram => 1024 },
  { :hostname => 'kubernetes-node1',  :ip => '192.168.30.11', :ram => 512 },
  { :hostname => 'kubernetes-node2',  :ip => '192.168.30.12', :ram => 512 },
  { :hostname => 'kubernetes-node3',  :ip => '192.168.30.13', :ram => 512 }
]

ansibleuser = <<SCRIPT
  ## add ansible
  useradd -m -s /bin/bash -U ansible -u 666 --groups wheel
  cp -r /home/vagrant/.ssh /home/ansible/
  chown -R ansible:ansible /home/ansible
  chmod 700 /home/ansible/.ssh/
  chmod 600 /home/ansible/.ssh/authorized_keys
  echo "%ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
SCRIPT

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = "bento/centos-7.3";
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      memory = node[:ram] ? node[:ram] : 256;
      config.vm.provision "file", source: "D:/Education/Kubernetes/auth_key_vagrant", destination: "~/.ssh/authorized_keys"
      config.vm.provision "shell", inline: "#{ansibleuser}", privileged: true
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--memory", memory.to_s,
          "--cpus", "1"
        ]
      end
#      config.vm.provision "ansible" do |ansible|
#          ansible.verbose = "v"
#          ansible.playbook = "./playbook.yml"
#        end
  end

  end

end
