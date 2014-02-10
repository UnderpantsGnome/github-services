class Service::Kandan < Service::HttpPost
  string :url
  string :token
  string :room

  white_list :url, :room

  default_events :push

  maintained_by email: "michael@underpantsgnome.com",
    github: 'UnderpantsGnome'

  supported_by email: "michael@underpantsgnome.com",
    twitter: "@UnderpantsGnome"

  def receive_event
    host = required_config_value('url')
    room = required_config_value('room')
    token = URI.escape(required_config_value('token'))

    uri = URI.parse(host)
    raise_config_error("Invalid URL") unless uri.scheme && uri.host

    http_post("#{uri.to_s}/#{event}?auth_token=#{token}", payload, {
      'X-Kandan-Room' => room
    })
  end

end
