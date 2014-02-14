{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network:lookup')) %}

{% set interfaces = datamap['default_interfaces'] %}

{% if salt['pillar.get']('network:interfaces', False) %}
  {% set interfaces = interfaces + salt['pillar.get']('network:interfaces') %}
{% endif %}

{% for n in interfaces %}
network-{{ n['name'] }}:
  network:
    - managed
    - name: {{ n['name'] }}
    - enabled: {{ n['enabled']|default(datamap['interface_defaults']['enabled']) }}
    - proto: {{ n['proto']|default(datamap['interface_defaults']['proto']) }}
    - type: {{ n['type']|default(datamap['interface_defaults']['type']) }}
  {% if n['proto'] in ['static'] %}
    {% if n['ipaddr'] is defined %}
    - ipaddr: {{ n['ipaddr'] }}
    {% endif %}
    {% if n['gateway'] is defined %}
    - gateway: {{ n['gateway'] }}
    {% endif %}
    {% if n['netmask'] is defined %}
    - netmask: {{ n['netmask'] }}
    {% endif %}
    {% if n['broadcast'] is defined %}
    - broadcast: {{ n['broadcast'] }}
    {% endif %}
  {% endif %}
{% endfor %}
