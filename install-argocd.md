# install 

```
kubectl create namespace argocd

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm install argocd argo/argo-cd --namespace argocd

# optional customization:
# helm show values argo/argo-cd > argocd-values.yaml
# helm install argocd argo/argo-cd -n argocd -f argocd-values.yaml

# get the pwd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# it is advised to delete the pwd:
# [https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli](https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)

# port forward:
kubectl port-forward service/argocd-server -n argocd 8080:443

```