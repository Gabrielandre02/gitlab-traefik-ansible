ANSIBLE_PLAYBOOK ?= ansible-playbook
ANSIBLE_CFG ?= ansible/ansible.cfg
VAGRANT_DIR ?= vagrant

.PHONY: up vm-up deploy destroy

up: vm-up deploy

vm-up:
	ANSIBLE_CONFIG=$(ANSIBLE_CFG) $(ANSIBLE_PLAYBOOK) ansible/playbooks/vagrant.yml

deploy: vm-up
	ANSIBLE_CONFIG=$(ANSIBLE_CFG) $(ANSIBLE_PLAYBOOK) ansible/playbooks/deploy.yml

destroy:
	ANSIBLE_CONFIG=$(ANSIBLE_CFG) $(ANSIBLE_PLAYBOOK) ansible/playbooks/destroy.yml
