package notifier

type Message struct {
	Username    string       `json:"username,omitempty"`
	IconURL     string       `json:"icon_url,omitempty"`
	IconEmoji   string       `json:"icon_emoji,omitempty"`
	Channel     string       `json:"channel,omitempty"`
	Text        string       `json:"text,omitempty"`
	Attachments []Attachment `json:"attachments,omitempty"`
}

type Attachment struct {
	AuthorName    string  `json:"author_name,omitempty"`
	AuthorLink    string  `json:"author_link,omitempty"`
	AuthorIconURL string  `json:"author_icon,omitempty"`
	Color         string  `json:"color,omitempty"`
	Title         string  `json:"title,omitempty"`
	Fields        []Field `json:"fields,omitempty"`
}

type Field struct {
	Title string `json:"title,omitempty"`
	Value string `json:"value,omitempty"`
	Short bool   `json:"short,omitempty"`
}
