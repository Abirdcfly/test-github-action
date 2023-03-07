#!/usr/bin/env bash
IMAGES=(
gcr.io/kaniko-project/executor:v1.5.1@sha256:c6166717f7fe0b7da44908c986137ecfeab21f31ec3992f6e128fff8a94be8a5
docker.io/library/bash:5.1.4@sha256:c523c636b722339f41b6a431b44588ab2f762c5de5ec3bd7964420ff982fb1d9
)

NEW_IMAGES=(
hyperledgerk8s/kaniko-executor:v1.5.1
hyperledgerk8s/bash:5.1.4
)

for ((i=0;i<${#IMAGES[@]};++i)); do
  docker pull ${IMAGES[$i]}
  docker tag ${IMAGES[$i]} ${NEW_IMAGES[$i]}
  docker push ${NEW_IMAGES[$i]} || true
done

