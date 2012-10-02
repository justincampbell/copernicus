Vagrant::Config.run do |config|
  config.vm.box = "base"

  config.vm.network :hostonly, "192.168.22.22"
  config.vm.forward_port 8080, 8080

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks-source"
    chef.add_recipe "copernicus"
    #chef.log_level = :debug
  end
end
