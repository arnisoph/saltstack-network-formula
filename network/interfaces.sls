#!jinja|yaml

{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network:lookup')) %}

{% set interfaces = datamap.interfaces.def_entries %}
{% set pkgs = datamap.interfaces.pkgs|default([]) %}

{%- macro set_p(paramname, dictvar) -%}
  {%- if paramname in dictvar -%}
- {{ paramname }}: {{ dictvar[paramname] }}
  {%- endif -%}
{%- endmacro -%}

{% if salt['pillar.get']('network:interfaces', False) %}
  {% set interfaces = interfaces + salt['pillar.get']('network:interfaces') %}
{% endif %}

{% for n in interfaces %}
network_{{ n.name }}:
  network:
    - managed
    - name: {{ n.name }}
    - enabled: {{ n.enabled|default(datamap.interfaces.default_values.enabled) }}
    - type: {{ n.type|default(datamap.interfaces.default_values.type) }}
  {% for p in datamap.interfaces.params_supported %}
    {{ set_p(p, n) }}
  {% endfor %}
  {% if n.use is defined %}
    - use:
      {% for u in n.use %}
      - network: network_{{ u }}
      {% endfor %}
  {% endif %}
  {% if n.provider is defined %}
    - provider: {{ n.provider }}
  {% endif %}
  {% if n.user is defined %}
    - user: {{ n.user }}
  {% endif %}
  {% if n.password is defined %}
    - password: {{ n.password }}
  {% endif %}
  {% if n.pppoe_iface is defined %}
    - pppoe_iface: {{ n.pppoe_iface }}
  {% endif %}
  {% if n.type|default(datamap.interfaces.default_values.type) == 'vlan' and datamap.interfaces.vlan_pkg|default('vlan') %}
    {% do pkgs.append(datamap.interfaces.vlan_pkg|default('vlan')) %}
    - require:
      - pkg: packages
  {% endif %}
{% endfor %}

{% if pkgs|length > 0 %}
packages:
  pkg:
    - installed
    - pkgs: {{ pkgs }}
{% endif %}
