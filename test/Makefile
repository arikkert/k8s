# test of kubernetes goed werkt

test: k8s01 k8s02 k8s03

k8s01: k8s01control k8s01workers
	@echo "--> $@ tested"
k8s02: k8s02control k8s02workers
	@echo "--> $@ tested"
k8s03: k8s03control k8s03workers
	@echo "--> $@ tested"

k8s01control k8s02control k8s03control:
	@echo "--> testing $@ .."
	sleep 2
	ssh $@ echo kubectl get nodes \| sudo su - kube
	ssh $@ echo kubectl get componentstatuses \| sudo su - kube
	ssh $@ echo kubectl get pods --all-namespaces -o wide \| sudo su - kube
	@echo
	@if ssh $@ echo kubectl get pods --all-namespaces -o wide \| sudo su - kube | grep -v ^NAMESPACE | grep -vw Running; \
	then \
		echo "NOK Some pods in all namespaces are not in state Running"; \
	else \
		echo "OK: All pods in all namespaces are in state Running"; \
	fi
	curl --insecure https://$@:6443/healthz; echo
	#curl --insecure https://$@:6443/healthz?verbose
	curl --insecure https://$@:6443/livez; echo
	#curl --insecure https://$@:6443/livez?verbose
	curl --insecure https://$@:6443/readyz; echo
	#curl --insecure https://$@:6443/readyz?verbose
	@echo


k8s01workers: k8s01worker01 k8s01worker02
	@echo "--> testing $@ .."
k8s02workers: k8s02worker01 k8s02worker02
	@echo "--> testing $@ .."
k8s03workers: k8s03worker01 k8s03worker02
	@echo "--> testing $@ .."

k8s01worker01 k8s01worker02 k8s02worker01 k8s02worker02 k8s03worker01 k8s03worker02:
	ssh $@ echo kubectl get nodes \| sudo su - kube
