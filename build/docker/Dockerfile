# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM bryannice/gopher-notes as BUILD

WORKDIR /go/src

RUN mkdir -p slack-notification

COPY main.go slack-notification/main.go
COPY command slack-notification/command
COPY configuration slack-notification/configuration

RUN go get ./... && \
    go install ./...

# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM alpine:3.10

COPY LICENSE README.md /
COPY --from=BUILD /go/bin/slack-notification /usr/bin

ENTRYPOINT ["slack-notification"]
