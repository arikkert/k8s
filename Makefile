YAMLLINT=@if which yamllint > /dev/null; then yamllint $@.yml; fi
ANSIBLELINT=@if which ansible-lint > /dev/null; then ansible-lint -q $@.yml; fi
OPTIONS=--diff #--check
PLAYBOOK=ansible-playbook $(OPTIONS) $@.yml

all: check_vms main k8scontrol kube_client k8sjoin helm dashboard octant storage

check_vms main k8scontrol kube_client k8sjoin helm dashboard octant storage k8sunjoin:
	$(YAMLLINT)
	$(ANSIBLELINT)
	$(PLAYBOOK)

token:
	ssh k8scontrol echo kubectl -n kubernetes-dashboard create token admin-user \| sudo su - kube; echo
