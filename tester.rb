require 'socket'
s = TCPSocket.open('localhost', 6379)
s.write "#{ARGV.shift}\r\n"
p 1
p s.gets
p s.gets
p s.gets
p s.gets
p 3
