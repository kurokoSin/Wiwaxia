Vagrant.configure("2") do |config|
  # manager-VM
  config.vm.define "manager" do |manager|
    manager.vm.box = "centos/7"
    manager.vm.hostname = "manager"
    manager.vm.network "private_network", ip: "172.16.97.11"
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
      # yum install -y ansible
      yum install -y PyYAML \
                     libyaml \
                     python-babel \
                     python-backports \
                     python-backports-ssl_match_hostname \
                     python-cffi \
                     python-enum34 \
                     python-httplib2   \
                     python-idna       \
                     python-ipaddress  \
                     python-jinja2     \
                     python-markupsafe \
                     python-paramiko   \
                     python-passlib    \
                     python-ply        \
                     python-pycparser  \
                     python-setuptools \
                     python-six        \
                     python2-cryptography \
                     python2-jmespath     \
                     python2-pyasn1       \
                     sshpass              \
                     git

    SHELL

    manager.vm.provision "shell", privileged: false, inline: <<-SHELL
      # registry ssh-key
      ssh-keygen -N "" -t ed25519 -f ~/.ssh/id_ed25519

      # registry known_hosts
      ssh-keyscan -H manager >> ~/.ssh/known_hosts

      # registry authorized_keys
      cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
      # ssh-copy-id vagrant@manager

      # install Ansible stable-2.8
      git clone -b stable-2.8 https://github.com/ansible/ansible.git ~/ansible
      cd ~/ansible
      source ./hacking/env-setup
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python ~/ansible/get-pip.py --user
      pip install --user -r ~/ansible/requirements.txt
      git pull --rebase

      echo manager > ~/ansible_hosts
      export ANSIBLE_INVENTORY=~/ansible_hosts
  
      # copy playbook
      cp -pR /vagrant/playbook ~/
    SHELL
  end
end
