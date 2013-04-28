require 'timeout'
require 'socket'
s = TCPSocket.open('localhost', 6379)
s.write "#{ARGV.shift}\r\n"
begin
  timeout(5) do
    message, client_address = s.recvfrom(999)
    p [message, client_address]
  end
rescue Timeout::Error
  "Timed out!"
end
