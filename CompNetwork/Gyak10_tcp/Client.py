#!/usr/bin/python

import socket
import pickle

def start_and_receive_message(host, port):
    clientsocket = socket.socket()

    clientsocket.connect((host, port))
    x = raw_input('Please enter the first number: ')
    y = raw_input('Please enter the second number: ')
    o = raw_input('Please enter the operator: ')
    message_to_send = (x, y, o)
    clientsocket.send(pickle.dumps(message_to_send))
    message = clientsocket.recv(1024)
    print message

    clientsocket.close()

start_and_receive_message('localhost', 42002)
