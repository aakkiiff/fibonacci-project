#!/usr/bin/env bash

# This script will install EKS prerequisites on Amazon Linux or Amazon Linux 2
# * kubectl
# * aws-iam-authenticator
# * AWS CLI

set -e

mkdir -p $HOME/bin
echo 'export PATH=$HOME/bin:$PATH' >>~/.bashrc

# Install kubectl, if absent
if ! type kubectl >/dev/null 2>&1; then
	curl -o "kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/$(uname -s)/amd64/kubectl"
	chmod +x ./kubectl
	cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
	echo 'kubectl installed'
else
	echo 'kubectl already installed'
fi

# aws-iam-authenticator

if ! type aws-iam-authenticator >/dev/null 2>&1; then
	curl -o aws-iam-authenticator https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
	chmod +x ./aws-iam-authenticator
	mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
	echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
	echo 'aws-iam-authenticator installed'
else
	echo 'aws-iam-authenticator already installed'
	aws-iam-authenticator version
fi

# AWS CLI

if ! type aws >/dev/null 2>&1; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install --update
	echo 'AWS CLI installed'
else
	echo 'AWS CLI already installed'
	aws --version
fi

# eksctl
if ! type eksctl >/dev/null 2>&1; then
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	mv /tmp/eksctl $HOME/bin
	echo 'eksctl installed'
else
	echo 'eksctl already installed'
fi

# kubectx/kubens
# if ! type kubectx >/dev/null 2>&1; then
# 	git clone https://github.com/ahmetb/kubectx /opt/kubectx
# 	ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
# 	ln -s /opt/kubectx/kubens /usr/local/bin/kubens
# 	echo 'kubectx installed'
# else
# 	echo 'kubectx already installed'
# fi

# Test if AWS credentials exist
aws sts get-caller-identity