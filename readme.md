
  

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

5.  **for eks:** update the kubernetes context of your machiine by`aws eks --region ap-south-1 update-kubeconfig --name eks-cluster-name`

7. then `kubectl apply -f ./k8s/`

8. run `kubectl get svc`and get the loadbalancer link and hit it.

9. your application is running!

  

## travisci cicd

  

1. integrate the github repository with the travis ci account

2. add environment variables, used in the .tavis.yml file to the travis console

3. everything should be ready by now,just push the code to the github and this will trigger the travis ci job which will build and push docker image to your docker account(make sure to use your own docker account and image name and update the info at the k8.yml and travis file)

4. ultimetly travis will deploy the k8s.yml files to the cluster and your app should be live by now!

  

## **important**

  

***if using different aws account to create eks cluster and another for travis ci ,then travis ci will not be permitted to deploy the k8s.yml file to the cluster unless given permission by the creator of the cluster

for this***

  

1. have eksctl running

2.  `eksctl create iamidentitymapping --cluster $eksclustername --region=ap-south-1 --arn theRoleArnOfTheNewUser --group system:masters --no-duplicate-arns`

3. now the new user/role is given permission to deploy files on the cluster

# aws cicd

 1. buildspec.yml file is the main file aws codebuild would be looking for.and buildspec.yml file triggers prereqsbuildspec.sh file.
 2. create eks cluster manually or `eksctl create cluster -f cluster.yml`
 3. make your ecr repo and send the images to it and change the image url of ur deployment file
 4. make a aws code commit repo.configure your system so that u push your code to codecommit
 5. make a aws code pipeline which is triggered by cloudwatch on once a code pushed to codecommit and configure aws codebuild to build it
 6. get your codecommit role arn and give it permission to work on k8s cluster [reference aws doc](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)`eksctl create iamidentitymapping --cluster test001(clustername) --region=ap-south-1 --arn arn:aws:iam::137440810107:role/codebuild-test0-service-role --group system:masters --no-duplicate-arns`
 7. add environment variables in your pipeline
 8. add these permissions to your codebuild role
 9. [ ] AmazonEC2ContainerRegistryFullAccess
 10. [ ] AmazonS3FullAccess
 11. [ ] AWSCodeBuildAdminAccess
 12. [ ] CloudWatchLogsFullAccess
 13. [ ] AWSCodeCommitFullAccess
 14. [ ] eks-describe
 15. [x] ***or just give it admin privilliges if u dont want to be that much granular***
 16. u should be good to go now,just push the code to codecommit and see ur website live!

# jenkins cicd

 1. have kubectl,docker,eksctl,awscli installed on jenkins server
 2. add github webhook to trigger jenkins build on commit
 3. use ngrok if using local machine [ngrok tutorial](https://youtu.be/adVWQc8T9qg)
 4. create eks cluster
 5. update eks context on jenkins server`aws configure on the server && server iam authorization eksctl create iamidentitymapping --cluster test001(clustername) --region=ap-south-1 --arn arn:aws:iam::137440810107:role/codebuild-test0-service-role --group system:masters --no-duplicate-arns`
 6. make a jenkins pipeline job and paste the jenkinsfile contents there.
 7. make a jenkins freestyle job which gets triggered on github push on master branch,and add to trigger pipeline job as post build action.
 8. you are good to go!
