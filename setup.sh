kubectl create namespace test

helm repo add litmuschaos https://litmuschaos.github.io/litmus-helm/
helm repo update

helm install chaos litmuschaos/litmus --namespace=litmus --set portal.frontend.service.type=NodePort --create-namespace
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/instance=chaos -n litmus --timeout 600s

kubectl apply -f https://raw.githubusercontent.com/litmuschaos/litmus/master/mkdocs/docs/3.6.1/litmus-portal-crds-3.6.1.yml

# POD_IP=$(kubectl get pod -n litmus -l app.kubernetes.io/component=litmus-frontend -o wide | grep -oP "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

# sed -i "s/localhost/$POD_IP/" chaos-litmus-chaos-enable.yaml 

kubectl apply -f chaos-litmus-chaos-enable.yaml

kubectl apply -f deployments -n test