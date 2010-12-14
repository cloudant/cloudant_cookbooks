group "bigcouch" do
  gid 400
end

user "bigcouch" do
  uid 400
  gid 400
  shell "/bin/bash"
  home "/home/bigcouch"
end

template "/home/bigcouch/.erlang.cookie" do
  source "erlang_cookie.erb"
  mode 0400
  owner "bigcouch"
  group "bigcouch"
end