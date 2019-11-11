package notifier

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/pkg/errors"
	"net/http"
)

func (message *Message) Send(webhook string) error {
	var err error

	msg, err := json.Marshal(message)
	if err != nil {
		return err
	}
	msgBytes := bytes.NewBuffer(msg)
	response, err := http.Post(webhook, "application/json", msgBytes)
	if err != nil {
		return err
	}

	if response.StatusCode >= 299 {
		err = errors.New(fmt.Sprintf("Exception: %s", response.Status))
	}
	fmt.Println(response.Status)

	return err
}
