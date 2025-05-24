# test of kubernetes goed werkt

#VERBOSE=?verbose
VERBOSE=

test: k8s01 k8s02 k8s03

k8s01: k8s01control k8s01workers
	@echo
	@echo ====================
	@echo "--> $@ tested"
	@echo ====================
	@echo
k8s02: k8s02control k8s02workers
	@echo
	@echo ====================
	@echo "--> $@ tested"
	@echo ====================
	@echo
k8s03: k8s03control k8s03workers
	@echo
	@echo ====================
	@echo "--> $@ tested"
	@echo ====================
	@echo

k8s01control k8s02control k8s03control:
	@echo "--> $@ testing .."
	sleep 2
	@echo "Nodes"
	@ssh $@ echo kubectl get nodes \| sudo su - kube
	@echo -n "health: "
	@ssh $@ echo kubectl get --raw='/healthz$(VERBOSE)' \| sudo su - kube; echo
	@echo -n "livez: "
	@ssh $@ echo kubectl get --raw='/livez$(VERBOSE)' \| sudo su - kube; echo
	@echo -n "readyz: "
	@ssh $@ echo kubectl get --raw='/readyz$(VERBOSE)' \| sudo su - kube; echo
	@if [ -n "$(VERBOSE)" ]; \
	then \
		ssh $@ echo kubectl get pods --all-namespaces -o wide \| sudo su - kube; \
	fi
	@echo
	@if ssh $@ echo kubectl get pods --all-namespaces -o wide \| sudo su - kube | grep -v ^NAMESPACE | grep -vw Running; \
	then \
		echo "NOK Some pods in all namespaces are not in state Running"; \
	else \
		echo "OK: All pods in all namespaces are in state Running"; \
	fi
	@echo -n "healtz:"
	@curl --insecure https://$@:6443/healthz$(VERBOSE); echo
	@echo -n "livez:"
	@curl --insecure https://$@:6443/livez$(VERBOSE); echo
	@echo -n "readyz:"
	@curl --insecure https://$@:6443/readyz$(VERBOSE); echo
	@echo "--> $@ tested .."
	@echo

k8s01workers: k8s01worker01 k8s01worker02
	@echo "--> $@ tested .."
k8s02workers: k8s02worker01 k8s02worker02
	@echo "--> $@ tested .."
k8s03workers: k8s03worker01 k8s03worker02
	@echo "--> $@ tested .."

k8s01worker01 k8s01worker02 k8s02worker01 k8s02worker02 k8s03worker01 k8s03worker02:
	#@echo "--> testing $@ .."
	#@ssh $@ echo kubectl get nodes \| sudo su - kube
