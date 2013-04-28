require 'socket'
s = TCPSocket.open('localhost', 6379)
s.write 'GET hello'
p s.gets

