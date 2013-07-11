# sync repository

git "#{node['oai']['path']}" do
  repository "https://github.com/ssp/SUB-harvester.git"
  reference "master"
  action :sync
end

# make directory for source
directory "#{node['oai']['path']}/#{node['oai']['service']['name']}" do
  action :create
end

# make directory in configuration
directory "#{node['oai']['path']}/configuration/#{node['oai']['service']['name']}" do
  action :create
end

# make directory for storing data
directory "#{node['oai']['path']}/harvester/data/#{node['oai']['service']['name']}" do
  action :create
  recursive true
end


# database parameter
template "#{node['oai']['path']}/configuration/#{node['oai']['service']['name']}/db_connect.php" do
  source 'db_connect.php.erb'
  mode 00644
end

# settings for source
template "#{node['oai']['path']}/configuration/#{node['oai']['service']['name']}/settings.php" do
  source 'settings.php.erb'
  mode 00644
end

# settings for source
template "#{node['oai']['path']}/#{node['oai']['service']['name']}/.htaccess" do
  source 'htaccess.erb'
  mode 00644
end

# set symlink to index.php
link "#{node['oai']['path']}/#{node['oai']['service']['name']}/index.php" do
  to "#{node['oai']['path']}/software/index.php"
end

# set symlink to resources
link "#{node['oai']['path']}/#{node['oai']['service']['name']}/resources" do
  to "#{node['oai']['path']}/software/resources"
end

# import mysql data
execute "import-mysql-data" do
  command "mysql -u #{node['oai']['mysql']['username']} -p #{node['oai']['mysql']['password']} < #{node['oai']['path']}/configuration/harvester_schema.sql"
  action :nothing
end
