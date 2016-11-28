#!/usr/bin/python
""" This is not even a package.. """

import socket

def start_and_receive_message(host, port):
    """ Receives a message from a server, and sends back a domain
        , which the server resolves (hopefully). """
    clientsocket = socket.socket()

    clientsocket.connect((host, port))
    message = clientsocket.recv(1024)
    message_to_send = raw_input(message)
    clientsocket.send(message_to_send.encode())
    message = clientsocket.recv(1024)
    print message

    clientsocket.close()

start_and_receive_message('localhost', 42002)
