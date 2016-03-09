#
# Cookbook Name:: bcpc
# Recipe:: chef vault install
#
# Copyright 2015, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'pathname'
require 'rubygems'

gem_package "chef-vault" do
  gem_binary Pathname.new(Gem.ruby).dirname.join("gem").to_s
  version ">=0.0.0"
  action :nothing
end.run_action(:install)

# set the gemspec permission
begin
  File.chmod( 0444, *Dir.glob(Gem.dir + "/specifications/*.gemspec") )
rescue
  Chef::Log.warn("Failed to correct permissions on gemspecs!")
end

Gem.clear_paths
