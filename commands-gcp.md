### Build Docker Image

    $ gcloud container builds submit --tag=gcr.io/${PROJECT_ID}/phx_gcp_cluster:v1

### Setup Kubernetes Cluster

    $ gcloud container clusters create phxgcp --num-nodes=2 --zone=us-central1-a

### Setup Kubernetes Secret & Volume

    $ kubectl create secret generic app-config --from-literal=erlang-cookie=DCRVBIZHJWHNZXYVSFPG
    $ kubectl create configmap vm-config --from-file=vm.args

### Setup Kubernetes Access

    Grant yourself rights to grant to the service account
    [documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control)

    $ kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin --user $(gcloud config get-value account)
    $ kubectl create -f kube-gcp-roles.yml

### Build & Run Kubernetes Deployment/Pods

    $ kubectl create -f kube-gcp-all-in-one.yml

    $ kubectl get pods
    $ kubectl describe pod phxclus-<id>
    $ kubectl logs phxclus-<id>

If you see something like `[info] [libcluster:phxgcpcluster] connected to :"phxgcpcluster@10.0.1.10"` then it worked!

----

### Delete Kubernetes Cluster

Doing this is important to ensure you are not charged.

    $ gcloud container clusters delete phxgcp --zone=us-central1-a
    $ gcloud compute forwarding-rules list
    $ gcloud compute forwarding-rules delete <id>
