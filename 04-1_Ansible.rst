Ansible
=======

Ansible ist ein Konfigurations- und Deployment-Automatisierungs-Werkzeug.

Demo
----

::

    $ cd ansible_demo
    $ export ANSIBLE_CONFIG=$(pwd)/ansible.cfg
    $ ansible-playbook site.yml

ähnliche Werkzeuge
------------------

* puppet
* chief
* cdist
* System Center
* DISM
* Empirum
* Altiris
* usw.

Ziele bzw. Vorzüge
------------------

* reproduzierbare Installation und Konfiguration von Diensten und Maschinen
* Automatisierung
* halb-deklarative Syntax
* Dokumentation der Installation
  * Ziel wird jeweils angegeben

Dokumentation
-------------

* http://docs.ansible.com/

Setup
-----

siehe ansible_demo/README.md

Ansible Layout
--------------

* ist relativ frei

hosts
~~~~~

* Deklaration von Maschinen
* diese können Tasks und Rollen beinhalten
  * siehe ansible_demo/hosts/host_1/setup.yml
* siehe auch /etc/hosts bzw. ~/.ssh/config

roles
~~~~~

* Rollen, welche von den hosts eingenommen werden

Tasks
-----

* name: Zweck
* Aktion
  * Modulname + Parameter
  * siehe z.B. http://docs.ansible.com/file_module.html

Weitere Features
----------------

* includes
  * siehe ansible_demo/roles/common/tasks/main.yml
* Variablen
  * siehe auch ansible_demo/host_vars
* Tags
  * ansible-playbook site.yml --tags=osinfo

Modi
----
* --check
* --check --diff
* ad hoc Tasks
  * ansible-playbook clean_up.yml

Erweiterungen
-------------
* library/dpkg_dep -> siehe Python Skript
