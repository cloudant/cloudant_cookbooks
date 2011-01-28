#
# Cookbook Name:: libcurl
# Recipe:: source
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

# generally only intended for use on centos and redhat to run js tests

bash "install libcurl" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  (cd /tmp; wget http://curl.haxx.se/download/curl-7.21.1.tar.gz)
  (cd /tmp; tar zxvf curl-7.21.1.tar.gz)
  (cd /tmp/curl-7.21.1; ./configure && make && make install)
  (rm -rf /tmp/curl-7.21.1)
  EOH
  only_if {::File.exists?("/usr/local/bin/curl")}
end