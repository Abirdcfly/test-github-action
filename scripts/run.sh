#!/usr/bin/env bash
IMAGES=(
mcr.microsoft.com/powershell:nanoserver@sha256:b6d5ff841b78bdf2dfed7550000fd4f3437385b8fa686ec0f010be24777654d6
)

NEW_IMAGES=(
hyperledgerk8s/tekton-pipeline-args-powershell:nanoserver-b6d5ff
)

for ((i=0;i<${#IMAGES[@]};++i)); do
  docker pull ${IMAGES[$i]}
  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
  docker push ${NEW_IMAGES[$i]} || true
done

