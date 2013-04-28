require 'socket'
s = TCPSocket.open('localhost', 6379)
s.write "GET #{ARGV.shift}\r\n"
p 1
p s.gets
p 2
p s.gets
p 3
