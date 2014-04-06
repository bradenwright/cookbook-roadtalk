#
# Cookbook Name:: roadtalk
# Recipe:: web_app
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

username = "roadtalk"
group = "roadtalk"
user_home = "/home/roadtalk"
project_name = "roadtalk"

project_postgresql = DataBagRescue.postgresql
node.normal[:postgresql][:password][:postgres] = project_postgresql[:password]

include_recipe "apt::default"
include_recipe "build-essential"
include_recipe "git"
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
include_recipe "rbenv::rbenv_vars"

rbenv_ruby "2.1.0" do
  global true
end

rbenv_gem "bundler" do
  ruby_version "2.1.0"
end

rbenv_gem "rails" do
  ruby_version "2.1.0"
  version "4.0.4"
end

%w{ deploy deploy/shared deploy/shared/log deploy/shared/pids deploy/shared/system deploy/shared/config }.each do |folder|
  directory "#{user_home}/#{folder}" do
    owner username
    group group
  end
end

template "#{user_home}/deploy/shared/config/database.yml" do
  owner username
  group group
  variables( :project_name => project_name,
             :username => username,
             :password => node[:postgresql][:password][:postgres])
end

template "/etc/init.d/#{project_name}" do
  source "init.d-site.erb"
  owner "root"
  group "root"
  mode 0555
  variables( :username => username,
             :home_dir => user_home,
             :environment => node[project_name][:rails_env] )
end

deploy "#{user_home}/deploy" do
  user username
  group group
  repository node[project_name][:git_repo]
  branch node[project_name][:git_branch]

  before_symlink do
    bash "bundler update" do
      user username
      ENV['HOME'] = user_home
      flags "-l"
      cwd "#{user_home}/deploy/releases"
      code <<-EOH
         cd `ls -r | awk 'NR<2'`
         bundle install
         bundle exec rake db:migrate
         bundle exec rake assets:precompile
      EOH
    end
  end
  restart_command "test -e /etc/init.d/#{project_name} && service #{project_name} upgrade || exit 0"
end

include_recipe 'nginx'

template "/etc/nginx/sites-available/#{project_name}" do
  source "nginx-site.erb"
  owner "root"
  group "root"
  mode 0555
  variables( :home_dir => user_home )
  notifies :restart, "service[nginx]"
end

link "/etc/nginx/sites-enabled/#{project_name}" do
  to "/etc/nginx/sites-available/#{project_name}"
end

service project_name do
  status_command "service #{project_name} status"
  action :start
end

##########################################################
### can't use service action enable bc unicorn tries
### to start before postgresql and it fails, number at end
### controls boot order (by name of symlinks) 
### lower numbers boot first (default 20)  
##########################################################
bash "setup #{project_name} to start on boot" do
  user "root"
  cwd "/etc/init.d"
  code "update-rc.d -f #{project_name} defaults 50"
end

