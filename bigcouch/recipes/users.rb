#
# Cookbook Name:: bigcouch
# Recipe:: users
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

group "bigcouch" do
  gid 400
end

user "bigcouch" do
  uid 400
  gid 400
  shell "/bin/bash"
  home "/home/bigcouch"
end

template "/home/bigcouch/.erlang.cookie" do
  source "erlang_cookie.erb"
  mode 0400
  owner "bigcouch"
  group "bigcouch"
end