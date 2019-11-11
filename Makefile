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
	@cp LICENSE README.md main.go build/slack-notification
	@cp -rf command configuration build/slack-notification
	@docker build --tag $$(basename $$(git rev-parse --show-toplevel)):$$(date +%s) build/slack-notification
	@rm -rf build/slack-notification/LICENSE \
		build/slack-notification/README.md \
		build/slack-notification/main.go \
		build/slack-notification/command \
		build/slack-notification/configuration
