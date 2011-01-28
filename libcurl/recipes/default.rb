
# curl is only needed to run js tests in couchdb and bigcouch

case node[:platform]
when "ubuntu"
  package "libcurl4-openssl-dev"
when "centos","redhat"
  include_recipe "libcurl::source"
end