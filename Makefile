YAMLLINT=@if which yamllint > /dev/null; then yamllint $@.yml; fi
ANSIBLELINT=@if which ansible-lint > /dev/null; then ansible-lint -q $@.yml; fi
OPTIONS=--diff #--check
PLAYBOOK=ansible-playbook $(OPTIONS) $@.yml

all: info check_vms main k8scontrol kube_client k8sjoin helm metrics octant storage

info check_vms main k8scontrol kube_client k8sjoin helm metrics octant storage k8sunjoin:
	$(YAMLLINT)
	$(ANSIBLELINT)
	$(PLAYBOOK)
