# Employer-specific aliases and functions
#
# This file contains aliases and functions specific to your current employer.
# Update this file when changing jobs.
#
# Examples of things to put here:
# - CI/CD shortcuts (Buildkite, CircleCI, etc.)
# - Internal tool aliases
# - Company-specific git workflows
# - VPN/network shortcuts

# ===========================================
# CONFIGURATION - Update these for your employer
# ===========================================

# Employer info
EMPLOYER_NAME="example"                      # For alias naming
EMPLOYER_GITHUB_ORG="example"                # GitHub organization (for clone function)

# CI/CD
BUILDKITE_ORG="example"                      # Buildkite organization

# Kubernetes contexts
K8S_CONTEXT_DEV="dev"
K8S_CONTEXT_STAGING="staging"
K8S_CONTEXT_PROD="prod"

# Multi-account GitHub setup
# Set to "true" if you have separate personal/employer GitHub accounts with different SSH keys
ENABLE_MULTI_GITHUB_ACCOUNTS="true"

# ===========================================
# END CONFIGURATION
# ===========================================

# Shortcut to my custom zsh apple aliases file
alias aliases-employer='cursor $ZSH_CUSTOM/aliases-employer.zsh'

# Shortcut to my .kube/config file
alias kubeconfig='cursor ~/.kube/config'

# Project shortcuts

# Vault
# alias secrets='vault wf secret'

# Mamba
# alias mamba="docker pull ${EMPLOYER_NAME}/mamba:latest && docker run -it --rm --platform linux/amd64 ${EMPLOYER_NAME}/mamba:latest"

# Publish a subgraph to Apollo Studio using Rover
# usage: rvSubgraphPublish <VARIANT_NAME> <SCHEMA_FILE> <SUBGRAPH_NAME>
function rvSubgraphPublish() {
  APOLLO_KEY=$APOLLO_KEY rover subgraph publish ${APOLLO_GRAPH_NAME}@$1 --schema $2 --name $3 --routing-url "http://localhost"
}

# Delete a subgraph from Apollo Studio using Rover
# usage: rvSubgraphDelete <VARIANT_NAME> <SUBGRAPH_NAME>
function rvSubgraphDelete() {
  APOLLO_KEY=$APOLLO_KEY rover subgraph delete ${APOLLO_GRAPH_NAME}@$1 --name $2
}

# MacOS in sets a default limit of 256 open files per process.
# To solve this, I start the mongod process with a higher limit
# via the `ulimit -n {N}` command.
#
# Example: ulimit -n 1024
#
# https://stackoverflow.com/a/24557815
# https://stackoverflow.com/a/48257700
# https://stackoverflow.com/a/57886874
# alias mongod:start='ulimit -n 1024 && mongod --dbpath=$HOME/data/db --replSet rs'

# use namespace aliases for less typing
function lookupKubernetesNamespace() {
  case "$1" in
    "default")
      echo "example-default"
      ;;
    "example2")
      echo "example-that-is-longer"
      ;;
    "example3")
      echo "example-that-is-very-very-very-long"
      ;;
    *)
      echo $1
      ;;
  esac
}

# usage: k <NAMESPACE or ALIAS> get pods
# usage: k <NAMESPACE or ALIAS> describe pod <POD>
# usage: k <NAMESPACE or ALIAS> <any command>>
# function k() {
#   kubectl -n $(lookupKubernetesNamespace $1) ${@:2:99}
# }

# usage: kpods <NAMESPACE or ALIAS>
# function kpods() {
#   kubectl get pods -n $(lookupKubernetesNamespace $1)
# }

# usage: kyaml <NAMESPACE or ALIAS> ing
# function kyaml() {
#   kubectl -n $(lookupKubernetesNamespace $1) get $2 -o yaml
# }

# usage: kevents <NAMESPACE or ALIAS>
# function kevents() {
#   kubectl get events -n $(lookupKubernetesNamespace $1) --sort-by='.metadata.creationTimestamp'
# }

# usage: ksecrets <NAMESPACE or ALIAS>
# function ksecrets() {
#   kubectl get secrets -n $(lookupKubernetesNamespace $1)
# }

# usage: kdeploys <NAMESPACE or ALIAS>
# function kdeploys() {
#   kubectl get Deployment -n $(lookupKubernetesNamespace $1)
# }

# usage: kcontext <NAMESPACE or ALIAS>
# function kcontext() {
#   kubectl config set-context --current --namespace=$(lookupKubernetesNamespace $1)
# }

# function kinfo() {
#   kubectl describe VirtualService
# }

# Deletes a virtual service
# usage: kdeletevs <NAMESPACE or ALIAS> <VIRTUAL_SERVICE>
# function kdeletevs() {
#   kubectl -n $(lookupKubernetesNamespace $1) delete virtualservice $2
# }

####
# Login to Google Cloud
alias gclogin="gcloud auth login"
alias gcdefaultlogin="gcloud auth application-default login"

###########################################
# kubectl
###########################################

####
# No. 1 thing to do is set the datacenter.

# Dev
alias kdev="kubectl config use-context $K8S_CONTEXT_DEV"

# Staging
alias kstage="kubectl config use-context $K8S_CONTEXT_STAGING"

# Prod
alias kprod="kubectl config use-context $K8S_CONTEXT_PROD"

####
# No. 2: now run:
# kset <NAMESPACE or ALIAS>
function kset() {
  kubectl config set-context --current --namespace=$(lookupKubernetesNamespace $1)
}
# alias kset="kubectl config set-context --current --namespace=$1"

####
# No. 3 depends on what you're trying to do. i.e. most common is to list pods

# When running `get` you can pass this to get it info YAML form:
# -o yaml

# Get pods
alias kpods="kubectl get pods"

# Get pod info: Run kpods first, then get a pod name:
# kubectl describe pod <pod-id/name>

# Canary
alias kcanary="kubectl get Canary"

# Virtual Service (Istio)
alias kvs="kubectl get VirtualService"

# Delete Virtual Service
# Use:
# kdeletevs <VIRTUAL_SERVICE>
alias kdeletevs="kubectl delete virtualservice"

# Cluster URL name is generated with this resource
alias kvs="kubectl get Service"

# Get everything
alias kall="kubectl get all"

# Get events
# Optional sorting:
# --sort-by='.metadata.creationTimestamp'
alias kevents="kubectl get Events"

# Get autoscaler object.
alias khpa="kubectl get HorizontalPodAutoscaler"

# Get secrets
alias ksecrets="kubectl get secrets"

# Get deployments
alias kdeploys="kubectl get Deployment"

# Get namespaces
alias kns="kubectl get namespaces"

# Get the config for a resource in Yaml
# usage: kyaml <NAME>
function kyaml() {
  kubectl get $1 -o yaml
}

# Get the config for a resource in JSON
# usage: kjson <NAME>
function kjson() {
  kubectl get $1 -o json
}

# Edit the config for a resource
# usage: kedit <NAME>
function kedit() {
  kubectl edit $1
}

# Exec into a pod with Bash
# usage: kbash <NAME>
function kbash() {
  kubectl exec -it $1 -- /bin/bash
}

# Get the pod logs:
# klogs <NAME>
#
# Get the logs of the previous pod that crashed:
# klogs <NAME> -p
#
# Follow the logs
# klogs <NAME> -f
function klogs() {
  kubectl logs $1 $2
}

# Delete a specific pod.
#
# usage: kdelete <NAME>
function kdelete() {
  kubectl delete pod $1
}

# usage: kdescribe <POD>
function kdescribe() {
  kubectl describe pod $1
}

# Opens the Buildkite pipeline for the current Git branch
function obk() {
  local git_url=$(git remote get-url origin)
  local repo_name=${git_url##*/}
  repo_name=${repo_name%.git}
  local branch_name=$(git symbolic-ref --short HEAD)
  open "https://buildkite.com/${BUILDKITE_ORG}/$repo_name/builds?branch=$branch_name"
}

# Clone a repo - supports multi-account GitHub setups if enabled
function clone () {
  if [[ "$ENABLE_MULTI_GITHUB_ACCOUNTS" == "true" ]]; then
    repo_base="personal"
    repo=${1##git@github.com:}
    if [[ $repo == *${EMPLOYER_GITHUB_ORG}/* ]]; then
      repo_base="employer"
    fi
    git clone "${repo_base}:${repo}"
  else
    git clone "$1"
  fi
}
