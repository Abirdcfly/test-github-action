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
printenv

if [[ $RUNNER_DEBUG -eq 1 ]] || [[ $GITHUB_RUN_ATTEMPT -gt 1 ]]; then
  # use https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/enabling-debug-logging#enabling-step-debug-logging
  # or run the same test multiple times.
  echo "123"
fi
echo "234"

#git clone https://github.com/bestchains/installer.git /tmp/installer
#cd /tmp/installer
#. ./scripts/e2e.sh --minio
