#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

jboss_home = node['jboss']['home']

user "jboss" do
home "/home/jboss"
shell "/bin/sh"
action :create
end

directory node['jboss']['home'] do
owner "jboss"
group "jboss"
mode "0755"
recursive true
end 

remote_file "/tmp/jboss.zip" do
source node['jboss']['link']
action :create
notifies :run,"execute[unzip-jboss]", :immediately
end

execute "unzip-jboss" do
cwd node['jboss']['home']
command "unzip /tmp/jboss.zip -d #{jboss_home}"
action :nothing
end

execute "runjboss" do
cwd "#{jboss_home}/jboss-as-7.1.1.Final/bin"
command "bash standalone.sh"
action :run
end