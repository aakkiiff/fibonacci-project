
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
- Argo cd
## what this app does
this app inputs the a number from the user,which is denoted as the index of fibonacci sequence,the worker calculates the fibonacci number of that index and pushes to redis,redis stores submitted number and calculated value,postgres only stores submitted number
  

## Step 1: Setting Github repo
2 repos.
one is for the application code
another one is for the Kubernetes manifest files  [click here](https://github.com/aakkiiff/fibonacci-project-config)
 
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

# provisioning ebs dynamic volume
1.[aws docs to install EBS CSI driver](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)

***caviates:***
1. eks cluster had 2 nodes,but the postgre deployment(which is claiming pv using ebs driver) was scheduling only 1 node! why?

	**FINDING:** EBS Vol. is created in a specific Availability Zone (AZ). If your EKS nodes are in different AZs, and the pods are requesting EBS volumes with a specific AZ specified, then the pods will only be scheduled on the node in the same AZ as the EBS volume.

	**SOLUTION:**  
	Deploy your EKS nodes in the same AZ as the EBS volumes that your pods are using. This ensures that your pods are always scheduled on a node that can access the EBS volumes.Wrong solution, if you need to deploy multiple nodes in multiple AZs to ensure high availability.

	Use a different storage solution that is not tied to a specific AZ, such as Amazon Elastic File System (EFS). EFS volumes can be accessed by nodes in any AZ within the same region, allowing your pods to be scheduled on any node in any AZ. However, EFS may not be suitable for all workloads and may have higher latency compared to EBS.
# provisioning efs dynamic volume  
[aws efs eks demo](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html)

# covering later
  1. logging:
  - fluentd -> cloudwatch ->elastic search -> kibana (monitor container logs)
  - controlplane logging (one click eks console,aggregates to cloudwatch)
  2. monitoring:
  - metrics collected by prometheus -> grafana visualization (monitor metrics)
  - cloudwatch container log insights to check container metrics,logs,fire lambda,alarm
  3. scalling
   - vpa
   - hpa
   - goldilocks
   - cluster auto scaller
   - kubecost
  4. others:
   - aws secrets manager for secrets
   - ebs dynamic provision
   - efs
   - init containers
   - domain setup?