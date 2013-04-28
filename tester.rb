require 'socket'
p 1
s = TCPSocket.open('localhost', 6379)
p 2
s.write 'GET hello'
p 3
p s.gets
p 4

