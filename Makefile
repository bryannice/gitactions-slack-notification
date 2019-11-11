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
	@docker build --tag $$(basename $$(git rev-parse --show-toplevel)):$$(date +%s) --build-arg "BRANCH=$(BRANCH)" build/docker
