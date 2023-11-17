# Vault (Testing)

https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide

### Pre-requisites
1. Helm
2. 

1. Add helm repo `helm repo add hashicorp https://helm.releases.hashicorp.com`
2. HA mode - Modify/create `overide-values.yml`
3. Create secret for Certs`kubectl --namespace='vault' create secret tls tls-secret --cert=path/to/tls.cert --key=path/to/tls.key` 
4. Install helm chart `helm install vault hashicorp/vault --namespace vault -f override-values.yaml` 
5. Init vault `kubectl exec --stdin=true --tty=true vault-0 -- vault operator init`
6. Unseal 
```
## Unseal the first vault server until it reaches the key threshold
$ kubectl exec --stdin=true --tty=true vault-0 -- vault operator unseal # ... Unseal Key 1
$ kubectl exec --stdin=true --tty=true vault-0 -- vault operator unseal # ... Unseal Key 2
$ kubectl exec --stdin=true --tty=true vault-0 -- vault operator unseal # ... Unseal Key 3
```
7. Enable UI with portforward `kubectl port-forward vault-0 8200:8200`

# Vault (Prod)

### TODO

- [ ] sort consul backend
- [ ] configure UI with loadbalancer [here](https://developer.hashicorp.com/vault/docs/platform/k8s/helm/configuration#ui)
