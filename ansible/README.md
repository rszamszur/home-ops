# Ansible automation

## Getting started

To have a reproducible environment for Ansible execution run the following [script](https://github.com/rszamszur/home-k8s/blob/master/ansible/run_ansible_env.sh):

```shell
$ ./run_ansible_env.sh
Found podman container engine.
bash-4.4# cd /workspace/
bash-4.4# ansible-playbook update_known_hosts.yml
bash-4.4# ansible rock64nodes -m ping --user YOUR_USERNAME --ask-pass
SSH password:
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
192.168.0.47 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
192.168.0.46 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
192.168.0.49 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
192.168.0.45 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
192.168.0.48 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

or with `nix-shell`:

```shell
nix-shell shell.nix
ansible-playbook update_known_hosts.yml
ansible rock64nodes -m ping --user YOUR_USERNAME --ask-pass
```

### Usage

```shell
./run_ansible_env.sh
cd /workspace
ansible-playbook update_know_hosts.yml
ansible-playbook $PLAYBOOK --user YOUR_USERNAME --ask-pass --ask-become-pass
```

Alternatively, you can provide secrets via hosts file although it's not recommended.
```
[rock64nodes:vars]
ansible_ssh_pass=***
ansible_sudo_pass=****
```

If you really want to store secrets, then research the topic of ansible vaults.

Lastly you want to execute playbook only on certain nodes from group use [--limit](https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html#patterns-and-ad-hoc-commands)
```shell
ansible-playbook $PLAYBOOK --user YOUR_USERNAME --ask-pass --ask-become-pass --limit "192.168.0.47"
```

## Ansible inventory

### Hosts

#### rock64nodes

[Clustered Pine64 Rock64 boards]() - worker nodes.

* 192.168.0.45
* 192.168.0.46
* 192.168.0.47
* 192.168.0.48
* 192.168.0.49


### Playbooks

#### update_known_hosts

Hosts: localhost

Store known hosts of all the hosts in the inventory file:
* For each host, scan for its ssh public key
* Ensure user .ssh directory exists 
* Add/update the public key in the `{{ ssh_known_hosts_file }}`

### propagate_ssh_pub

Hosts: rock64nodes

Propagate ssh pub key to hosts:
* Ensure ssh key entry in authorized_key

