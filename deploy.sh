docker build -t folaraz/multi-client:latest -t folaraz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t folaraz/multi-server:latest -t folaraz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t folaraz/multi-worker:latest  -t folaraz/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push folaraz/multi-client:latest
docker push folaraz/multi-server:latest
docker push folaraz/multi-worker:latest
docker push folaraz/multi-client:$SHA
docker push folaraz/multi-server:$SHA
docker push folaraz/multi-worker:$SHA
kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=folaraz/multi-server:$SHA
kubectl set image deployments/client-deployment client=folaraz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=folaraz/multi-worker:$SHA