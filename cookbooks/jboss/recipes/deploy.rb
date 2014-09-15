link = "http://www.cumulogic.com/download/Apps/testweb.zip" 
deploy_dir = node['jboss']['deploy_dir']

remote_file "/tmp/testweb.zip"
source link
notifies :run,"execute[unpack]",:immediately
end

execute "unpack" do
command = "unzip /tmp/testweb.zip -d #{deploy_dir}"
end

execute "restartjboss" do
cwd "#{jboss_home}/jboss-as-7.1.1.Final/bin"
command "bash standalone.sh"
action :run
end

