docker build -t jith912/multi-client:latest -t jith912/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jith912/multi-server:latest -t jith912/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jith912/multi-worker:latest -t jith912/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jith912/multi-client:latest
docker push jith912/multi-server:latest
docker push jith912/multi-worker:latest

docker push jith912/multi-client:$SHA
docker push jith912/multi-server:$SHA
docker push jith912/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jith912/multi-server:$SHA
kubectl set image deployments/client-deployment client=jith912/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jith912/multi-worker:$SHA