ARG INPUT_VERSION=latest
RUN echo ${INPUT_VERSION}
FROM bryannice/slack-notification:${INPUT_VERSION}

ENTRYPOINT ["slack-notification"]
