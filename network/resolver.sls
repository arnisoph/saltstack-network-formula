#!jinja|yaml

{% from "network/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('network:lookup')) %}

resolver:
  file:
    - managed
    - name: {{ datamap.resolver.path|default('/etc/resolv.conf') }}
    - user: {{ datamap.resolver.user|default('root') }}
    - group: {{ datamap.resolver.group|default('root') }}
    - mode: {{ datamap.resolver.mode|default(644) }}
    - contents: |
{%- if salt['pillar.get']('network:resolver:file_prepend', False) %}
        {{ salt['pillar.get']('network:resolver:file_prepend') }}
{%- endif -%}
{% if salt['pillar.get']('network:resolver:domain', False) %}
        domain {{ salt['pillar.get']('network:resolver:domain') }}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:search', False) %}
        search {{ salt['pillar.get']('network:resolver:search')|join(' ') }}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:nameservers', False) -%}
  {%- for n in salt['pillar.get']('network:resolver:nameservers') %}
        nameserver {{ n }}
  {%- endfor -%}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:options', False) %}
        options {{ salt['pillar.get']('network:resolver:options')|sort|join(' ') }}
{%- endif -%}
{%- if salt['pillar.get']('network:resolver:file_append', False) %}
        {{ salt['pillar.get']('network:resolver:file_append') }}
{%- endif %}
