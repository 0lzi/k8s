# AWX install ( NON PRODUCTION READY)

https://www.youtube.com/watch?v=Nvjo2A2cBxI

1. Install k3s on server
2. Install `kubectl` & `Kustomize`
3. `kustomize build . | kubectl apply -f -`
4. Get admin password `kubectl get secret awx-admin-password -o jsonpath="{.data.password}" --namespace awx | base64 --decode`