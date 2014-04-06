#
# Cookbook Name:: roadtalk
# Recipe:: firewall
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

include_recipe 'simple_iptables'

###############################################################
# Reject packets other than those explicitly allowed
###############################################################
simple_iptables_policy "INPUT" do
  policy "DROP"
end

###############################################################
# The following rules define a "system" chain; chains
# are used as a convenient way of grouping rules together,
# for logical organization.
# Allow all traffic on the loopback device
# Allow any established connections to continue, even
# if they would be in violation of other rules.
# Allow Ping
# Allow SSH
###############################################################
['--in-interface lo', '-m conntrack --ctstate ESTABLISHED,RELATED', '-p icmp --icmp-type echo-request','--proto tcp --dport 22'].each do |rule|
  simple_iptables_rule "system" do
    rule rule
    jump "ACCEPT"
  end
end

simple_iptables_rule "web" do
  rule ["--proto tcp --dport 80",
        "--proto tcp --dport 443"]
  jump "ACCEPT"
  only_if { run_context.loaded_recipe?("roadtalk::web_app") }
end

simple_iptables_rule "database" do
  rule ["--proto tcp --dport 5432"]
  jump "ACCEPT"
  only_if { run_context.loaded_recipe?("roadtalk::database") && \
            !run_context.loaded_recipe?("roadtalk::web_app") }
end

