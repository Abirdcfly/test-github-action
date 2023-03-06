#!/usr/bin/env bash
IMAGES=(
registry:2
docker:dind
docker.io/library/docker:stable@sha256:18ff92d3d31725b53fa6633d60bed323effb6d5d4588be7b547078d384e0d4bf
)

NEW_IMAGES=(
hyperledgerk8s/registry:2
hyperledgerk8s/docker:dind
hyperledgerk8s/docker:stable
)

for ((i=0;i<${#IMAGES[@]};++i)); do
  docker pull ${IMAGES[$i]}
  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
  docker push ${NEW_IMAGES[$i]} || true
done

