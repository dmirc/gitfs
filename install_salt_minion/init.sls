# This is a state which will install salt-minion on your hosts using Salt SSH
# It will install the SaltStack repo, install salt-minion from that repo, enable and start the salt-minion service and
# declare master in /etc/salt/minion file

{% set minion_var = "2019.2.3" %}
salt-minion:
    # Install SaltStack repo for RHEL/Centos systems
    pkgrepo.managed:
        - name: salt-minion
        - humanname: SaltStack Latest Release Channel for RHEL/Centos $releasever
        - baseurl: https://repo.saltstack.com/yum/redhat/$releasever/$basearch/archive/{{ minion_var }}
        - gpgkey: https://repo.saltstack.com/yum/redhat/$releasever/$basearch/archive/{{ minion_var }}/SALTSTACK-GPG-KEY.pub
        - gpgcheck: 1
        - enabled: 1
    # Install the salt-minion package and all its dependencies.
    pkg:
        - installed
        # Require that SaltStack repo is set up before installing salt-minion.
        - require:
            - pkgrepo: salt-minion
    # Start and enable the salt-minion daemon.
    service:
        - running
        - enable: True
        # Require that the salt-minion package is installed before starting daemon
        - require:
            - pkg: salt-minion
        # Restart salt-minion daemon if /etc/salt/minion file is changed
        - watch:
            - file: /etc/salt/minion

# Configure Salt master in conf file
/etc/salt/minion:
  file.append:
    - text:
      - "master: 78.47.72.129"
