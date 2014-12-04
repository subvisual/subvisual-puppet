# GB Puppet

A Puppet module and a few helper scripts to set up web servers

# Puppet module

The module contains common patterns to be used in puppet manifests accross different web applications. It is available on [puppet forge](https://forge.puppetlabs.com/groupbuddies/gb).

# Provisioning a machine

## 1. Base provisioning

For the default base setup for a web server, the `ubuntu` helper script can be
applied. To use it, SSH into a newly created machine, and run this command:

```bash
curl -s https://raw.githubusercontent.com/groupbuddies/gb-puppet/master/setup/ubuntu > install
chmod +x install
./install
```

This will:

* install some base packages (git, puppet)
* create a `deploy` user. You will be prompted for a password at the end
* Add all of [GB's public keys](https://github.com/groupbuddies/public-keys) to the `deploy` user
* ensure `/var/www` (where all web apps will go) belongs to the `deploy` user
* enable Upstart session jobs
* install nginx

## 2. App provisioning

At this step, it is assumed the machine is ready with the setup described in [base provisioning](#1-base-provisioning).

This will be app-specific. For each app, a puppet manifest and a hiera data file is needed. The later one is used to store sensitive data (and thus should not be commited to git). Here's an example for an app that uses ruby 2.1.5 and a PostgreSQL database, and is deployed with Capistrano:

```puppet
# manifest.pp
$data = hiera('common')
gb::ruby { 'ruby-2.1.5': }

gb::postgresql { 'app_name':
  password => $data[app_name][db_password],
}

gb::capistrano { 'app_name': }

gb::nginx_conf { 'app_name':
  path => 'config/nginx.production.conf',
}
```

```yaml
# common.yaml
---
common:
  app_name:
    db_password: "a-random-p4ssw0rd"
```

The `setup/app` helper script  assists with getting these files on the server and provisioning it. No SSH needed at this stage:

```bash
curl -s https://raw.githubusercontent.com/groupbuddies/gb-puppet/master/setup/app > install-app
chmod +x install-app
./install-app
```

The script will prompt you for a few things:

* The hostname or IP address of the server
* The SSH port to use (defaults to 22)
* path to the manifest
* path to the hiera data

The script will upload both files to the server and apply the puppet manifest.
