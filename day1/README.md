# Day 1 — Kubernetes Fundamentals

## Overview

This lab documents my first hands-on exercises from the Descomplicando Kubernetes Expert Mode learning journey.

The goal was to understand the fundamental Kubernetes architecture, configure a local cluster, explore Kubernetes resources, and deploy a containerized application.

## 1. Concepts Covered

### Container Engine, Runtime and OCI

A Container Engine provides tooling to manage containers, images, networking and storage.

A Container Runtime is responsible for managing container execution.

The Open Container Initiative (OCI) defines open specifications that improve container interoperability.

Key technologies discussed:

- Docker and Podman
- containerd and CRI-O
- runc
- OCI specifications

### Kubernetes Architecture

Kubernetes uses a control plane to manage the desired state of a cluster and worker nodes to execute application workloads.

**Control Plane components**

| Component | Responsibility |
|---|---|
| kube-apiserver | Exposes the Kubernetes API |
| etcd | Stores cluster state |
| kube-scheduler | Assigns unscheduled Pods to nodes |
| kube-controller-manager | Runs controllers that reconcile desired and actual state |

**Node components**

| Component | Responsibility |
|---|---|
| kubelet | Manages Pods assigned to a node |
| Container Runtime | Executes containers |
| kube-proxy | Implements Service networking where deployed |

## 2. Lab Environment

The exercises were performed on Ubuntu Linux using Docker, kubectl and Kind.

The Kubernetes cluster was configured with:

- 1 control-plane node
- 2 worker nodes
- Cluster name: `giropops`

### Cluster Configuration

File: `kind/kind-cluster.yaml`

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

### Create the Cluster

From the repository root:

```bash
kind create cluster \
  --name giropops \
  --config day1/kind/kind-cluster.yaml
```

### Verify the Cluster

```bash
kubectl cluster-info --context kind-giropops
kubectl get nodes
kubectl get namespaces
kubectl get pods -A
```

## 3. Exploring Kubernetes Resources

The following commands were practiced to investigate the cluster:

```bash
kubectl get pods -A -o wide
kubectl get deployments -A
kubectl get replicasets -A
kubectl get services -A
kubectl get pods -n kube-system
```

These commands demonstrate how to inspect workloads and system components across namespaces.

## 4. Creating a Pod

A Pod was created using the NGINX container image.

```bash
kubectl run giropops --image=nginx --port=80
```

Verify the Pod:

```bash
kubectl get pods
kubectl describe pod giropops
```

### Generating a YAML Manifest

Instead of immediately creating a resource, kubectl can generate a manifest using client-side dry-run:

```bash
kubectl run giropops \
  --image=nginx \
  --port=80 \
  --dry-run=client \
  -o yaml
```

This introduced the concept of declarative resource management.

## 5. Working with Services

A Kubernetes Service provides a stable network endpoint for accessing selected Pods.

The following Service types were introduced:

| Type | Description |
|---|---|
| ClusterIP | Exposes a Service inside the cluster |
| NodePort | Exposes a Service through a port on each node |
| LoadBalancer | Requests external load-balancer integration where supported |

Example using the NGINX Pod:

```bash
kubectl expose pod giropops \
  --name=giropops-service \
  --port=80 \
  --target-port=80
```

Verify:

```bash
kubectl get svc
kubectl describe svc giropops-service
```

Note: This creates a ClusterIP Service by default. A ClusterIP does not automatically make the application externally accessible.

## 6. Troubleshooting Lessons

### Resource Type Missing

An attempted command:

```bash
kubectl delete giropops
```

failed because Kubernetes requires the resource type.

Correct syntax:

```bash
kubectl delete pod giropops
```

### Service Port Detection

When exposing a Pod, kubectl may be unable to infer the destination port.

An explicit port can be provided:

```bash
kubectl expose pod giropops --port=80
```

### Declarative Configuration

Repeated execution of:

```bash
kubectl apply -f manifest.yaml
```

helps demonstrate Kubernetes declarative resource management.

The command creates or updates resources based on the manifest. Whether an actual change occurs depends on the difference between the submitted configuration and the existing resource.

## 7. Cleaning Up

Remove the Service if it exists:

```bash
kubectl delete svc giropops-service --ignore-not-found
```

Remove the Pod:

```bash
kubectl delete pod giropops --ignore-not-found
```

Remove the Kind cluster:

```bash
kind delete cluster --name giropops
```

## 8. Key Takeaways

After completing the first lab, I gained practical experience with:

- Kubernetes control plane and worker node architecture.
- Creating multinode clusters using Kind.
- Navigating Kubernetes resources with kubectl.
- Creating and inspecting Pods.
- Generating Kubernetes YAML manifests.
- Understanding declarative configuration.
- Exposing Pods using Services.
- Troubleshooting command and resource configuration errors.

## References

- [Kubernetes Concepts](https://kubernetes.io/docs/concepts/)
- [Kubernetes Components](https://kubernetes.io/docs/concepts/overview/components/)
- [Pods](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
- [Kind Documentation](https://kind.sigs.k8s.io/)

---

**Learning journey:** Descomplicando Kubernetes — Expert Mode

**Author:** Diego Silva

This document contains my own learning notes and laboratory examples. It is not an official reproduction of the course material.
