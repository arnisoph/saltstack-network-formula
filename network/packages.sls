#!jinja|yaml

{% for action, pkgs in salt['pillar.get']('network:pkgs', {}).iteritems() %}
network_pkgs_{{ action }}:
  pkg.{{ action }}:
    - pkgs: {{ pkgs }}
{% endfor %}
