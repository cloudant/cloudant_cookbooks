#
# Cookbook Name:: libicu
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
  if node[:platform_version] != "10.04"
  
    if node[:kernel][:machine] == "x86_64"
      build = "amd64"
    elsif node[:kernel][:machine] = "i686" || node[:kernel][:machine] == "i386"
      build = "i386"
    end
    
    ## install libicu42
    
    libicu_dpkg_path = File.join(Chef::Config[:file_cache_path], "/", "libicu42_4.2.1-3_#{build}.deb")
    
    remote_file(libicu_dpkg_path) do
      source "http://mirrors.kernel.org/ubuntu/pool/main/i/icu/libicu42_4.2.1-3_#{build}.deb"
      not_if "/usr/bin/test -f /usr/lib/libicui18n.so.42.1"
    end
    
    dpkg_package(libicu_dpkg_path) do
      source libicu_dpkg_path
      action :install
      not_if "/usr/bin/test -f /usr/lib/libicui18n.so.42.1"
    end
    
    ## install libicu-dev (4.2)
    
    libicu_dev_dpkg_path = File.join(Chef::Config[:file_cache_path], "/", "libicu-dev_4.2.1-3_#{build}.deb")
    
    remote_file(libicu_dev_dpkg_path) do
      source "http://mirrors.kernel.org/ubuntu/pool/main/i/icu/libicu-dev_4.2.1-3_#{build}.deb"
      not_if "/usr/bin/test -f /usr/share/icu/4.2.1/config/mh-linux"
    end
    
    dpkg_package(libicu_dev_dpkg_path) do
      source libicu_dev_dpkg_path
      action :install
      not_if "/usr/bin/test -f /usr/share/icu/4.2.1/config/mh-linux"
    end
    
  else
    package "libicu42"
    package "libicu-dev"
  end

when "centos","redhat"
  %w{libicu libicu-devel}.each do |icu|
   package icu
  end
 
end