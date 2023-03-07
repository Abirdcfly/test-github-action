#!/usr/bin/env bash
IMAGES=(
ubuntu:22.04
)

NEW_IMAGES=(
hyperledgerk8s/ubuntu:22.04
)

for ((i=0;i<${#IMAGES[@]};++i)); do
  docker pull ${IMAGES[$i]}
  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
  docker push ${NEW_IMAGES[$i]} || true
done

