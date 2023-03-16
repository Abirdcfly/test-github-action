#!/usr/bin/env bash
#IMAGES=(
#mcr.microsoft.com/powershell:nanoserver-1809@sha256:a3c7e83f8018352a6284cefdf5066602bff9b298edf3cd51085c74a19cfafffc
#)

#NEW_IMAGES=(
#hyperledgerk8s/tekton-pipeline-args-powershell:nanoserver-1809
#)

#for ((i=0;i<${#IMAGES[@]};++i)); do
#  docker pull ${IMAGES[$i]}
#  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
#  docker push ${NEW_IMAGES[$i]} || true
#done

kind create cluster --config=scripts/kind.yaml --image kindest/node:v1.24.4
