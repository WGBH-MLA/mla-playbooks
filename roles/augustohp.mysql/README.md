# Ansible Role: MySQL [![Build Status](https://travis-ci.org/augustohp/ansible-role-mysql.svg?branch=master)](https://travis-ci.org/augustohp/ansible-role-mysql)

Installs MySQL server on RHEL/CentOS or Debian/Ubuntu servers.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `vars/main.yml`):

    mysql_packages:
      - mysql
      - mysql-server
      - MySQL-python

Packages to be installed. In some situations, you may need to add additional
packages, like `mysql-devel`.

    mysql_user_home: /root

The home directory inside which Python MySQL settings will be stored, which
Ansible will use when connecting to MySQL. This should be the home directory of
the user which runs this Ansible role.

    mysql_root_password: root

The MySQL root user account password.

### MySQL configuration

    mysql_port: "3306"
    mysql_datadir: /var/lib/mysql
    mysql_socket: /var/lib/mysql/mysql.sock

Default MySQL connection configuration.

    mysql_log_error: /var/log/mysqld.log
    mysql_syslog_tag: mysqld

MySQL logging configuration. Setting `mysql_log_error` to `syslog` will make
MySQL log to syslog using the `mysql_syslog_tag`.

    mysql_key_buffer_size: "256M"
    mysql_max_allowed_packet: "1M"
    mysql_table_open_cache: "256"
    [...]

The rest of the settings in `defaults/main.yml` control MySQL's memory usage.
The default values are tuned for a server where MySQL can consume ~512 MB RAM,
so you should consider adjusting them to suit your particular server better.

    mysql_include_dirs:
        - "/etc/mysql/conf.d"

All files with `.cnf` extension from the directories listed on this variable
will be included by MySQL.

### Databases and Users

    mysql_databases: []

The MySQL databases to create. A database has the values `name`, `encoding`
(defaults to `utf8`) and `collation` (defaults to `utf8_general_ci`). The
formats of these are the same as in the `mysql_db` module.

    mysql_users: []

The MySQL users and their privileges. A user has the values `name`, `host`
(defaults to `localhost`), `password` and `priv` (defaults to `*.*:USAGE`). The
formats of these are the same as in the `mysql_user` module.

### RedHat (and CentOS) only

    mysql_enablerepo: ""

If you have enabled any additional repositories (might I suggest
geerlingguy.repo-epel or geerlingguy.repo-remi), those repositories can be list
ed under this variable (e.g. `remi,epel`). This can be handy, as an example, if
you want to install later versions of MySQL.

### Multiple MySQL instances

  mysql_multi:
      - GNR: 1
        port: 3306
        pid-file: "/var/run/mysqld/mysqld1.pid"
        socket: "/var/run/mysqld/mysql1.sock"
      - GNR: 2
        port: 3307
        pid-file: "/var/run/mysqld/mysqld2.pid"
        socket: "/var/run/mysqld/mysql2.sock"
      - GNR: 3
        port: 3308
        pid-file: "/var/run/mysqld/mysqld3.pid"
        socket: "/var/run/mysqld/mysql3.sock"

Enables multiple instances of MySQL under the same host, all configurations above
(`GNR`, `port`, pid-file` and `socket`) are obrigatory.

Using multiple instances disables (the original) single instance favouring just
multiple instance management and execution.

## Example Playbook

    - hosts: db-servers
      vars_files:
        - vars/main.yml
      roles:
        - { role: augustohp.mysql }

*Inside `vars/main.yml`*:

    mysql_root_password: super-secure-password
    mysql_databases:
      - name: example_db
        encoding: latin1
        collation: latin1_general_ci
    mysql_users:
      - name: example_user
        host: "%"
        password: similarly-secure-password
        priv: "example_db.*:ALL"

## License

MIT / BSD

