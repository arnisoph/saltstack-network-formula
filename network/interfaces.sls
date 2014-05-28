#!jinja|yaml

{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network:lookup')) %}

{% set interfaces = datamap.interfaces.def_entries %}

{%- macro set_p(paramname, dictvar) -%}
  {%- if paramname in dictvar -%}
- {{ paramname }}: {{ dictvar[paramname] }}
  {%- endif -%}
{%- endmacro -%}

{% if salt['pillar.get']('network:interfaces', False) %}
  {% set interfaces = interfaces + salt['pillar.get']('network:interfaces') %}
{% endif %}

{% for n in interfaces %}
network-{{ n.name }}:
  network:
    - managed
    - name: {{ n.name }}
    - enabled: {{ n.enabled|default(datamap.interfaces.values.enabled) }}
    - proto: {{ n.proto|default(datamap.interfaces.values.proto) }}
    - type: {{ n.type|default(datamap.interfaces.values.type) }}
    {% for p in datamap.interfaces.params_supported %}
    {{ set_p(p, n) }}
    {% endfor %}
    {% if n.use is defined %}
    - use:
      {% for u in n.use %}
      - network: network-{{ u }}
      {% endfor %}
    {% endif %}
{% endfor %}
