#
# Cookbook Name:: spidermonkey
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

case node[:platform]
  
when "ubuntu"
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
  
when "centos","redhat"
  package "js-devel"
end