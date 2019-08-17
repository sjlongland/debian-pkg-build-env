#!/bin/sh

# Generate the Dockerfiles

: ${BASE_IMAGES:=debian:buster-slim ubuntu:bionic}

for IMAGE in ${BASE_IMAGES}; do
	DOCKERFILE=Dockerfile.$( echo ${IMAGE} | tr : - )
	( echo "FROM ${IMAGE}" | cat - Dockerfile.base ) > ${DOCKERFILE}
done
