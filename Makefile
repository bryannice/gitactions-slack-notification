# -------------
# VARIABLES
# -------------

# -------------
# FUNCTIONS
# -------------


# -------------
# TASKS
# -------------
.PHONY: fmt
fmt:
	@gofmt -w -s -d command/notifier
	@gofmt -w -s -d configuration
	@gofmt -w -s -d internal

.PHONY: test-build
test-build: fmt
	@go build

.PHONY: build
build:
	@cp LICENSE README.md main.go build/docker
	@cp -rf command configuration build/docker
	@docker build --tag $$(basename $$(git rev-parse --show-toplevel)):$$(date +%s) --build-arg "BRANCH=$(BRANCH)" build/docker
	@rm -rf build/docker/LICENSE \
		build/docker/README.md \
		build/docker/main.go \
		build/docker/command \
		build/docker/configuration
