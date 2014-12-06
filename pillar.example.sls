network:
  interfaces:
    {# Disable default interface entries #}
    interfaces:
      def_entries: []

    {# Basic Setup #}
    - name: eth0
      proto: dhcp
      type: eth
    - name: eth1
      proto: static
      ipaddr: 192.168.2.31
      netmask: 255.255.255.0
      gateway: 192.168.2.1
    - name: eth2

    {# Bridge Setup #}
    - name: eth0
      proto: static
      type: eth
      ipaddr: 172.16.34.10
      netmask: 255.255.255.0
      post_up_cmds:
        - brctl addif br0 eth0
      pre_down_cmds:
        - brctl delif br0 eth0
    - name: br0
      proto: static
      type: bridge
      ipaddr: 172.16.34.10
      netmask: 255.255.255.0
      delay: 0
      ports: eth0
      stp: off
      maxwait: 0
      fd: 0
      pre_up_cmds:
        - brctl addbr br0
      post_down_cmds:
        - brctl delbr br0
    - name: eth1
      proto: static
      type: eth
      ipaddr: 192.168.2.31
      netmask: 255.255.255.0
      gateway: 192.168.2.1
      enable_ipv6: True
      ipv6proto: static
      ipv6ipaddr: '2a03:beef:42::a'
      ipv6netmask: 64
      ipv6gateway: 'fe80::1'

  resolver:
    domain: domain.local
    search:
      - domain.local
      - another.local
    nameservers:
      - 192.168.2.1
      - 2002::beef
    options:
      - rotate
      - timeout:1

  hosts:
    - name: example.com
      ip: 192.168.2.100
    - name: example.org
      ip: 192.168.2.150
      ensure: present
    - name: example.net
      ip: 192.168.2.200
      ensure: absent

  routes:
    eth1:
      networks:
        - name: for_lan
          ipaddr: 172.16.0.0
          netmask: 255.255.0.0
          gateway: 192.168.2.1

