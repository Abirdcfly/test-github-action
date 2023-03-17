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


#git clone https://github.com/bestchains/installer.git /tmp/installer
#cd /tmp/installer
#. ./scripts/e2e.sh --minio

kubectl create deployment minio --image hyperledgerk8s/minio-minio:RELEASE.2023-02-10T18-48-39Z
sleep 30
pwd
kubectl get po -oyaml

kubectl get po -A -o yaml | grep "image: " | awk -F ": " '{print $2}' | sort -u | grep -v "k8s.gcr.io"
