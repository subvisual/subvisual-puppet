#!/usr/bin/env puma
# MANAGED BY PUPPET

name = "<%= @name %>"
path = "/run/deploy/#{name}/shared/sockets"
environment "<%= @env %>"

threads <%= @min_threads %>, <%= @max_threads %>

pidfile "#{path}/puma.pid"
state_path "#{path}/puma.state"

bind "unix://#{path}/puma.sock"
activate_control_app "unix://#{path}/pumactl.sock"
daemonize true
