package configuration

import (
	"errors"
	"os"
)

type Config struct {
	SlackWebhook     string
	SlackTitle       string
	SlackMessage     string
	SlackIconUrl     string
	SlackChannel     string
	SlackColor       string
	SlackUsername    string
	GithubActor      string
	GithubRepository string
	GithubRef        string
	GithubAction     string
	GithubEventName  string
	GithubWorkFlow   string
}

func (config *Config) Init() error {

	var err error

	// Checking and setting required environment variables
	if os.Getenv("SLACK_WEBHOOK") == "" {
		err = errors.New("SLACK_WEBHOOK must be set")
	} else {
		config.SlackWebhook = os.Getenv("SLACK_WEBHOOK")
	}

	if os.Getenv("SLACK_TITLE") == "" {
		err = errors.New("SLACK_TITLE must be set")
	} else {
		config.SlackTitle = os.Getenv("SLACK_TITLE")
	}

	if os.Getenv("SLACK_MESSAGE") == "" {
		err = errors.New("SLACK_MESSAGE must be set")
	} else {
		config.SlackMessage = os.Getenv("SLACK_MESSAGE")
	}

	// Setting unrequired environment variables
	config.SlackIconUrl = os.Getenv("SLACK_ICON")
	config.SlackChannel = os.Getenv("SLACK_CHANNEL")
	config.SlackColor = os.Getenv("SLACK_COLOR")
	config.SlackUsername = os.Getenv("SLACK_USERNAME")
	config.GithubActor = os.Getenv("GITHUB_ACTOR")
	config.GithubRepository = os.Getenv("GITHUB_REPOSITORY")
	config.GithubRef = os.Getenv("GITHUB_REF")
	config.GithubAction = os.Getenv("GITHUB_ACTION")
	config.GithubEventName = os.Getenv("GITHUB_EVENT_NAME")
	config.GithubWorkFlow = os.Getenv("GITHUB_WORKFLOW")

	return err
}
