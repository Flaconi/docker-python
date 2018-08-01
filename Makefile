###
### Default
###
help:
	@printf "%s\n\n" "Flaconi Python images"
	@printf "%s\n\n" "make update-base:     Pull latest base image"
	@printf "%s\n"   "make build-all:       Build all images (see below)"
	@printf "%s\n"   "make build-latest:    Build Python latest Docker image"
	@printf "%s\n"   "make build-23:        Build Python 3.7 Docker image"
	@printf "%s\n"   "make build-24:        Build Python 3.6 Docker image"
	@printf "%s\n"   "make build-25:        Build Python 3.5 Docker image"
	@printf "%s\n"   "make build-26:        Build Python 2.7 Docker image"
	@printf "%s\n"   "make build-27:        Build Python 2 Docker image"
	@printf "%s\n\n" "make build-28:        Build Python 3 Docker image"
	@printf "%s\n"   "make test-all:        Test all images (see below)"
	@printf "%s\n"   "make test-latest:     Test Python latest Docker image"
	@printf "%s\n"   "make test-23:         Test Python 3.7 Docker image"
	@printf "%s\n"   "make test-24:         Test Python 3.6 Docker image"
	@printf "%s\n"   "make test-25:         Test Python 3.5 Docker image"
	@printf "%s\n"   "make test-26:         Test Python 2.7 Docker image"
	@printf "%s\n"   "make test-27:         Test Python 2 Docker image"
	@printf "%s\n"   "make test-28:         Test Python 3 Docker image"



###
### Update
###
update-base:
	docker pull python:slim


###
### Build all
###
build-all: build-latest build-23 build-24 build-25 build-26 build-27 build-28


###
### Build Single
###
build-latest: update-base
	docker build -t flaconi/python:latest .

build-23: update-base
	docker build --build-arg PYTHON_VERSION=3.7 -t flaconi/python:3.7 .

build-24: update-base
	docker build --build-arg PYTHON_VERSION=3.6 -t flaconi/python:3.6 .

build-25: update-base
	docker build --build-arg PYTHON_VERSION=3.5 -t flaconi/python:3.5 .

build-26: update-base
	docker build --build-arg PYTHON_VERSION=2.7 -t flaconi/python:2.7 .

build-27: update-base
	docker build --build-arg PYTHON_VERSION=2 -t flaconi/python:2 .

build-28: update-base
	docker build --build-arg PYTHON_VERSION=3 -t flaconi/python:3 .
	
###
### Test all
###
test-all: test-latest test-23 test-24 test-25 test-26 test-27 test-28


###
### Build Single
###
test-latest:
	$(eval LATEST = $(shell curl -q https://api.github.com/repos/python/python/git/refs/tags 2>/dev/null | grep '"ref"' | grep -Eo 'v[.0-9]+"' | grep -Eo '[.0-9]+' | sort -Vu | tail -1))
	docker images | grep 'flaconi/python' | grep 'latest'
	docker run --rm flaconi/python:latest python --version | grep "$(LATEST)"

test-23:
	docker images | grep 'flaconi/python' | grep '3.7'
	docker run --rm flaconi/python:3.7 python --version | grep '3.7'

test-24:
	docker images | grep 'flaconi/python' | grep '3.6'
	docker run --rm flaconi/python:3.6 python --version | grep '3.6'

test-25:
	docker images | grep 'flaconi/python' | grep '3.5'
	docker run --rm flaconi/python:3.5 python --version | grep '3.5'

test-26:
	docker images | grep 'flaconi/python' | grep '2.7'
 	docker run --rm flaconi/python:2.7 python --version | grep '2.7'

test-27:
	docker images | grep 'flaconi/python' | grep -E 'flaconi\/python\s+2\s'
	docker run --rm flaconi/python:2 python --version 2>&1 | grep '2'

test-28:
	docker images | grep 'flaconi/python' | grep -E 'flaconi\/python\s+3\s'
	docker run --rm flaconi/python:3 python --version 2>&1 | grep '3'