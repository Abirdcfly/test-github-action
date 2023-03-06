#!/usr/bin/env bash
IMAGES=(
gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/kubeconfigwriter:v0.42.0@sha256:672df16c97c15d20102749c6e86195683d037bd6c8787560c9c07ade8b610071
gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/nop:v0.42.0@sha256:bd1fcc45d40a8ef1621789856caa2f54d7a884f19af921105feafae0131648c5
gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/imagedigestexporter:v0.42.0@sha256:370d5a0e39577f784f1376fac0822230b9a44950c01fe2190692a0a5a810adc6
gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/pullrequest-init:v0.42.0@sha256:e00d578d40d57a5124bee5107cb3358763874588a7fe2522ebc7bb979280d06e
gcr.io/tekton-releases/github.com/tektoncd/pipeline/cmd/workingdirinit:v0.42.0@sha256:60a39c629448ac2845c4781513ef44c2f2fbcb6eb321d70a016002b5fa7b2379
gcr.io/google.com/cloudsdktool/cloud-sdk@sha256:27b2c22bf259d9bc1a291e99c63791ba0c27a04d2db0a43241ba0f1f20f4067f
cgr.dev/chainguard/busybox@sha256:19f02276bf8dbdd62f069b922f10c65262cc34b710eea26ff928129a736be791
mcr.microsoft.com/powershell:nanoserver@sha256:b6d5ff841b78bdf2dfed7550000fd4f3437385b8fa686ec0f010be24777654d6
)

NEW_IMAGES=(
hyperledgerk8s/tekton-pipeline-args-kubeconfigwriter:v0.42.0
hyperledgerk8s/tekton-pipeline-args-nop:v0.42.0
hyperledgerk8s/tekton-pipeline-args-imagedigestexporter:v0.42.0
hyperledgerk8s/tekton-pipeline-args-pullrequest-init:v0.42.0
hyperledgerk8s/tekton-pipeline-args-workingdirinit:v0.42.0
hyperledgerk8s/tekton-pipeline-args-cloud-sdk:27b2c2
hyperledgerk8s/tekton-pipeline-args-busybox:19f022
hyperledgerk8s/tekton-pipeline-args-powershell:nanoserver-b6d5ff
)

for ((i=0;i<${#IMAGES[@]};++i)); do
  docker pull ${IMAGES[$i]}
  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
  docker push ${NEW_IMAGES[$i]} || true
done

