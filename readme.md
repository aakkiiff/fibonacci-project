
# Fibonacci Project The GitOps Way And Applying Kubernetes Best Practices

  

**APP DIAGRAM:**

![- diagram of app](https://github.com/aakkiiff/fibonacci-project/blob/master/Project%20Diagram.jpg?raw=true)

  

**Pipeline Diagram**
![enter image description here](https://github.com/aakkiiff/fibonacci-project/blob/master/Pipelinediagram.jpg?raw=true)

## what tools will be used
- Docker
- Jenkins
- Kubernetes
- aws

## what this app does
this app inputs the a number from the user,which is denoted as the index of fibonacci sequence,the worker calculates the fibonacci number of that index and pushes to redis,redis stores submitted number and calculated value,postgres only stores submitted number
  

## Step 1: Setting Github repo
2 repos.
one is for the application code
another one is for the Kubernetes manifest files
 
## step 2: Setting Jenkins CI pipeline

***code -> github(app repo) ->jenkinspipeline1 -> jenkinspipeline2 -> deployment file tag update*** 

1.  Start a ec2, install docker,jenkins,open port 8080 and start the jenkins server
2.  install plugin **Generic Webhook Trigger**
3. make a pipeline,configure it,generic webhook trigger,token=sad,and jenkinsfile would be pipeline script from scm
4. go to github main repo and configure webhook trigger,application/json,only push event send,url will be, 
	

    http:// JENKINS U R L/generic-webhook-trigger/invoke?token=sad
   
5. now add dockerhub credential in jenkins global creds
6. docker creds were got from docker hub access tokens
7. now make a new jenkins pipeline and use that name in the previous app repository's jenkins file,so that its invoked once the 1st jenkins pipeline is completed
8. now configure 2nds pipeline,check the project is parameterized,and get the jenkins file from git scm.

all done,lets start pushing the code to the github and see the whole process automated
  

## step 3: Setting EKS cluster
1. install awscli2,eksctl,kubectl in your device
2. get aws access key and secret access key.configure your awscli
3. `eksctl create cluster -f cluster.yaml`
your cluster will be up and running in 20mins
  

## step 4: installing kubernetes ingress nginx

[Kubernetes/ingress-nginx - click here for installation docs](https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx)

## step 5: installing ARGOCD, CD pipeline
[argo cd get started](https://argo-cd.readthedocs.io/en/stable/getting_started/)
# covering later

- domain setup

- postgre persistent volume ebs set up

- secrets maybe in secret manager?

- tls encryption internal communication

- farget?

- research more what should be added next?
