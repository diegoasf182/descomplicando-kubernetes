# Descomplicando Kubernetes | Hands-on Labs


[![Manifest Validation](https://github.com/diegoasf182/descomplicando-kubernetes/actions/workflows/validate-manifests.yml/badge.svg?branch=main)](https://github.com/diegoasf182/descomplicando-kubernetes/actions/workflows/validate-manifests.yml)

[![Kubernetes Integration Tests](https://github.com/diegoasf182/descomplicando-kubernetes/actions/workflows/day1-integration.yml/badge.svg?branch=main)](https://github.com/diegoasf182/descomplicando-kubernetes/actions/workflows/day1-integration.yml)

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
├── .github/
│   └── workflows/
│       ├── validate-manifests.yml
│       └── day1-integration.yml
├── day1/
│   ├── kind/
│   │   ├── kind-cluster.yaml
│   │   └── pod.yaml
│   └── README.md
├── scripts/
│   ├── create-cluster.sh
│   ├── cleanup-cluster.sh
│   └── validate-day1.sh
├── .gitignore
└── README.md
```

The repository will evolve as new labs are completed.

## Learning Progress

| Lab | Topics | Status | Documentation |
|---|---|---|---|
| Day 1 | Kubernetes fundamentals, Kind, Pods, Services, multicontainer Pods and CI | Completed | [Day 1 Lab](day1/README.md) |
| Day 2 | Upcoming Kubernetes labs | Planned | - |

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

The repository includes a validated multicontainer Pod running NGINX and Apache HTTP Server.

The Pod manifest has been successfully deployed in a Kind cluster and verified through automated integration tests.

- NGINX: HTTP 200 on TCP port 80
- Apache: HTTP 200 on TCP port 8080
- Kubernetes nodes: 3 Ready
- Pod containers: 2/2 Ready

See the [Day 1 documentation](day1/README.md) for the lab results and tested versions.


### Delete the Cluster

```bash
kind delete cluster --name giropops
```


## Continuous Integration

This repository uses GitHub Actions to validate Kubernetes manifests and execute automated integration tests.

### Manifest Validation

The `validate-manifests.yml` workflow:

- Validates Kubernetes manifests using Kubeconform.
- Checks the Kind cluster configuration.
- Runs on pull requests and pushes to the main branch.

### Kubernetes Integration Tests

The `day1-integration.yml` workflow:

- Creates an isolated Kubernetes cluster using Kind.
- Configures one control-plane node and two worker nodes.
- Deploys the NGINX and Apache multicontainer Pod.
- Waits for Kubernetes nodes and the Pod to become Ready.
- Executes `scripts/validate-day1.sh`.
- Verifies successful HTTP responses from both web servers.
- Collects diagnostic information when tests fail.

### Reproducing the Tests Locally

From the repository root:

```bash
bash scripts/create-cluster.sh
kubectl apply -f day1/kind/pod.yaml
bash scripts/validate-day1.sh
```

To remove the laboratory cluster:

```bash
bash scripts/cleanup-cluster.sh
```

The integration workflow runs on GitHub-hosted runners and does not depend on the local laboratory environment.

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
