# install custom spidermonkey (1.9.2)
bash "setup spidermonkey repo" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  (apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 74EE6429)
  (echo "deb http://ppa.launchpad.net/commonjs/ppa/ubuntu karmic main" >> /etc/apt/sources.list)
  (apt-get update)
  EOH
  not_if "/usr/bin/test -f /usr/lib/libmozjs-1.9.2.so"
end

if node[:platform_version].to_f <= 9.10
  package "libmozjs0d" do
    action :remove
  end

  package "libmozjs-dev" do
    action :remove
  end
end

package "libmozjs-1.9.2"
package "libmozjs-1.9.2-dev"

link "/usr/lib/libmozjs.so" do
  to "/usr/lib/libmozjs-1.9.2.so"
end
