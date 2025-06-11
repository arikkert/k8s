YAMLLINT=@if which yamllint > /dev/null; then yamllint $@.yml; fi
ANSIBLELINT=@if which ansible-lint > /dev/null; then ansible-lint -q $@.yml; fi
GITLEAKS=@if which gitleaks > /dev/null; then gitleaks detect . --verbose ; fi
OPTIONS=--diff #--check
PLAYBOOK=ansible-playbook $(OPTIONS) $@.yml

all: info check_vms main k8scontrol kube_client k8sjoin metrics octant k9s storage

info check_vms main k8scontrol kube_client k8sjoin metrics octant k9s storage k8sunjoin:
	$(YAMLLINT)
	$(ANSIBLELINT)
	$(PLAYBOOK)

gitleaks:
	$(GITLEAKS)
