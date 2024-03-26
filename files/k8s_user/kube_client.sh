if [ -f /etc/kubernetes/admin.conf ]
then
	FILE=/etc/kubernetes/admin.conf
else
	FILE=/var/tmp/admin.conf
fi

mkdir -p ${HOME}/.kube
sudo cp -i ${FILE} ${HOME}/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
