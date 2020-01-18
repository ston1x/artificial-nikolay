# frozen_string_literal: true

module Messages
  # Adds functionality to write messages to database
  class Writer
    def initialize(options)
      @message  = options[:message]
      @response = options[:response]
    end

    def write_to_db
    end
  end
end
