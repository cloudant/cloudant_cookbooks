# bigcouch defaults
set[:bigcouch][:cluster][:q] = 2
set[:bigcouch][:cluster][:r] = 2
set[:bigcouch][:cluster][:w] = 2
set[:bigcouch][:cluster][:n] = 3

set[:bigcouch][:database_dir] = "/srv/db"
set[:bigcouch][:view_index_dir] = "/srv/view_index"

# attribs for user
set[:bigcouch][:erlang][:cookie] = "somecookie"

# attribs for releases

set[:bigcouch][:version] = "0.3a-1"
set[:bigcouch][:repo_url] = "http://builds.cloudant.com"
