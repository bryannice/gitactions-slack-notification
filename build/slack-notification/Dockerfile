# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM bryannice/gopher-notes as BUILD

WORKDIR /go/src

RUN git clone https://github.com/bryan-nice/slack-notification.git

RUN go get ./... && \
    go install ./...

# -----------------------------------------------------------------------------
# Stage: BUILD
# -----------------------------------------------------------------------------
FROM alpine:3.10

COPY LICENSE README.md /
COPY --from=BUILD /go/bin/slack-notification /usr/bin

ENTRYPOINT ["slack-notification"]
