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

export UPLOAD_IMAGE=NO
function save_all_images() {
	outputDir=$1
	imageListFile=$2
	if [ ! -f $imageListFile ]; then
		echo "" >$imageListFile
	fi
	echo "get all images list..."
	IMAGES=$(kubectl get po -A -o yaml | grep "image: " | awk -F ": " '{print $2}' | sort -u)
	echo "compare all images list with $imageListFile"
	same=0
	echo $IMAGES | diff - $imageListFile -y -q && same=0 || same=1
	if [[ $same -eq 0 ]]; then
		echo "image list is same with cache, skip store. done.✅"
	else
		echo "try to save all cluster images to $outputDir, images list to $imageListFile..."
		echo $IMAGES >$imageListFile
		IMAGES+=('foo')
		dockerContainerNames=$(kubectl get node --no-headers=true | awk '{print $1}')
		n=0
		for image in ${IMAGES[@]}; do
			n=$((n + 1))
			for dockerContainerName in ${dockerContainerNames[@]}; do
				docker exec -i ${dockerContainerName} ctr --namespace=k8s.io images export --skip-manifest-json --skip-non-distributable ${outputDir}/${n}.tar ${image}) || exit_status=$?
				echo $image $exit_status $dockerContainerName
				if [[ $exit_status -eq 0 ]]; then
					break
				fi
			done
		done
		UPLOAD_IMAGE=YES
		echo "save all images done.✅"
	fi
	export UPLOAD_IMAGE=$UPLOAD_IMAGE
}

function load_all_images() {
	kindName=$1
	inputDir=$2
	if [ ! -d $inputDir ]; then
		echo "no image dir found $inputDir, skip"
		exit 0
	fi
	if [ ! -n "$(ls $inputDir)" ]; then
		echo "no image found in $inputDir, skip"
		exit 0
	fi
	echo "try to load all cluster images from $outputDir to kind cluster $kindName..."
	dockerContainerNames=$(docker ps -a --filter label=io.x-k8s.kind.cluster=${kindName} --format {{.Names}})
	for dockerContainerName in ${dockerContainerNames[@]}; do
		for imagefile in "$inputDir"/*; do
			docker exec -i ${dockerContainerName} ctr --namespace=k8s.io images import ${imagefile}
		done
		echo "load all images for ${dockerContainerName} done."
	done
	echo "load all images done.✅"
}

save_all_images /tmp/images /tmp/images.list
load_all_images kind /tmp/images
