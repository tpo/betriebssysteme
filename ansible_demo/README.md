Ansible 
=======

Ansible: http://http://www.ansible.com
Introduction: http://docs.ansible.com/intro.html

Installation
------------

Debian/Ubuntu have ansible included.

From source:

    git clone git://github.com/ansible/ansible.git
    cd ./ansible
    sudo checkinstall


Configuration
-------------

    cat > ansible.cfg <<EOS
    #http://www.ansibleworks.com/docs/intro_configuration.html
    #Overrides /etc/ansible/ansible.cfg
    [defaults]
    hostfile=$(pwd)/production
    roles_path=$(pwd)/roles
    transport=ssh

    #default module name for /usr/bin/ansible
    module_name=shell
    EOS

    # only needed for our demo
    #
    export ANSIBLE_CONFIG=$(pwd)/ansible.cfg

Test
----

    make sure, that host_1 and host_2 are in /etc/hosts or in
    ~/.ssh/config

    ssh-add
    ansible host_1 -m ping


Issue commands
--------------

Default module is shell, so a shell command can be passed as argument:

    ansible host_1 -a w

Update package list on all demo servers:

    ansible demo -u root -a "apt-get update"

Get all OS versions:

    ansible demo -m setup -a filter=ansible_lsb


Use playbooks
-------------

Deploy to a single server:

    cd hosts/$servername
    ansible-playbook setup.yml

Update deployment on all demo servers:

    ansible-playbook site.yml

Examples with tags:

    ansible-playbook site.yml --tags=osinfo
