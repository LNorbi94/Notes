# Socketpy

#!/usr/bin/python

import socket, pickle

# SOCK_STREAM - TCP
# SOCK_DGRAM - UDP
serversocket = socket.socket (
        socket.AF_INET, socket.SOCK_STREAM)

serversocket.bind (('localhost', 12345))
serversocket.listen(5)
(clientsocket, address) = serversocket.accept()
print ('Got connection from', address)
clientsocket.send('Thank you for connecting'.encode())
(clientsocket2, address2) = serversocket.accept()
print ('Got connection from', address2)
clientsocket2.send(pickle.dumps(address))
serversocket.close()

#Client1

#!/usr/bin/python

import socket

clientsocket = socket.socket()
host = 'localhost'
port = 12345

clientsocket.connect((host, port))
print (clientsocket.recv(1024))
data, addr = clientsocket.recvfrom(2048)
print (data)

clientsocket.close()

# Client2

#!/usr/bin/python

import socket, pickle

clientsocket = socket.socket()
host = 'localhost'
port = 12345

clientsocket.connect((host, port))
address = pickle.loads(clientsocket.recv(1024))
print (address)
clientsocket.sendto('Hi'.encode(), address)

clientsocket.close()

# Házi feladat
# example szerverrel kommunikálni
