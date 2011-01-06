include_recipe "libicu"
include_recipe "spidermonkey"

case node[:platform]
when "ubuntu"
  package "libcurl4-openssl-dev"
  include_recipe "runit"
  
  if node[:kernel][:machine] == "x86_64"
    build = "amd64"
  elsif node[:kernel][:machine] = "i686" || node[:kernel][:machine] == "i386"
    build = "i386"
  end
  
  package = "deb"
when "centos","redhat"
  %w{openssl openssl-devel}.each do |openssl|
    package openssl
  end
  include_recipe "libcurl::source" ## install curl from source to meet couchdb version requirement
  package = "rpm"
  build = node[:kernel][:machine]
end
  
bigcouch_pkg_path = File.join(Chef::Config[:file_cache_path], "/", "bigcouch_#{node[:bigcouch][:version]}_#{build}.#{package}")

remote_file(bigcouch_pkg_path) do
  source "#{node[:bigcouch][:repo_url]}/bigcouch_#{node[:bigcouch][:version]}_#{build}.#{package}"
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
  owner "bigcouch"
  group "bigcouch"
  mode "0755"
end
 
directory node[:bigcouch][:view_index_dir] do
  owner "bigcouch"
  group "bigcouch"
  mode "0755"
end

template "/home/bigcouch/.erlang.cookie" do
  source "erlang_cookie.erb"
  mode 0400
  owner "bigcouch"
  group "bigcouch"
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