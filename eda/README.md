# Event Driven Ansible - K3S ( NON PRODUCTION READY )

_NOTES:_ https://github.com/kurokobo/awx-on-k3s/tree/main/rulebooks

1. Install k3s on server
2. Install `kubectl` & `Kustomize`
3. `kustomize build . | kubectl apply -f -`
4. Check logs `k logs -f deployments/eda-server-operator-controller-manager -c eda-manager -n eda`
5. Get admin password `kubectl get secret eda-admin-password -o jsonpath="{.data.password}" --namespace eda | base64 --decode`
6. Create AWX token `kubectl -n awx exec deployment/awx-task -- awx-manage create_oauth2_token --user=admin`
7. Add Decision Environment
```
Name: DE

Image: quay.io/ansible/ansible-rulebook:latest
```
8. Add Project ( Rulebooks must be within `rulebook` directory )
9. Create Rulebook Activation
10. Deploy ingress resource for webhook
```
Get Activation ID from URL http://eda.local/eda/rulebook-activation/1/details

$ ACTIVATION_ID=1
$ kubectl -n eda get job -l activation-id=${ACTIVATION_ID}
NAME                 COMPLETIONS   DURATION   AGE
activation-job-1-1   0/1           7m3s       7m3s

```

Get Job Name

```
$ JOB_NAME=$(kubectl -n eda get job -l activation-id=${ACTIVATION_ID} -o jsonpath='{.items[*].metadata.name}')
$ kubectl -n eda get pod -l job-name=${JOB_NAME}
NAME                       READY   STATUS    RESTARTS   AGE
activation-job-1-1-ctz24   1/1     Running   0          7m16s
```

Get the service 

```
$ kubectl -n eda get service -l job-name=${JOB_NAME}
NAME                      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
activation-job-1-1-5000   ClusterIP   10.43.82.223   <none>        5000/TCP   7m40s

```

Modify ingress.yml

_NOTES:_  Below section works with dns entry added to DNS server. but changing to eda.0lzi.com and running sending data to the webhook gets `405 Not Allowed`` as 0lzi.com hits an nginx reverse proxy and is prox_pass to k8s host IP which uses the ingress. Needs investigating. 

```
spec:
  tls:
    - hosts:
        - eda.lab
      secretName: eda-secret-tls
  rules:
    - host: eda.lab
```

```

service:
    name: activation-job-1-1-5000 

```

Apply `kubectl apply -f ingress.yml`

### Cleanup


1. Delete deployment `k delete all --all -n eda && k delete namespace eda`