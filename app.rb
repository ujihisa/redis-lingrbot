require 'sinatra'
require 'json'

set :bind, 'localhost'
set :port, 4003

get '/' do
  {RUBY_DESCRIPTION: RUBY_DESCRIPTION}.inspect
end

post '/' do
  begin
    JSON.parse(request.body.string)['events'].map {|event|
      msg = event['message']
      next unless %w[computer_science vim].include? msg['room']
      p msg['text']
      ''
    }.join
  rescue => e
    p e
    ''
  end
end

