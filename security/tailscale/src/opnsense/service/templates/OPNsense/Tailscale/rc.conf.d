# DO NOT EDIT
# THIS FILE IS AUTOMATICALLY GENERATED - ANY CHANGES WILL BE OVERWRITTEN
#
{%  if not helpers.empty('OPNsense.tailscale.settings.enabled')  %}
tailscaled_enable="YES"
# Uncommenting the below breaks being able to access subnets
# see - https://github.com/tailscale/tailscale/issues/5573#issuecomment-1584695981
# tailscaled_env="TS_DEBUG_NETSTACK_SUBNETS=0"
{%    if helpers.exists('OPNsense.tailscale.settings.listenPort') %}
tailscaled_port="{{ OPNsense.tailscale.settings.listenPort }}"
{%    endif %}
{%    set up_args = [] %}
{%    if helpers.exists('OPNsense.tailscale.settings.advertiseExitNode') and OPNsense.tailscale.settings.advertiseExitNode|default("0") == "1" %}
{%      do up_args.append("--advertise-exit-node") %}
{%    else %}
{%      do up_args.append("--advertise-exit-node=false") %}
{%    endif %}
{%    if helpers.exists('OPNsense.tailscale.settings.acceptSubnetRoutes') and OPNsense.tailscale.settings.acceptSubnetRoutes|default("0") == "1" %}
{%      do up_args.append("--accept-routes") %}
{%    else %}
{%      do up_args.append("--accept-routes=false") %}
{%    endif %}
{%    if helpers.exists('OPNsense.tailscale.settings.acceptDNS') and OPNsense.tailscale.settings.acceptDNS|default("0") == "1" %}
{%      do up_args.append("--accept-dns") %}
{%    else %}
{%      do up_args.append("--accept-dns=false") %}
{%    endif %}
{%    if helpers.exists('OPNsense.tailscale.settings.enableSSH') and OPNsense.tailscale.settings.enableSSH|default("0") == "1" %}
{%      do up_args.append("--ssh=true") %}
{%    else %}
{%      do up_args.append("--ssh=false") %}
{%    endif %}
{%    if helpers.exists('OPNsense.tailscale.authentication.loginServer') %}
{%      do up_args.append("--login-server=" + OPNsense.tailscale.authentication.loginServer) %}
{%    endif %}
{%    if helpers.exists('OPNsense.tailscale.authentication.preAuthKey') %}
{%      do up_args.append("--auth-key=" + OPNsense.tailscale.authentication.preAuthKey) %}
{%    else %}
{%      do up_args.append("--auth-key=non-specified") %}
{%    endif %}
{#  loop through subnets to build list #}
{%    if helpers.exists('OPNsense.tailscale.settings.subnets.subnet4') %}
{%      set subnets = [] %}
{%      for subnet_list in helpers.toList('OPNsense.tailscale.settings.subnets.subnet4') %}
{%        do subnets.append(subnet_list.subnet) %}
{%      endfor %}
{%      set subnetString = subnets|join(',') %}
{%      do up_args.append("--advertise-routes=" + subnetString) %}
{%    else %}
{%      do up_args.append("--advertise-routes=") %}
{%    endif %}
tailscaled_up_args="{{ up_args|join(' ') }}"
{%  else %}
tailscaled_enable=NO
{%  endif %}
