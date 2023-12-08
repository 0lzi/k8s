# AWX install ( NON PRODUCTION READY)

_NOTES:_ 

https://www.youtube.com/watch?v=Nvjo2A2cBxI

https://github.com/kurokobo/awx-on-k3s/tree/main

1. Install k3s on server
2. Install `kubectl` & `Kustomize`
3. `kustomize build . | kubectl apply -f -`
4. Check logs `k logs -f deployments/awx-operator-controller-manager -c awx-manager -n awx`
5. Get admin password `kubectl get secret awx-admin-password -o jsonpath="{.data.password}" --namespace awx | base64 --decode`
6. Add awx pv and pvc `kubectl apply -f awx-pv.yml && kubectl apply -f awx-pvc.yml`
7. Create new local user
8. Set up Github OAuth
```
GitHub OAuth2 Organization Map - 

{
  "Default": {
    "admins": [
      "0lzi",
      "foolishhim@gmail.com"
    ],
    "users": false
  }
}

```

9. Login with GH account
10. Disable future SOCIAL Logins `Settings` > `System` > `Miscellaneous Authentication` > `Social Auth User Fields` and put `[]`


### Cleanup 

1. Delete deployment `k delete all --all -n awx && k delete namespace awx`

### Upgrade

- [TODO]