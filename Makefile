OUTPUT_IMAGE_NAME ?= sjlongland/debian-pkg-build-env
TARGETS ?= latest=debian:bullseye-slim latest-ubuntu=ubuntu:focal

# Local overrides
-include local.mk

# Target names
TARGET_NAMES=$(foreach TARGET,$(TARGETS),$(firstword $(subst =, ,$(TARGET))))

# Derived files
DOCKERFILES=$(patsubst %,Dockerfile.%,$(TARGET_NAMES))
IMAGE_FILES=$(patsubst %,.build/build-%,$(TARGET_NAMES))
PUSH_FILES=$(patsubst %,.build/push-%,$(TARGET_NAMES))

# Macros
DOCKERFILE_IMAGE=$(shell echo $(1) | sed -e 's:.build/Dockerfile\.::; s/_/:/g; s:~:/:g;)

all: $(PUSH_FILES)

clean:
	rm -f .build

.build:
	mkdir $@

.build/build-%: .build/Dockerfile.% | .build
	docker build -t $(OUTPUT_IMAGE_NAME):$* -f $< .
	touch $@

.build/push-%: .build/build-%
	docker push $(OUTPUT_IMAGE_NAME):$*
	touch $@

.build/Dockerfile.%: Dockerfile.base | .build
	echo "FROM $(lastword $(subst =, ,$(filter $*=%,$(TARGETS))))" | cat - $< > $@
