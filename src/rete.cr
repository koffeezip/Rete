require "option_parser"
require "http/client"
require "validator"

output = "passed.txt"
urlTimeout = 1

OptionParser.parse do |parser|
  parser.banner = "Usage: rete [arguments] [file/urls]"
  parser.on("-t TIMEOUT", "--timeout=TIMEOUT", "Sets how many seconds until rete declares a timeout") {|timeout|
  urlTimeout = timeout}
  parser.on("-f FILE", "--file=FILE", "Checks all urls in a txt file.") { |file|
  urls = File.read(file)
  checkUrlFromFile urls, output, urlTimeout.to_i
  exit 0}
  parser.on("-o FILENAME", "--output=FILENAME", "Sets the name of the outputted file. -f flag required") {|filename|
  output = filename}
  parser.on("-v", "--version", "Displays current version of rete.") {
  puts "Rete 1.0 by koffee.zip"
  exit(0)}
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

def checkUrlFromFile(content, output, urlTimeout) # Sorry for the crappy method name.
  repeat = 0
  working = 0
  notWorking = 0
  exist = true

  begin
    config = File.read("config.txt")
  rescue File::NotFoundError
    puts "Oh No! It seems that your config.txt file does not exist!"
    puts "This is required for rete to know what classifies if a url is working or not!"
    puts "You can fix this by creating a config.txt file and by then entering status codes you classify as \"working\""
    exit(1)
  end

  urls = content.split("\n")

  while repeat < urls.size
    begin
      validUrl = Valid.url? urls[repeat]
    rescue Regex::Error
      validUrl = false
    end

    if validUrl == true
      begin
        STDIN.read_timeout = 1
        uri = URI.parse(urls[repeat])
        client = HTTP::Client.new(uri)
        client.connect_timeout = urlTimeout.seconds

        response = client.get("/")
        if config.includes?(response.status_code.to_s)
          puts "#{urls[repeat]} is a valid URL and works. Status code: #{response.status_code}"
          File.open("#{output}", "a") do |file|
            file.puts urls[repeat]
          end
          working += 1
        else
          puts "#{urls[repeat]} is a valid URL but does not work. Status Code: #{response.status_code}"
          notWorking += 1
        end
      rescue
        puts "#{urls[repeat]} is a valid URL but does not exist."
        notWorking += 1
      end
    else
      puts "#{urls[repeat]} is not a valid URL"
      notWorking += 1
    end
    repeat += 1
  end
  
  puts "=============================="
  puts "Finished testing urls."
  puts "A total of #{repeat} url(s) were tested."
  puts "#{working}/#{repeat} url(s) were working."
  puts "#{notWorking}/#{repeat} url(s) were not working."
  exit 0
end

repeat = 0
working = 0
notWorking = 0
config = File.read("config.txt")

 while repeat < ARGV.size
    if Valid.url? ARGV[repeat]
      begin
        response = HTTP::Client.get(ARGV[repeat])
        if config.includes?(response.status_code.to_s)
          puts "#{ARGV[repeat]} is a valid URL and works. Status code: #{response.status_code}"
          working += 1
        else
          puts "#{ARGV[repeat]} is a valid URL but does not work. Status Code: #{response.status_code}"
          notWorking += 1
        end
      rescue Socket::Addrinfo::Error
        puts "#{ARGV[repeat]} is a valid URL but does not exist."
        notWorking += 1
      end
    else
      puts "#{ARGV[repeat]} is not a valid URL"
      notWorking += 1
    end
    repeat += 1
  end

  puts "=============================="
  puts "Finished testing urls."
  puts "A total of #{repeat} url(s) were tested."
  puts "#{working}/#{repeat} url(s) were working."
  puts "#{notWorking}/#{repeat} url(s) were not working."