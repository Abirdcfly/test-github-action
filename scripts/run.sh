#!/usr/bin/env bash
IMAGES=(
gcr.io/kaniko-project/executor:v1.9.1
)

NEW_IMAGES=(
hyperledgerk8s/kaniko-executor:v1.9.1
)

for ((i=0;i<${#IMAGES[@]};++i)); do
  docker pull ${IMAGES[$i]}
  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
  docker push ${NEW_IMAGES[$i]} || true
done

