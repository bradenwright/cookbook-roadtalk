#
# Cookbook Name:: roadtalk 
# Attributes:: default
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

force_default[:rbenv][:user]   = "roadtalk"
force_default[:rbenv][:group]  = "roadtalk"
force_default[:rbenv][:user_home] = "/home/roadtalk"

force_default[:nginx][:default_site_enabled] = false

default[:roadtalk][:web_app] = true
default[:roadtalk][:database] = true
default[:roadtalk][:firewall] = true

default[:roadtalk][:rails_env] = "development"
default[:roadtalk][:git_repo] = "https://github.com/bradenwright/rails-roadtalk"
default[:roadtalk][:git_branch] = "master"
