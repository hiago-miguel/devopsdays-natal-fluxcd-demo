# Variables
OS := $(shell uname)
BREW := $(shell command -v brew 2>/dev/null)
REPOSITORY := "devopsdays-natal-fluxcd-demo"
CLUSTER_NAME := "devopsdays-natal"
REQUIRED_VARS := $(GITHUB_USER) $(GITHUB_TOKEN)

# Ensure required environment variables are defined
ifndef REQUIRED_VARS
$(error Error: GITHUB_USER and/or GITHUB_TOKEN are not set. Please export both.)
endif

# Ensure Homebrew is installed before running any targets
ifeq ($(BREW),)
$(error Error: Homebrew is not installed. Please install Homebrew first.)
endif

# Targets
.PHONY: all check_os check_brew install_tools create_kind_cluster flux_bootstrap

all: all check_os install_tools create_kind_cluster flux_bootstrap
	@echo "All tasks completed successfully!"

check_os:
	@if [ "$(OS)" != "Linux" ]  && [ "$(shell uname -s)" != "Darwin" ]; then \
		echo "Error: This script only supports Linux."; \
		exit 1; \
	else \
		echo "Operating System is Linux."; \
	fi

check_brew:
	@if [ -z "$(BREW)" ]; then \
		echo "Error: Homebrew is not installed. Please install Homebrew first."; \
		exit 1; \
	else \
		echo "Homebrew is installed."; \
	fi
	
install_tools:
	@if ! command -v kind >/dev/null 2>&1; then \
		echo "Kind is not installed. Installing kind..."; \
		$(MAKE) check_brew; \
		brew install kind; \
	else \
		echo "Kind is already installed. Skipping installation."; \
	fi

	@if ! command -v flux >/dev/null 2>&1; then \
		echo "Flux CLI is not installed. Installing flux..."; \
		$(MAKE) check_brew; \
		brew install fluxcd/tap/flux; \
	else \
		echo "Flux CLI is already installed. Skipping installation."; \
	fi

install_tools:
	@echo "Installing fluxcd and kind using Homebrew..."
	brew install fluxcd/tap/flux kind
	@echo "Tools installed successfully!"

create_kind_cluster:
	@if ! kind get clusters | grep -q "^$(CLUSTER_NAME)$$"; then \
		echo "Creating kind Kubernetes cluster..."; \
		kind create cluster --name $(CLUSTER_NAME) --config kind-config.yaml; \
		echo "Kind Kubernetes cluster created."; \
	else \
		echo "Cluster $(CLUSTER_NAME) already exists. Skipping creation."; \
	fi

flux_bootstrap:
	@echo "Checking Kubernetes Cluster..."
	flux check --pre
	@echo "Bootstraping flux..."
	flux bootstrap github \
		--owner=$(GITHUB_USER) \
		--repository=$(REPOSITORY) \
		--branch=main \
		--path="./clusters/$(CLUSTER_NAME)" \
		--personal \
		--private=false