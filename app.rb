require 'timeout'
require 'socket'
require 'sinatra'
require 'json'

set :bind, 'localhost'
set :port, 4003

get '/' do
  {RUBY_DESCRIPTION: RUBY_DESCRIPTION}.inspect
end

s = TCPSocket.open('localhost', 6379)
post '/' do
  begin
    JSON.parse(request.body.string)['events'].map {|event|
      msg = event['message']
      next unless %w[computer_science vim].include? msg['room']
      text = msg.text
      next unless /^(GET|SET|MGET|MSET|INFO)\s+/
      s.write "#{text}\r\n"
      begin
        timeout(5) do
          message, _ = s.recvfrom(1024*10)
          if message.size > 1000
            "#{message[0...800]}... (total #{message.size} chars)"
          else
            message
          end
        end
      rescue Timeout::Error
        "Timed out!"
      end
    }.join
  rescue => e
    p e
    ''
  end
end

