### Cloudant Cookbooks
  
  * Used with Chef (http://www.opscode.com) to bootstrap bigcouch machines on Ubuntu
  * These cookbooks depend on the Opscode runit and heartbeat cookbooks (which are included for convenience)

### Assumptions
  
  * You already have a working installation of chef (client or solo) to apply the cookbooks
  * You are running Ubuntu (we use 10.04 LTS) or Centos/RHEL 5

### Getting Started

#### Usage w/ Chef Solo

  * Clone this repo to a machine
  * Edit solo.rb to point to the cloned repo
  * Run the following to install and configure bigcouch
    
    mkdir /tmp/chef-solo # or another path if you changed file_cache_path
    
    sudo chef-solo -c /path/to/solo.rb -j /path/to/bigcouch.json

#### Usage w/ Chef Client

  * Upload the cookbooks in this repo to your Chef server using knife
  * Add the cookbooks to your nodes
  
### Caveats
  
  * Redhat/Centos doesn't include an init script, we recommend using runit or daemontools.
  * If installing the RPM packages on Redhat/Centos run the following to turn off signed package checking.

    sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.conf
    
### Getting Help

  * IRC: #cloudant on freenode