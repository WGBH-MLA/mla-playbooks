# Ansible Playbooks and Roles for WGBH Media Library and Archives

This repository contains Ansible playbooks for provisioning virtual machines
used by WGBH Media Library and Archives.

These instructions are intended for WGBH-MLA staff, and are not expected to work
for the general public.

## Playbooks

Each Blacklight site we maintain has its own playbook here which provisions the VMs:
- openvault, for [Open Vault](https://github.com/WGBH/openvault3)
- aapb, for [American Archive](https://github.com/WGBH/AAPB2)
- bostonlocaltv, for [Boston TV News](https://github.com/WGBH/bostonlocaltv/)

The configurations are essentially identical. The redundancy is fine because our
priority is to make these simple, rather than making things more immediately complex
by factoring out the differences.

The playbook is intended to be run from a developer's computer.

### Prerequisites

Before the playbook can be run, you need to ensure the following:
  * **Ansible has been installed on your machine.**
  * **The target host has been created, and is running on AWS.**
  * **The target host allows access to port 22 from the your machine.**
  * **You have the private key required to SSH into the host.**

### Setup your local copy of the playbook

(The examples below use `openvault`, but replace as appropriate.)

1. **Clone the repository**
  ```
  git clone https://github.com/WGBH/mla-playbooks.git
  ```

1. **Copy the sample inventory file**
  ```
  cp openvault/hosts.sample openvault/hosts
  ```

1. **Edit the inventory file**

  In the `openvault/hosts` file under the `[webservers]` section, replace
  `xxx.xxx.xxx.xxx` with the target host's public IP or domain. For instance,
  if the public IP of the host is 123.123.123.123, then `openvault/hosts`
  should look like this:  
  ```
  [webservers]
  123.123.123.123
  ```

1. **Get the private key for accessing the target host with SSH and set the permissions**

  The private key must be securely obtained from a WGBH-MLA developer. By
  convention, name the private key file the same as the name of the key pair
  in AWS, and put it in your `~/.ssh/` directory.

  For instance, if the key pair used to access the host is named "openvault-
  demo", then your private key file should be at `~/.ssh/openvault-demo.pem`.

  Set the permissions of the private key file to `600`, e.g.
    ```
    chmod 600 ~/.ssh/openvault-demo.pem
    ```

### Run the playbook

From the root directory of your cloned repo, you can run the playbook using
the `ansible-playbook` command.
```
ansible-playbook -i openvault/hosts openvault/site.yml --private-key path/to/private-key.pem
```

If the playbook ran without errors, then there should be a host ready to run the Open Vault code, once it is deployed (see below).

If you got errors, please [file a bug](https://github.com/WGBH/mla-playbooks/issues).

### Deploying the website code

See [these instructions](https://github.com/WGBH/openvault3_deploy) for
deploying the Open Vault code to a provisioned host.
