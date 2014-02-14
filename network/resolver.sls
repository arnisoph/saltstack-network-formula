{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network:lookup')) %}

resolver:
  file:
    - managed
    - name: {{ datamap['resolver']['path'] }}
    - mode: '0644'
    - user: root
    - group: root
    - contents: |
{%- if salt['pillar.get']('network:resolver:file_prepend') is defined %}
        {{ salt['pillar.get']('network:resolver:file_prepend') }}
{%- endif -%}
{% if salt['pillar.get']('network:resolver:domain') is defined %}
        domain: {{ salt['pillar.get']('network:resolver:domain') }}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:search') is defined %}
        search: {{ salt['pillar.get']('network:resolver:search') }}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:nameservers') is defined -%}
  {%- for n in salt['pillar.get']('network:resolver:nameservers') %}
        nameserver: {{ n }}
  {%- endfor -%}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:options') is defined %}
        options: {{ salt['pillar.get']('network:resolver:options')|join(' ') }}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:file_append') is defined %}
        {{ salt['pillar.get']('network:resolver:file_append') }}
{%- endif %}
