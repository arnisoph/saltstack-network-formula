#!jinja|yaml
# vim: sts=2 ts=2 sw=2 et ai

{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network')) %}

{# TODO: The function name 'routes' in 'network.routes' should be moved into the list as soon as it's possible
   for code convention reasons. Unfortunately 'routes' is also used in **kwargs when calling ip.build_routes
   in salt.states.network #}
{% for r in datamap.routes|default([]) %}
{{ r.name }}:
  network.routes:
    - routes:
  {% for n in r.networks %}
      - name: {{ n.name }}
        ipaddr: {{ n.ipaddr }}
        netmask: {{ n.netmask }}
        gateway: {{ n.gateway }}
  {% endfor %}
{% endfor %}
