PROJECT := $(shell basename -s .git `git config --get remote.origin.url`)
GIT_HASH := $(shell git rev-parse --verify HEAD)
RELEASE_VERSION := $(shell shards version .)

build_snapshot:
	echo "build image $(PROJECT):$(GIT_HASH)"
	docker build --build-arg SHARDS_BUILD_OPTIONS='' --tag $(PROJECT):$(GIT_HASH) .

build_release:
	echo "build image $(PROJECT):$(RELEASE_VERSION)"
	docker build --build-arg SHARDS_BUILD_OPTIONS=--production --tag $(PROJECT):$(RELEASE_VERSION) .

deploy_snapshot:
	docker push $(PROJECT):$(GIT_HASH)

deploy_release:
	docker push $(PROJECT):$(RELEASE_VERSION)

