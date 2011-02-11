#
# Cookbook Name:: bigcouch
# Attributes:: bigcouch
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

# bigcouch defaults
set[:bigcouch][:cluster][:q] = 2
set[:bigcouch][:cluster][:r] = 2
set[:bigcouch][:cluster][:w] = 2
set[:bigcouch][:cluster][:n] = 3

set[:bigcouch][:database_dir] = "/srv/db"
set[:bigcouch][:view_index_dir] = "/srv/view_index"

set[:bigcouch][:bind_address] = "0.0.0.0"

# attribs for erlang
set[:bigcouch][:erlang][:cookie] = "somecookie"
set[:bigcouch][:erlang][:node_name] = "bigcouch"

# attribs for releases

set[:bigcouch][:version] = "0.3-1"
set[:bigcouch][:repo_url] = "http://cloud.github.com/downloads/cloudant/bigcouch"
