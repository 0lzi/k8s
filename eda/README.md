# Event Driven Ansible - K3S ( NON PRODUCTION )

1. Install k3s on server
2. Install `kubectl` & `Kustomize`
3. `kustomize build . | kubectl apply -f -`
4. Get admin password `kubectl get secret eda-admin-password -o jsonpath="{.data.password}" --namespace eda | base64 --decode`