# Event Driven Ansible - K3S ( Not got working - NON PRODUCTION )

1. Install k3s on server
2. Install `kubectl` & `Kustomize`
3. `kustomize build . | kubectl apply -f -`
4. Edit each pod to pull `:main` instead of `:latest`
    `k9s` then go to failing pod `e` then `:%s/server:latest/server:main`
4. Check logs `k logs -f deployments/eda-server-operator-controller-manager -c eda-manager -n eda`
5. Get admin password `kubectl get secret eda-admin-password -o jsonpath="{.data.password}" --namespace eda | base64 --decode`
6. Delete deployment `k delete all --all -n eda && k delete namespace eda`
