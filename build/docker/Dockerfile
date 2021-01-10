ARG STEP_1_IMAGE=golang:1.15.6-alpine3.12
ARG STEP_2_IMAGE=alpine:3.12

# -----------------------------------------------------------------------------
# Step 1
# -----------------------------------------------------------------------------
FROM ${STEP_1_IMAGE} AS STEP_1

RUN mkdir -p git gitactions-slack-notification

COPY . /go/src/gitactions-slack-notification

WORKDIR /go/src/gitactions-slack-notification

RUN go build

# -----------------------------------------------------------------------------
# Step 2
# -----------------------------------------------------------------------------
FROM ${STEP_2_IMAGE}

LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="purple"
LABEL "com.github.actions.name"="GitActions Slack Notification"
LABEL "com.github.actions.description"="Send notification to Slack"

COPY --from=STEP_1 /go/src/gitactions-slack-notification /usr/bin
COPY --from=STEP_1 /go/src/gitactions-slack-notification/LICENSE /
COPY --from=STEP_1 /go/src/gitactions-slack-notification/README.md /

# Create Terraform User
RUN addgroup -S gitactions-slack-notification && adduser -S gitactions-slack-notification -G gitactions-slack-notification

USER gitactions-slack-notification

WORKDIR /home/gitactions-slack-notification

ENTRYPOINT ["gitactions-slack-notification"]
