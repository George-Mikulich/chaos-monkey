helm repo add kubemonkey https://asobti.github.io/kube-monkey/charts/repo
helm repo update

kubectl create namespace test1
kubectl create namespace test2
kubectl create namespace test3


helm install kubemonkey kubemonkey/kube-monkey \
 --version 1.5.0 --set config.dryRun=false \
 --set config.whitelistedNamespaces="{test1,test2,test3}" \
 --namespace kube-monkey --create-namespace \
 --set config.runHour=0 \
 --set config.startHour=1 \
 --set config.endHour=23 

kubectl apply -f deployments --namespace test1
kubectl apply -f deployments --namespace test2
kubectl apply -f deployments --namespace test3

kubectl wait --for=condition=Ready pod -l app=kube-monkey -n kube-monkey