# GitLab + Traefik (Docker Swarm) with Vagrant and Ansible

This repository provides a lab to run GitLab and Traefik on Docker Swarm using Vagrant for the VM and Ansible for provisioning and deployment.

## Structure

- compose/ : Docker Swarm stacks (gitlab, traefik, postgres, redis)
- envs/ : GitLab and Postgres environment variables
- traefik/ : Traefik dynamic configuration
- postgres/ : Postgres init.sql
- vagrant/ : Vagrantfile to create the VM
- ansible/ : playbooks and roles to provision and deploy

## Requirements

- Vagrant
- VirtualBox
- Ansible
- Docker inside the VM (installed by the playbook)

## Key variables

Edit values in `ansible/vars/main.yml`:

- gitlab_domain, traefik_domain, traefik_alt_domain
- GitLab credentials (root/email)
- LDAP/SMTP (if applicable)
- deploy_root
- Vagrant settings (memory, cpu, ip)

## Commands

Run the commands below from the repository root.

- `make deploy`
  - creates/validates the VM with Vagrant
  - updates the Ansible inventory with the VM SSH details
  - installs Docker
  - initializes Swarm if needed
  - creates overlay networks and deploys the stacks

- `make destroy`
  - destroys the Vagrant VM
  - removes local Vagrant state

- `make vm-up`
  - brings up only the VM (no deploy)

## Notes

- The deploy uses Docker Swarm. The playbook initializes Swarm automatically.
- Overlay networks are created automatically (see `swarm_networks` in `ansible/vars/main.yml`).
- SSH access uses the Vagrant forwarded port. The inventory is updated automatically.
- If the VM is inconsistent, run `make destroy` and then `make deploy`.

## Recommended flow

1) Update variables in `ansible/vars/main.yml`
2) Run `make deploy`
3) Verify services in Docker Swarm
