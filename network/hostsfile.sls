#!jinja|yaml
# vi: set ft=yaml.jinja :

{% if salt['pillar.get']('network:hostsfile:fqdn', False) %}
network_hostsfile:
  file:
    - managed
    - name: /etc/hosts
    - source: salt://network/templates/etc_hosts.jinja
    - template: jinja
    - context:
        fqdn: {{ salt['pillar.get']('network:hostsfile:fqdn') }}
        hostname: {{ salt['pillar.get']('network:hostsfile:hostname') }}
{% endif %}
