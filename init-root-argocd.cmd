
kubectl create namespace argocd

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd --namespace argocd -f apps/argocd/values.yaml

REM Wait for ArgoCD to be ready
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

REM Apply the root app of apps
kubectl apply -f root-app.yaml

REM Wait a bit for the root app to sync
timeout /t 10

REM Apply the argocd self-management app
kubectl apply -f apps/argocd/application.yaml

REM Get the admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

