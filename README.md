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
helm install nginx-ingress . -n nginx-ingress

# Check pods
watch oc get pods

# Get `nginx` Ingress Class
oc get ingressclass nginx

# Go back to previous working directory
cd -
```
2. Create `demo` namespace
```sh
# Create `demo` namespace
kubectl create ns demo

# Set current namespace to `demo`
kubectl config set-context `kubectl config current-context` --namespace demo
kubectl config get-contexts
```
3. Create demoapp nginx master ingress
```sh
kubectl apply -f deploy/demoapp-nginx-master.yaml -n demo
```
4. Deploy `demoapp-backend`
```sh
cd charts/demoapp-backend
helm dependency update .
helm upgrade -i demoapp-backend . \
  -n demo \
  --values values-docker-desktop.yaml
cd -
```
5. Deploy `demoapp-frontend`
```sh
cd charts/demoapp-frontend
helm dependency update .
helm upgrade -i demoapp-frontend . \
  -n demo \
  --values values-docker-desktop.yaml
cd -
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
  --values values-docker-desktop.yaml
```
3. Deploy `demoapp-frontend`
```sh
cd charts/demoapp-frontend
helm dependency update .
helm upgrade -i demoapp-frontend . \
  --values values-docker-desktop.yaml
```
