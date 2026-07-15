require "http/client"
require "validator"

repeat = 0

config = File.read("config.txt")

while repeat < ARGV.size
  if Valid.url? ARGV[repeat]
    response = HTTP::Client.get(ARGV[repeat])
    if config.includes?(response.status_code.to_s)
      puts "#{ARGV[repeat]} is a valid URL and works. #{response.status_code}"
    else
      puts "#{ARGV[repeat]} is a valid URL but does not work. #{response.status_code}"
    end
  elsif
    puts "#{ARGV[repeat]} is not a valid URL"
  end
repeat += 1
end

puts "=======================\nFinished"
