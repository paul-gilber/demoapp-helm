# demoapp-helm-charts
Helm Charts for deploying demoapp to Kubernetes and OpenShift

## Deployment to OpenShift Local
Prerequisites:
1. [Red Hat OpenShift Local](https://developers.redhat.com/products/openshift-local/overview)

Steps:
1. Create `demo` project
```sh
# Login to OpenShift Local
oc login -u kubeadmin https://api.crc.testing:6443

# Create project
oc new-project demo
```
2. Deploy `demoapp-backend`
```sh
cd charts/demoapp-backend
helm dependency update .
helm upgrade -i demoapp-backend . \
  --values values-openshift-local.yaml
```
3. Deploy `demoapp-frontend`
```sh
cd charts/demoapp-frontend
helm dependency update .
helm upgrade -i demoapp-frontend . \
  --values values-openshift-local.yaml
```
