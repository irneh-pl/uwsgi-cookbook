#
# Cookbook Name:: uwsgi
# Recipe:: configure
#
# Copyright 2014, Pulselocker, Inc.
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

###
# Recipe to install application and configure server environment
###

# Create the runtime directories
log "Creating uWSGI runtime directories"
node['uwsgi']['config']['directories'].each do |key, value|
  directory value do
    owner "root"
    group "root"
    mode 00755
    action :create
  end
end

directory node['uwsgi']['config']['emperor'] do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  only_if { node['uwsgi']['emperor']['enable'] == true }
end

if node['platform_family'] == 'debian'
  include_recipe "uwsgi::_debian"
end
