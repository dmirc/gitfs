# Deploy salt-minion using salt-ssh
See the how-to files for instructions

##Install salt-master:

$ wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

$ sudo sh bootstrap-salt.sh -P -M git v2019.2.3

## Apply state

$ salt-ssh '*' --no-host-keys  state.apply install_salt_minion

##Install salt minion (manually setup if needed)
If you installed the stable version using salt-bootstrap, you can download the same script to your minion machine:

$ cd ~
$ curl -L https://bootstrap.saltstack.com -o install_salt.sh

We will call the script in almost the same way that we did on the Salt master. The only difference is that we leave out the -M flag, since we do not need to install the master tools and daemons:

$ sudo sh install_salt.sh -P


##Firewalld (optional if nedeed)
Find out to which zone the eth1 interface belongs:

$ sudo firewall-cmd --get-active-zones

You will find out that the eth1 interface belongs to the "public" zone. Therefore, you need to allow traffic through the two ports in the "public" zone:

$ sudo firewall-cmd --permanent --zone=public --add-port=4505-4506/tcp

$ sudo firewall-cmd --reload

