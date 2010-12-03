### Cloudant Cookbooks
  
  * Used with Chef (http://www.opscode.com) to bootstrap bigcouch machines on Ubuntu
  * These cookbooks depend on the Opscode runit and heartbeat cookbooks (which are included for convenience)

### Assumptions:
  
  * You already have a working installation of chef (client or solo) to apply the cookbooks
  * You are running Ubuntu (we use 10.04 LTS), we will likely support other distros soon

### Getting Started

#### Usage w/ Chef Solo:

  * Clone this repo to a machine
  * Edit solo.rb to point to the cloned repo
  * Run the following to install and configure bigcouch
    
    sudo chef-solo -c /path/to/solo.rb -j /path/to/bigcouch.json

### Usage w/ Chef Client

  * Upload the cookbooks in this repo to your Chef server using knife
  * Add the cookbooks to your nodes