# -----------------------------------------------------------------------------
# GitActions Slack Notifications
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Internal Variables
# -----------------------------------------------------------------------------

BOLD :=$(shell tput bold)
RED :=$(shell tput setaf 1)
GREEN :=$(shell tput setaf 2)
YELLOW :=$(shell tput setaf 3)
RESET :=$(shell tput sgr0)

# -----------------------------------------------------------------------------
# Git Variables
# -----------------------------------------------------------------------------

GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
GIT_REPOSITORY_NAME := $(shell git config --get remote.origin.url | rev | cut -d"." -f2 | cut -d"/" -f1 | rev )
GIT_ACCOUNT_NAME := $(shell git config --get remote.origin.url | rev | cut -d"." -f2 | cut -d"/" -f2 | cut -d":" -f1 | rev)
GIT_SHA := $(shell git log --pretty=format:'%H' -n 1)
GIT_TAG ?= $(shell git describe --always --tags | awk -F "-" '{print $$1}')
GIT_TAG_END ?= HEAD
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')
GIT_VERSION_LONG := $(shell git describe --always --tags --long --dirty)

# -----------------------------------------------------------------------------
# Docker Variables
# -----------------------------------------------------------------------------

STEP_1_IMAGE ?= golang:1.15.6-alpine3.12
STEP_2_IMAGE ?= alpine:3.12
IMAGE_TAG ?= master
DOCKER_IMAGE_TAG ?= $(GIT_REPOSITORY_NAME):$(GIT_VERSION)
DOCKER_IMAGE_NAME := $(GIT_REPOSITORY_NAME)

# -----------------------------------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------------------------------



# -----------------------------------------------------------------------------
# Docker-based builds
# -----------------------------------------------------------------------------

.PHONY: docker-build
docker-build: docker-rmi-for-build
	@echo "$(BOLD)$(YELLOW)Building docker image.$(RESET)"
	@echo $(STEP_1_IMAGE) $(STEP_2_IMAGE) $(IMAGE_TAG) $(DOCKER_IMAGE_NAME) $(DOCKER_IMAGE_NAME):$(GIT_VERSION)
	@docker build \
		--build-arg STEP_1_IMAGE=$(STEP_1_IMAGE) \
		--build-arg STEP_2_IMAGE=$(STEP_2_IMAGE) \
		--build-arg IMAGE_TAG=$(IMAGE_TAG) \
		--tag $(DOCKER_IMAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		--file build/docker/Dockerfile \
		.
	@echo "$(BOLD)$(GREEN)Completed building docker image.$(RESET)"

.PHONY: docker-build-development-cache
docker-build-development-cache: docker-rmi-for-build-development-cache
	@echo "$(BOLD)$(YELLOW)Building docker image.$(RESET)"
	@docker build \
		--build-arg STEP_1_IMAGE=$(STEP_1_IMAGE) \
		--build-arg STEP_2_IMAGE=$(STEP_2_IMAGE) \
		--build-arg IMAGE_TAG=$(IMAGE_TAG) \
		--tag $(DOCKER_IMAGE_TAG) \
		--file build/docker/Dockerfile \
		.
	@echo "$(BOLD)$(GREEN)Completed building docker image.$(RESET)"

# -----------------------------------------------------------------------------
# Docker Clean up targets
# -----------------------------------------------------------------------------

.PHONY: docker-rmi-for-build
docker-rmi-for-build:
	-docker rmi --force \
		$(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		$(DOCKER_IMAGE_NAME)

.PHONY: docker-rmi-for-build-development-cache
docker-rmi-for-build-development-cache:
	-docker rmi --force $(DOCKER_IMAGE_TAG)

# -------------
# Go Lang
# -------------
.PHONY: fmt
fmt:
	@gofmt -w -s -d command/notifier
	@gofmt -w -s -d configuration

.PHONY: test-build
test-build: fmt
	@go build
