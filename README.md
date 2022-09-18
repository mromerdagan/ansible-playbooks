
### How to use the playbook locally

    ansible-playbook \
    	--connection=local \
    	--inventory 127.0.0.1, \
    	--limit 127.0.0.1  \
    	playbooks/omerd-bringup.yml -i inventory/hosts
