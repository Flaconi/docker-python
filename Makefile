###
### Default
###
help:
	@printf "%s\n\n" "Flaconi Python images"
	@printf "%s\n\n" "make update-base:     Pull latest base image"
	@printf "%s\n"   "make build-all:       Build all images (see below)"
	@printf "%s\n"   "make build-latest:    Build Python latest Docker image"
	@printf "%s\n"   "make build-37:        Build Python 3.7 Docker image"
	@printf "%s\n"   "make build-36:        Build Python 3.6 Docker image"
	@printf "%s\n"   "make build-35:        Build Python 3.5 Docker image"
	@printf "%s\n"   "make build-27:        Build Python 2.7 Docker image"
	@printf "%s\n"   "make build-2:        Build Python 2 Docker image"
	@printf "%s\n\n" "make build-3:        Build Python 3 Docker image"
	@printf "%s\n"   "make test-all:        Test all images (see below)"
	@printf "%s\n"   "make test-latest:     Test Python latest Docker image"
	@printf "%s\n"   "make test-37:         Test Python 3.7 Docker image"
	@printf "%s\n"   "make test-36:         Test Python 3.6 Docker image"
	@printf "%s\n"   "make test-35:         Test Python 3.5 Docker image"
	@printf "%s\n"   "make test-27:         Test Python 2.7 Docker image"
	@printf "%s\n"   "make test-2:         Test Python 2 Docker image"
	@printf "%s\n"   "make test-3:         Test Python 3 Docker image"



###
### Update
###
update-base:
	docker pull python:slim


###
### Build all
###
build-all: build-latest build-37 build-36 build-35 build-27 build-2 build-3


###
### Build Single
###
build-latest: update-base
	docker build -t flaconi/python:latest .

build-37: update-base
	docker build --build-arg PYTHON_VERSION=3.7 -t flaconi/python:3.7 .

build-36: update-base
	docker build --build-arg PYTHON_VERSION=3.6 -t flaconi/python:3.6 .

build-35: update-base
	docker build --build-arg PYTHON_VERSION=3.5 -t flaconi/python:3.5 .

build-27: update-base
	docker build --build-arg PYTHON_VERSION=2.7 -t flaconi/python:2.7 .

build-2: update-base
	docker build --build-arg PYTHON_VERSION=2 -t flaconi/python:2 .

build-3: update-base
	docker build --build-arg PYTHON_VERSION=3 -t flaconi/python:3 .
	
###
### Test all
###
test-all: test-latest test-37 test-36 test-35 test-27 test-2 test-3


###
### Build Single
###
test-latest:
	$(eval LATEST = $(shell curl -q https://api.github.com/repos/python/python/git/refs/tags 2>/dev/null | grep '"ref"' | grep -Eo 'v[.0-9]+"' | grep -Eo '[.0-9]+' | sort -Vu | tail -1))
	docker images | grep 'flaconi/python' | grep 'latest'
	docker run --rm flaconi/python:latest python --version | grep "$(LATEST)"

test-37:
	docker images | grep 'flaconi/python' | grep '3.7'
	docker run --rm flaconi/python:3.7 python --version | grep '3.7'

test-36:
	docker images | grep 'flaconi/python' | grep '3.6'
	docker run --rm flaconi/python:3.6 python --version | grep '3.6'

test-35:
	docker images | grep 'flaconi/python' | grep '3.5'
	docker run --rm flaconi/python:3.5 python --version | grep '3.5'

test-27:
	docker images | grep 'flaconi/python' | grep '2.7'
 	docker run --rm flaconi/python:2.7 python --version | grep '2.7'

test-2:
	docker images | grep 'flaconi/python' | grep -E 'flaconi\/python\s+2\s'
	docker run --rm flaconi/python:2 python --version 2>&1 | grep '2'

test-3:
	docker images | grep 'flaconi/python' | grep -E 'flaconi\/python\s+3\s'
	docker run --rm flaconi/python:3 python --version 2>&1 | grep '3'