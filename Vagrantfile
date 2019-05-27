Vagrant.configure("2") do |config|
  # manager-VM
  config.vm.define "manager" do |manager|
    manager.vm.box = "centos/7"
    manager.vm.hostname = "manager"
    manager.vm.network "private_network", ip: "172.16.97.11", auto_config: false
    manager.vm.synced_folder './server', '/vagrant', :mount_options => ['dmode=775', 'fmode=664']

    manager.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end
    
    manager.vm.provision "shell", inline: <<-SHELL
      # IPv6 disable
      cp /vagrant/disable_ipv6.conf /etc/sysctl.d/disable_ipv6.conf
      sysctl -p /etc/sysctl.d/disable_ipv6.conf

      # update package
      # yum update -y
      yum install -y ansible
    SHELL

    manager.vm.provision "shell", privileged: false, inline: <<-SHELL
      # registry ssh-key
      ssh-keygen -N "" -t ed25519 -f ~/.ssh/id_ed25519

      # registry known_hosts
      #ssh-keyscan -H manager   >> ~/.ssh/known_hosts

      # registry authorized_keys
      cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
      cat ~/.ssh/id_ed25519.pub >> ~/.ssh/known_hosts
      # ssh-copy-id vagrant@manager

      # copy playbook
      cp -pR /vagrant/playbook ~/
    SHELL
  end
end
