### Build Docker Image

    $ gcloud container builds submit --tag=gcr.io/${PROJECT_ID}/phx_gcp_cluster:v1

### Setup Kubernetes Secret & Volume

    $ kubectl create secret generic app-config --from-literal=erlang-cookie=DCRVBIZHJWHNZXYVSFPG
    $ kubectl create configmap vm-config --from-file=vm.args

### Setup Kubernetes Access

    Grant yourself rights to grant to the service account
    [documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control)

    $ kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin --user $(gcloud config get-value account)
    $ kubectl create -f kube-gcp-roles.yml

### Build Kubernetes Pod

    $ kubectl create -f kube-gcp-all-in-one.yml
    $ kubectl get pods
    $ kubectl describe pod phxclus-fmhjs
