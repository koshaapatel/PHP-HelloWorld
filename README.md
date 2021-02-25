# Task 0: Install a ubuntu 16.04 server 64-bit

● Download: ​http://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso
● Download: ​https://www.virtualbox.org/
● LAMP server and OpenSSH server are installed in virtualbox.
for VM, use NAT network and forward required ports to host machine
Go to: Settings > Network > Advanced > Port Forwarding and set rules as:

# Task 1: Update system

ssh to guest machine from host machine ($ ssh user@localhost -p 2222) and update the system
to the latest

## ● ssh kosha@localhost -p 2222

## ● sudo apt-get update

## ● sudo apt-get upgrade

## ● sudo reboot


upgrade the kernel to the 16.04 latest

## ● sudo apt-get install --install-recommends

## linux-generic-hwe-16.04 -y

## ● uname -r

# Task 2: Install LAMP stack in the host

Expect output: http server is up and running at ​http://127.0.0.1​ (no tls or FQDN required)
Access it from host machine ​http://127.0.0.1:
Phpmyadmin is also up and running and can connect to the backend mysql db.
Access it from host machine ​http://127.0.0.1:8080/phpmyadmin


# Task 3: Create a demo hello world project in your personal github repo

https://github.com/koshaapatel/PHP-HelloWorld

# Task 4. Create a demo hello world php page

## ● cd “/var/www/html”

## ● touch index.php

## ● sudo nano index.php #edit the file

## ● cd "/etc/apache2/"

## ● sudo nano ports.conf

## ● cd "sites-enabled"

## ● sudo nano apache2.conf

## ● cd "/etc/apache2/mods-available"

## ● Sudo nano dir.conf


## ● sudo systemctl restart apache

Expect output:
curl [http://127.0.0.1:](http://127.0.0.1:)

# Task 5: Install docker

# ● sudo ​apt-get update

# ● sudo ​apt-get install apt-transport-https ca-certificates ​\

## curl gnupg-agent software-properties-common

## ● curl ​-fsSL​ https://download.docker.com/linux/ubuntu/gpg |

## sudo ​apt-key add -


## ● sudo ​add-apt-repository ​"deb [arch=amd64]

## https://download.docker.com/linux/ubuntu ​$(​lsb_release ​-cs)

## stable"

## ● sudo ​apt-get update

## ● sudo ​apt-get install docker-ce docker-ce-cli containerd.io

# Task 6: Run the app in container

## ● Cd /“var/www/html”

## ● touch Dockerfile

## ● sudo nano Dockerfile

build a docker image ($ docker build) for the web app and run that in a container ($ docker run),
expose the service to 8082 (-p)

## ● sudo docker build -t phpdemo:v.

## ● sudo docker container list

## ● sudo docker run -d -p8082:80 phpdemo:v

Check in the Dockerfile into github
Expect output:
curl [http://127.0.0.1:](http://127.0.0.1:)


What if to build the mysql and phpmyadmin in the container as well?
Because 8082 port is in used, I configured phpmyadmin to run on 8084.

## ● docker pull mysql:8.0.

## ● docker run --name my-own-mysql -e

## MYSQL_ROOT_PASSWORD=mypass123 -d mysql:8.0.

## ● docker pull phpmyadmin/phpmyadmin:latest

## ● docker run --name my-own-phpmyadmin -d --link

## my-own-mysql:db -p 8084:80 phpmyadmin/phpmyadmin

curl ​http://127.0.0.1:


# Task 7: Push image to dockerhub

## ● sudo docker tag phpdemo:v1 koshapatel/phpdemo

## ● sudo docker push koshapatel/phpdemo

Expect output: ​https://hub.docker.com/r/koshapatel/phpdemo

# Task 8: Document the procedure in a MarkDown file

# Task 9: Install a single node Kubernetes cluster using kubeadm

1. Kubeadm Installation​-​Letting iptables see bridged traffic

## ● cat ​<<EOF | sudo tee /etc/modules-load.d/k8s.conf

## br_netfilter

## EOF

## ● cat ​<<EOF | sudo tee /etc/sysctl.d/k8s.conf

## net.bridge.bridge-nf-call-ip6tables = 1

## net.bridge.bridge-nf-call-iptables = 1

## EOF

## ● sudo sysctl --system

2. Kubeadm, Kubectl, Kubelet installation

## ● sudo apt-get update ​&&​ sudo apt-get install -y

## apt-transport-https curl

## ● curl -s

## https://packages.cloud.google.com/apt/doc/apt-key.gpg

## | sudo apt-key add -

## ● cat ​<<EOF | sudo tee

## /etc/apt/sources.list.d/kubernetes.list

## ● deb https://apt.kubernetes.io/ kubernetes-xenial main

## ● EOF

## ● sudo apt-get update

## ● sudo apt-get install -y kubelet kubeadm kubectl

## ● sudo apt-mark hold kubelet kubeadm kubectl

3. Kubeadm init

## ● kubeadm init

```
While performing this task, I encountered an error: ​running with swap on is not
supported. Please disable swap. I resolved it by the following command:
```

## ● Sudo sed -i ‘/ swap / s/^\(.*\)$/#\1/g’ /etc/fstab

## ● Sudo swapoff -a

## ● systemctl daemon-reload

## ● systemctl restart kubelet

## ● kubeadm init

admin.conf : ​https://github.com/koshaapatel/PHP-HelloWorld

# Task 10: Deploy the hello world container

in the kubernetes above and expose the service to nodePort 31080
On master node, we shouldn’t deploy container. I wanted to create another virtual machine. I
wanted to create worker nodes on another machine where I would have used kubeadm join. But
I allocated 3 CPU to existing virtual system on which I was already working so, I decided to
deploy container on master node. I got rid of the taints by following command which was an
obstacle I faced as well.

## ● kubectl get nodes -o json | jq '.items[].spec.taints'

## ● kubectl taint nodes --all node-role.kubernetes.io/master-

There was an error related to ​network plugin is not ready: cni config uninitialized. It was
resolved by following command.

## ● Kubectl apply -f

## https://docs.projectcalico.org/manifests/calico.yaml

To start the cluster perform this

## ● mkdir -p ​$HOME​/.kube


## ● sudo cp -i /etc/kubernetes/admin.conf ​$HOME​/.kube/config

## ● sudo chown ​ $( ​id -u​ ) ​:​ $( ​id -g​ ) ​ ​$HOME​/.kube/config

To install pod network add-on

## ● kubectl apply -f hello-world.yaml

Expect output:
curl [http://127.0.0.1:](http://127.0.0.1:)

# Task 11: Install kubernetes dashboard


and expose the service to nodeport 31081
Run this on separate powershell:

## ● kubectl proxy

## ● kubectl apply -f

## https://raw.githubusercontent.com/kubernetes/dashboard/v2.

## .0/aio/deploy/recommended.yaml

## ● curl

## http://localhost:8001/api/v1/namespaces/kubernetes-dashboar

## d/services/https:kubernetes-dashboard:/proxy/

# Task 12: Generate token for dashboard login in task 11

figure out how to generate a token to login to the dashboard and publish the procedure to the
github.

## ● kubectl get secret -n kube-system | grep k8s

## ● kubectl apply -f sa.yaml

## ● kubectl apply -f crb.yaml

## ● kubectl -n kube-system describe secret $(kubectl -n

## kube-system get secret | grep admin-user | awk '{print

## $1}')


# Task 13: Thoughts for improvement

```
● Improvement on Task 10 is possible by creating worker nodes on another machine and
use kubeadm join since deployment should not be performed on master node.
```
# Task 14: Publish your work

https://github.com/koshaapatel/PHP-HelloWorld


