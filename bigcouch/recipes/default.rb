include_recipe "libicu42"
include_recipe "libmozjs_1.9.2"
include_recipe "bigcouch::users"

package "libcurl4-openssl-dev"


directory "/srv/db" do
  owner "bigcouch"
  group "bigcouch"
  mode "0755"
end

directory "/srv/view_index" do
  owner "bigcouch"
  group "bigcouch"
  mode "0755"
end

tarball = "bigcouch-#{node[:bigcouch][:version]}-ubuntu-#{node[:kernel][:machine]}.tar.gz"

remote_file "/tmp/#{tarball}" do
  source "#{node[:bigcouch][:repo_url]}/#{tarball}"
  mode 0644
  owner "bigcouch"
  group "bigcouch"
  not_if "/usr/bin/test -d /opt/bigcouch"
end

bash "install bigcouch release" do
  user "root"
  cwd "/opt"
  code <<-EOH
  (tar zxf /tmp/#{tarball} -C /opt)
  (chown -R bigcouch:bigcouch /opt/bigcouch)
  EOH
  not_if "/usr/bin/test -d /opt/bigcouch"
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

# setup runit service
include_recipe "runit"
runit_service "bigcouch"
