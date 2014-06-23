#!jinja|yaml
# vim: sts=2 ts=2 sw=2 et ai
{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network')) %}

{% for r in datamap.routes %}
{{ r.name }}:
  network.routes:
    - name: {{ r.name }} 
    - routes:
      {% for n in r.networks %}
      - name: {{ n.name }} 
        ipaddr: {{ n.ipaddr }}
        netmask: {{ n.netmask }} 
        gateway: {{ n.gateway }} 
      {% endfor %}
{% endfor %}
