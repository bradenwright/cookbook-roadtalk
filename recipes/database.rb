#
# Cookbook Name:: roadtalk_web_app
# Recipe:: database
#
#
# Author:: Braden Wright
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

project_postgresql = DataBagRescue.postgresql
node.normal[:postgresql][:password][:postgres] = project_postgresql[:password]

package "nodejs"

include_recipe "apt::default"
include_recipe "postgresql::server"

bash "create database" do
  user "postgres"
  code <<-EOH
  psql <<EOF
  create role roadtalk with createdb login password 'password1';
  create database roadtalk_test owner roadtalk;
  create database roadtalk_production owner roadtalk;
  create database roadtalk_development owner roadtalk;
  EOF
  EOH
#  not_if "sudo su -c 'echo \\l | psql | grep roadtalk_test' - postgres"
end

