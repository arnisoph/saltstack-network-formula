network:
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
