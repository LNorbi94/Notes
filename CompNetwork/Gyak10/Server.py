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
        , '^' : operator.xor
        , '**': operator.pow }

def on_new_client(data, addr, socket):
        print 'Got connection from ', addr
        (frst, snd, operator) = pickle.loads(data)
        sol = ops[operator](int(frst), int(snd))
        print sol
        socket.sendto(str(sol).encode(), addr)

serversocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
serversocket.bind(('localhost', 42002))

while True:
        (data, addr) = serversocket.recvfrom(1024)
        thread.start_new_thread(on_new_client
        , (data, addr, serversocket))

serversocket.close()
