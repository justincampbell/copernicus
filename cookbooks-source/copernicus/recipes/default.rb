#
# Cookbook Name:: copernicus
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "apt"
include_recipe "build-essential"
include_recipe "git"

node['rvm']['user_installs'] = [
  {
    'user'          => 'vagrant',
    'default_ruby'  => '1.9.3',
    'rubies'        => ['1.9.3']
  }
]

include_recipe "rvm::user"

directory "/srv" do
  recursive true
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

git "/srv/copernicus" do
  action :sync
  repository "git://github.com/JustinCampbell/copernicus.git"
  user "vagrant"
end

rvm_shell "install gems" do
  code "bundle install"
  cwd "/srv/copernicus"
  user "vagrant"
end

rvm_shell "start server" do
  code "bundle exec rails server --daemon --port 8080"
  cwd "/srv/copernicus"
  user "vagrant"
end

