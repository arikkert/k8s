if [ -f /etc/kubernetes/admin.conf ]
then
	FILE=/etc/kubernetes/admin.conf
else
	FILE=/var/tmp/admin.conf
fi

mkdir -p			${HOME}/.kube
sudo cp ${FILE}			${HOME}/.kube/config
sudo chown $(id -u):$(id -g)	${HOME}/.kube/config
sudo chmod 0600			${HOME}/.kube/config
