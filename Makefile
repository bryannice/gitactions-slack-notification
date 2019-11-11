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

.PHONY: build
build: fmt
	@go build