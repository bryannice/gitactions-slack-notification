# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
ARG BRANCH="master"
FROM golang:1.13.4-alpine3.10 as BUILD

# Add github
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        git

WORKDIR /go/src

RUN git clone https://github.com/bryan-nice/slack-notification.git && \
    cd slack-notification && \
    git checkout ${BRANCH}

RUN go get ./... && \
    go install ./...

# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM alpine:3.10

COPY LICENSE README.md /
COPY --from=BUILD /go/bin/slack-notification /usr/bin

ENTRYPOINT ["slack-notification"]
