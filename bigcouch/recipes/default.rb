#
# Cookbook Name:: bigcouch
# Recipe:: default
#
# Copyright 2011, Cloudant
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "libicu"
include_recipe "spidermonkey"

case node[:platform]
when "ubuntu"
  
  include_recipe "runit"
  
  if node[:kernel][:machine] == "x86_64"
    build = "amd64"
  elsif node[:kernel][:machine] = "i686" || node[:kernel][:machine] == "i386"
    build = "i386"
  end
  
  package = "deb"
  filename = "bigcouch_#{node[:bigcouch][:version]}_#{build}.#{package}"
  
when "centos","redhat"
  
  %w{openssl openssl-devel}.each do |openssl|
    package openssl
  end
  package = "rpm"
  build = node[:kernel][:machine]
  filename = "bigcouch-#{node[:bigcouch][:version]}_#{build}.#{package}"
  
end
  
bigcouch_pkg_path = File.join(Chef::Config[:file_cache_path], "/", filename)

remote_file(bigcouch_pkg_path) do
  source "#{node[:bigcouch][:repo_url]}/#{filename}"
  not_if "/usr/bin/test -d /opt/bigcouch"
end

case node[:platform]
when "ubuntu"
  dpkg_package(bigcouch_pkg_path) do
    source bigcouch_pkg_path
    action :install
    not_if "/usr/bin/test -d /opt/bigcouch"
  end

when "centos","redhat"
  package(bigcouch_pkg_path) do
    source bigcouch_pkg_path
    action :install
    not_if "/usr/bin/test -d /opt/bigcouch"
  end
end

directory node[:bigcouch][:database_dir] do
  action :create
  owner "bigcouch"
  group "bigcouch"
  mode "0755"
  recursive true
end

directory node[:bigcouch][:view_index_dir] do
  action :create
  owner "bigcouch"
  group "bigcouch"
  mode "0755"
  recursive true
end

template "/opt/bigcouch/etc/default.ini" do
  source "default_ini.erb"
  owner "bigcouch"
  group "bigcouch"
  mode 0644
end
 
template "/opt/bigcouch/etc/vm.args" do
  source "vm_args.erb"
  owner "bigcouch"
  group "bigcouch"
  mode 0644
end

case node[:platform]
when "ubuntu"
  runit_service "bigcouch"
end
