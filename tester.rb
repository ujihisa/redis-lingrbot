require 'socket'
s = TCPSocket.open('localhost', 6379)
s.puts 'GET hello'
p s.gets

