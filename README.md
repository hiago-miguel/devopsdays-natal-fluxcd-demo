# DevOpsDays Natal - FluxCD v2 Demo

Welcome to the FluxCD v2 Demo repository for the DevOpsDays Natal event! This project is a practical demonstration of how to use FluxCD v2 for GitOps, showcasing the flux bootstrap process to set up a Kubernetes cluster and manage deployments through Git.

## Repository Overview
This repository includes:
* FluxCD v2 bootstrap demonstration: Walkthrough of initializing a GitOps pipeline using FluxCD.
* Makefile: Simplifies running necessary commands for cluster setup, tool installation, and Flux bootstrapping.
* Kind cluster configuration: Local Kubernetes setup using kind for development and testing.

---

## Prerequisites
Before running the commands in this repository, ensure you have the following:
1. Environment Variables:
* GITHUB_USER: Your GitHub username.
* GITHUB_TOKEN: A personal access token with repository access.
2. Installed Tools:
* brew: Homebrew for managing dependencies (Only needed if you don't have kind and flux cli installed)

## Features
**Makefile Automation:** The included Makefile automates the following tasks:
* Operating system compatibility checks.
* Installation of required tools (kind and flux).
* Kubernetes cluster creation using kind.
* FluxCD bootstrapping into the cluster with your GitHub repository.
**GitOps Best Practices:** Demonstrates the use of Git as the single source of truth for Kubernetes configurations.

---

## Getting Started
### Clone the Repository
```bash
git clone https://github.com/<your-username>/<repository-name>.git
cd <repository-name>
```

### Export Required Environment Variables
Ensure the following variables are set in your shell:

```bash
export GITHUB_USER=<your-github-username>
export GITHUB_TOKEN=<your-github-token>
```

### Run the Makefile
To run all required steps, use:

```bash
make all
```

This will:
1. Check your operating system.
2. Verify that Homebrew is installed.
3. Install necessary tools (kind and flux).
4. Create a Kubernetes cluster using Kind.
5. Bootstrap FluxCD in your GitHub repository.

---

## Example FluxCD Bootstrap Command
The FluxCD bootstrap process is configured to:
* Use your GitHub username and token.
* Target a repository named devopsdays-natal-fluxcd-demo.
* Set up a GitOps pipeline on the main branch.

The command executed by the Makefile is equivalent to:

```bash
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=devopsdays-natal-fluxcd-demo \
  --branch=main \
  --path=./clusters/devopsdays-natal \
  --personal \
```

## Example Interacting with the Kind Kubernetes Cluster

```bash
kubectl config use-context kind-devopsdays-natal
kubectl get po -A
```

## Example Interacting with Flux CLI

```bash
flux get kustomizations --watch
flux logs --tail=100 -f
```
---

## Acknowledgments
Special thanks to the DevOpsDays Natal community for inspiring this demo and advancing the practice of DevOps! 🚀