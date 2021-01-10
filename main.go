package main

import (
	"github.com/bryannice/gitactions-slack-notification/command/notifier"
	"github.com/bryannice/gitactions-slack-notification/configuration"
	"github.com/pkg/errors"
	"log"
	"fmt"
)

func main() {
	var err error
	var config *configuration.Config
	var slackMessage *notifier.Message

	// Init configuration from environment variables
	config = new(configuration.Config)
	err = config.Init()
	if err != nil {
		log.Fatalf("Exception: %v", err)
	}

	slackMessage = new(notifier.Message)
	slackMessage.Username = config.SlackUsername
	slackMessage.IconURL = config.SlackIconUrl
	slackMessage.Channel = config.SlackChannel
	slackMessage.Attachments = []notifier.Attachment{
		{
			AuthorName:    config.GithubActor,
			AuthorLink:    "http://github.com/" + config.GithubActor,
			AuthorIconURL: "http://github.com/" + config.GithubActor + ".png?size=32",
			Color:         config.SlackColor,
			Title:         config.GithubEventName,
			Fields: []notifier.Field{
				{
					Title: "Ref",
					Value: config.GithubRef,
					Short: true,
				}, {
					Title: "Event",
					Value: config.GithubEventName,
					Short: true,
				},
				{
					Title: "Repo Action URL",
					Value: "https://github.com/" + config.GithubRepository + "/actions",
					Short: false,
				},
				{
					Title: config.SlackTitle,
					Value: config.SlackMessage,
					Short: false,
				},
			},
		},
	}
	fmt.Println(config.SlackWebhook)

	err = slackMessage.Send(config.SlackWebhook)
	if err != nil {
		log.Printf("%+v", errors.Wrap(err, "Exception"))
	}
}

