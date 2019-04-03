require "rss"
require "open-uri"
require "pry-byebug"
require "highline"  # gem install highline
# include HighLine::SystemExtensions

onion_headlines = []
real_headlines = []


NUMBER_OF_QUESTION = 10

open("https://www.theonion.com/rss") do |rss|
  feed = RSS::Parser.parse(rss)
  onion_headlines = feed.items.map(&:title)
end

open("http://rss.cnn.com/rss/cnn_topstories.rss") do |rss|
  feed = RSS::Parser.parse(rss)
  real_headlines += feed.items.map(&:title)
end

open("https://news.yahoo.com/rss/odd") do |rss|
  feed = RSS::Parser.parse(rss)
  real_headlines += feed.items.map(&:title)
end

right_answers = 0
wrong_answers = 0

1.upto(10) do |i|
  puts "-------------------------------------------"
  puts "🔥 Question #{i} 🔥"

  correct_answer = rand(0..1)
  if (correct_answer == 0)
    headline = onion_headlines.sample
  else
    headline = real_headlines.sample
  end

  puts "\"#{headline.upcase}\""
  puts "0. Onion"
  puts "1. Not the Onion"

  cli = HighLine.new
  user_answer = cli.ask "What do you think?"
  puts "you typed: #{user_answer}"

  if correct_answer == user_answer.to_i
    foo = ["Good job", "Great answer", "Your mom is proud", "U R SMART"].sample
    puts foo
    right_answers += 1
  else
    puts "Bruh.  :-("
    wrong_answers += 1
  end
end

puts "-------------------------------------------"
puts "Alright. You got #{right_answers} right and #{wrong_answers} wrong"

