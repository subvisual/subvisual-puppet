#!/usr/bin/env puma
# MANAGED BY PUPPET

name = "<%= @name %>"
path = "/var/www/#{name}/shared/sockets"
environment "<%= @env %>"
quiet

threads <%= @min_threads %>, <%= @max_threads %>

pidfile "#{path}/puma.pid"
state_path "#{path}/puma.state"

bind "unix://#{path}/puma.sock"
activate_control_app "unix://#{path}/pumactl.sock"
daemonize true