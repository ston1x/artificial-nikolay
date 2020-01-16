require "dotenv/load"
require "telegram/bot"
require "open-uri"
require "pry"

token = ENV["token"]
bot_username = ENV["rb_unibot"]
url = ENV["url"]
schedule = ""

puts "Token: #{token}"
puts "URL: #{url}"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/command"
    end
  end
end

