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

directory node['directory'] do
  recursive true
  owner node['user']
  group node['group']
  mode "0755"
end

git node['directory'] do
  action :sync
  repository node['git']
  user node['user']
end

rvm_shell "install gems" do
  code "bundle install"
  cwd node['directory']
  user node['user']
end

rvm_shell "start server" do
  code "bundle exec rails server --daemon --port 8080"
  cwd node['directory']
  user node['user']
end

