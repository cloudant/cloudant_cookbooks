include_recipe "heartbeat"

gem_package "tmail"
gem_package "right_aws"

cloudant_lb_primary = search(:node, "role:cloudant-lb AND lb_role:prima=
ry")
cloudant_lb_secondary = search(:node, "role:cloudant-lb AND lb_role:sec=
ondary")
peer_node = search(:node, "role:cloudant-lb NOT ipaddress:#{node[:ipadd=
ress]}")

template "/etc/ha.d/ha.cf" do
  source "ha_cf.erb"
  variables :primary => cloudant_lb_primary[0], :secondary => cloudant_lb_secondary[0], :peer_node => peer_node[0]
  mode 0644
end

template "/etc/ha.d/haresources" do
  source "haresources.erb"
  variables :primary => cloudant_lb_primary[0]
  mode 0644
end

template "/etc/ha.d/authkeys" do
  source "authkeys.erb"
  mode 0644
end

template "/usr/local/bin/aws_elastic_ip" do
  source "aws_elastic_ip.erb"
  mode 0755
end

template "/etc/init.d/aws_elastic_ip" do
  source "aws_elastic_ip_init.erb"
  mode 0755
end