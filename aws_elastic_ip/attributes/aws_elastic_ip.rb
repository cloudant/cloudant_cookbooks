#
# Cookbook Name:: aws_elastic_ip
# Attributes:: aws_elastic_ip
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

set[:aws_elastic_ip][:email_to] = "to@email.com"
set[:aws_elastic_ip][:email_from] = "from@email.com"

set[:aws_elastic_ip][:key] = "ec2key"
set[:aws_elastic_ip][:secret] = "ec2secret"
set[:aws_elastic_ip][:elastic_ip] = "elasticip"

set[:aws_elastic_ip][:heartbeatsecret] = "heartbeatsecret"

# manually set this attribute to "primary" on primary node
set_unless[:aws_elastic_ip][:lb_role] = "secondary"