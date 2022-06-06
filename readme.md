
# **fibonacci project**
![project diagram](https://github.com/aakkiiff/fibonacci-project/blob/master/Project%20Diagram.jpg?raw=true)
## docker compose

Just plug and play!

 1. have docker running and `docker compose up` go to http://localhost:3050 and enjoy!

## kubeadm/eks

 1. have docker, kubectl and necessary tools to run kubernetes
 2. push your dockerfiles of client,worker,server to docker hub
 3. make sure to change my docker hub image name from k8 file with yours
 4. after pushing,`kubectl apply -f ./k8s/`
 5. run `kubectl get svc`and get the loadbalancer link and hit it.
 6. your application is running!

## jenkins ci/cd

