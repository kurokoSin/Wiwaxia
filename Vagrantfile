Vagrant.configure("2") do |config|
  config.vm.define "manager" do |manager|
    config.vm.box = "generic/ubuntu1804"
    config.vm.hostname = "manager"
    config.vm.network "private_network", ip: "172.16.97.101"
  
    config.vm.provider "libvirt" do |v|
      v.memory = 2048
      v.cpus = 2
    end

    config.vm.provision :shell, path: "bootstrap.sh"
    config.vm.network "forwarded_port", guest: 8080, host: 8080
  end
end
