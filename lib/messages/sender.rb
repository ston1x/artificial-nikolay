# frozen_string_literal: true

module Messages
  # Adds functionality to send messages to recipient
  class Sender
    def self.send(options)
      options[:bot].api.send_message(
        chat_id: options[:id],
        parse_mode: options[:mode],
        text: options[:text]
      )
    end
  end
end
