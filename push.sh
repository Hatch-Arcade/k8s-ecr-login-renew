VERSION=1.2
REGISTRY=public.ecr.aws/s3r8h5m7
IMAGE=${REGISTRY}/k8s-ecr-login-renew:${VERSION}

for ARCH in amd64 arm64 arm
do
    docker build -f Dockerfile-${ARCH} -t ${IMAGE}-${ARCH} .
    docker push ${IMAGE}-${ARCH}
done

docker manifest create ${IMAGE} ${IMAGE}-amd64 ${IMAGE}-arm64 ${IMAGE}-arm

for ARCH in amd64 arm64 arm
do
    docker manifest annotate --arch ${ARCH} ${IMAGE} ${IMAGE}-${ARCH}
done

docker manifest push ${IMAGE}
