
# **fibonacci project**
![project diagram](https://github.com/aakkiiff/fibonacci-project/blob/master/Project%20Diagram.jpg?raw=true)
## docker compose

Just plug and play!

 1. have docker running and `docker compose up` go to http://localhost:3050 and enjoy!

## kubeadm/eks
 1. have docker, kubectl and necessary tools to run kubernetes
 2. have kubeadm/eks running
 3. push your dockerfiles of client,worker,server to docker hub
 4. make sure to change my docker hub image name from k8 file with yours
 5. **for eks:** update the kubernetes context of your machiine by`aws eks --region ap-south-1 update-kubeconfig --name eks-cluster-name`
 7. then `kubectl apply -f ./k8s/`
 8. run `kubectl get svc`and get the loadbalancer link and hit it.
 9. your application is running!

## travisci cicd

 1. integrate the github repository with the travis ci account
 2. add environment variables, used in the .tavis.yml file to the travis console
 3. everything should be ready by now,just push the code to the github and this will trigger the travis ci job which will build and push docker image to your docker account(make sure to use your own docker account and image name and update the info at the k8.yml and travis file)
 4. ultimetly travis will deploy the k8s.yml files to the cluster and your app should be live by now!

**important**
if using different aws account to create eks cluster and another for travis ci ,then travis ci will not be permitted to deploy the k8s.yml file to the cluster unless given permission by the creator of the cluster
for this 

 1. have eksctl running
 2.  `eksctl  create  iamidentitymapping  --cluster  $eksclustername --region=ap-south-1  --arn  theRoleArnOfTheNewUser  --group  system:masters  --no-duplicate-arns`
 3. now the new user/role is given permission to deploy files on the cluster
