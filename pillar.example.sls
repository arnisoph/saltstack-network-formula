network:
  lookup:
    interfaces:
      - name: eth0
        proto: dhcp
        type: eth
      - name: eth1
        proto: static
        ipaddr: 192.168.2.31
        netmask: 255.255.255.0
        gateway: 192.168.2.1
      - name: eth2
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
