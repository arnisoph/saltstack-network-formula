{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network:lookup')) %}

{% set hosts = datamap['default_hosts'] %}

{% if salt['pillar.get']('network:hosts', False) %}
  {% set hosts = hosts + salt['pillar.get']('network:hosts') %}
{% endif %}

{% for h in hosts %}
host-{{ h['name'] }}_{{ h['ip'] }}:
  host:
    - {{ h['ensure']|default(datamap['host_defaults']['ensure']) }}
    - ip: {{ h['ip'] }}
    - name: {{ h['name'] }}
{% endfor %}
