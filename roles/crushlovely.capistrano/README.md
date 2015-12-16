# Ansible Role For Capistrano Base Directories

[![Build Status](https://circleci.com/gh/crushlovely/ansible-capistrano.svg?style=shield)](https://github.com/crushlovely/ansible-capistrano)
[![Current Version](http://img.shields.io/github/release/crushlovely/ansible-capistrano.svg?style=flat)](https://galaxy.ansible.com/list#/roles/2370)

This Ansible role creates the paths required by capistrano to install the app.

## Installation

``` bash
$ ansible-galaxy install crushlovely.capistrano,v1.0.0
```

## Variables

``` yaml
app_path: /home/ubuntu/test
app:
  user: ubuntu
  group: ubuntu
```

## Usage

Once this role is installed on your system, include it in the roles list of your playbook.

``` yaml
- hosts: localhost
  roles:
    - crushlovely.capistrano
```

## Dependencies

None

## License

MIT