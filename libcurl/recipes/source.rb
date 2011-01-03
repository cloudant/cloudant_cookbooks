
# generally only intended for use on centos and redhat to meet the couchdb version requirement

bash "install libcurl" do
  user "root"
  cwd "/tmp"
  code <<-EOH
  (cd /tmp; wget http://curl.haxx.se/download/curl-7.21.1.tar.gz)
  (cd /tmp; tar zxvf curl-7.21.1.tar.gz)
  (cd /tmp/curl-7.21.1; ./configure && make && make install)
  (rm -rf /tmp/curl-7.21.1)
  EOH
  only_if {::File.exists?("/usr/bin/curl")}
end