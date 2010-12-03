set[:aws_elastic_ip][:email_to] = "to@email.com"
set[:aws_elastic_ip][:email_from] = "from@email.com"

set[:aws_elastic_ip][:key] = "ec2key"
set[:aws_elastic_ip][:secret] = "ec2secret"
set[:aws_elastic_ip][:elastic_ip] = "elasticip"

set[:aws_elastic_ip][:heartbeatsecret] = "heartbeatsecret"

# manually set this attribute to "primary" on primary node
set_unless[:aws_elastic_ip][:lb_role] = "secondary"