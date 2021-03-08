# install docker

sudo apt update && sudo apt upgrade -y

curl -fsSL https://get.docker.com -o get-docker.sh

sh get-docker.sh

sudo usermod -aG docker $USER

sudo systemctl enable docker

# ip tables pre-req

sudo iptables -F
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# append "cgroup_memory=1 cgroup_enable=memory" to /boot/cmdline.txt

#RPi
echo cgroup_memory=1 cgroup_enable=memory | sudo tee -a /boot/cmdline.txt

#Ubuntu Pi?
echo cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1 | sudo tee -a /boot/cmdline.txt

# master node oneliner

curl -sfL https://get.k3s.io | 	INSTALL_K3S_EXEC="--docker --write-kubeconfig-mode 644" sh -

# get token

sudo cat /var/lib/rancher/k3s/server/token

# export node token 

export NODE_TOKEN=[token here]

# node oneliner

curl -sfL https://get.k3s.io | K3S_TOKEN=${NODE_TOKEN} K3S_URL=https://192.168.1.16:6443 INSTALL_K3S_EXEC="--docker" sh -