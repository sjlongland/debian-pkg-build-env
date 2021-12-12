#!/bin/sh

# Generate the Dockerfiles

: ${BASE_IMAGES:=debian:bullseye-slim ubuntu:focal}

for IMAGE in ${BASE_IMAGES}; do
	DOCKERFILE=Dockerfile.$( echo ${IMAGE} | tr : - )
	( echo "FROM ${IMAGE}" | cat - Dockerfile.base ) > ${DOCKERFILE}
done
