# Variables
OS := $(shell uname)
BREW := $(shell command -v brew 2>/dev/null)

# Targets
.PHONY: all check_os check_brew install_tools

all: check_os check_brew install_tools
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
	@echo "Installing fluxcd and kind using Homebrew..."
	brew install fluxcd/tap/flux kind
	@echo "Tools installed successfully!"

create_kind_cluster:
	@echo "Creating kind kubernetes cluster..."
	kind create cluster --name devopsdays-natal --config kind-config.yaml
	@echo "Kind kubernetes cluster created."