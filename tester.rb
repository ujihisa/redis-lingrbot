require 'timeout'
require 'socket'
s = TCPSocket.open('localhost', 6379)
s.write "#{ARGV.shift}\r\n"
begin
  timeout(5) do
    message, _ = s.recvfrom(1024*10)
    if message.size > 1000
      "#{message[0...800]}... (total #{message.size} chars)"
    else
      message
  end
rescue Timeout::Error
  "Timed out!"
end
