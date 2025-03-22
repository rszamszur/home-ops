<div align="center">

<img src="docs/assets/logo.png" align="center" width="144px" height="144px"/>

### Home Lab Repository

_... managed with Terraform, Bazel, ArgoCD, Renovate and GitHub Actions_ 🤖

</div>

![homelab](docs/assets/homelab_front.jpg?raw=true) 
---

## 📖 Overview

This is a mono repository for my home infrastructure and Kubernetes cluster. I try to adhere to Infrastructure as Code (IaC) and GitOps practices using the tools like [Terraform](https://www.terraform.io/), [Kubernetes](https://kubernetes.io/), [Bazel](https://bazel.build), [ArgoCD](https://github.com/argoproj/argo-cd), [Renovate](https://github.com/renovatebot/renovate) and [GitHub Actions](https://github.com/features/actions).

---

## 🔧 Hardware

* [Dell PowerEdge T630 GPU Rack](https://www.dell.com/learn/gh/en/ghpad1/shared-content~data-sheets~en/documents~dell-poweredge-t630-spec-sheet.pdf)

  <details>
    <summary>Click to see the insides</summary>
  
    ![t630_inside](docs/assets/dell_t630_inside.jpg?raw=true)
  </details>
  
  * Motherboard: Dell 0NT78X
    * CPU: 2x [Intel Xenon E5-2697 v4](https://www.intel.com/content/www/us/en/products/sku/91755/intel-xeon-processor-e52697-v4-45m-cache-2-30-ghz/specifications.html) (18 cores, 2.30 Ghz)
    * Memory: 16x 16Gb DDR4-2400 RDIMM ([SK Hynix HMA82GR7AFR8N-UH](https://memory.net/product/hma82gr7afr8n-uh-sk-hynix-1x-16gb-ddr4-2400-rdimm-pc4-19200t-r-dual-rank-x8-module/))
    * Network: 2x I350 Gigabit Network Connection
  * Storage:
    * [Dell PowerEdge Raid Controller H330](https://i.dell.com/sites/doccontent/shared-content/data-sheets/en/Documents/Dell-PowerEdge-RAID-Controller-H330.pdf) (in HBA mode)
    * 4x Seagate Exos X16 12TB 7.2k SATA 6Gbps ([ST12000NM001G-2M](https://www.seagate.com/www-content/product-content/enterprise-hdd-fam/exos-x-16/en-us/docs/100845789f.pdf))
    * 2x Goodram CX400 1TB 2,5" Sata3 (SSDPR-CX400-01T-)
    * 2x Samsung PM963 960GB SSD NVMe U.2 Gen 3
* [Unifi Dream Machine Pro](https://eu.store.ui.com/eu/en/products/udm-pro)
* [Unifi USW Pro Max POE](https://eu.store.ui.com/eu/en/category/switching-professional-max/products/usw-pro-max-24-poe)

## ⛵ Kubernetes

My Kubernetes cluster is deployed with [Talos](https://talos.dev) on the Proxmox using the following Terraform modules:

* A module for creating Talos Kubernetes VM nodes on Proxmox: https://github.com/rszamszur/home-ops/tree/master/terraform/talos/nodes
* A module for configuring and initializing the Talos Kubernetes cluster: https://github.com/rszamszur/home-ops/tree/master/terraform/talos/k8s

Core Components:

* [buildbarn](https://github.com/buildbarn): Distributed caching and build infrastructure for Bazel.
* [coder](https://github.com/coder/coder): Provision remote development environments via Terraform.
* [kube-prometheus-stack](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack): Cluster monitoring with Grafana nad Prometheus using the Prometheus Operator.
* [democratic-csi-iscsi](https://github.com/democratic-csi/democratic-csi): A csi storage for container orchestration systems.
* [cert-manager](https://github.com/cert-manager/cert-manager): Creates SSL certificates for services in my cluster.
* [ingress-nginx](https://github.com/kubernetes/ingress-nginx): Kubernetes ingress controller using NGINX as a reverse proxy and load balancer.
* [local-path-provisioner](https://github.com/rancher/local-path-provisioner): Dynamically provisioning persistent local storage.
* [actions-runner-controller](https://github.com/actions/actions-runner-controller): Self-hosted Github runners.

### GitOps Structure

Below is an explanation on how this repo is laid out. You'll notice
that I use [Kustomize](https://kustomize.io/) heavily. I do this since I
follow the [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
principal when it comes to YAML files.

```shell
cluster-XXX/ #1
├── bootstrap #2
│   ├── base
│   │   ├── argocd.Namespace.yaml
│   │   ├── kustomization.yaml
│   │   └── secrets
│   │       └── ...
│   └── overlays
│       └── default
│           └── kustomization.yaml
├── gitops-controller #3
│   ├── applications
│   │   ├── gitops-controller.Application.yaml
│   │   └── kustomization.yaml
│   ├── applicationsets
│   │   ├── core-components.ApplicationSet.yaml
│   │   ├── kustomization.yaml
│   │   └── workloads.ApplicationSet.yaml
│   ├── init
│   │   └── kustomization.yaml
│   ├── kustomization.yaml
│   └── projects
│       ├── kustomization.yaml
│       └── test-project.AppProject.yaml
├── core #4
│   ├── certificates
│   │   ├── cert-manager.Application.yaml
│   │   ├── cert-manager.Namespace.yaml
│   │   ├── cert-manager-webhook-ovh.Application.yaml
│   │   └── kustomization.yaml
│   ├── ingress-controller
│   │   └── kustomization.yaml
│   ├── monitoring
│   │   ├── airgradient-dashboard.ConfigMap.yaml
│   │   ├── airgradient-dashboard.json
│   │   ├── alert-manager.Certificate.yaml
│   │   ├── grafana-tls.Certificate.yaml
│   │   ├── kube-prometheus-stack.Application.yaml
│   │   ├── kube-prometheus-stack.Namespace.yaml
│   │   ├── kustomization.yaml
│   │   └── prometheus-tls.Certificate.yaml
│   └── ...
└── workloads #5
    └── ...
```

|#|Directory Name|Description|
|---|----------------|-----------------|
| 1. |`cluster-XXX`| This is the cluster name. This name should be unique to the specific cluster you're targeting. If you're using CAPI, this should be the name of your cluster, the output of `kubectl get cluster`|
| 2. | `bootstrap` | This is where bootstrapping specifc configurations are stored. These are items that get the cluster/automation started. They are usually install manifests.<br /><br />`base` is where are the "common" YAML would live and `overlays` are configurations specific to the cluster.<br /><br />The `kustomization.yaml` file in `default` points `base` and to `cluster-XXX/gitops-controller/` in order for initialize declarative deployment cycle - gitops-controller managin itself and all the defined deployments.|
| 3. | `gitops-controller` | This is where specific components for the GitOps Controller lives (in this case [Argo CD](https://github.com/argoproj/argo-cd)).<br /><br />`applicationsets` is where all the ApplicationSets YAMLs live, `aplications` is where all the `Application` YAML's live and lastly `argocdproj` is where the ArgoAppProject YAMLs live.<br /><br />. The `init` is a special directory which has all the necessary manifest files to initialize any given gitops-controller. Lastly, ther things that can live here are RBAC, Git repo, and other Argo CD specific configurations (each in their repsective directories).|
| 4. | `core` | This is where YAML for the core functionality of the cluster live. Here is where the Kubernetes administrator will put things that is necissary for the functionality of the cluster (like cluster configs or cluster workloads).<br /><br />This `core` directory gets deployed as an applicationset which can be found under `cluster-XXX/gitops-controller/applicationsets/core-components-appset.yaml`.<br /><br />To add a new "core functionality" workoad, one needs to add a directory with some yaml in the `core` directory. See the `monitoring` directory as an example.|
| 5. | `workloads` | This is where the workloads for this cluster live.<br /><br />Similar to `core`, the `workloads` directory gets loaded as part of an `ApplicationSet` that is under `cluster-XXX/gitops-controller/applicationsets/workloads-appset.yaml`.<br /><br />This is where Devlopers/Release Engineers do the work. They just need to commit a directory with some YAML and the applicationset takes care of creating the workload.<br /><br />|

### Bootstrapping

To see this in action, first get yourself a cluster (using [minikube](https://minikube.sigs.k8s.io/docs/start/) as an example)

```shell
minikube start --driver=docker
```

First apply secrets:
_These cannot be applied with `kubectl` in the regular fashion due to be encrypted with age_

```shell
age -d -i ~/.config/age/key.txt cluster-home/bootstrap/base/secrets/argocd-ghcr-repo-secret.yaml.age | kubectl apply -f -
age -d -i ~/.config/age/key.txt cluster-home/bootstrap/base/secrets/coder-db-postgresql-secret.yaml.age | kubectl apply -f -
age -d -i ~/.config/age/key.txt cluster-home/bootstrap/base/secrets/coder-db-url-secret.yaml.age | kubectl apply -f -
age -d -i ~/.config/age/key.txt cluster-home/bootstrap/base/secrets/democratic-csi-iscsi-driver-config-secret.yaml.age | kubectl apply -f -
age -d -i ~/.config/age/key.txt cluster-home/bootstrap/base/secrets/gha-runner-home-ops-secret.yaml.age | kubectl apply -f -
age -d -i ~/.config/age/key.txt cluster-home/bootstrap/base/secrets/ovh-credentials-secret.yaml.age | kubectl apply -f -
```

Then, just apply this repo:

```shell
until kubectl apply -k https://github.com/rszamszur/home-ops/cluster-home/bootstrap/overlays/default; do sleep 3; done
```

This should give you the following applications:

```shell
$ kubectl get applications -n argocd
NAME                       SYNC STATUS   HEALTH STATUS
argocd-ingress             Synced        Healthy
buildbarn                  Synced        Healthy
cert-manager               Synced        Healthy
cert-manager-webhook-ovh   Synced        Healthy
certificates               Synced        Healthy
coder                      Synced        Healthy
coder-db                   Synced        Healthy
coder-v2                   Synced        Healthy
democratic-csi-iscsi       Synced        Healthy
fastapi-mvc-example        Synced        Healthy
gha-runner                 Synced        Healthy
gha-runner-controller      Synced        Healthy
gitops-controller          Synced        Healthy
ingress-controller         Synced        Healthy
kube-prometheus-stack      Synced        Healthy
monitoring                 Synced        Healthy
storage                    Synced        Healthy
```

Backed by 2 applicationsets:

```shell
$ kubectl get appsets -n argocd
NAME      AGE
cluster   19m
workloads   19m
```

To see the Argo CD UI, you'll first need the password:

```shell
kubectl get secret/argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d ; echo
```

Then port-forward to see it in your browser (using admin as the username):

```shell
kubectl -n argocd port-forward service/argocd-server 8080:443
```

## Resources

* [christianh814/example-kubernetes-go-repo](https://github.com/christianh814/example-kubernetes-go-repo)
* [onedr0p/home-ops](https://github.com/onedr0p/home-ops)
