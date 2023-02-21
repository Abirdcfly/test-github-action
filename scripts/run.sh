#!/usr/bin/env bash
docker pull gcr.io/tekton-releases/github.com/tektoncd/operator/cmd/kubernetes/proxy-webhook:v0.64.0
docker tag gcr.io/tekton-releases/github.com/tektoncd/operator/cmd/kubernetes/proxy-webhook:v0.64.0 hyperledgerk8s/tekton-operator-proxy-webhook:v0.64.0
docker push hyperledgerk8s/tekton-operator-proxy-webhook:v0.64.0 || true
