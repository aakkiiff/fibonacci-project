docker build -t akifboi/multi-client:latest -t akifboi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akifboi/multi-server:latest -t akifboi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akifboi/multi-worker:latest -t akifboi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akifboi/multi-client:latest
docker push akifboi/multi-server:latest
docker push akifboi/multi-worker:latest

docker push akifboi/multi-client:$SHA
docker push akifboi/multi-server:$SHA
docker push akifboi/multi-worker:$SHA

echo "starting"
aws eks --region ap-south-1 describe-cluster --name test001 --query cluster.status 
echo "applying k8 files"
kubectl apply -f ./k8s/
kubectl set image deployments/server-deployment server=akifboi/multi-server:$SHA
kubectl set image deployments/client-deployment client=akifboi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akifboi/multi-worker:$SHA

echo "done"