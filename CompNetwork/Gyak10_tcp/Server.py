#!/usr/bin/python

import socket
import pickle
import operator
import thread

ops = { '+': operator.add
	, '-': operator.sub
	, '*' : operator.mul
        , '/' : operator.div
        , '%' : operator.mod
        , '^' : operator.xor  }

def on_new_client(client, addr):
        print 'Got connection from ', addr
        (frst, snd, operator) = pickle.loads(client.recv(1024))
        sol = ops[operator](int(frst), int(snd))
        print sol
        client.send(str(sol).encode())
        client.close()

serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serversocket.bind(('localhost', 42002))
serversocket.listen(5)

while True:
        (client, addr) = serversocket.accept()
        thread.start_new_thread(on_new_client, (client, addr))

serversocket.close()
