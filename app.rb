# frozen_string_literal: true

require 'dotenv/load'
require 'telegram/bot'
require 'open-uri'
require 'pry'
require 'whatlanguage'
require 'yaml'

# Require message handling logic
Dir['./lib/messages/*.rb'].sort.each { |file| require file }

module App
  SETTINGS = YAML.load_file('config/settings.yml')

  TOKEN = ENV['token']
  MODE = 'Markdown'
  puts "Token: #{TOKEN}"

  Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |message|
      sender = OpenStruct.new(
        first_name: message.from.first_name,
        last_name: message.from.last_name,
        username: message.from.username
      )

      puts "#{sender.first_name} #{sender.last_name}: #{message.text}"

      analysis = Messages::Analyzer.new(message).analyze

      response = Messages::Generator.new(analysis).generate

      Messages::Sender.send(
        bot: bot,
        id: message.chat.id,
        mode: MODE,
        text: response.text
      )

      # writer = Messages::Writer.new(
      #   message: analysis,
      #   response: response.text
      # )
      # writer.write_to_db(:inbox, :outbox)
    end
  end
end
