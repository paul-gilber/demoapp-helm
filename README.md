# demoapp-helm-charts
Helm Charts for deploying demoapp to Kubernetes and OpenShift

## Deployment to Kubernetes
Prerequisites:
1. Kubernetes Cluster

Steps:
1. Install NGINX Ingress Controller
```sh
# Pull Helm Chart
helm pull oci://ghcr.io/nginxinc/charts/nginx-ingress --untar
cd nginx-ingress

# Apply CRDs
kubectl apply -f crds/

# Create `nginx-ingress` namespace
kubectl create ns nginx-ingress

# Set current namespace to `nginx-ingress`
kubectl config set-context `kubectl config current-context` --namespace nginx-ingress
kubectl config get-contexts

# Install Helm Chart
helm install nginx-ingress .

# Check pods
watch oc get pods
```

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
