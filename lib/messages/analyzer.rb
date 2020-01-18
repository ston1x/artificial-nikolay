# frozen_string_literal: true

module Messages
  class Analyzer
    QUESTION_TYPES = %i[what how when why who or].freeze
    QUESTION_TYPES.each { |type| const_set(type.upcase, type) }

    attr_accessor :message, :language, :sender, :type, :mood
    def initialize(message)
      @message = message
      @text    = message.text
    end

    def analyze
      @language = detect_language(text)
      @sender   = detect_sender(message[:from])
      @type     = detect_type(text)
      @mood     = detect_mood(text)
    end

    def detect_language(text)
      wl = WhatLanguage.new(*App::SETTINGS['languages'].map(&:to_sym))
      wl.language(text.gsub(/\W+/, ''))
    end

    def detect_type(text)
    end

    def detect_mood(text)
    end

    def detect_user(sender)
      User.find_or_create_by(uid: sender.uid)
    end
  end

  private

  def detect_sender(from)
    OpenStruct.new(
      uid: from.id,
      username: from.username,
      first_name: from.first_name,
      last_name: from.last_name
    )
  end
end
