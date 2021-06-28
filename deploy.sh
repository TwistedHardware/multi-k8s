docker build -t twistedhardware/multi-client:latest -t twistedhardware/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t twistedhardware/multi-server:latest -t twistedhardware/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t twistedhardware/multi-worker:latest -t twistedhardware/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push twistedhardware/multi-client:latest
docker push twistedhardware/multi-server:latest
docker push twistedhardware/multi-worker:latest
docker push twistedhardware/multi-client:$SHA
docker push twistedhardware/multi-server:$SHA
docker push twistedhardware/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deplyments/client-deployment client=twistedhardware/multi-client:$SHA
kubectl set image deplyments/server-deployment server=twistedhardware/multi-server:$SHA
kubectl set image deplyments/worker-deployment worker=twistedhardware/multi-worker:$SHA