ARG STEP_1_IMAGE=golang:1.15.6-alpine3.12
ARG STEP_2_IMAGE=alpine:3.12
ARG IMAGE_TAG=0.0.0

# -----------------------------------------------------------------------------
# Step 1
# -----------------------------------------------------------------------------
FROM ${STEP_1_IMAGE} AS STEP_1

ARG IMAGE_TAG="master"

# Add github
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        git

WORKDIR /go/src

RUN git clone https://github.com/bryannice/gitactions-slack-notification.git && \
    cd gitactions-slack-notification && \
    git checkout ${IMAGE_TAG}

RUN go get ./... && \
    go install ./...

# -----------------------------------------------------------------------------
# Step 2
# -----------------------------------------------------------------------------
FROM ${STEP_2_IMAGE}

LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="purple"
LABEL "com.github.actions.name"="GitActions Slack Notification"
LABEL "com.github.actions.description"="Send notification to Slack"

COPY --from=STEP_1 /go/bin/gitactions-slack-notification /usr/bin
COPY --from=STEP_1 /go/src/gitactions-slack-notification/LICENSE /
COPY --from=STEP_1 /go/src/gitactions-slack-notification/README.md /

# Create Terraform User
RUN addgroup -S gitactions-slack-notification && adduser -S gitactions-slack-notification -G gitactions-slack-notification

USER gitactions-slack-notification

WORKDIR /home/gitactions-slack-notification

ENTRYPOINT ["gitactions-slack-notification"]
