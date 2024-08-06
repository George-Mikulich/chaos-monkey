helm repo add spinnaker https://opsmx.github.io/spinnaker-helm/
helm repo update

helm install spinnaker spinnaker/spinnaker -n spinnaker --create-namespace
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/instance=spinnaker -n spinnaker