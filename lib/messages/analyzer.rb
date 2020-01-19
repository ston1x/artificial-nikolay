# frozen_string_literal: true

module Messages
  class Analyzer
    QUESTION_TYPES = %i[what how when why who or].freeze
    QUESTION_TYPES.each { |type| const_set(type.upcase, type) }

    attr_accessor :language, :sender, :type, :mood, :text
    def initialize(message)
      @sender  = detect_sender(message[:from])
      @text    = message.text
    end

    def analyze
      @language = detect_language(@text)
      @type     = detect_type(@text)
      @mood     = detect_mood(@text)
      self
    end

    def detect_language(text)
      wl = WhatLanguage.new(*App::SETTINGS['languages'].map(&:to_sym))
      wl.language(text).to_s
    end

    def detect_type(text)
      'UNDEFINED TYPE'
    end

    def detect_mood(text)
      'UNDEFINED MOOD'
    end

    def detect_user(sender)
      User.find_or_create_by(uid: sender.uid)
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
end
