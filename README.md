# Descomplicando Kubernetes | Hands-on Labs

![Kubernetes](https://img.shields.io/badge/Kubernetes-Hands--on-326CE5?logo=kubernetes&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?logo=ubuntu&logoColor=white)
![Kind](https://img.shields.io/badge/Kind-Local_Clusters-2E75B6)
![GitHub](https://img.shields.io/badge/GitHub-Learning_Repository-181717?logo=github&logoColor=white)

## About This Repository

Welcome to my Kubernetes learning repository!

This repository contains hands-on labs, Kubernetes manifests, practical exercises, troubleshooting notes, and automation scripts developed throughout my journey with the **Descomplicando Kubernetes** course by LINUXtips.

The goal is to document my learning experience while building a practical and reproducible Kubernetes knowledge base.

## Learning Objectives

- Understand Kubernetes architecture and core components.
- Deploy and manage containerized applications.
- Configure local Kubernetes clusters using Kind.
- Work with Pods, Deployments, ReplicaSets, and Services.
- Understand imperative and declarative resource management.
- Create and maintain Kubernetes YAML manifests.
- Develop troubleshooting and operational skills.
- Explore Kubernetes networking, storage, and security.
- Apply Kubernetes concepts to enterprise infrastructure environments.

## Technology Stack

| Technology | Purpose |
|---|---|
| Ubuntu Linux | Lab environment |
| Docker | Container infrastructure |
| Kubernetes | Container orchestration |
| kubectl | Kubernetes CLI |
| Kind | Kubernetes clusters running in Docker |
| K9s | Terminal-based Kubernetes management |
| Git | Version control |
| GitHub | Documentation and collaboration |

## Repository Structure

```text
descomplicando-kubernetes/
├── day1/
│   └── kind/
│       ├── kind-cluster.yaml
│       └── pod.yaml
└── README.md
```

The repository will evolve as new labs are completed.

## Learning Progress

| Lab | Topic | Status |
|---|---|---|
| Day 1 | Kubernetes fundamentals, Kind, Pods and Services | In progress |
| Day 2+ | Additional labs following the course | Planned |

## Day 1 — Kubernetes Fundamentals

The first laboratory focuses on creating a local Kubernetes environment and understanding its basic components.

### Cluster Architecture

The Kind cluster configuration contains:

- 1 control-plane node
- 2 worker nodes

### Create the Kubernetes Cluster

```bash
kind create cluster \
  --name giropops \
  --config day1/kind/kind-cluster.yaml
```

### Verify Cluster Connectivity

```bash
kubectl cluster-info --context kind-giropops
kubectl get nodes
kubectl get pods -A
```

### Explore Kubernetes Resources

```bash
kubectl get namespaces
kubectl get deployments -A
kubectl get replicasets -A
kubectl get services -A
kubectl get pods -A -o wide
```

### Working with Pods

Generate a Pod manifest without creating the resource:

```bash
kubectl run giropops \
  --image=nginx \
  --port=80 \
  --dry-run=client \
  -o yaml
```

The repository also contains a multicontainer Pod example in `day1/kind/pod.yaml`. This manifest is being refined and should be validated before deployment.

### Delete the Cluster

```bash
kind delete cluster --name giropops
```

## Future Learning Topics

- Deployments and workload management
- Kubernetes Services and networking
- ConfigMaps and Secrets
- PersistentVolumes and StorageClasses
- RBAC and Kubernetes security
- Helm package management
- Monitoring and observability
- GitOps and continuous delivery
- Advanced Kubernetes troubleshooting
- Kubernetes integration with enterprise cloud infrastructure

## References

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Kind Documentation](https://kind.sigs.k8s.io/)
- [kubectl Reference](https://kubernetes.io/docs/reference/kubectl/)
- [K9s Documentation](https://k9scli.io/)
- [LINUXtips — Descomplicando Kubernetes](https://github.com/badtuxx/DescomplicandoKubernetes)

## Author

**Diego Silva**

Cloud Infrastructure & VMware Consultant Engineer

Focused on infrastructure automation, VMware Cloud Foundation, networking, and cloud-native technologies.

[GitHub Profile](https://github.com/diegoasf182)

## Disclaimer

This is an independent educational repository based on my personal learning experience with Descomplicando Kubernetes.

It is not an official LINUXtips repository. All notes, configurations, and examples should be tested in a laboratory environment before production use.
