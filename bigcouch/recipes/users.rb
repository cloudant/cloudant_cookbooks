user "bigcouch" do
  uid 400
  shell "/bin/bash"
  home "/home/bigcouch"
end

directory "/home/bigcouch" do
  owner "bigcouch"
  group "bigcouch"
  mode 0700
end

template "/home/bigcouch/.erlang.cookie" do
  source "erlang_cookie.erb"
  mode 0400
  owner "bigcouch"
  group "bigcouch"
end