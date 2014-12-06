#!jinja|yaml

{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network')) %}

{# TODO: The function name 'routes' in 'network.routes' should be moved into the list as soon as it's possible
   for code convention reasons. Unfortunately 'routes' is also used in **kwargs when calling ip.build_routes
   in salt.states.network #}

{% for k, v in datamap.routes|default({})|dictsort %}
routes_{{ v.name|default(k) }}:
  network.routes:
    - name: {{ v.name|default(k) }}
    - routes:
  {% for net in v.networks %}
      - name: {{ net.name }}
        ipaddr: {{ net.ipaddr }}
        netmask: {{ net.netmask }}
        gateway: {{ net.gateway }}
  {% endfor %}
{% endfor %}
