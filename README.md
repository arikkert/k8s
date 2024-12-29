playbook documentation
======================

Playbooks to deploy 3 k8s clusters on *Ubuntu 24.04 LTS* hosts
(tested on Vagrant box https://portal.cloud.hashicorp.com/vagrant/discover/crystax/ubuntu2404/versions/1.0.0)

It will:
- check if the hosts fullfill the prereq
- configure the k8s controllers and join the k8s workers to the clusters
- install a user *kube* to administer the cluster
- install helm
- prepare scripts for k8s dashboard
- configure octant
- prepare workers to be NFS client for k8s NFS in-tree driver

Info
----

This implementation uses a Makefile as installation wrapper.  
Just type **make** in the directory where the Makefile is located, to install all dependencies and run the playbook.
The makefile calls tools like **yamllint** and **ansible-lint**.
These tools are only called when found in the search path, so no problem if they are not installed.

Requirements
------------

Deploy host has **make**, **ansible** and **ansible-galaxy** installed.
Target hosts have *Ubuntu 24.04 LTS* installed.
Requires root access to target hosts.

Variables
---------

Ansible inventory containing definitions for
3 clusters each with 1 control node and 2 worker nodes.
The playbooks only refer to the group names and never tot the individual hosts (*bla.mydomain*) so you can choose your own names for the actual hostnames.

    [k8s01control]
    k8s01control.mydomain
    
    [k8s01workers]
    k8s01worker01.mydomain
    k8s01worker02.mydomain
    
    [k8s01:children]
    k8s01control
    k8s01workers
    
    [k8s02control]
    k8s02control.mydomain
    
    [k8s02workers]
    k8s02worker01.mydomain
    k8s02worker02.mydomain
    
    [k8s02:children]
    k8s02control
    k8s02workers
    
    [k8s03control]
    k8s03control.mydomain
    
    [k8s03workers]
    k8s03worker01.mydomain
    k8s03worker02.mydomain
    
    [k8s03:children]
    k8s03control
    k8s03workers

ansible group_vars for groups *k8s01*, *k8s02*, *k8s03* with this content:

    _ansible_distribution: 'Ubuntu'
    _ansible_distribution_major_version: 24
    k8s_user: kube
    k8s_group: kube
    k8s_version: v1.32

where *k8s_version* may vary per cluster if the rest of the code is common for all versions
e.g.. Cluster *k8s01*/*k8s02* have version v1.31 and Cluster k8s03 has version v1.32

Other variables:
    *domain*	# the domain of the used hosts, here *mydomain*

What if you only want one cluster to be deployed
------------------------------------------------

The playbooks handle 3 clusters, but if you leave/comment out all entries for k8s02 en k8s03 in the inventory
the playbooks cannot match the hosts so effectively skip configuring the k8s02 and k8s03 clusters.
So then only k8s01 will be deployed.

Testing
-------

Run:

    cd test
    make

to test the 3 clusters

Dependencies
------------

License
-------

BSD

Author Information
------------------

    ARK-ICT
    Andre Rikkert de Koe - ICT
