require 'timeout'
require 'socket'
s = TCPSocket.open('localhost', 6379)
s.write "#{ARGV.shift}\r\n"
begin
  timeout(5) do
    message, _ = s.recvfrom(999)
    p message
  end
rescue Timeout::Error
  "Timed out!"
end
