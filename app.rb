require 'timeout'
require 'socket'
require 'sinatra'
require 'json'

set :bind, 'localhost'
set :port, 4003

s = TCPSocket.open('localhost', 6379)

get '/' do
  {RUBY_DESCRIPTION: RUBY_DESCRIPTION, s: s}.inspect
end

post '/' do
  begin
    JSON.parse(request.body.string)['events'].map {|event|
      msg = event['message']
      next unless %w[computer_science vim lingr].include? msg['room']
      text = msg['text']
      next unless /^(GET|SET|DEL|ECHO|KEYS|PING|TIME|TTL|TYPE|MGET|MSET|INFO|SAVE)/ =~ text
      s.write "#{text}\r\n"
      begin
        timeout(5) {
          message, _ = s.recvfrom(1024*10)
          if message.size > 1000
            "#{message[0...800]}... (total #{message.size} chars)"
          else
            message
          end
        }.gsub(/\r/, '').each_line.reject {|line| /^\$\d+$/ =~ line }.join
      rescue Timeout::Error
        "Timed out!"
      end
    }.join
  rescue => e
    p e
    ''
  end
end

